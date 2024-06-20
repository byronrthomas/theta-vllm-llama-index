# Trial container

## Build a new tag

```
docker build -t byronthomas712/trial-container:0.1 .
```

## Run from tag

```
docker run -d -p 5000:5000 --rm --name theta-container-trial byronthomas712/trial-container:0.1 --bind-all
```

## Storage inside containers

Typically mounted at /workspace

- So make sure anything else FROM A CONTAINER gets put into /usr/app or whatever..
- Need to think how this plays with the Theta kind of containers, but can save this for later

## Next steps

Next steps:

1. X - Get SSH compatible thing running by pushing trial container type stuff
2. X - On that, double-check my files (/workspace) and try and change that
3. Inside of that container, attempt to install a specific python and a vllm etc
   TODO: will this be part of the real solution or no?
4. On that, double-check my files and try and change that

Current plan is to develop things on a public docker repo, by only having dependencies in that container and keeping
everything else in volume / git

```
docker run -d -p 1022:22 --rm --name theta-container-trial byronthomas712/trial-container:1.0
```

SSH_PUBLIC_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKYUnKSFuRmpvjjkWDeb0+/2q7qloJsIWosfO/xc6zhQ byron.thomas@gmail.com" docker build -t byronthomas712/trial-container:1.0 -f Dockerfile .

docker build -t byronthomas712/trial-container:1.0 -f Dockerfile --build-arg SSH_PUBLIC_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKYUnKSFuRmpvjjkWDeb0+/2q7qloJsIWosfO/xc6zhQ byron.thomas@gmail.com" .

ssh -p 1022 -i ~/.ssh/id_ed25519 root@localhost
