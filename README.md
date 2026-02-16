# docker

docker compose files for my home server. each service lives in its own directory with a `docker-compose.yml` and a `.env.example`.

## setup

```
cp .env.example .env
# edit .env with your values
docker compose up -d
```

do this in each service directory you want to run.

## services

all services share a single external docker network (configured via `DOCKER_MY_NETWORK` in `.env`). caddy handles reverse proxying with automatic tls via cloudflare dns.

| service | description |
|---------|-------------|
| autobrr | torrent automation |
| caddy | reverse proxy + tls |
| cloudflared | cloudflare tunnel |
| dashdot | server dashboard |
| homarr | home page |
| homebox | inventory management |
| immich | photo management |
| jellyfin | media server |
| prowlarr | indexer manager |
| qbitwebui | qbittorrent web interface |
| qbittorrent | torrent client |
| radarr | movie management |
| rarbg | rarbg selfhosted |
| recyclarr | trash guides sync |
| slskd | soulseek client |
| sonarr | tv management |
| streamyfin-optimized-server | streamyfin transcoding |
| tubearchivist | youtube archiver |

## network

create the shared network before starting any services:

```
docker network create caddy
```

## ports

webui ports are internal-only (`expose`), accessible only within the docker network for caddy to proxy. only external-facing ports are published:

- **caddy**: 80, 443 (entry point)
- **qbittorrent**: 6881 (torrent peer connections)
- **slskd**: 50300 (soulseek listen port)

everything else stays inside the network.

## notes

- caddy uses `{$VAR}` syntax in the caddyfile to load the domain and secrets from its `.env`
- the caddyfile expects a cloudflare api token for acme dns challenge
- all services are accessed via `<service>.<domain>` subdomains
