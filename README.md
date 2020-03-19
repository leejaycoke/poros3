## poros3

Upload log file after postrotate in logrotate.

This script upload log file to s3.

> S3 full path: `s3://{bucket}/{servic}/{module}/{date:yyyyMM}/{ip_adress}/filename`

The `{ip_adress}` is obtained from ec2 meta information (timeout:3s). If it fails, hostname is used.

## Requirements

- aws cli
- ec2 instance

## Installation

1. Clone this repository.

2. Install.

    ```bash
    $ ./install.sh
    ```

    > This is a simply hard linking to `/usr/local/bin/poros3`. So if you don't like the path, you can do this manually through `ln ...`

## Example

### example 1. (command)

```bash
$ poros3 --bucket mywebservice-logs \
    --service admin \
    --module nginx \
    --date TODAY \
    /var/log/nginx/access.log
```

### example 2. (logrotate)

```bash
/var/log/nginx/*.log {
        daily
        dateext
        dateyesterday
        missingok
        ifempty
        rotate 90
        compress
        create 644 nginx
        sharedscripts
        olddir /var/log/nginx/backup
        postrotate
            if [ -f /var/run/nginx.pid ]; then
                kill -USR1 `cat /var/run/nginx.pid`
            fi
            poros3 --bucket mywebservice-logs --service admin --module nginx --date YESTERDAY --compress-gzip $1
        endscript
```

### Help

```
$ poros3 --help
Usage: $(basename $0) [options...] [--bucket S3_BUCKET] <file>

-b, --bucket    s3 bucket name (mandantory)
-s, --service   service name (api, admin, web ...)
-m, --module    module name (nginx, syslog, apache2 ...)
-d, --date      (TODAY or YESTERDAY) default: TODAY
--compress-gzip     compress by gzip

optional arguments:
    -v, --version   show version
    -h, --help      show this help message and exit
```