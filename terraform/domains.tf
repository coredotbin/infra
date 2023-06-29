# Domains
resource "linode_domain" "cbarts_net" {
	domain = "cbarts.net"
	type = "master"
	soa_email = "admin@cbarts.net"
	tags = [ "terraform" ]
}

resource "linode_domain" "kspier_net" {
	domain = "kspier.net"
	type = "master"
	soa_email = "admin@kspier.net"
	tags = [ "terraform" ]
}
