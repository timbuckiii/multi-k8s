docker build -t timbuckiii/multi-client:latest -t timbuckiii/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t timbuckiii/multi-server:latest -t timbuckiii/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t timbuckiii/multi-worker:latest -t timbuckiii/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push timbuckiii/multi-client:latest
docker push timbuckiii/multi-server:latest
docker push timbuckiii/multi-worker:latest
docker push timbuckiii/multi-client:$SHA
docker push timbuckiii/multi-server:$SHA
docker push timbuckiii/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image depoyments/server-deployment server=timbuckiii/multi-server:$SHA
kubectl set image depoyments/client-deployment client=timbuckiii/multi-client:$SHA
kubectl set image depoyments/worker-deployment server=timbuckiii/multi-worker:$SHA