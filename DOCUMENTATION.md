# CGAL MediaWiki

This project deploys two MediaWiki instances for the CGAL community:

- **CGAL Members Wiki**: Wiki for CGAL members (`/CGAL/Members/`)
- **CGAL Editors Wiki**: Wiki for CGAL editors (`/CGAL/Editors/`)

## Architecture

```text
[Caddy Reverse Proxy]
         ↓
[mediawiki_members:80] ← /CGAL/Members/*
[wiki_editors:80]      ← /CGAL/Editors/*
         ↓
[MariaDB Container]
 ├── mediawiki (members DB)
 └── mediawiki-editors (editors DB)
```
## Installation and Startup

### 1. Clone the project

```bash
git clone https://github.com/CGAL/cgal-mediawiki.git
cd cgal-mediawiki
```

### 2. Prepare the databases

Place your database dumps in the `db-dumps/` folder (create it if it does not exist):

- `cgalwiki-dump.sql`: Members DB dump
- `cgalebwikidb.sql`: Editors DB dump

### 3. Environment configuration

#### With Docker Compose

```bash
# For development/testing
docker-compose --profile test up

# For production
docker-compose --profile production up -d
```

#### With Podman

**System Podman:**

```bash
# Start podman service
sudo systemctl start podman.socket

# Source environment variables
source ./system-podman.env
```

**User Podman:**

```bash
# Source environment variables
source ./user-podman.env
```

### 4. Database schema update

If you use older MediaWiki dumps:

```bash
# For members DB
docker-compose --profile update_db run update_db

# For editors DB
docker-compose --profile update_db run update_db_editors
```

## Environment Configuration

### Docker Compose profiles

- **`test`**: Local deployment for development
- **`production`**: Deployment with Caddy and HTTPS
- **`update_db`**: Database schema update

## Container Management

### Startup

```bash
# Test mode (local ports)
docker-compose --profile test up -d

# Production mode (with Caddy)
docker-compose --profile production up -d
```

### Shutdown

```bash
docker-compose down
```

### Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f mediawiki_members
docker-compose logs -f wiki_editors
docker-compose logs -f db
```

## MediaWiki Extensions

The project automatically installs these extensions:

### Main extensions

- **VisualEditor**: Visual editing
- **ConfirmAccount**: Account confirmation
- **Interwiki**: Inter-wiki links
- **Renameuser**: User renaming
- **UserMerge**: User merging
- **Math**: Math formulas
- **ParserFunctions**: Parser functions
- **SyntaxHighlight_GeSHi**: Syntax highlighting

### Custom extensions

- **WikiMarkdown**: Markdown support (custom repo)
- **BacktickCode**: Code with backticks
- **PageForms**: Forms

The `install_cgalmediawiki_extension.sh` script handles automatic installation.

## Backup System

### Automatic backup script

The `backup_wiki.sh` script performs a full backup:

```bash
./backup_wiki.sh
```

#### Backup process

1. **Automatic detection** of running containers
2. **Freeze wikis** (read-only mode) during backup
3. **Database backup** (MariaDB dumps)
4. **File backup** (images and uploads)
5. **Automatic unfreeze** at the end

#### Backup structure

```text
backup/
├── wiki_members_backup_YYYY-MM-DD.sql
├── wiki_editors_backup_YYYY-MM-DD.sql
├── backup_wiki_files_YYYY-MM-DD.tar.gz
└── backup_wiki_editors_files_YYYY-MM-DD.tar.gz
```

### Manual freeze/unfreeze

```bash
# Freeze a wiki (read-only mode)
./freeze_wiki.sh ./LocalSettings-Members.php

# Unfreeze a wiki
./freeze_wiki.sh --unfreeze ./LocalSettings-Members.php
```

## Maintenance and Updates

### MediaWiki update

1. **Change the version** in the `Dockerfile`:

```dockerfile
ARG MW_VERSION=1.43  # New version
```

2. **Rebuild the image**:

```bash
docker-compose build mediawiki_members wiki_editors
```

3. **Update the databases**:

```bash
docker-compose --profile update_db run update_db
docker-compose --profile update_db run update_db_editors
```

### Container maintenance

```bash
# Restart a service
docker-compose restart mediawiki_members

# Rebuild and restart
docker-compose up -d --build mediawiki_members

# Access a container
docker-compose exec mediawiki_members bash
docker-compose exec db mysql -u root -p
```

## Security and Access

### Authentication

Wiki access is protected by basic authentication via Caddy:

- **Members**: `/CGAL/Members/*` - authentication required
- **Editors**: `/CGAL/Editors/*` - authentication required

### SELinux configuration

For systems with SELinux:

```bash
./fix-selinux.sh
```

### Secrets

Passwords are managed via Docker secrets:

```yaml
secrets:
  cgal_password:
    external: true
    name: "CGAL_MEMBERS_PASSWORD"
```

## URLs and Access

### Test mode (development)

- **Members Wiki**: http://localhost:8083/CGAL/Members/wiki/
- **Editors Wiki**: http://localhost:8084/CGAL/Editors/wiki/

### Production mode

- **Main site**: https://cgalwiki.geometryfactory.com
- **Members**: https://cgalwiki.geometryfactory.com/CGAL/Members/wiki/
- **Editors**: https://cgalwiki.geometryfactory.com/CGAL/Editors/wiki/

## File Structure

```text
cgalmediawiki/
├── backup_wiki.sh              # Backup script
├── freeze_wiki.sh              # Freeze/unfreeze wikis
├── docker-compose.yml          # Docker Compose config
├── Dockerfile                  # Custom MediaWiki image
├── LocalSettings-Members.php   # Members MediaWiki config
├── LocalSettings-Editors.php   # Editors MediaWiki config
├── install_cgalmediawiki_extension.sh  # Extension installer
├── production.env              # Production variables
├── production-test.env         # Test production variables
├── system-podman.env           # System Podman config
├── user-podman.env             # User Podman config
├── config/
│   ├── Caddyfile               # Caddy config
│   ├── cgal_wiki_httpd.conf    # Members Apache config
│   └── cgal_editors_wiki_httpd.conf  # Editors Apache config
├── db-init/                    # DB init scripts
├── db-dumps/                   # DB dumps
├── extensions/BacktickCode/    # Custom extension
├── update-context/             # Update context
└── quadlets/                   # Podman Quadlets configs
```

## Troubleshooting

### Debugging

```bash
# Check service status
docker-compose ps

# Inspect containers
docker-compose exec mediawiki_members bash
docker-compose exec db bash

# View real-time logs
docker-compose logs -f --tail=100
```

## Utility Scripts

- **`backup_wiki.sh`**: Full automatic backup
- **`freeze_wiki.sh`**: Freeze/unfreeze wikis
- **`unfreeze_wiki.sh`**: Quick unfreeze (symlink)
- **`migrate_volumes.sh`**: Docker volume migration
- **`fix-selinux.sh`**: SELinux context fix
- **`scriptmediawiki.sh`**: MediaWiki container entry script