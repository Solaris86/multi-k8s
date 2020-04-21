docker build -t nsuscevic/multi-client:latest -t nsuscevic/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nsuscevic/multi-server:latest -t nsuscevic/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nsuscevic/multi-worker:latest -t nsuscevic/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nsuscevic/multi-client:latest
docker push nsuscevic/multi-server:latest
docker push nsuscevic/multi-worker:latest

docker push nsuscevic/multi-client:$SHA
docker push nsuscevic/multi-server:$SHA
docker push nsuscevic/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nsuscevic/multi-server:$SHA
kubectl set image deployments/client-deployment client=nsuscevic/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nsuscevic/multi-worker:$SHA