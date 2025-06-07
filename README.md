# GoodMailers IP List

This repository provides up-to-date IPv4 and IPv6 lists for common, trusted mail providers (“good mailers”). The generated `ipv4.txt` and `ipv6.txt` files can be used to whitelist these providers in firewalls or other network appliances.

The lists are updated daily via a scheduled GitHub Action.

## Supported SPF Domains

The following SPF include domains are used by the resolver script to gather IP ranges:

```bash
DOMAINS=(
  "_spf.google.com"
  "_spf.mail.yahoo.com"
  "spf.protection.outlook.com"
  "outlook.com"
  "_spf.gmx.net"
  "_spf.web.de"
  "_spf.protonmail.ch"
  "_spf.icloud.com"
  "amazonses.com"
  "sendgrid.net"
  "mailgun.org"
)
```
## Integration

* Import the generated `ipv4.txt` and `ipv6.txt` into your firewall or alias group (e.g., OPNsense aliases) to whitelist these IPs on relevant ports.

## Contributing

Feel free to add or remove SPF domains in `.github/scripts/resolve_spf.sh` by modifying the `DOMAINS` array. Submit pull requests for updates to additional mail providers or fixes.