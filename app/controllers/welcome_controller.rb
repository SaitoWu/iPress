class WelcomeController < ApplicationController
  meta '#index'
  get '/' do
    render 'welcome/index'
  end
end
