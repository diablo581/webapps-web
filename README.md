# webapps-web

PHP 8.4 + Apache image for small legacy intranet apps:

- PHP extensions: gd (jpeg/png/freetype), pdo_mysql, pdo_sqlite, curl
- Apache CGI (`cgid`) with bash, `bc` and the `mariadb` client available to scripts
- Apache LDAP / Active Directory Basic auth (`authnz_ldap`)
- `session.upload_progress.enabled = 0` (CVE-2026-109618/109619 hardening), `expose_php = Off`

Built daily on top of the newest `php:8.4-apache` by GitHub Actions and published as
`ghcr.io/diablo581/webapps-web:latest`. The image contains no app code or secrets.

## Runtime environment

| Variable | Purpose |
|---|---|
| `SERVER_NAME` | Apache ServerName |
| `DB_HOST`, `DB_USER`, `DB_PASSWORD` | written to a `[client]` my.cnf at start, so CGI scripts can call `mysql` without credentials |
| `LDAP_URL`, `LDAP_BIND_DN`, `LDAP_BIND_PASSWORD` | AD/LDAP lookup for Basic auth |
| `ASSET_USERS` | space-separated sAMAccountNames allowed into the protected folders |

Mount app code at `/var/www/html`, `/var/www/asset`, `/var/www/asset-new` (see `apache.conf`).
