FROM centos:7

LABEL name="kube-diag" \
    vendor="CentOS" \
    os-version="7" \
    license="GPLv2" \
    build-date="20170717" \
    oc-client-version="v1.5.1-7b451fc-linux-64bit" \
    kubectl-version="1.7.0" \
    maintainer="sahinerokan@gmail.com" 

RUN yum install -y \
wget \
nmap \
ping \
telnet \
curl 

RUN mkdir -p /tmp/oc \
&& wget -q https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl -O /bin/kubectl \
&& chmod 755 /bin/kubectl


RUN wget -q https://github.com/openshift/origin/releases/download/v1.5.1/openshift-origin-client-tools-v1.5.1-7b451fc-linux-64bit.tar.gz -O /tmp/oc/oc_client.tar.gz \
&& tar -zxvf /tmp/oc/oc_client.tar.gz -C /tmp/oc/ \
&& mv /tmp/oc/openshift-origin-client-tools-v1.5.1-7b451fc-linux-64bit/oc /bin/ \
&& rm -rf /tmp/oc 

RUN yum install -y yum-utils \
&& yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo \
&& yum install -y openresty \
&& wget -q https://raw.githubusercontent.com/bungle/lua-resty-template/master/lib/resty/template.lua -O /usr/local/openresty/site/lualib/template.lua

RUN ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log
RUN ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log 

ADD nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
ADD entrypoint.sh /entrypoint.sh

RUN chmod -R g+w /usr/local/openresty
RUN chmod g+x /entrypoint.sh

USER 1000000


EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]

