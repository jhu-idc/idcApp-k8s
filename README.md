# idcApp-k8s
Base application repository for the iDC kubernetes project.

## Quick start

1. Extract snapshot content into a tar file.  Currently, idcApp-k8s does not have a convenient way of handling snapshots, so this must be handled manually.

   a. Identify a snapshot image to extract.  Copy the latest image tag from [the github package registry](https://github.com/orgs/jhu-sheridan-libraries/packages/container/package/idc-isle-dc%2Fsnapshot), or look in `idc-isle-dc/.env`.  For example, `ghcr.io/jhu-sheridan-libraries/idc-isle-dc/snapshot:upstream-20201007-739693ae-213-g3669e99.1616768917`.

   b. Extract a tar file from the snapshot image via `snapshot=$(docker create <IMAGE>); docker export $snapshot > data.tar`.  For example,
     <pre>
      snapshot=$(docker create ghcr.io/jhu-sheridan-libraries/idc-isle-dc/snapshot:upstream-20201007-739693ae-213-g3669e99.1616768917); \
      docker export $snapshot > data.tar
     </pre>

1. Extract the `data` directory of the tar file to the right location for your platform; then re-name it to `idc`.  _if there is a pre-existing `idc` directory present, delete it.  The kubernetes app uses this directory as a bind mount volume for all persistent state.  So deleting the existing idc directory and replacing it with content extracted from the snapshot will start from a clean/empty snapshot_.

   a. Windows (wsl2):  `tar -C /mnt/c/kubernetes -xvf data.tar data;  mv /mnt/c/kubernetes/data /mnt/c/kubernetes/idc`

   b. Linux:  `tar -C /minukube-host/ -xvf data.tar data;  mv /minikube-host/data /minikube-host/idc`

   c. Mac:  ??

1. `cd` into the overlays/development/&lt;PLATFORM&gt; directory for your platform.

1. Run `kubectl kustomize . | kubectl apply -f -` to start the stack!

## Development
To develop this application, clone https://github.com/jhu-sheridan-libraries/idc-kubernetes with recursion. This is a submodule of that repository. 
