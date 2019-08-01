# Terraform AWS VPN Gateway
Create an AWS site-to-site VPN connexion.
This module relied on the official [terraform-aws-vpn-gateway](https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway/tree/master) and creates the `aws_customer_gateway`.
This module should be used with [aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc) module and `enable_vpn_gateway` must be set to true in order to create the customer gateway.