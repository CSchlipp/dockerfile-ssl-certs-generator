Self Signed SSL Client Certificate Generator
=================================================

About
-----
Origin: https://github.com/stakater/dockerfile-ssl-certs-generator

This is a small docker image based on `alpine linux` which allows you to create one or multiple client certificates for mutual TLS authentication.

Default settings are suitable for usage with [Traefik](https://containo.us/traefik/). 
```
$ docker run -v /tmp/certs:/certs cschlipp/client-cert-ca:latest
----------------------------
| SSL Client Cert Generator |
----------------------------

--> Certificate Authority
====> Generating new CA key ca-key.pem
Generating RSA private key, 8192 bit long modulus
.........................................................................................................................................................................................................................................................................+++
..........+++
e is 65537 (0x10001)
====> Generating new CA Certificate ca.pem
====> Generating new config file openssl.cnf
====> Generating new client SSL KEY client-key.pem
Generating RSA private key, 4096 bit long modulus
.......................................................................................................................................................................................++++
...........................................................................++++
e is 65537 (0x10001)
====> Generating new client SSL CSR client-csr.csr
====> Generating new client SSL CERT client-cert.pem
Signature ok
subject=/CN=example.com
Getting CA Private Key
====> Exporting client SSL P12 client-cert.p12

----------------------------
|         Finished!        |
----------------------------

$ ls /tmp/certs 
ca-key.pem  ca.pem  ca.srl  client-cert.p12  client-cert.pem  client-csr.csr  client-key.pem  openssl.cnf

```

Advanced Usage
--------------

Customize the certs using the following Environment Variables:

* `CA_KEY` CA Key file, default `ca-key.pem` __[1]__
* `CA_KEY_SIZE` CA Key size, default `8192‬` __[1]__
* `CA_CERT_PEM` CA Certificate as .pem file, default `ca.pem` __[1]__
* `CA_CERT_CRT` CA Certificate as .crt file, default `ca.crt` __[1]__ 
* `CA_CRT_FORMAT` Certificate format used for CA .crt export, default `pem`
* `CA_SUBJECT` CA Subject, default `client-auth-ca`
* `CA_EXPIRE` CA Expiry, default `1825` days
* `SSL_CONFIG` SSL Config, default `openssl.cnf` __[1]__
* `CLIENT_KEY` Client SSL Key file, default `client-key.pem`
* `CLIENT_CSR` Client SSL Cert Request file, default `client-csr.csr`
* `CLIENT_CERT` Client SSL Cert file, default `client-cert.pem`
* `CLIENT_P12` Client SSL Cert as .p12 file, default `client-cert-p12`
* `CLIENT_PASSWD` Password for Client cert .p12 file, default `password`
* `CLIENT_KEY_SIZE` Client SSL Cert size, default `4096` bits
* `CLIENT_EXPIRE` Client SSL Cert expiry, default `365` days
* `CLIENT_SUBJECT` Client SSL Subject default `example.com`
* `CLIENT_DNS` comma seperate list of alternative hostnames, no default __[2]__
* `CLIENT_IP` comma seperate list of alternative IPs, no default __[2]__

__[1] If file already exists will re-use.__

__[2] If `CLIENT_DNS` or `CLIENT_IP` is set will add `CLIENT_SUBJECT` to alternative hostname list__

Usage with Traefik
--------------
The following Traefik config in TOML format enforces [mutual TLS Authentication](https://docs.traefik.io/v2.1/https/tls/#client-authentication-mtls) with a client cert issued by ca.crt for all TLS endpoints.
```
[tls]
  [tls.options]
    [tls.options.default]
      [tls.options.default.clientAuth]
        caFiles = ["/certs/ca.crt"]
        clientAuthType = "RequireAndVerifyClientCert"
```

Deploy using docker-compose
--------------
Example docker-compose file. Remove line comments for advanced usage options.
```
version: "3.3"

services:
  client-ca:
    image: cschlipp/client-cert-ca
    container_name: Client-CA
    volumes:
      - ./certs:/certs
    restart: "no"
    network_mode: "none"
    #environment:
      #- "CA_KEY=ca-key.pem"
      #- "CA_KEY_SIZE=8192‬"
      #- "CA_CERT_PEM=ca.pem"
      #- "CA_CERT_CRT=ca.crt"
      #- "CA_CRT_FORMAT=pem"
      #- "CA_SUBJECT=client-auth-ca"
      #- "CA_EXPIRE=1825"
      #- "SSL_CONFIG=openssl.cnf"
      #- "CLIENT_KEY=client-key.pem"
      #- "CLIENT_CSR=client-csr.csr"
      #- "CLIENT_CERT=client-cert.pem"
      #- "CLIENT_P12=client-cert-p12"
      #- "CLIENT_PASSWD=password"
      #- "CLIENT_KEY_SIZE=4096"
      #- "CLIENT_EXPIRE=365"
      #- "CLIENT_SUBJECT=example.com"
      #- "CLIENT_DNS="
      #- "CLIENT_IP="
```