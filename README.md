# AWS Client VPN

AWS Client VPN endpoint is a secure gateway service that allows users to securely connect their devices to AWS resources and other networks over the internet.

 ![alt text](image.png)

Resources :
1 - https://dev.to/kasukur/how-to-setup-an-aws-client-vpn-51f

2 - https://devopscube.com/aws-client-vpn/

## Steps  

- Create a VPC with two Private Subnets
  - VPC cidr : 10.0.0.0/16
  - Subnet 1 : 10.0.1.0/24
  - Subnet 2 : 10.0.2.0/24

- Create Certificates using easyrsa3

      # check the gen.sh file for detailed steps

      chmod +x ./gen.sh

      # Enter the folder name and client config name and types yes to proceed
      bash ./gen.sh

- Configure the AWS CLI and upload the Certs to AWS Cert manager. (you can manually copy paste on the console also)

      aws configure

      ⚠️check the names before running the command

      aws acm import-certificate --certificate fileb://server.crt --private-key fileb://server.key --certificate-chain fileb://ca.crt


      aws acm import-certificate --certificate fileb://client1.domain.tld.crt --private-key fileb://client1.domain.tld.key --certificate-chain fileb://ca.crt

- Create the Client VPN endpoint 
   -  do not overlap the CIDR of the VPC that you are going to associate
   -  enable split tunneling for Forwarding only Aws traffic to AWS
   -  Enable Mutual Auth for using certificates based Auth
 
- Associate the VPC and Subnet after VPN endpoint creation.

- Add Authorization Rule , that allows your VPC Cidr block address

- Download the OVPN config File

- Edit the OVPN File (Add your client crt and key)

      <cert>
      Contents of client certificate (.crt) file, which is client1.domain.tld.crt under the same direcroty when the server and client certificates are located
      </cert>

      <key>
      Contents of private key (.key) file, which is client1.domain.tld.crt
      </key>

- Download any OVPN Compatible VPN clinet or AWS VPN Client and Connect it

- You will be connected to your Network

- Now try to login into your EC2 Instance which is in the Private Subnet

- That's it!