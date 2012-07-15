require 'money'
require 'active_merchant'
require 'active_merchant/billing/integrations/action_view_helper'

ActionView::Base.send(:include,
ActiveMerchant::Billing::Integrations::ActionViewHelper)

if Rails.env.production?
  PAYPAL_ACCOUNT = 'production.paypal.account@domain.com'
else
  PAYPAL_ACCOUNT = 'rhaamo@gruik.at'
  ActiveMerchant::Billing::Base.mode = :test
end
