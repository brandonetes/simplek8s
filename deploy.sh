docker build -t brandonetes/multi-client:latest -t brandonetes/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brandonetes/multi-server:latest -t brandonetes/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brandonetes/multi-worker:latest -t brandonetes/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push brandonetes/multi-client:latest
docker push brandonetes/multi-server:latest
docker push brandonetes/multi-worker:latest
docker push brandonetes/multi-client:$SHA
docker push brandonetes/multi-server:$SHA
docker push brandonetes/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=brandonetes/multi-server:$SHA
kubectl set image deployments/client-deployment server=brandonetes/multi-client:$SHA
kubectl set image deployments/worker-deployment server=brandonetes/multi-worker:$SHA
