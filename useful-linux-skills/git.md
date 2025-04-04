# useful git command

## git remote

### git remote add

* add local repo path
```sh
$ git remote add repo_name /path/to/repo
```

* add remote repo from ssh
```sh
$ git remote add git remote add repo_name ssh://IP:port/path/to/repo
```

for example:
    1. from local guest to host,
    ```sh
    $git remote add ssh://10.0.2.2:/path
    ```
    2. from host ot local guest
    ```sh
    $ git remote add ssh://localhost:2222/path
    ```


