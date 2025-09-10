# DaVinci Tools in Docker — Devcontainer Template

Run Vector DaVinci tools inside Docker with a ready-to-adapt devcontainer. This repository provides a minimal, practical starting point for containerized development and CI.

## What you get

- `Dockerfile`  
  Adds the Vector external repository and installs prerequisites, including the Vector License Client.

- `docker-compose.yml`  
  Defines volumes and networking for a clean project/workspace mapping.

- `.devcontainer/devcontainer.json`  
  Optional configuration for the VS Code “Dev Containers” extension.

- `vector-license-setup.sh`  
  Entrypoint that starts the Vector License Client inside the container.

## Requirements

- Docker and Docker Compose
- Optional: VS Code with the “Dev Containers” extension
- Network access to your Vector package sources (if applicable)
- A valid Vector license and reachable license server

## Getting started

1. **Configure licensing**
   - Add your corporate/root CA certificates in the `Dockerfile` so the image can reach internal resources.
   - In `docker-compose.yml`, provide the license server details (for example via environment variables or an extra hosts entry).

2. **Choose your toolset**
   - The `Dockerfile` includes DaVinci Developer Classic 4.15.53 as an example.
   - Replace, add, or remove tools to match your needs.

3. **Add the devcontainer to your project**
   - Place the `.devcontainer` folder at the root of your project.  
     The project directory will be mounted into the container as a volume.

4. **Start developing**
   - With VS Code: open the project and select “Reopen in Container.”
   - With CLI:
     ```bash
     docker compose up -d
     docker compose exec app bash
     ```

## Conventions inside the container

- Project files are available under `/work`
- Vector tools are typically installed under `/opt/vector`

## Example compose snippet

```yaml
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    volumes:
      - .:/work
    environment:
      # Example: make your license server reachable
      # VLIC_SERVER: "10.0.0.42"
    working_dir: /work
    entrypoint: ["/bin/bash", "/work/.devcontainer/vector-license-setup.sh"]
```

## Tips

- Keep secrets and certificates out of version control; use build args or a secure secrets store.
- If your network requires proxies, configure them in both the `Dockerfile` and `docker-compose.yml`.
- For CI use, you can base pipeline jobs on the built image to ensure identical toolchains.
