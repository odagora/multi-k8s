docker build -t odagora/multi-client:latest -t odagora/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t odagora/multi-server:latest -t odagora/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t odagora/multi-worker:latest -t odagora/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push odagora/multi-client:latest
docker push odagora/multi-client:$SHA

docker push odagora/multi-server:latest
docker push odagora/multi-server:$SHA

docker push odagora/multi-worker:latest
docker push odagora/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=odagora/multi-server:$SHA
kubectl set image deployments/client-deployment client=odagora/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=odagora/multi-worker:$SHA