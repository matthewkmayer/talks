### Step one: dockerized ruby service
cd code/step_one
# build named docker container:
docker build -t strangler .

# run docker container, allowing ctrl-c to detach and expose port 9494 on local machine:
docker run -t -p 9494:9494 --name strangler strangler

# Demo all ruby code:
curl localhost:9494/v1/user | jq
curl localhost:9494/v1/user/1 | jq

# cucumber:
cucumber

### Step two: delegate approach
docker rm -f strangler

cd ../step_two
docker build -t strangler .

docker run -t -p 9494:9494 --name strangler strangler

# Demo proxy code:
curl localhost:9494/v1/user | jq
curl localhost:9494/v1/user/1 | jq

# cucumber:
cucumber

# Logs show the Golang version was hit:
docker logs strangler

### Step three: nginx in front:
docker rm -f strangler

cd ../step_three
docker build -t strangler .

docker run -t -p 9494:9494 --name strangler strangler

# Demo all ruby code:
curl localhost:9494/v1/user | jq
curl localhost:9494/v1/user/1 | jq

# cucumber:
cucumber

# show ruby code wasn't hit:
docker logs strangler

# cleanup
docker rm -f strangler

# Danger zone
# rebuild Go app in step three for linux:
GOOS=linux go build -o strangler