# :open_book: :outbox_tray: :floppy_disk: Contact Importer - Koombea :open_book: :outbox_tray: :floppy_disk:
### The application will allow users to upload contact files in CSV format and process them in order to generate a unified contact file.
## Getting Started
### Assuming you have Ruby 3.1.2 and Rails 7.0.4
```bash
bundle install
yarn
rails db:drop db:create db:migrate db:seed
bundle exec rails assets:precompile
```
### Running locally

Let's use foreman to make it easier to run the various apps locally and have some scripts to help.

```bash
bin/dev # runs everything

# run individual services
bin/dev web # runs rails
bin/dev js # runs js
bin/dev css # runs css
bin/dev worker # runs sidekiq
```

## Debugging

Ruby 3.0+ added a new built in debugger called [debug](https://github.com/ruby/debug). Rails 7 uses this by default.

I'm also including a more standard [byebug](https://github.com/deivid-rodriguez/byebug) debugger via [pry-byebug](https://github.com/deivid-rodriguez/pry-byebug).

You can use different breakpoints methods to use one or the other.

```
binding.break # use ruby's built in debugger
binding.pry   # use byebug debugger
```

Note that Rails and Byebug both define a `debugger` alias. But `byebug`'s debugger is picked when you use that alias. It's better to be explicit about which debugger you want.

### Setting breakpoints
Insert a `debugger` statement in any Ruby code to stop execution at that point and launch a REPL. See [Debugging with the debug gem](https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem).

### Specs

##### Running tests
Setup
```
rails db:test:prepare
```

Running
```sh
rspec
rspec spec/path/to/myfile.rb
rspec spec/path/to/myfile.rb:50
```
### Rubocop
Running
```sh
rubocop
```

### Sidekiq
Make sure you have redis installed and running
```sh
sudo service redis-server restart
```

To check all background jobs, go to http://localhost:3000/sidekiq


### Test User
Go to http://localhost:3000 and use the following credentials:
```
Email: test@koombea.com
Password: 123456
```