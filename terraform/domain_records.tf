# Domain records
## cbarts.net
resource "linode_domain_record" "cbarts_net_protonmail_mx_10" {
	domain_id = linode_domain.cbarts_net.id
	record_type = "MX"
	priority = 10
	target = "mail.protonmail.ch"
}
resource "linode_domain_record" "cbarts_net_protonmail_mx_20" {
	domain_id = linode_domain.cbarts_net.id
	record_type = "MX"
	priority = 20
	target = "mailsec.protonmail.com"
}


### A records
resource "linode_domain_record" "cb_lin_deb_ca_01_a" {
	domain_id = linode_domain.cbarts_net.id
	name = "cb-lin-deb-ca-01"
	record_type = "A"
	target = linode_instance.cb_lin_deb_ca_01.ip_address
}
resource "linode_domain_record" "cb_lin_deb_use_01_a" {
	domain_id = linode_domain.cbarts_net.id
	name = "cb-lin-deb-use-01"
	record_type = "A"
	target = linode_instance.cb_lin_deb_use_01.ip_address
}

### AAAA records
resource "linode_domain_record" "cb_lin_deb_ca_01_aaaa" {
	domain_id = linode_domain.cbarts_net.id
	name = "cb-lin-deb-ca-01"
	record_type = "AAAA"
	target = replace(linode_instance.cb_lin_deb_ca_01.ipv6, "/\\/\\d*/", "")
}
resource "linode_domain_record" "cb_lin_deb_use_01_aaaa" {
	domain_id = linode_domain.cbarts_net.id
	name = "cb-lin-deb-use-01"
	record_type = "AAAA"
	target = replace(linode_instance.cb_lin_deb_use_01.ipv6, "/\\/\\d*/", "")
}

### CNAME records
resource "linode_domain_record" "cbarts_net_vpn_cname" {
	domain_id = linode_domain.cbarts_net.id
	name = "vpn"
	record_type = "CNAME"
	target = "cb-lin-deb-ca-01.cbarts.net"
}
resource "linode_domain_record" "cbarts_net_git_cname" {
	domain_id = linode_domain.cbarts_net.id
	name = "git"
	record_type = "CNAME"
	target = "cb-lin-deb-use-01.cbarts.net"
}
resource "linode_domain_record" "cbarts_net_www_cname" {
	domain_id = linode_domain.cbarts_net.id
	name = "www"
	record_type = "CNAME"
	target = "cbarts.net"
}
resource "linode_domain_record" "cbarts_net_protonmail_dkim1" {
	domain_id = linode_domain.cbarts_net.id
	name = "protonmail._domainkey"
	record_type = "CNAME"
	target = "protonmail.domainkey.d54jb2xmwmmyjawzyztmko2lix3f4dz4uwu2rptmnailfrd6hqgeq.domains.proton.ch"
}
resource "linode_domain_record" "cbarts_net_protonmail_dkim2" {
	domain_id = linode_domain.cbarts_net.id
	name = "protonmail2._domainkey"
	record_type = "CNAME"
	target = "protonmail2.domainkey.d54jb2xmwmmyjawzyztmko2lix3f4dz4uwu2rptmnailfrd6hqgeq.domains.proton.ch"
}
resource "linode_domain_record" "cbarts_net_protonmail_dkim3" {
	domain_id = linode_domain.cbarts_net.id
	name = "protonmail3._domainkey"
	record_type = "CNAME"
	target = "protonmail3.domainkey.d54jb2xmwmmyjawzyztmko2lix3f4dz4uwu2rptmnailfrd6hqgeq.domains.proton.ch"
}

### TXT records
resource "linode_domain_record" "cbarts_net_spf" {
	domain_id = linode_domain.cbarts_net.id
	name = ""
	record_type = "TXT"
	target = "v=spf1 include:_spf.protonmail.ch mx -all"
}
resource "linode_domain_record" "cbarts_net_dmarc" {
	domain_id = linode_domain.cbarts_net.id
	name = "_dmarc"
	record_type = "TXT"
	target = "v=DMARC1; p=quarantine; rua=mailto:admin@cbarts.net,mailto:86be0037@mxtoolbox.dmarc-report.com; ruf=mailto:admin@cbarts.net,mailto:86be0037@forensics.dmarc-report.com"
}
resource "linode_domain_record" "cbarts_net_protonmail_verify" {
	domain_id = linode_domain.cbarts_net.id
	name = ""
	record_type = "TXT"
	target = "protonmail-verification=6f4a7061e225cccb015af158de72b8f037bcf283"
	ttl_sec = 30
}
resource "linode_domain_record" "cbarts_net_hibp_verify" {
	domain_id = linode_domain.cbarts_net.id
	name = ""
	record_type = "TXT"
	target = "have-i-been-pwned-verification=969b09429820b1f2aaa1b064cf800440"
	ttl_sec = 30
}

