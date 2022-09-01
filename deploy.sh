docker build -t ravindar86/multi-client:latest -t ravindar86/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ravindar86/multi-server:latest -t ravindar86/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ravindar86/multi-worker:latest -t ravindar86/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ravindar86/multi-client:latest
docker push ravindar86/multi-server:latest
docker push ravindar86/multi-worker:latest

docker push ravindar86/multi-client:$SHA
docker push ravindar86/multi-server:$SHA
docker push ravindar86/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=ravindar86/multi-server:$SHA
kubectl set image deployments/client-deployment client=ravindar86/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ravindar86/multi-worker:$SHA