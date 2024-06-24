**Download a file using wget**

1. Password is visible to anyone 
wget --user=remote_user --password=SECRET https://www.google.com/file.ext

2. Password is visible to anyone looking behind your shoulders
 wget --user=remote_user --password=SECRET https://www.google.com/file.ext

3. Password is not visible to anyone including you
wget --user=remote_user --ask-password https://www.google.com/file.ext
