COMMON_NAME = ns_nginx

IMAGE = $(COMMON_NAME)
NAME = $(COMMON_NAME)

# --user root
# -v $$PWD/app:/usr/src/app
# -p 80:80
# -e "ENVVAR=1"
# --link="mysql:mysql.ccl"
PARAMS = -p 8080:8080 \
		--add-host="api.ccl:172.17.0.7" \
		-v $$NODESTACK_NGINX_PATH/config:/etc/nginx \
		-v $$NODESTACK_NGINX_PATH/keys:/keys \
		-v $$NODESTACK_PROJECTS_PATH:/projects

.PHONY: build run rund runsh stop inspect logs test

build:
		docker build -t $(IMAGE) .

run:
		docker run --rm -it --name $(NAME) $(PARAMS) $(IMAGE)

rund:
		docker run -d --name $(NAME) $(PARAMS) $(IMAGE)

runsh:
		docker run --rm -it --name $(NAME) $(PARAMS) $(IMAGE) bash

stop:
		docker stop $(NAME)
		docker rm $(NAME)

inspect:
		docker exec -it $(NAME) bash

logs:
		docker logs $(NAME)

test:
		docker run --rm -it --name $(NAME) $(PARAMS) $(IMAGE) nginx -t