### CAA records
resource "linode_domain_record" "cbarts_net_caa_issue" {
	domain_id = linode_domain.cbarts_net.id
	name = ""
	record_type = "CAA"
	target = "letsencrypt.org"
	tag = "issue"
}
resource "linode_domain_record" "cbarts_net_caa_issuewild" {
	domain_id = linode_domain.cbarts_net.id
	name = ""
	record_type = "CAA"
	target = "letsencrypt.org"
	tag = "issuewild"
}
resource "linode_domain_record" "cbarts_net_caa_iodef" {
	domain_id = linode_domain.cbarts_net.id
	name = ""
	record_type = "CAA"
	target = "letsencrypt.org"
	tag = "iodef"
}

## kspier.net
### MX records
resource "linode_domain_record" "kspier_net_protonmail_mx_10" {
	domain_id = linode_domain.kspier_net.id
	record_type = "MX"
	priority = 10
	target = "mail.protonmail.ch"
}
resource "linode_domain_record" "kspier_net_protonmail_mx_20" {
	domain_id = linode_domain.kspier_net.id
	record_type = "MX"
	priority = 20
	target = "mailsec.protonmail.com"
}

### A records
resource "linode_domain_record" "kspier_net_a" {
	domain_id = linode_domain.kspier_net.id
	name = ""
	record_type = "A"
	target = linode_instance.cb_lin_deb_use_01.ip_address
}

### AAAA records
resource "linode_domain_record" "kspier_net_aaaa" {
	domain_id = linode_domain.cbarts_net.id
	name = ""
	record_type = "AAAA"
	target = replace(linode_instance.cb_lin_deb_use_01.ipv6, "/\\/\\d*/", "")
}

### CNAME records
resource "linode_domain_record" "kspier_net_www_cname" {
	domain_id = linode_domain.kspier_net.id
	name = "www"
	record_type = "CNAME"
	target = "kspier.net"
}
resource "linode_domain_record" "kspier_net_protonmail_dkim1" {
	domain_id = linode_domain.kspier_net.id
	name = "protonmail._domainkey"
	record_type = "CNAME"
	target = "protonmail.domainkey.dh6wmzeh4z6tb4ihvbofpmuzll2j6362bughn4rc4ldethzlyw4jq.domains.proton.ch"
}
resource "linode_domain_record" "kspier_net_protonmail_dkim2" {
	domain_id = linode_domain.kspier_net.id
	name = "protonmail2._domainkey"
	record_type = "CNAME"
	target = "protonmail2.domainkey.dh6wmzeh4z6tb4ihvbofpmuzll2j6362bughn4rc4ldethzlyw4jq.domains.proton.ch"
}
resource "linode_domain_record" "kspier_net_protonmail_dkim3" {
	domain_id = linode_domain.kspier_net.id
	name = "protonmail3._domainkey"
	record_type = "CNAME"
	target = "protonmail3.domainkey.dh6wmzeh4z6tb4ihvbofpmuzll2j6362bughn4rc4ldethzlyw4jq.domains.proton.ch"
}

### TXT records
resource "linode_domain_record" "kspier_net_spf" {
	domain_id = linode_domain.kspier_net.id
	name = ""
	record_type = "TXT"
	target = "v=spf1 include:_spf.protonmail.ch mx -all"
}
resource "linode_domain_record" "kspier_net_dmarc" {
	domain_id = linode_domain.kspier_net.id
	name = "_dmarc"
	record_type = "TXT"
	target = "v=DMARC1; p=quarantine; rua=mailto:admin@kspier.net; ruf=mailto:admin@kspier.net;"
}
resource "linode_domain_record" "kspier_net_protonmail_verify" {
	domain_id = linode_domain.kspier_net.id
	name = ""
	record_type = "TXT"
	target = "protonmail-verification=429f539fe1a75714064c09c6f8a5e01fdf0e1faa"
	ttl_sec = 30
}
resource "linode_domain_record" "kspier_net_ahrefs_verify" {
	domain_id = linode_domain.kspier_net.id
	name = ""
	record_type = "TXT"
	target = "ahrefs-site-verification_544db24e0083e2cd2a60113d7953d89fdacb9291ce05e6882c6fc4022545537d"
	ttl_sec = 30
}

### CAA records
resource "linode_domain_record" "kspier_net_caa_issue" {
	domain_id = linode_domain.kspier_net.id
	name = ""
	record_type = "CAA"
	target = "letsencrypt.org"
	tag = "issue"
}
resource "linode_domain_record" "kspier_net_caa_issuewild" {
	domain_id = linode_domain.kspier_net.id
	name = ""
	record_type = "CAA"
	target = ";"
	tag = "issuewild"
}
resource "linode_domain_record" "kspier_net_caa_iodef" {
	domain_id = linode_domain.kspier_net.id
	name = ""
	record_type = "CAA"
	target = "admin@kspier.net"
	tag = "iodef"
}
