docker build -t alidesoki/multi-client:latest -t alidesoki/multi-client:$SHA ./client/Dockerfile ./client
docker build -t alidesoki/multi-server:latest -t alidesoki/multi-server:$SHA ./server/Dockerfile ./server
docker build -t alidesoki/multi-worker:latest -t alidesoki/multi-worker:$SHA ./worker/Dockerfile ./worker

docker push alidesoki/multi-client:latest
docker push alidesoki/multi-server:latest
docker push alidesoki/multi-worker:latest
docker push alidesoki/multi-client:$SHA
docker push alidesoki/multi-server:$SHA
docker push alidesoki/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=alidesoki/multi-server:$SHA
kubectl set image deployments/client-deployment client=alidesoki/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alidesoki/multi-worker:$SHA