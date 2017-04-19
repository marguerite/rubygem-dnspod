rubygem-dnspod

-----

This is a ruby implementation of DNSPod API.

It is partial currently, but implemented everything you need to dynamically update your domain IP.

So you are safe to depoly it on your Raspberry Pi server.

## Usage

* Copy `config.yml.template` to `/etc/dnspod/config.yml` and fill in your credentials.

* Set a cronjob to run `/usr/bin/dnspod-ddns` on your schedule.
