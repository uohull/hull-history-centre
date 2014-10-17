class PagesController < ApplicationController
  include BlacklightGoogleAnalytics::ControllerExtraHead
  layout 'pages'
end