# Docker Container for Kubernetes and Openshift Diagnostics & Troubleshooting

The Images is based on Centos7 with some troubleshooting tools installed;
* nmap
* ping
* curl
* wget
* telnet
* kubectl
* oc
* openresty server (nginx with lua) 

nginx.conf taken from gcr.io/google-containers/echoserver

to use:

`docker pull okansahiner/kube-diag`

or

`docker run -it -p 8080:8080 okansahiner/kube-diag:latest`


