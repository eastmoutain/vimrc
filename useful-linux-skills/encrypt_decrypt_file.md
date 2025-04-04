


tar -cvf directory.tar /path/to/directory
Then, use the "gpg" command to encrypt the tar archive using a symmetric key. For example −

gpg --symmetric --cipher-algo AES256 directory.tar
This will prompt you to enter and verify a passphrase, which will be used as the symmetric key.

To decrypt the directory, you would first use the "gpg" command to decrypt the archive using the symmetric key −

gpg --decrypt directory.tar.gpg > directory.tar
Then, use the "tar" command to extract the files from the decrypted archive −

tar -xvf directory.tar
