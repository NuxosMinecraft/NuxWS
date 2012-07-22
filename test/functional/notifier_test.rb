require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "edit_password_reset_url" do
    mail = Notifier.edit_password_reset_url
    assert_equal "Edit password reset url", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
