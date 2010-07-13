include BarcodesHelper

Допустим /^пользователь уже создал QR Коды:$/ do |таблица|
  таблица.hashes.each do |row|
     bar_code = row['type'].camelize.constantize.create(row)
     bar_code.valid?.should be_true
  end
end

Тогда /^список созданых мною QR Кодов:$/ do |таблица|
  has_css?('.history')
  таблица.hashes.each do |row|
    within('.history') do
      bar_code = BarCode.find_by_type(row['type'].camelize)
      body.should include(bar_code_title(bar_code))
    end
  end
end

Тогда /^я должен увидеть QR Код:$/ do |список|
  has_css?('.history')
  row = список.rows_hash
  within('.history') do
    bar_code = BarCode.find_by_type(row['type'].camelize)
    body.should include(bar_code_title(bar_code))
  end
end