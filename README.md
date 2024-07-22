# Theta VLLM Llama-Index container stack

This is a set of Dockerfiles that handles building a base stack to build on top of for a GPU-cloud like
Theta EdgeCloud. It contains:

* Ubuntu
* pyEnv
* Python 3.11.8 - set using pyEnv to be the global python version
* Flask & Fastapi - two choices for using a webserver
* vLLM - a local LLM management framework with multi-processor support
* Llama Index - a framework wrapping up LLMs with RAG and Agent features

## Dev container

There is also a dev Dockerfile that adds pytest

## Build new tag - for both containers

```
export TVLI_TAG=1.1
docker build -t "byronthomas712/theta-vllm-llama-index:$TVLI_TAG" -f Dockerfile  .
docker build --build-arg BASE_IMAGE_TAG=$TVLI_TAG -t "byronthomas712/theta-vllm-llama-index:$TVLI_TAG-dev" -f Dockerfile.dev .
```

