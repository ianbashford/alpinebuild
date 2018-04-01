# remove old image, and build
docker rmi alpinebuild
docker build -t alpinebuild .
