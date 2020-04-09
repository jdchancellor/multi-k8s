docker build -t jdchancellor/multi-client:latest -t jdchancellor/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jdchancellor/multi-server:latest -t jdchancellor/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jdchancellor/multi-worker:latest -t jdchancellor/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jdchancellor/multi-client:latest
docker push jdchancellor/multi-client:$SHA
docker push jdchancellor/multi-server:latest
docker push jdchancellor/multi-server:$SHA
docker push jdchancellor/multi-worker:latest
docker push jdchancellor/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jdchancellor/multi-server:$SHA
kubectl set image deployments/client-deployment client=jdchancellor/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jdchancellor/multi-worker:$SHA
