docker build . -t registry.cn-shanghai.aliyuncs.com/salt87/phoenix-demo:latest

docker push registry.cn-shanghai.aliyuncs.com/salt87/phoenix-demo:latest

ssh server "./phoenix-demo.sh"
