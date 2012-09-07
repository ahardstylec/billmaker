Billmaker.controllers :bills do
	
	get :index do 
		
		@clients = current_account.clients
		@client = current_account.clients.where(status: true).first
		@worksessions = @client.worksessions.where(bill: nil).order("start.desc")
		@worksessions.eaach do |w|
			unless bill = Bill.where(date: w.date)
				bill = Bill.create(date: w.date)
			end
			bill.worksessions << w
		end
		@bills = @client.bills
		
		render "bills/index"
	end
end