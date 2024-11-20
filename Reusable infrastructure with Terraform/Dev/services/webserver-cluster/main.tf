module "vpc" {
  source              =""
  cidr_block          = var.cidr_block
  public_subnet_count = var.public_subnet_count
  public_subnet_cidrs = var.public_subnet_cidrs
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
