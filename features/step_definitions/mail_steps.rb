# encoding: utf-8

Тогда /^я должен получить "password_reset_instructions" письмо:$/ do |table|
  attributes = table.rows_hash

  mail = specify_mail_fields attributes
  user = User.find_by_email(attributes['to'])

  mail.body.should match(Regexp.escape(edit_password_reset_path(user.perishable_token)))
end


def specify_mail_fields(attributes)
  ActionMailer::Base.deliveries.should have(1).item

  mail = ActionMailer::Base.deliveries.first

  mail.to.should      == [ attributes['to']   ]
  mail.from.should    == [ attributes['from'] ]
  mail.subject.should == attributes['subject']
  
  mail
end