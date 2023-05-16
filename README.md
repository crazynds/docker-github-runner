# Github-runner

Docker image to create a self hosted github runner.

Runners are the machines that execute jobs in a GitHub Actions workflow. For example, a runner can clone your repository locally, install testing software, and then run commands that evaluate your code.

GitHub provides runners that you can use to run your jobs, or you can host your own runners. Each GitHub-hosted runner is a new virtual machine (VM) hosted by GitHub with the runner application and other tools preinstalled, and is available with Ubuntu Linux, Windows, or macOS operating systems. When you use a GitHub-hosted runner, machine maintenance and upgrades are taken care of for you.


## Getting Started

### Usage

#### Container Parameters

```shell
docker run crazynds/github-runner -v '/var/run/docker.sock:/var/run/docker.sock' -e URL $URL -e TOKEN $TOKEN
```

#### Docker compose


```yaml
version: '3'
services:
  runner:
    image: crazynds/github-runner
    restart: unless-stopped
    volumes:
      - './data:/runner'
      - '/var/run/docker.sock:/var/run/docker.sock'
    environment:
      URL: ${URL}
      TOKEN: ${TOKEN}
```

#### Environment Variables

* `URL` - Url of repository
* `TOKEN` - Token for github repository. 

You can get this in *Repository*->Settings->Actions->Runners->New Self Hosted Runner (_Configure_ section)



#### Useful File Locations

* `/runner` - Saved data from github used by runner.
* `/var/run/docker.sock` - You have to map docker socket to runner be able to use docker.

## Built With

* Github-runner v2.304.0
* Ubuntu:lunar

## Find Us

* [GitHub](https://github.com/crazynds/docker-github-runner)

## Authors

* **Luiz H** - [Crazynds](https://github.com/crazynds)


## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/crazynds/docker-github-runner/blob/main/LICENSE) file for details.
