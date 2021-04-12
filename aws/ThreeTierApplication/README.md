Haven't been able to figure out how to apply the whole code without targetting vpc and private, public subnet resources in vpc module before applying rest of the config.

Run below commands in order specified for code to work

1. terraform apply -target="module.vpc.aws_vpc.main"
2. terraform apply -target="module.vpc.aws_subnet.private_subnet"
3. terraform apply -target="module.vpc.aws_subnet.public_subnet"