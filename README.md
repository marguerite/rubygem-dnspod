rubygem-dnspod

-----

This is a ruby implementation of DNSPod API.

It is partial currently, but implemented everything you need to dynamically update your domain IP.

So you are safe to depoly it on your Raspberry Pi server.

## Usage

* Copy `config.yml.template` to `/etc/dnspod.yml` and fill in your credentials.
* link `bin/dnspod-ddns` to `/usr/bin/dnspod-ddns`.
* Drop a simple bash script into your `/etc/cron.hourly`:

        #!/bin/sh
        /usr/bin/dnspod-ddns

