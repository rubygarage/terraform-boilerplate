### AWS infrastructure

AWS infrastructure for a staging and production servers was created using [Terraform](https://www.terraform.io/). Be sure to make all subsequent changes using Terraform too. Otherwise they will be wiped off after the next Terraform apply.

#### Setting up tools for creation/changing infrastructure (have to be done once for a developer)

1. Install AWS CLI, following [the official documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) for your system.

2. Install Terraform, following [the official documentation](https://www.terraform.io/downloads.html) for your system.

3. Configure your AWS CLI for the project, using [named profiles](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) and user with admin permissions:
  ```bash
  aws configure --profile terraform-rails
  ```
  Set up the following values:
  - AWS Access Key ID: `YOUR_KEY_ID`
  - AWS Secret Access Key: `YOUR_ACCESS_KEY`
  - Default region name: `eu-north-1`
  - Default output format: `json`


4. Ask your teammates to share SSH private keys (`terraform/ssh_keys`), SSL certificates (`terraform/ssl_certificates`) and Terraform variables (`terraform/terraform.tfvars`). Paste it to an appropriate Terraform folder.

5. Initialize Terraform providers and modules, running the next command from the `terraform` folder:
  ```shell
  terraform init
  ```

#### Changing infrastructure

1. Make changes to configuration in `terraform` folder and apply new Terraform config:
  ```shell
  terraform apply
  ```

2. From the output of the command above, make sure changes you're going to apply are the correct ones (including a correct environment).

3. Type `yes` to apply the above changes.

#### Destroy infrastructure

1. Destroy all the resources managed by Terraform:
  ```shell
  terraform destroy
  ```

#### Setting up Terraform backend (for S3 backend only, need to be done only once per project)

Terraform can't create backend for itself, so these resources have to be created manually (once for a project).

1. Configure your AWS CLI for the project using admin user credentials (as described above):
  ```shell
  aws configure --profile terraform-rails
  ```

2. Set region
  ```shell
  region=eu-north-1
  ```

3. Create S3 bucket to store Terraform state (bucket name have to be unique across all regions):
  ```shell
  aws s3api create-bucket \
      --profile terraform-rails \
      --bucket terraform-rails-tfstate \
      --region $region
  ```

  **NOTE:** If your region is not `us-east-1`, you have to pass additional option to the previous command `--create-bucket-configuration LocationConstraint=$region`

4. Block public access
  ```shell
  aws s3api put-public-access-block \
      --bucket terraform-rails-tfstate \
      --public-access-block-configuration \
      "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
  ```

5. Add versioning to S3 bucket:
  ```shell
  aws s3api put-bucket-versioning \
      --profile terraform-rails \
      --bucket terraform-rails-tfstate \
      --versioning-configuration Status=Enabled
  ```

6. Add encryption to S3 bucket:
  ```shell
  aws s3api put-bucket-encryption \
    --profile terraform-rails \
    --bucket terraform-rails-tfstate \
    --server-side-encryption-configuration '{
      "Rules": [
        {
          "ApplyServerSideEncryptionByDefault": {
            "SSEAlgorithm": "AES256"
          }
        }
      ]
    }'
  ```

7. Create DynamoDB table to store terraform state locks:
  ```shell
  aws dynamodb create-table \
    --profile terraform-rails \
    --table-name terraform-rails-terraform-locks \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region $region
  ```

#### Destroy manually created cloud resources for Terraform (for S3 backend only)

  **WARNING:** Terraform will not work after that

1. Delete S3 bucket using Amazon S3 console https://s3.console.aws.amazon.com/s3/home.

2. Delete DynamoDB table:
  ```shell
  aws dynamodb delete-table \
    --profile terraform-rails \
    --table-name terraform-rails-terraform-locks \
    --region $region
  ```

#### Upload/change server SSL certificate for production

1. Prepare files for upload. Delete all odd symbols as end of string while concatenating. All files have to be in PEM format. https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html#upload-server-certificate

2. Upload certificate:
  ```shell
  aws iam upload-server-certificate --server-certificate-name terraform-rails-production \
      --certificate-body file://path_to_file/rails-app.ml.bundled.crt \
      --private-key file://path_to_file/rails-app.ml.key.pem
  ```

3. Get an Amazon Resource Name (ARN) of the previously uploaded SSL certificate:
  ```shell
  aws iam list-server-certificates
  ```

4. Update `certificate_arn` in terraform config `terraform/environments/production/alb.tf`.

5. Apply changes (see instructions above).

#### Upload/change server SSL certificate for staging

1. Prepare files for upload. Files have to be named `rails-app.ml.bundled.crt` for certificate (including root certificate) and `rails-app.ml.key` for private key.

2. Copy the above files to `/home/ec2-user/ssl` folder on a staging server EC2 instance.

3. Change permissions to certificates to nginx user (uid 101):
  ```shell
  sudo chown 101:101 ssl/rails-app.ml.bundled.crt
  sudo chown 101:101 ssl/rails-app.ml.key
  ```

4. Trigger changes by deploying to a staging server.

#### Get into a running container on a server

1. SSH to a EC2 container instance using a key from `terraform/ssh_keys` folder.

2. Run one of the commands below depending on the container:

- **Application** container:
  ```shell
  docker exec -it $(docker ps -q --filter name=-app-) bash
  ```

- **Scheduler** container (for now for production only):
  ```shell
  docker exec -it $(docker ps -q --filter name=-scheduler-) bash
  ```

- **Worker** container (for now for production only):
  ```shell
  docker exec -it $(docker ps -q --filter name=-worker-) bash
  ```

- **NGINX** container:
  ```shell
  docker exec -it $(docker ps -q --filter name=-web-server-) bin/ash
  ```

- **DB** container (for staging only, for production see instructions below):
  ```shell
  docker exec -it $(docker ps -q --filter name=-db-) bash
  ```

#### Working with DB on production

A production server uses AWS RDS. Due to security reasons, you can SSH connect to a DB instance only from one of a production EC2 instances.

1. SSH to one of the production EC2 container instances using key from `terraform/ssh_keys` folder.

2. Run the following command (DB_HOST, DB_USERNAME and DB_PASSWORD can be found in `.dev-prod` file):
  ```shell
  mysql -h <DB_HOST> -P 3306 -u <DB_USERNAME> -p
  ```

3. Enter DB_PASSWORD.
