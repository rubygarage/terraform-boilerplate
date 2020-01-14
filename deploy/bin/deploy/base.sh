#!/bin/bash

set -e

deploy() {
  while [ $# -gt 0 ]
  do
    key="$1"

    case $key in
      --region)
        REGION="$2"
        shift
        shift
      ;;
      --aws-access-key)
        AWS_ACCESS_KEY_ID="$2"
        shift
        shift
      ;;
      --aws-secret-key)
        AWS_SECRET_ACCESS_KEY="$2"
        shift
        shift
      ;;
      --cluster)
        CLUSTER="$2"
        shift
        shift
      ;;
      --service)
        SERVICE="$2"
        shift
        shift
      ;;
      --image-name)
        IMAGE_NAME="$2"
        shift
        shift
      ;;
      --repo)
        REPO="$2"
        shift
        shift
      ;;
      --running-tag)
        RUNNING_TAG="$2"
        shift
        shift
      ;;
      --skip-build)
        SKIP_BUILD="$2"
        shift
        shift
      ;;
      *)
        echo "Unknown option $1\n"
        shift
        shift
    esac
  done

  deploy/lib/print_environment.sh --running-tag $RUNNING_TAG

  HASH_TAG="$(git rev-parse --short HEAD)"

  RUNNING_IMAGE=$REPO:$RUNNING_TAG
  CURRENT_IMAGE=$IMAGE_NAME:$HASH_TAG
  RUNNING_IMAGE_BUILDER=$REPO-builder
  CURRENT_IMAGE_BUILDER=$IMAGE_NAME-builder:$HASH_TAG

  echo "🐳 Building and pushing Docker image $CURRENT_IMAGE"
  build_and_push

  echo "🚀 Deploy $CURRENT_IMAGE to $CLUSTER:$SERVICE"
  aws ecs update-service \
    --region $REGION --cluster $CLUSTER --service $SERVICE --force-new-deployment

  echo "✅ Docker image was successfully built and pushed. Changes will apply in a few mins"
}

build_and_push() {
  if [ -n "$SKIP_BUILD" ]
  then
    echo "📦 Skip build"
  else
    $(aws ecr get-login --region $REGION --no-include-email)

    # For multi-stage build
    docker build --target builder -t $CURRENT_IMAGE_BUILDER --cache-from=$RUNNING_IMAGE_BUILDER -f .docker/prod/Dockerfile .
    docker tag $CURRENT_IMAGE_BUILDER $REPO-builder:$HASH_TAG
    docker tag $CURRENT_IMAGE_BUILDER $REPO-builder

    # Necessary to use cache from builder and final images
    docker build -t $CURRENT_IMAGE --cache-from=$CURRENT_IMAGE_BUILDER --cache-from=$RUNNING_IMAGE -f .docker/prod/Dockerfile . \
                 --build-arg RAILS_ENV=$RUNNING_TAG
    docker tag $CURRENT_IMAGE $REPO:$HASH_TAG
    docker tag $CURRENT_IMAGE $RUNNING_IMAGE

    docker push $REPO:$HASH_TAG
    docker push $RUNNING_IMAGE
  fi
}
