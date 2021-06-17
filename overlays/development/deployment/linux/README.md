# Running on Linux

## Using Minikube

* Follow the directions to get a snapshot tar file.
* Extract the tar file to a directory for minikube to use. (ie: /home/me/idc/idc/)
* Start minikube with the following: `minikube start --mount-string=/home/me/idc/ --mount`
** NOTE: The directory should be one up from the idc directory you extracted and made from the tar file.
* go into the `overlays/development/definitions/linux/resources/` directory and run `./generate_secrets.sh`
* Run the following to start up the stack: `kustomize build . | kubectl apply -f -`

