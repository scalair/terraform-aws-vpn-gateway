####################
# Customer Gateway #
####################
variable "aws_customer_gateway_ip_address" {
  description = "The IP address of the gateway's Internet-routable external interface."
}

variable "aws_customer_gateway_type" {
  description = "The type of customer gateway. The only type AWS supports at this time is ipsec.1."
  default     = "ipsec.1"
}

variable "aws_customer_gateway_bgp_asn" {
  description = "The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)."
  default     = 65000
}

variable "aws_customer_gateway_tags" {
  description = "Set of tags to be added to the VPN gateway"
  type        = map(string)
  default     = {}
}

####################
# VPC remote state #
####################
variable "vpc_bucket" {
  description = "Name of the bucket where vpc state is stored"
}

variable "vpc_state_key" {
  description = "Key where the state file of the VPC is stored"
}

variable "vpc_state_region" {
  description = "Region where the state file of the VPC is stored"
  default     = "eu-west-1"
}

##########################################################
# Module terraform-aws-modules/terraform-aws-vpn-gateway #
##########################################################
variable "create_vpn_connection" {
  description = "Set to false to prevent the creation of a VPN Connection."
  type        = bool
  default     = true
}

# Workaround for limitation when using computed values in count attribute
# https://github.com/hashicorp/terraform/issues/10857
variable "vpc_subnet_route_table_count" {
  description = "The number of subnet route table ids being passed in via `vpc_subnet_route_table_ids`."
  type        = number
  default     = 0
}

variable "vpn_gateway_tags" {
  description = "Set of tags to be added to the VPN Connection resource (only if `create_vpn_connection = true`)."
  type        = map(string)
  default     = {}
}

variable "vpn_connection_static_routes_only" {
  description = "Set to true for the created VPN connection to use static routes exclusively (only if `create_vpn_connection = true`). Static routes must be used for devices that don't support BGP."
  type        = bool
  default     = false
}

variable "vpn_connection_static_routes_destinations" {
  description = "List of CIDRs to be used as destination for static routes (used with `vpn_connection_static_routes_only = true`). Routes to destinations set here will be propagated to the routing tables of the subnets defined in `vpc_subnet_route_table_ids`."
  type        = list(string)
  default     = []
}

variable "tunnel1_inside_cidr" {
  description = "The CIDR block of the inside IP addresses for the first VPN tunnel."
  type        = string
  default     = ""
}

variable "tunnel2_inside_cidr" {
  description = "The CIDR block of the inside IP addresses for the second VPN tunnel."
  type        = string
  default     = ""
}

variable "tunnel1_preshared_key" {
  description = "The preshared key of the first VPN tunnel."
  type        = string
  default     = ""
}

variable "tunnel2_preshared_key" {
  description = "The preshared key of the second VPN tunnel."
  type        = string
  default     = ""
}

#Attachment can be already managed by the terraform-aws-vpc module by using the enable_vpn_gateway variable
variable "create_vpn_gateway_attachment" {
  description = "Set to false to prevent attachment of the vGW to the VPC"
  type        = bool
  default     = true
}