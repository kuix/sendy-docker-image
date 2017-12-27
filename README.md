## Docker Image for Sendy Self Hosted Newsletter Application

The image based on the original `php:7.2-apache` image but added some extra apache module which necessary for run sendy. The following modifications added:

* MySQL module added
* Apache ModRewrite module enabled
* Apache SSL module enabled

### Usage

Define your environment variables based on `.env.example` file. After that place a compose file with the following content. This compose file will start two container:

* An Apache and PHP container to server sendy
* A MySQL container to store subsribers

```
version: '2'
services:
    apache-php:
        image: sendy
        container_name: sendy-apache-php
        volumes:
            - ./sendy/:/var/www/html
            - ./cron:/etc/cron.d/sendy
            - ./apache.conf:/etc/apache2/sites-enabled/000-default.conf
        ports:
          - "80:80"
          - "443:443"
        env_file:
            - .env
        links:
            - mysql
    sendy-mysql:
        image: mysql:5.5
        container_name: sendy-mysql
        volumes:
            - ./data/mysql:/var/lib/mysql
        ports:
            - "3306:3306"
        env_file:
              - .env
```