# Spreedly gem

* https://github.com/spreedly/spreedly-gem

## Description

The Spreedly gem provides a convenient Ruby wrapper for the Spreedly
Subscriptions API.

## Features

* Makes it easy to get started.
* Fully tested.
* (Mostly) fully substitutable mock implementation for fast tests.
* Great example code.

## Synopsis

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

## Requirements

* A Spreedly Subscriptions account.
* HTTParty

## Install

    $ gem install spreedly
