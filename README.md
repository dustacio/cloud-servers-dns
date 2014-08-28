# Cloud Servers DNS

A DNS server that serves up your Rackspace Cloud Server instances by name.

The idea for this server came from [aws-name-server](https://github.com/ConradIrwin/aws-name-server) by Conrad Irwin.

# Usage

```
$ cat config.yml
:connection_details:
  :provider: 'Rackspace',
  :version: :v2,
  :rackspace_username: '',
  :rackspace_api_key: '',
  :rackspace_region: ''
:domains:
  - domain1.com
  - domain2.org

$ cloud-server-dns --config config.yml

```

This will server up DNS records for the following:
  -  ```<name>.domain1.com``` your cloud servers with Name=<name>
  -  ```<name>.domain2.org``` your cloud servers with Name=<name>

# Quick Start

  #. Open port 53 (UDP, TCP)
  #. gem install cloud-servers-dns.gem
  #. copy upstart to ```/etc/conf```
  #. Setup your NS records

# Contributing

  #. Fork
  #. Submit Pull Request

# License

Cloud Servers DNS is licensed under the MIT license:
  - [www.opensource.org/licenses/MIT](http://www.opensource.org/licenses/MIT)


