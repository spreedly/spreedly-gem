= Spreedly-Gem

* http://terralien.com/static/projects/spreedly-gem/
* Source[http://github.com/terralien/spreedly-gem]

== DESCRIPTION:

The Spreedly gem provides a convenient Ruby wrapper for the goodness that is
the http://spreedly.com API. Created by Terralien[http://terralien.com].

== FEATURES:

* Makes it easy to get started.
* Fully tested.
* (Mostly) fully substitutable mock implementation for fast tests.
* Great example code.

== SYNOPSIS:

  # For real
  require 'spreedly'  
  Spreedly.configure('site short name', 'crazy hash token')
  url = Spreedly.subscribe_url('customer id', 'plan id')
  subscriber = Spreedly::Subscriber.find('customer id')
  subscriber.active?
  
  # For fast tests
  require 'spreedly/mock'
  Spreedly.configure('site short name', 'crazy hash token')
  url = Spreedly.subscribe_url('customer id', 'plan id')
  subscriber = Spreedly::Subscriber.find('customer id')
  subscriber.active?
  
Yup, they're exactly the same except for the require and the speed!

== REQUIREMENTS:

* A (free) Spreedly account.
* HTTParty (vendored for now).

== INSTALL:

  `sudo gem install spreedly`

== LICENSE:

(The MIT License)

Copyright (c) 2009 Nathaniel Talbott

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
