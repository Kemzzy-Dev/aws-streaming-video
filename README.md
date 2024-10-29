## Video streaming application with terraform
This is a Terraform project that creates a video streaming infrastructure on AWS leveraging the us of S3 bucket for storing the video, cloudFront distribution as the CDN, domain name routing with route53 and SSL validation using AWS Certificate Manager (ACM).

My domain name was bought on namecheap so I had to do some extra stuffs to get it to work with route53. If your domain is on AWS, you should be fine, if not you have to add your AWS hosted zone nameserver to your domain (took me a while to figure this out :/ )

#### Note: The data.tf file should be ignored if your domain name is on AWS

main.tf: This file contains the main Terraform configuration for the project.
s3.tf: This file contains the Terraform configuration for the S3 bucket.
vars.tf: This contains the variables used
data.tf: Contains code to get the certificate and zone from AWS


I guess that should be all for now.....well I'll update this if I think of something new to add

