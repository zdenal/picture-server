# Picture-Server

## Run within docker

```shell
$ docker build -t picture-server .
$ docker run -p 8080:3000 -it picture-server bundle exec thin start -p 3000
```

App will run on port localhost:8080
