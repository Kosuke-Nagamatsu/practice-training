# README

## Table schema

#### User
| column | data type |
| ---- | ---- |
| id | primary_key |
| email | string |
| password_digest | string |

#### Task
| column | data type |
| ---- | ---- |
| id | primary_key |
| user_id(FK) | bigint |
| tittle | string |
| content | text |
| time_limit | datetime |
| priority | string |
| status | string |

#### Label
| column | data type |
| ---- | ---- |
| id | primary_key |
| task_id(FK) | bigint |
| content | string |

#### TaskLabel
| column | data type |
| ---- | ---- |
| id | primary_key |
| task_id(FK) | bigint |
| label_id(FK) | bigint |

<br>

## How to deploy
### login to Heroku
```
$ heroku login
```
### create a new application on Heroku
```
$ heroku create
Creating app... done, ⬢ fierce-mountain-94329
https://fierce-mountain-94329.herokuapp.com/ | https://git.heroku.com/fierce-mountain-94329.git
```
In the above case, `https://fierce-mountain-94329.herokuapp.com/` would be the URL of the application. The URL is different each time.

### asset precompile
```
$ rails assets:precompile RAILS_ENV=production
```

### commit
```
$ git add -A
$ git commit -m "write a commit message in this space"
```

### add Heroku buildpack
Heroku buildpack is for compiling your application on Heroku. Basically, Heroku will automatically detect it according to the development language of the source code, and buildpack will be installed. However, if that is not enough, or if you need an additional buildpack, you can add the buildpack by running the following command. Below is an example of adding a node.js buildpack as well.
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```

### deploy to Heroku
```
$ git push heroku master
Counting objects: 92, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (79/79), done.
Writing objects: 100% (92/92), 22.60 KiB | 0 bytes/s, done.
Total 92 (delta 2), reused 0 (delta 0)
~ (ellipsis) ~
remote: Verifying deploy... done.
To https://git.heroku.com/fierce-mountain-94329.git
 * [new branch]      master -> master
```
If it is displayed as above, it is successful.

### database migration
Heroku database creation is automatic, but migration (table creation) must be done manually. Not needed if there is no migration.
```
$ heroku run rails db:migrate
```
### access application
The address to the Heroku app is set as `https://app name.herokuapp.com/`
**how to check the app name**
```
$ heroku config
=== fierce-mountain-94329 Config Vars
~ (ellipsis) ~
```
After you run <code>$ heroku config</code>, the app name will be displayed on the first line. In the above example, **fierce-mountain-94329** means to the app name.

Please visit `https://app name.herokuapp.com/`.

<br>

## Technology used
* Ruby 2.6.5
* Ruby on Rails 5.2.5
* PostgreSQL 13.2
* RSpec 3.10
