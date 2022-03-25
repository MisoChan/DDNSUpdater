FROM ruby:3.0.3
WORKDIR /home/app
COPY . .

ENTRYPOINT ["ruby","./main.rb"]