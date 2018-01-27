# Terraform + Docker

## Introduction

In this branch we are keeping Terraform files that allow you to setup _staging_ and _production_ environment + deploy new releases with Docker.

## Getting started

1. Through AWS Console create new user with name `terraform` that has only _Programmatic access_.

2. Create `terraform.tfvars` file in root-level directory with such content:

```
aws_access_key = "XXXXXXXXXXXXXXXXXXXX"
aws_secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
```

Replace values of `aws_access_key` and `aws_secret_key` with ones that `terraform` user has.

3. Generate SSH keys for _staging_ and _production_ environments or copy to `ssh-keys` directory if they already exist:

```
ssh-keygen -t rsa -b 4096 -f ssh-keys/example-staging
ssh-keygen -t rsa -b 4096 -f ssh-keys/example-production
```

4. Copy SSL certificates to `ssl-certificates` directory:

```
ssl-certificates/example.com.crt
ssl-certificates/example.com.key
```

5. Run `terraform validate` to check if everything is OK!

6. Run `terraform apply` to setup your _staging_ and _production_ environment in AWS.
