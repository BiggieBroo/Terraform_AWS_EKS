# Deploying EKS by using Terraform
To deploy Kubernetes on AWS requires bunch of the actions such as creating VPC, Subnets, Roles and etc. Terraform pre-ready modules on registry.terraform.io ease the routine of work with setting parameters.
# Pre-requisites
1. Installed kubectl
2. AWS CLI
3. aws-iam-authenticator
4. Terraform
5. AWS account (Free tier also can be acceptable since not such a big manipulation will be done)
6. Set up credentials on Terraform which can be found: ~/.aws/credentials. The region can be set based on your preference
# Installation
1. At first need to create a VPC on Terraform. Requires to put a module from registry.terraform.io and set the parameters:
![image](https://github.com/BiggieBroo/Terraform_AWS_EKS/assets/140602458/7eff7f49-50d5-42b0-932a-1eafb5a3d752)
2. Then requires to retrieve a module of EKS from the registry.terraform.io into a new file by the name eks.tf:
![image](https://github.com/BiggieBroo/Terraform_AWS_EKS/assets/140602458/18294060-b142-44a4-934e-4ce615592723)
3. After all a user must run **terraform init** so the modules could download from the server. When the download is sucessful the settings of the Terraform can be installed by typing **terraform apply --auto-approve**. But before applying the configurations it is highly recommended to run the command **terraform plan** to check out the settings if they correspond.
4. As soon as the installation is successful, a user should connect to a newly deployed EKS by running the commands:
**aws eks update-kubeconfig --name [name of the cluster] --region [the current region]**
**kubectl get node**
**kubectl get pod**
5. For the verification a user can run a ready NGINX by using prepared NGINX "Deployment" and "Service" K8s YAML file.
