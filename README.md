## poros3

Upload log file after postrotate in logrotate.

This script upload log file to s3.

> S3 full path: `s3://{bucket}/{servic}/${module}/${date:yyyyMM}/${ip_adress}/filename`

The ip `${ip_adress}` is obtained from ec2 meta information (timeout:3s). If it fails, hostname is used.

## Requirements

- aws cli
- ec2 instance

## Installation

1. Clone this repository.

2. Install.

    This is a simply hard linking to `/usr/local/bin/poros3`.

    > If you don't like the path, you can do this manually through `ln ...`

    ```bash
    $ ./install.sh
    ```

## Example

```bash
$ poros3 --bucket mywebservice-logs \
    --service admin \
    --module nginx \
    --date YESTERDAY \
    /var/log/nginx/access.log
```


```bash
$ poros3 --help
```

### Help

```
Usage: poros3 [options...] [--bucket S3_BUCKET] <file>

-b, --bucket    s3 bucket name
-s, --service   service name (api, admin, web ...)
-m, --module    module name (nginx, syslog, apache2 ...)
-d, --date      (TODAY or YESTERDAY) default: TODAY

optional arguments:
    -v, --version   show version
    -h, --help      show this help message and exit
```