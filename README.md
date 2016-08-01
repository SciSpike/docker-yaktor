[![yaktor image](http://yaktor.io/pics/yaktor-logo.png)](http://yaktor.io)


# Docker Image

## To Create & Run a Yaktor Application

```
docker run -it -v "$PWD":/app --rm yaktor/yaktor yaktor create test
cd test
yak gen-src gen-views start
```
Or, if you like `alias`:
```
alias yaktor-create='docker run -it -v "$PWD":/app --rm yaktor/yaktor yaktor create'
yaktor-create test
cd test
yak gen-src gen-views start
```

## How to Build for Testing
### TL;DR
```
./create-local-dev-image <pathToYourYaktor>
```
will create an image locally called `yaktor/yaktor:dev`.  Then,
* `cd` to some test directory,
* create a yaktor application with `docker run -it -v "$PWD":/app --rm yaktor/yaktor:dev yaktor create foobar`,
* `cd foobar`,
* change the `FROM` command in the `docker/Dockerfile` to `FROM yaktor/yaktor:dev`,<sup>[1](#1)</sup> and
* test as needed.

### Long Story
If you're developing yaktor itself and need to create a new image based on changes you have locally, use the handy script `create-dev-image`.  Its first argument should be the path to your local yaktor directory (where you're doing your work, like `~/dev/yaktor` or whatever), then any arguments you'd give `docker build` _except_ `-f/--file` (the script uses `Dockerfile.localyaktor`) and the positional argument `PATH | URL | -`. See `docker help build` and the script source for more information.  Example:
```
./create-local-dev-image ~/dev/yaktor -t yaktor/yaktor:mine
```
Once the image is built, change to a temporary directory and run command
```
docker run -it -v "$PWD":/app --rm yaktor/yaktor:mine yaktor create yourtest
```
to generate yaktor application `yourtest` using the image you just built.

After that, update the `FROM` command in `yourtest/docker/Dockerfile` to use the image you specified (`yaktor/yaktor:mine` in this example).<sup>[1](#1)</sup>

Now, you can `cd yourtest` and run the application normally with `yak gen-src gen-views start` & test as needed.

<a name="1">1</a>: Hopefully, we'll be able to automate this step in the future.
