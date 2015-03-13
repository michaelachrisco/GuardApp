## README
```Bash
rails new GaurdApp
cd GaurdApp
bundle exec guard init

echo "
group :development, :test do
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers', require: false
end" >> Gemfile

# if mac os
echo "gem 'rb-readline', require: false, group: :development" >> Gemfile

bundle install
bundle exec rspec --init
rails generate rspec:install
bundle exec guard init
bundle exec guard init rspec

# Rubocop options: will not start up every time guard is initiated.
echo "guard :rubocop, :all_on_start => false, :cli => ['--format', 'clang', '--rails'] do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
" >> Guardfile
bundle exec guard
```
## Tests
```Bash
echo "require 'shoulda/matchers' >> spec/rails_helper.rb

mkdir spec/models
# spec/models
echo "
require 'rails_helper'

describe Foo do
  it 'is invalid without a name' do
    is_expected.to validate_presence_of(:name)
  end
  it 'is invalid without a key' do
    is_expected.to validate_presence_of(:key)
  end
end" >> spec/models/foo_spec.rb
# watch Guard fail with
# `<top (required)>': uninitialized constant Foo (NameError)
# create Foo model

rails g model Foo name:string key:string

#      invoke  active_record
#      create    db/migrate/20150313004118_create_foos.rb
#      create    app/models/foo.rb
#      invoke    rspec
#    conflict      spec/models/foo_spec.rb
#    Overwrite /Users/michaelchrisco/dev/development/GaurdApp/spec/models/foo_spec.rb? (enter "h" for help) [Ynaqdh] n
#        skip      spec/models/foo_spec.rb
# Watch rpsec fail and Guard fail

# `<top (required)>': uninitialized constant Foo (NameError)
#:1:1: C: Missing top-level class documentation comment.
# class CreateFoos < ActiveRecord::Migration
# ^^^^^
#
# 2 files inspected, 1 offense detected

rake db:migrate RAILS_ENV=test

touch app/models/foo.rb
echo "
class Foo < ActiveRecord::Base
  validates :name, :presence => true
  validates :key, :presence => true
end
" > app/models/foo.rb

# rspec passes but rubocop does not. Left for the reader as an exercise.
```
