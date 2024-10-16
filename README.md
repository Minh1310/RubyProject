# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

#Build docker

docker build -t first_app .

docker run -d -p 3000:3000 -e RAILS_MASTER_KEY=ce26160907da46934fac605735e635451e1745e3461ae45f0fb06d0513aa90455fca0772875c35e80462bea723c79e891a9cdc4ce16787c4ae2905a0267baeb9 first_app

