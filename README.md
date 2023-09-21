# aws_k8sInfra

This repository contains the infrastructure code and Kubernetes configurations for deploying a project on AWS using Terraform and Kubernetes.

## Directory Structure

```
.
├── LICENSE                           # License for the project
├── README.md                         # This README file
├── deployments.yml                   # Kubernetes deployment configurations
├── services-lb.yaml                  # Kubernetes service configurations with LoadBalancer
└── terraform                         # Terraform configurations and modules
    ├── data.tf                       # Data sources for Terraform
    ├── locals.tf                     # Local values for Terraform
    ├── main.tf                       # Main Terraform configuration file
    ├── modules                       # Terraform modules
    │   ├── eks                       # EKS related Terraform configurations
    │   │   ├── iam_policies.tf       # IAM policies for EKS
    │   │   ├── locals.tf             # Local values specific to EKS
    │   │   ├── main.tf               # Main configuration for EKS module
    │   │   ├── outputs.tf            # Outputs for the EKS module
    │   │   └── variables.tf          # Variable definitions for the EKS module
    │   ├── security_group            # Security group related Terraform configurations
    │   │   ├── locals.tf             # Local values specific to security groups
    │   │   ├── main.tf               # Main configuration for security group module
    │   │   ├── outputs.tf            # Outputs for the security group module
    │   │   └── variables.tf          # Variable definitions for the security group module
    │   └── vpc                       # VPC related Terraform configurations
    │       ├── locals.tf             # Local values specific to VPC
    │       ├── main.tf               # Main configuration for VPC module
    │       ├── outputs.tf            # Outputs for the VPC module
    │       └── variables.tf          # Variable definitions for the VPC module
    ├── providers.tf                  # Provider configurations for Terraform
    ├── terraform.tfstate             # Terraform state file
    ├── terraform.tfstate.backup      # Backup of the Terraform state file
    ├── terraform.tfvars              # Terraform variables file
    ├── tfvars.example                # Example Terraform variables file
    └── variables.tf                  # Global variable definitions for Terraform
```

# Terraform AWS EKS Setup Explanation

This Terraform setup is designed to provision a Kubernetes cluster (EKS) on AWS along with its necessary supporting infrastructure such as a VPC and Security Group. Here's a deeper dive into each component:

## 1. **Virtual Private Cloud (VPC)**

Located in the `./terraform/modules/vpc` directory, the VPC module is responsible for setting up a virtual network within AWS where the EKS cluster and its associated resources will reside.

- **CIDR Block**: The VPC is defined with a CIDR block specified by the `virginia_cidr` variable. This determines the IP range of our VPC.
  
- **Subnets**: Within this VPC, the module creates both private and public subnets. These subnets spread across multiple availability zones (`azs`) for high availability. The CIDR blocks for these subnets are defined by the `private_subnet` and `public_subnet` variables.

- **Internet Gateway**: An Internet Gateway is provisioned and attached to the VPC, enabling communication between the VPC and the internet. This is crucial for resources within the VPC that might need to reach out to the internet (like EC2 instances pulling Docker images).

## 2. **Security Group**

Located in the `./terraform/modules/security_group` directory, the Security Group module is designed to define the inbound and outbound traffic rules for resources within the VPC.

- **Ingress Rules**: Using the `ingress_ports_list` variable, specific ports are opened for incoming traffic. By default, traffic from any IP (`0.0.0.0/0`, as defined by `sg_ingress_cidr`) can access these ports. Common ports include 22 (SSH), 80 (HTTP), and 443 (HTTPS).

- **Egress Rules**: Similarly, the `egress_ports_list` variable defines ports that our resources can reach out to. By default, they can reach any IP (`0.0.0.0/0`, as defined by `sg_egress_cidr`).

## 3. **Elastic Kubernetes Service (EKS)**

Found in the `./terraform/modules/eks` directory, the EKS module provisions the managed Kubernetes cluster on AWS.

- **IAM Roles & Policies**: Before the EKS cluster can be created, IAM roles and policies are defined. These are crucial for allowing the EKS service to operate and manage resources on your behalf. The roles allow services like EC2 (worker nodes) and EKS to communicate and function properly.

- **EKS Cluster**: The main EKS cluster is provisioned with the required IAM roles and within the VPC that was previously created. The `cluster_name` variable defines its name, and it's set to utilize the subnets created in our VPC module.

- **EKS Node Group**: A node group, a group of EC2 instances that will run our Kubernetes workloads, is also provisioned. It uses the IAM roles and policies defined earlier and is associated with the EKS cluster.

## Getting Started

1. **Setup AWS Credentials**: Ensure you have your AWS credentials setup, either using the AWS CLI or environment variables.

2. **Initialize Terraform**:
   ```
   cd terraform
   terraform init
   ```

3. **Apply Terraform**:
   ```
   terraform apply
   ```

**Workflow Perspective**

    When `terraform apply` is run:
    
    -  The VPC is created first since it's the foundational network layer.
    -  The Security Group is provisioned next, defining the traffic rules within the VPC.
    -  With the network set, the EKS module then starts by setting up IAM roles and policies.
    -  Once IAM is ready, the EKS cluster is provisioned.
    -  Finally, the EKS node group, the actual EC2 instances running the Kubernetes workloads, is set up and linked to the EKS cluster.


4. **Accessing the EKS Cluster**:

Once the EKS cluster is provisioned, accessing it requires updating your local `kubeconfig`. Execute the following AWS CLI command:

```
aws eks --region [REGION] update-kubeconfig --name [CLUSTER_NAME]
```

Replace `[REGION]` with your AWS region and `[CLUSTER_NAME]` with the name of your EKS cluster. This command configures `kubectl` to communicate with your newly created EKS cluster.

---

5. **Deploy to Kubernetes**:
   ```
   kubectl apply -f deployments.yml
   kubectl apply -f services-lb.yaml
   ```

## Author

- Alejandro Piña ([email](mailto:alexander.pinna@protonmail.com))
