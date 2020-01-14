### Deployment process

The deployment process leverages [Docker](https://www.docker.com/) and [Amazon ECS](https://aws.amazon.com/ecs/).
<br>
**If you deploy the first time,** follow steps for setting up tools for deployment (need to be done only once for a developer).
<br>
**For a subsequent deployments,** skip that section and proceed to [Deployment](#deployment) section.

#### Setting up tools for deployment (need to be done once for a developer)

1. Install AWS CLI, following [the official documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) for your system.

2. Configure your AWS CLI for the project, using named profiles and user with admin permissions:
```bash
aws configure --profile terraform-rails
```
  Set up the following values:
  - AWS Access Key ID: `YOUR_KEY_ID`
  - AWS Secret Access Key: `YOUR_ACCESS_KEY`
  - Default region name: `eu-central-1`
  - Default output format: `json`


3. Install ECS CLI, following [the official documentation](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_CLI_installation.html) for your system.

4. Install Docker Compose as described in [the official documentation](https://docs.docker.com/compose/install/) for your system. For Linux, you have to run Docker as non-root user, as described [here](https://docs.docker.com/install/linux/linux-postinstall/).

5. Ask your teammates to share `.env-dev` and `.env-prod` files with you.

6. Populate `deploy/bin/variables.sh` with the new values (need to be done only if you change region or ECR repository).

#### Deployment

1. Make sure that you're on the correct branch and there are no changes in your local repository. All the Docker images are built based on your local repository, not the remote one.

2. Select the project [profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) in AWS CLI:
```bash
export AWS_DEFAULT_PROFILE=terraform-rails
```

3. Run the following command from the root of the project to deploy to **staging** server:
```bash
deploy/bin/deploy/staging.sh
```

4. Run the following command from the root of the project to deploy to **production** servers:
```bash
deploy/bin/deploy/production.sh
```

  **NOTE:** Before each deployment to production server RDS snapshot is created.

#### Changing NGINX configuration

1. Change NGINX configuration in `deploy/nginx/configs` folder.

2. Select the project [profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) in AWS CLI:
```bash
export AWS_DEFAULT_PROFILE=terraform-rails
```

3. Run the following command to update NGINX Docker image for **staging** server:
```bash
deploy/bin/build/nginx_image.sh --running-tag staging
```

4. Run the following command to update NGINX Docker image for **production** server:
```bash
deploy/bin/build/nginx_image.sh --running-tag production
```

  **NOTE:** Changes will apply after the next deployment.
