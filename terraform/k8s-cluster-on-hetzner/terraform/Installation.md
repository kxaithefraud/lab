# Install Terraform

First of all we need to isntall [Terraform](https://developer.hashicorp.com/terraform/install).
Go to the [Website](https://developer.hashicorp.com/terraform/install) and download it for the used OS.
Example for Ubuntu/Debian:
`wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform`

After the installation is complete check if it is working with:
`terraform -v`
this should return something like this:
`Terraform v1.11.3 on linux_amd64`

## Done :)