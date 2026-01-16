# Self-Hosting Pattern Diagrams

Deploy the pattern library on your local infrastructure with Tailscale Funnel for public access.

## Architecture

```
Internet → Tailscale Funnel → Caddy → Astro (site) + Kroki (diagrams)
```

## Prerequisites

- Docker & Docker Compose
- Tailscale account (free tier works)
- A device to run on (Raspberry Pi, NUC, old laptop, VM)

## Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USER/pattern-diagrams.git
cd pattern-diagrams/infrastructure
```

### 2. Set up Tailscale

Option A: **Tailscale on Host** (recommended)
```bash
# Install Tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# Authenticate
sudo tailscale up

# Enable Funnel (requires Tailscale admin approval)
sudo tailscale funnel 80
```

Option B: **Tailscale in Docker**
```bash
# Generate auth key at https://login.tailscale.com/admin/settings/keys
export TS_AUTHKEY=tskey-auth-xxxxx

# Start with Tailscale container
docker compose --profile tailscale up -d
```

### 3. Start services

```bash
# Without Tailscale container (if running on host)
docker compose up -d

# With Tailscale container
docker compose --profile tailscale up -d
```

### 4. Access your site

- **Local**: http://localhost:3000
- **Tailnet**: http://your-machine.tailnet-name.ts.net
- **Public** (with Funnel): https://your-machine.tailnet-name.ts.net

## Configuration

### Environment Variables

```bash
# .env file
TS_AUTHKEY=tskey-auth-xxxxx  # For Tailscale container
```

### Custom Domain

To use a custom domain with Tailscale:

1. Add CNAME record pointing to your Tailscale hostname
2. Update Caddyfile with your domain
3. Tailscale handles HTTPS automatically

### Performance Tuning

Edit `docker-compose.yml` to adjust resources:

```yaml
services:
  kroki:
    deploy:
      resources:
        limits:
          memory: 512M
```

## Services

| Service | Port | Description |
|---------|------|-------------|
| site | 3000 | Astro static site |
| kroki | 8000 | Diagram rendering API |
| caddy | 80/443 | Reverse proxy |

## Diagram Rendering

Kroki supports multiple diagram formats:

```bash
# PlantUML
curl -X POST http://localhost:8000/plantuml/svg -d '@startuml
A -> B
@enduml'

# Mermaid
curl -X POST http://localhost:8000/mermaid/svg -d 'graph TD
A --> B'

# D2
curl -X POST http://localhost:8000/d2/svg -d 'x -> y'

# GraphViz
curl -X POST http://localhost:8000/graphviz/svg -d 'digraph { a -> b }'
```

## Monitoring

```bash
# View logs
docker compose logs -f

# Check health
curl http://localhost/health

# Service status
docker compose ps
```

## Updating

```bash
# Pull latest changes
git pull

# Rebuild and restart
docker compose up -d --build
```

## Troubleshooting

### Kroki rendering slow
- Increase memory limits in docker-compose.yml
- First render is slower (JVM warmup)

### Tailscale Funnel not working
- Ensure Funnel is enabled in Tailscale admin console
- Check `tailscale funnel status`

### Site not loading
```bash
# Check all services are running
docker compose ps

# Check Caddy logs
docker compose logs caddy
```

## Hardware Recommendations

| Scale | Hardware | Notes |
|-------|----------|-------|
| Personal | Raspberry Pi 4 (4GB) | ~100 renders/min |
| Team | Intel NUC / Mini PC | ~500 renders/min |
| Production | VM with 4 CPU, 8GB RAM | ~2000 renders/min |

## Security

- Tailscale provides end-to-end encryption
- No ports exposed to public internet (except via Funnel)
- Kroki runs in safe mode by default
- Consider adding authentication for write operations
