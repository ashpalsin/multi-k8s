docker build -t stephengrider/multi-client:latest -t stephengrider/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stephengrider/multi-server:latest -t stephengrider/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stephengrider/multi-worker:latest -t stephengrider/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ashpalsin/multi-client:latest
docker push ashpalsin/multi-server:latest
docker push ashpalsin/multi-worker:latest
docker push ashpalsin/multi-client:$SHA
docker push ashpalsin/multi-server:$SHA
docker push ashpalsin/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ashpalsin/multi-server:$SHA
kubectl set image deployments/client-deployment client=ashpalsin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ashpalsin/multi-worker:$SHA