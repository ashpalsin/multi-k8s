echo $SHA
docker build -t ashpalsin/multi-client:latest -t ashpalsin/multi-client:$SHA -f ./client/Dockerfile.txt https://github.com/ashpalsin/multi-k8s/tree/master/client
docker build -t ashpalsin/multi-server:latest -t ashpalsin/multi-server:$SHA -f ./server/Dockerfile.txt https://github.com/ashpalsin/multi-k8s/tree/master/server
docker build -t ashpalsin/multi-worker:latest -t ashpalsin/multi-worker:$SHA -f ./worker/Dockerfile.txt https://github.com/ashpalsin/multi-k8s/tree/master/worker
docker push ashpalsin/multi-client:latest
docker push ashpalsin/multi-server:latest
docker push ashpalsin/multi-worker:latest
docker push ashpalsin/multi-client:$SHA
docker push ashpalsin/multi-server:$SHA
docker push ashpalsin/multi-worker:$SHA
kubectl apply -f K8s
kubectl set image deployments/server-deployment server=ashpalsin/multi-server:$SHA
kubectl set image deployments/client-deployment client=ashpalsin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ashpalsin/multi-worker:$SHA