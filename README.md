## Istanbul-tools Docker image
Dockerfile to host the [istanbul-tools](https://github.com/getamis/istanbul-tools) binary in a go:alpine image.

### It will:
-  check condition: if `/efs/shared/genesis.json` NOT exist
-  load `/efs/shared/config.toml` from EFS
-  generate `Istanbul extra-data` 
-  load `genesis.json` template from ConfigMap `genesis-template` 
-  add `Istanbul extra-data` to genesis and generate `/efs/shared/genesis.json`

### Usage:

Container:
```bash
docker run -it --name init04 init04 /efs/shared /genesis-template/genesis.json
```

Usage: `write_genesis.py` [-h] -t TEMPLATE_PATH -f GENESIS_PATH -e EXTRA

Generate `genesis.json` file
```
optional arguments:
  -h, --help        show this help message and exit   
  -t TEMPLATE_PATH  Path to template file for genesis.json   
  -f GENESIS_PATH   Path to genesis.json   
  -e EXTRA          Encoded Istanbul extra-data   
```
