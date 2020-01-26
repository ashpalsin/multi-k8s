echo $SHA
chmod 0755 client
chmod 0755 server
chmod 0755 worker
sudo docker build -t ashpalsin/multi-client:latest -t ashpalsin/multi-client:$SHA -f ./client/Dockerfile.txt ./client
sudo docker build -t ashpalsin/multi-server:latest -t ashpalsin/multi-server:$SHA -f ./server/Dockerfile.txt ./server
sudo docker build -t ashpalsin/multi-worker:latest -t ashpalsin/multi-worker:$SHA -f ./worker/Dockerfile.txt ./worker
sudo docker push ashpalsin/multi-client:latest
sudo docker push ashpalsin/multi-server:latest
sudo docker push ashpalsin/multi-worker:latest
sudo docker push ashpalsin/multi-client:$SHA
sudo docker push ashpalsin/multi-server:$SHA
sudo docker push ashpalsin/multi-worker:$SHA
kubectl apply -f K8s
kubectl set image deployments/server-deployment server=ashpalsin/multi-server:$SHA
kubectl set image deployments/client-deployment client=ashpalsin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ashpalsin/multi-worker:$SHA