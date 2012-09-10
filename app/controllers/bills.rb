Billmaker.controllers :bills do
	
	get :index do 
		
		@clients = current_account.clients
		@client = current_account.clients.where(status: true).first
		@worksessions = @client.work_sessions.where(bill: nil).order("start.desc")
		@worksessions.to_a.each do |w|
			bill = Bill.where(month: w.date.mon, year: w.date.cwyear).first
			unless bill
				bill = Bill.create(month: w.date.mon, year: w.date.cwyear, client_id: @client.id)
			end
			w.set(bill: bill.id)
			bill.add_profit w.profit.round(2)
			#bill.push(work_sessions: w.id)
		end
		@bills = @client.bills
		
		render "bills/index"
	end

	get :edit, map: "bills/edit/:id" do
		@bill = Bill.find(params[:id])
		render "bills/edit"
	end

	delete :destroy, map: "bills/destroy/:id" do 
		@bill = Bill.find(params[:id])
		@client = current_account.clients.where(status: true).first
		@bill.destroy
		render "bills/index"
	end

	post :create do
	end

	put :update do
	end
end