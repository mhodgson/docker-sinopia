# S3-Backed Sinopia (Docker image)
Sinopia is a private npm repository server. This version uploads its npm packages into an S3 bucket for easy (and automatic) backup.

## Pulling docker-hub image
` docker pull ndigati/docker-sinopia `

## Create container
```
 docker run --name sinopia -d -e SINOPIA_STORAGE_BUCKET=<fill-in> -e SINOPIA_CONFIG_BUCKET=<fill-in> -p 4873:4873 sinopia
```


## To use the registry
` npm set registry http://<docker_host_ip>:4873/ `

## Building and running yourself
1. Clone the repo:

  ```
  git clone https://github.com/ndigati/docker-sinopia.git
  ```

2. Change to new directory and build the image:

 ```bash
 cd docker-sinopia
 docker build -t sinopia .
 ```

3. Run the container:
	```
   docker run --name sinopia -d -e SINOPIA_STORAGE_BUCKET=<fill-in> -e SINOPIA_CONFIG_BUCKET=<fill-in> -p 4873:4873 sinopia
  ```

4. Sinopia should now be running on your machine at `<docker_host_ip>:4873` and syncing its contents to an S3 bucket `$SINOPIA_STORAGE_BUCKET`

# Links
- [Sinopia on Github](https://github.com/rlidwka/sinopia)
- [Sinopia's own Docker image](https://hub.docker.com/r/keyvanfatehi/sinopia/)
