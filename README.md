# lxrDocker
A Docker Container for LXR.

LXR is a general source code indexer and cross-referencer providing web-based browsing of source code.

lxrDocker image based on base image ubuntu:16.04 with lxr 2.2.1.

# Usage

The are two things your need to provide to image. first is the public ip address used by lxr perl cgi. And the second one
it the project you want to index. it should include the source code files and the version name.
This images only support  single project but multiple versions and you should put all them under same directory.


the docker run command is   
`docker run -v ${source_path}/source -p ${connect_port}/80 ${ip_address} ${version1} ${version2}...${version10}`

## Explanation
- **source_path**: the location of your project's source code files
- **connect_port**: the port you used to connect from outside.
- **ip_address**: the public ip address of your host, it should be same as the ip address in your browser.
- **versions**: source code versions of your project. For each version, you should have one directory in ${source_path} and the name of directory should equal to the version.

## Example
Download the **ceph** source code with three different versions and store them into /tmp directory

```bash
>ll /tmp
total 12K
drwxr-xr-x 23 root root 4.0K Jun  6 13:40 master
drwxr-xr-x 23 root root 4.0K Jun  6 13:52 v12.0.3
drwxr-xr-x 23 root root 4.0K Jun  6 13:48 v9.2.1
```

assume the public ip address is 10.2.3.4 and type the following command to pull the image and run the lxr server.

```
docker pull hwchiu/lxr:single
docker run --name lxr -it -v tmp:/source   -p 800180  hwchiu/lxr:single   104.154.246.9  master v12.0.3 v9.2.1
```

After that, open your browser and type the **10.2.3.4:8001/lxr/source** in the serach bar and you will see something like below.
I use the drbd for below example.
![aa](http://i.imgur.com/52T0hk9.png)

