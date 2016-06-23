[![Yaktor Logo](https://s.gravatar.com/avatar/64ecb24ea406d1b93e13b5e9fc75b8c0?s=80)](http://yakter.io/)
Yaktor

## Run/Create a Yaktor application

assuming your PATH=./node_modules/.bin:$PATH 

```
docker run -it -v "$PWD":/app --rm yaktor/yaktor yaktor create test
cd test
yak grunt gen-src gen-views start
```

##

## How to build for testing

```
docker build -t yaktor/yaktor:latest .
```