#!/bin/bash

###################################################################
#Script Name	:  build_versions.sh                                                                                            
#Description	: builds containerized DPDK, with tags for different versions
#               : default container name will be dpdk, if you have ptp as either 1st or 2nd
#               : parameter then it will be dpdk-ptp.                                                                               
#Args           : [p] - build all versions in parallel [ptp] - build with ptp enabled                                                                                          
#Author       	: Patrick Kutch                                                
#Email         	: Patrick.G.Kutch@Intel.com                                           
###################################################################


DOCKER_REPO="patrickkutch"
IMAGE_NAME="hping"
  

#pick up proxy settings
# I use no-cache to make sure I pick up latest repo
# probably a more efficient way of doing this, but this works for now
#export Params="--no-cache --build-arg http_proxy=$http_proxy --build-arg https_proxy=$http_proxy --build-arg HTTP_PROXY=$http_proxy --build-arg HTTPS_PROXY=$http_proxy --network=host"
export Params="--build-arg http_proxy=$http_proxy --build-arg https_proxy=$http_proxy --build-arg HTTP_PROXY=$http_proxy --build-arg HTTPS_PROXY=$http_proxy --network=host"

buildIt() {
    #echo docker build $Params --build-arg DPDK_VER=$dpdkVer --rm -t $DOCKER_REPO/$IMAGE_NAME:$dpdkVer .
    docker build $Params --rm -t $DOCKER_REPO/$IMAGE_NAME .
}
 
pushIt() {
    docker push $DOCKER_REPO/$IMAGE_NAME
}

buildIt
pushIt
