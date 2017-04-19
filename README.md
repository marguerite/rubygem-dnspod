rubygem-dnspod

-----

This is a ruby implementation of DNSPod API.

It is partial currently, but implemented everything you need to dynamically update your domain IP.

So you are safe to depoly it on your Raspberry Pi server.

## BootStrap

By default, there's no A record for your domain on DNSPod's server.

So you need to register your current IP as A record on DNSPod's server.

* Copy `config.yml.template` to `bin/config.yml` and fill in your credentials.
* Run `bin/dnspod-bootstrap` once first

## Usage

Drop a simple bash script into your `/etc/cron.hourly`:

        #!/bin/sh
        <DOWNLOAD PATH>/rubygem-dnspod/bin/dnspod-ddns

