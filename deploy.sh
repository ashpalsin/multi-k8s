docker build -t ashpalsin/multi-client:latest -t ashpalsin/multi-client:$SHA -f .\client\Dockerfile .\client
docker build -t ashpalsin/multi-server:latest -t ashpalsin/multi-server:$SHA -f .\server\Dockerfile .\server
docker build -t ashpalsin/multi-worker:latest -t ashpalsin/multi-worker:$SHA -f .\worker\Dockerfile .\worker
docker push ashpalsin/multi-client:latest
docker push ashpalsin/multi-server:latest
docker push ashpalsin/multi-worker:latest

docker push ashpalsin/multi-client:$SHA
docker push ashpalsin/multi-server:$SHA
docker push ashpalsin/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ashpalsin/multi-server:$SHA
kubectl set image deployments/client-deployment server=ashpalsin/multi-client:$SHA
kubectl set image deployments/worker-deployment server=ashpalsin/multi-worker:$SHA