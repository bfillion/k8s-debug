## Commande

``` bash
docker build -t kafka.ui:v1 \
  --build-arg DOTNET_CONFIG=Build \
  --build-arg INSTALL_CLRDBG="apt-get update \
    && apt-get install -y --no-install-recommends unzip \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sSL https://aka.ms/getvsdbgsh | \
       bash /dev/stdin -v latest -l /vsdbg" \
  -f ./kafka.ui/Dockerfile .;
```