docker run -d --restart=always --privileged -v /var/run/docker.sock:/var/run/docker.sock -p 8888:80 --name haproxy-balancer docker-gen-haproxy-branch
