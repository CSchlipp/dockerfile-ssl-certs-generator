Self Signed SSL Client Certificate Generator
=================================================

About
-----
Origin: https://github.com/stakater/dockerfile-ssl-certs-generator

This is a small docker image based off `alpine linux` which allows you to create one or multiple client certificates for mutual TLS authentication.

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