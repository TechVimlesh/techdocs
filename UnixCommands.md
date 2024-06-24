**Download a file using wget**

- **Password is visible to anyone**
   - wget --user=remote_user --password=SECRET https://www.google.com/file.ext

- **Password is visible to anyone looking behind your shoulders**
   - wget --user=remote_user --password=SECRET https://www.google.com/file.ext

- **Password is not visible to anyone including you**
   - wget --user=remote_user --ask-password https://www.google.com/file.ext
