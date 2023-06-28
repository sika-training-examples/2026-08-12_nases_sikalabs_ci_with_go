[Ondrej Sika (sika.io)](https://sika.io) | <ondrej@sika.io>

# Golang Training

## Course

## Install Go

- https://go.dev/doc/install

### Mac

```
brew install golang
```

## Setup Go Project

```
mkdir hello-world
```

```
cd hello-world
```

### VS Code Setup

Install Go extension

- https://marketplace.visualstudio.com/items?itemName=golang.Go

Optional extensions

- https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig

For monorepo support add to `settings.json`

```json
"gopls": {
    "experimentalWorkspaceModule": true,
}
```

### editorconfig

Create `.editorconfig` file

```
root = true
[*]
indent_style = space
indent_size = 2
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true
end_of_line = lf
max_line_length = off
[Makefile]
indent_style = tab
[*.go]
indent_style = tab
```

Create `.editorconfig` file using **slu**

```
slu ft ec --go
```

### gitignore

Create simple `.gitignore` where `hello-world` is the output binary, which is the package name.

```gitignore
# Global
.DS_Store

# Editor
.vscode

# Go
/hello-world
/hello-world.exe
/dist
```

or using `slu ft gitignore --go --go-package hello-world`

### go mod init

```
go mod init hello-world
```

or

```
go mod init github.com/ondrejsika/hello-world
```

### main.go

Create `main.go` file

```go
package main

import "fmt"

func main() {
  fmt.Println("Hello World")
}
```

## go run

```
go run main.go
```

or

```
go run .
```

## go build

Build

```
go build
```

and run

```
./hello-world
```

or on windows

```
./hello-world.exe
```

Build to custom name

```
go build -o dist/hello
```

You can build single file using `go build example-server.go` and output will be `example-server`

### Cross Platform Build

```
GOOS=linux GOARCH=amd64 go build -o dist/hello-linux-amd64
GOOS=darwin GOARCH=arm64 go build -o dist/hello-darwin-arm64
GOOS=windows GOARCH=amd64 go build -o dist/hello-windows-amd64.exe
```

## A Tour of Go

https://go.dev/tour/list

### Offline Tour

Install

```
go install golang.org/x/website/tour@latest
```

Run

```
~/go/bin/tour
```

## Go By Example

https://gobyexample.com/

## Go Install

```
go install github.com/sikalabs/hello-world-server@latest
```

## CLI with Cobra

- https://github.com/spf13/cobra

Examples

- Simple Example - https://github.com/ondrejsika/golang-examples/tree/master/cobra_example_simple
- Quick Start Example - https://github.com/ondrejsika/golang-examples/tree/master/cobra_example

## Configuration with Viper

- Viper with only environment variables - https://github.com/ondrejsika/golang-examples/tree/master/viper_env_only
- Simple Viper example - https://github.com/ondrejsika/golang-examples/tree/master/viper_example
- Cobra and Viper - https://github.com/ondrejsika/golang-examples/tree/master/viper_and_cobra_example_advanced

## Build Optiopns

For smaller binaries

```
go build --ldflags "-s -w"
```

Trim paths

```
go build --trimpath
```

Final production build

```
go build --trimpath --ldflags "-s -w"
```

## Goreleaser

- https://goreleaser.com/
- https://github.com/goreleaser/goreleaser

### Install Goreleaser

- https://goreleaser.com/install/

### Install Goreleaser using Go

```
go install github.com/goreleaser/goreleaser@latest
```

### Install Goreleaser on Mac

```
brew install goreleaser
```

### Create `.goreleaser.yaml`

```
gorleaser init
```

or here is my example of `.goreleaser.yaml`

```yaml
project_name: hello-world

before:
  hooks:
    - rm -rf dist
    - go mod tidy
    - git push
    - git push --tags

builds:
  - env:
      - CGO_ENABLED=0
    goos:
      - linux
      - windows
      - darwin
    flags:
      - -trimpath
    ldflags:
      - -s
      - -w
      - -X hello-world/version.Version=v{{.Version}}

snapshot:
  name_template: "{{ incminor .Version }}-dev"

archives:
  - format: tar.gz
    name_template: "{{ .ProjectName }}_v{{ .Version }}_{{ .Os }}_{{ .Arch }}"
    format_overrides:
      - goos: windows
        format: zip

checksum:
  name_template: "{{ .ProjectName }}_checksums.txt"
  algorithm: sha256
```

For custom Gitlab, you have to add `gitlab_urls` section

```yaml
gitlab_urls:
  api: https://gitlab.sikalabs.com/api/v4/
  download: https://gitlab.sikalabs.com
```

### Goreleaser Build

Snapshot

```
goreleaser build --snapshot --rm-dist
```

Release build

```
git tag v0.1.0
```

```
goreleaser build --rm-dist
```

### Goreleaser Release

```
goreleaser release --rm-dist
```

or just

```
goreleaser
```

Download the release from Github using **slu** on Mac

```
slu install-any-bin \
  --url https://github.com/ondrejsika/example-for-golang-training/releases/download/v0.1.0/hello-world_v0.1.0_darwin_arm64.tar.gz \
  --name hello-world \
  --bin-dir .
```

or on Linux

```
slu install-any-bin \
  --url https://github.com/ondrejsika/example-for-golang-training/releases/download/v0.1.0/hello-world_v0.1.0_linux_amd64.tar.gz \
  --name hello-world \
  --bin-dir .
```

## Logging

- https://github.com/rs/zerolog
- https://github.com/sirupsen/logrus

### Logging with Zerolog

- https://github.com/ondrejsika/golang-examples/tree/master/zerolog_example

## Writing Docs

- https://go.dev/blog/godoc

Example

- https://gitlab.sikalabs.com/go/hello-from-gitlab-demo
- https://pkg.go.dev/gitlab.sikalabs.com/go/hello-from-gitlab-demo

### godoc server

Install

```
go install golang.org/x/tools/cmd/godoc@latest
```

Run

```
~/go/bin/godoc -http=:8080
```

### Private Modules

Set `GOPRIVATE` env variable

```
export GOPRIVATE=gitlab.sikalabs.com,gitlab.sikademo.com
```

```
export GOPRIVATE='*'
```

Use ssh keys instead of https on `gitlab.sikalabs.com`

```
git config --global url."git@gitlab.sikalabs.com:".insteadOf "https://gitlab.sikalabs.com/"
```

or use `.netrc` file

```
machine gitlab.sikalabs.com
login token
password glpat-rKKSwt8izeXUGGWu7PEV
```

Example

```
go get -u gitlab.sikalabs.com/go/hello-from-gitlab-private
```

```go
// main.go

package main

import "gitlab.sikalabs.com/go/hello-from-gitlab-private"

func main() {
	hello.HelloFromGitlab()
}
```

## Thank you! & Questions?

That's it. Do you have any questions? **Let's go for a beer!**

### Ondrej Sika

- email: <ondrej@sika.io>
- web: <https://sika.io>
- twitter: [@ondrejsika](https://twitter.com/ondrejsika)
- linkedin: [/in/ondrejsika/](https://linkedin.com/in/ondrejsika/)
- Newsletter, Slack, Facebook & Linkedin Groups: <https://join.sika.io>

_Do you like the course? Write me recommendation on Twitter (with handle `@ondrejsika`) and LinkedIn (add me [/in/ondrejsika](https://www.linkedin.com/in/ondrejsika/) and I'll send you request for recommendation). **Thanks**._

Wanna to go for a beer or do some work together? Just [book me](https://book-me.sika.io) :)

## Resources

- Example Project - https://github.com/ondrejsika/example-for-golang-training
- Golang Examples - https://github.com/ondrejsika/golang-examples
- My Golang Projects
  - slu - CLI utils - https://github.com/ondrejsika/slu
  - gobble - Ansible alternative in Go - https://github.com/ondrejsika/gobble
  - tergum - Backup tool - https://github.com/ondrejsika/slu

## Training Sessions

#### 2023-05-29

- https://github.com/golang-training-examples/example1
- https://gitlab.sikalabs.com/go/hello-world
