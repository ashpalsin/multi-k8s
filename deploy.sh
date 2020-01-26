echo $SHA
chmod 0755 client
chmod 0755 server
chmod 0755 worker
docker build -t ashpalsin/multi-client:latest -t ashpalsin/multi-client:$SHA -f ./client/Dockerfile.txt ./client
docker build -t ashpalsin/multi-server:latest -t ashpalsin/multi-server:$SHA -f ./server/Dockerfile.txt ./server
docker build -t ashpalsin/multi-worker:latest -t ashpalsin/multi-worker:$SHA -f ./worker/Dockerfile.txt ./worker
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