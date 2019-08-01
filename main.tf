terraform {
  required_version = ">= 0.12.0"
}

module "vpn_gateway" {
  source  = "terraform-aws-modules/vpn-gateway/aws"
  version = "2.0.0"

  customer_gateway_id = aws_customer_gateway.main.id

  vpc_id                       = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_subnet_route_table_count = var.vpc_subnet_route_table_count
  vpc_subnet_route_table_ids   = data.terraform_remote_state.vpc.outputs.private_route_table_ids

  vpn_gateway_id                            = data.terraform_remote_state.vpc.outputs.vgw_id
  vpn_connection_static_routes_only         = var.vpn_connection_static_routes_only
  vpn_connection_static_routes_destinations = var.vpn_connection_static_routes_destinations

  tunnel1_inside_cidr   = var.tunnel1_inside_cidr
  tunnel2_inside_cidr   = var.tunnel2_inside_cidr
  tunnel1_preshared_key = var.tunnel1_preshared_key
  tunnel2_preshared_key = var.tunnel2_preshared_key

  create_vpn_connection         = var.create_vpn_connection
  create_vpn_gateway_attachment = var.create_vpn_gateway_attachment

  tags = var.vpn_gateway_tags
}

resource "aws_customer_gateway" "main" {
  bgp_asn    = var.aws_customer_gateway_bgp_asn
  ip_address = var.aws_customer_gateway_ip_address
  type       = var.aws_customer_gateway_type
  tags       = var.aws_customer_gateway_tags
}