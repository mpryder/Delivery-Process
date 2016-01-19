
require 'net/smtp'
timenow = Time.new  
@time = Time.new

smtp = Net::SMTP.new 'smtp.gmail.com', 587
smtp.enable_starttls
emailServer = "smtp.gmail.com"
serverPort = 25
passWord="RidMan0001"
userName= "ryddlemethis@gmail.com"
domain="gmail.com"
fm= "ryddlemethis@gmail.com "
to = ARGV[0]
sendMsg = <<END_OF_MESSAGE
From: #{fm} 
To: #{ARGV[0]}
Subject: #{ARGV[1]}

#{ARGV[2]}
END_OF_MESSAGE



begin
smtp = Net::SMTP.new('smtp.gmail.com', 587 )
smtp.enable_starttls
smtp.start(domain, userName, passWord, :login) do |smtp|
        smtp.send_message sendMsg, fm, to

end

end
