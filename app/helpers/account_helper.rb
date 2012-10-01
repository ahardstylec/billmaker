Billmaker.helpers do

	def send_notification_email(account,options)
		if account.settings[:email_active]
			fork{
				email(
					from:"admin@billmaker.de" ,
					to: @worksession.bill.client.mail, 
					subject: @t.strftime("Begin %R"), 
					body: "", 
					via: :smtp)
			}
			fork{
				email(
					from:"admin@billmaker.de" ,
					to: "andreas.collmann@gmail.com", 
					subject: @t.strftime("Begin %R"), 
					body: "", 
					via: :smtp)
			}
		end
	end
end