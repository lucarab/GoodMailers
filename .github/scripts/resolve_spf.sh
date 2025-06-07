#!/bin/bash
set -e

DOMAINS=(
  "_spf.google.com"
  "_spf.mail.yahoo.com"
  "spf.protection.outlook.com"
  "mx.spf.gmx.net"
  "mx.spf.web.de"
  "spf.protonmail.ch"
  "icloud.com"
)

IPV4_FILE="ipv4.txt"
IPV6_FILE="ipv6.txt"

> "$IPV4_FILE"
> "$IPV6_FILE"

resolve_spf() {
  local domain=$1
  local records
  records=$(dig +short TXT "$domain" | tr -d '"')
  for part in $records; do
    case "$part" in
      include:*)
        resolve_spf "${part#include:}"
        ;;
      ip4:*)
        echo "${part#ip4:}" >> "$IPV4_FILE"
        ;;
      ip6:*)
        echo "${part#ip6:}" >> "$IPV6_FILE"
        ;;
    esac
  done
}

for domain in "${DOMAINS[@]}"; do
  resolve_spf "$domain"
done

# Optional: sort & deduplicate
sort -u "$IPV4_FILE" -o "$IPV4_FILE"
sort -u "$IPV6_FILE" -o "$IPV6_FILE"
