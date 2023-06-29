# Servers
resource "linode_instance" "cb_lin_deb_ca_01" {
	label = "cb-lin-deb-ca-01"
	type = "g6-nanode-1"
	region = "ca-central"
	# image = "linode/debian11"
	tags = [ "terraform" ]
	backups_enabled = true
}

resource "linode_instance" "cb_lin_deb_use_01" {
	label = "cb-lin-deb-use-01"
	type = "g6-nanode-1"
	region = "us-east"
	# image = "linode/debian11"
	tags = [ "terraform" ]
	backups_enabled = true
}
