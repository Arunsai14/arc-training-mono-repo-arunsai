data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["vpc-${var.namespace}-${var.environment}-arunsai"]
  }
  depends_on = [module.vpc]
}

data "aws_subnets" "private_subnet" {
  filter {
    name = "tag:Name"

    values = [
      "vpc-${var.namespace}-${var.environment}-arunsai-private-1",
      "vpc-${var.namespace}-${var.environment}-arunsai-private-2"
    ]
  }
  depends_on = [module.vpc]
}

data "aws_subnet" "public_subnet" {
  filter {
    name = "tag:Name"

    values = [
      "vpc-${var.namespace}-${var.environment}-arunsai-public-1",
    ]
  }
  depends_on = [module.vpc]
}
