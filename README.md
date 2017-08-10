
# Intro

This is a demo implementation of a basic VPC setup for application deployment.

For background and architecture, please reference the blog post: http://blog.osgcorp.com/cloud/aws/setup-vpc-web-app/

After running `terraform apply` the output will list the bastion server IP and the IP of the
application server.

This demo will create only a single app server and a single NAT gateway.  For a production deployment
you'll want to configure your networking so that you have a NAT gateway in each availability zone,
as AWS charges for traffic between zones.

# Configuration

## Key Name

Specify the name of the key you created in AWS that will be used to launch instances with.

Unless you are launching a custom AMI that has your public SSH key pre-installed, this will be
the only way for you to access your instances.

## DB Config

`master_db_username` & `master_db_password` these will be used to configure you DB login credentials.

## Subnet Calculation

CIDR blocks for subnets are automatically calculated.

Make sure there are enough IPs available for the 9 subnets.  This is calculated by taking the total IPs possible in `cidr` variable and dividing it by the total number of subnets, 9 in our case.  The result is the total number of IPs possible within each subnet.

Make sure the `cidr_block_size` is less than that.

For example, our default is 2 availability zones and our default IP range contains 255 IPs. Since
we have 2 subnets per each logical function area (ELB, App, RDS, NAT) and 1 for Bastion,
we have 9 subnets and the default is to create 4 bits worth of IP block (2^4 = 16) in each subnet, we end up with, roughly, 144 IPs.

This is the most confusing part and to fully get it, you should play with `cidrsubnet` function
Terraform provides as it will allow you to automatically generate IP blocks without having to
manually manage it.

