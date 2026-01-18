# READemption with Docker

## Step-1: Pull Docker Image

```bash
sudo docker pull tillsauerwein/reademption
```

## Step-2: Run READemption container
```bash
sudo docker run -i -t -v /home/codanics:/home/codanics \
    -w /home/codanics/04_rnaseq/docker tillsauerwein/reademption:latest
```

## Step-3: Run READemption
```bash
reademtion --help
```
