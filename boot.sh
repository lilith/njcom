#!/usr/bin/env ruby
# coding: utf-8
STDERR << "Using port 4002\n"
`bundle exec rerun --dir '.' --pattern '**/*.{rb,slim,js,yml,css,less, scss,sass,erb,html,htmf,haml,ru,haml,md,mdown,markdown}' -- thin start --debug --port=4002`
