## Architecture components

This terraform deployment will create the following in AWS:

* 1 VPC (Basically a cloud datacentre)
* 3 Public subnets (one in each availbility zone a - c to allow for highly available deployments)
* 1 Internet Gateway (allows networking out to the internet)
* 1 Route table and attachments to the subnets (allows you to control where you route network traffic)
* 3 ENI (to be used by each webserver)
* 3 Elastic IPs (to attach to the ENI and EC2 instances to allow public internet access)
* 1 security group (allowing port 22, 80 and 443)
* 3 Apache webservers (one in each availbility zone)
* 1 Application Load Balancer (ALB) - round robin load balancing to a server in each AZ. Allows for highly available web server deployment
* 1 Target group, Listener & the attachments to the ALB

## Deployment

* Download / save `main.tf` file to ideally an empty directory
* Install terraform https://learn.hashicorp.com/tutorials/terraform/install-cli
* Go to directory you've saved the file and open a powershell / cmd / bash window and type:
```
terraform init (to initialize terraform)
terraform validate (to validate the file config has correct syntax - especially if you're making changes)
terraform plan (to see exactly what will be deployed)
terraform apply (to apply the changes and create the resources)
```


## To do

* Allow template to use more variables?
* Add variables to a variables.tf file otherwise the `aws_access_key` & `aws_secret_key` will need to be passed everytime you try to apply it with `terraform apply`