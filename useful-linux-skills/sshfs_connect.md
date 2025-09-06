# install sshfs
- macos
  on MacOS, you need to install sshfs
  ```sh
  brew install sshfs
  ```
- ubuntu
  on Ubuntu, you need to install sshfs
  ```sh
  sudo apt-get install sshfs
  ```
- centos
  on CentOS, you need to install sshfs
  ```sh
  sudo yum install sshfs
  ```

# mount remote directory
- allow other user to mount
  uncoment `user_allow_other` in file /etc/fuse.conf

  ```sh
  sudo sed -i 's/#user_allow_other/user_allow_other/g' /etc/fuse.conf
  ```

- mounte the remote directory by sshfs command 
  ```sh
  SSHFS_USER="user"
  REMOTE_HOST="192.168.1.2"
  LOCAL_DIR=/path/to/local/directory
  REMOTE_DIR=/path
  mkdir -p $LOCAL_DIR
  sshfs -o allow_other,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,uid=$(id -u),gid=$(id -g) $SSHFS_USER@$REMOTE_HOST:$REMOTE_DIR $LOCAL_DIR
  ```
