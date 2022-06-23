# Plan

## Service Provider Account
Create 1 VPC with 3 public subnets
Create MSK cluster with plaintext and no auth
- Configure each broker with listening port 9094
- Configure each broker with unique advertised port 909X.
Create NLBs for each advertized port mapping to the one listening port 9094

## Service Consumer Account

Create 1 VPC with a single public subnet
Create single endpoint in client VPC pointing to 3 different NLBs
Create client ASG to connect
