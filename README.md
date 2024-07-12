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

## Pyenv inside containers

NOTE: although the working dir can define which env to point to, without further finagling the envs themselves
will be in the non-mounted part of the container (because they will be in e.g. `/root/.pyenv/versions`).
So it is better generally to stick python deps in the container build step, as installing them from the mounted
workspace dir will tend to have more work to do.

## Next steps

Current plan is to develop things on a public docker repo, by only having dependencies in that container and keeping
everything else in volume / git

## Useful commands

```
docker stop theta-container-trial; docker run -d -p 1022:22 --rm --name theta-container-trial byronthomas712/trial-container:2.0
```

docker build -t byronthomas712/trial-container:2.3 -f Dockerfile --build-arg SSH_PUBLIC_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKYUnKSFuRmpvjjkWDeb0+/2q7qloJsIWosfO/xc6zhQ byron.thomas@gmail.com" .

ssh -p 1022 -i ~/.ssh/id_ed25519 root@localhost

docker build --build-arg BASE_IMAGE_TAG=2.3 -t byronthomas712/trial-container:2.3-dev -f Dockerfile.dev .
