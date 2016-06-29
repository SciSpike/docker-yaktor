[![yaktor image](yaktor.png)](http://yaktor.io)


# Docker Image

## Run/Create a Yaktor application

```
docker run -it -v "$PWD":/app --rm yaktor/yaktor:0.3 yaktor create test
cd test
yak gen-src gen-views start
```

## How to build for testing

```
docker build -t yaktor/yaktor:0.3 .
```

