include QrCodesHelper

Допустим /^пользователь уже создал QR код(?:ы)?:$/ do |таблица|
  таблица.hashes.each do |row|
     qr_code = row['type'].camelize.constantize.create(row)
     qr_code.valid?.should be_true
  end
end

Тогда /^список созданых мною QR кодов:$/ do |таблица|
  has_css?('.history')
  таблица.hashes.each do |row|
    within('.history') do
      qr_code = BarCode.find_by_type(row['type'].camelize)
      body.should include(qr_code_title(qr_code))
    end
  end
end

Тогда /^я должен увидеть QR код:$/ do |список|
  has_css?('.history')
  row = список.rows_hash
  within('.history') do
    qr_code = BarCode.find_by_type(row['type'].camelize)
    body.should include(qr_code_title(qr_code))
  end
end