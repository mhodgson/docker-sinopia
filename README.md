# S3-Backed Sinopia (Docker image)
Sinopia is a private npm repository server. This version uploads its npm packages into an S3 bucket for easy (and automatic) backup.

## Installing Image
` docker pull ndigati/docker-sinopia `

### Building and running yourself
1. Clone the repo:  
	` git clone https://github.com/ndigati/docker-sinopia.git `
2. Change to new directory and Build the image:  
	```bash
	cd docker-sinopia
	docker build -t sinopia . 
	```
3. Run the container:  
	` docker run --name sinopia --privileged -d -e AWS_ACCESS_KEY_ID=<fill-in> -e AWS_SECRET_ACCESS_KEY=<fill-in> -e SINOPIA_BUCKET=<fill-in> -p 4873:4873 sinopia `
4. Sinopia should now be running on your machine at `<docker-ip>:4873` and syncing its contents to an S3 bucket `$SINOPIA_BUCKET`

# Links
- [Sinopia on Github](https://github.com/rlidwka/sinopia)
- [Inspiration for Docker set-up config](https://github.com/rlidwka/sinopia/pull/357/files)
- [Sinopia's own Docker image](https://hub.docker.com/r/keyvanfatehi/sinopia/)
