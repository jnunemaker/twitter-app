require 'common_view_helpers'
require 'common_controller_helpers'

ActionController::Base.send :include, CommonControllerHelpers
ActionView::Base.send :include, CommonViewHelpers