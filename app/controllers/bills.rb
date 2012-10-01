Billmaker.controllers :bills do
	
	get :index do 
		
		@clients = current_account.clients
		@client = current_account.current_client
		@bills = @client.bills
		
		render "bills/index"
	end

	get :edit, map: "bills/edit/:id" do
		@bill = Bill.find(params[:id])
		render "bills/edit"
	end

	get :show, map: "bills/show/:id", provides: [:pdf, :html] do
		@bill = Bill.find(params[:id])
		case content_type
      		when :html  
      			render "bills/show.html"
      		when :pdf
      			render "bills/show.pdf"
    	end
	end

	post :destroy, map: "bills/destroy/:id" do 
		@bill = Bill.find(params[:id])
		@client = current_account.clients.where(status: true).first
		@bills = @client.bills
		@bill.destroy
		render "bills/index"
	end

	post :create do
	end

	put :update, map: "bills/update/:id" do
		@bill = Bill.find(params[:id])
		@bill.update_attributes(params[:bill])
		@bills= current_account.bills
		render "bills/index"
	end

	post :start_work, provides: [:html, :js] do
		@t = Time.new
		@worksession = WorkSession.new(start: Time.now, active: true)
		@client = current_account.current_client
		@bill = @client.current_bill
		if @bill
			if @bill.date.mon == @t.mon && @bill.date.year == @t.year
				@bill.work_sessions.where(active: true).each{ |ws| ws.set(active: false)}
			else
				@bill = Bill.new(date: @t)
				@client.bills << @bill
			end
		else
			@bill = Bill.new(date: @t)
			@bill.save
			@client.bills << @bill
			@bill.save
		end	
		@worksession.bill = @bill
		if	@worksession.save
			options = current_account.emailsetting.attributes.except("_id", "created_at", "updated_at", "account_id")  
			send_notification_email	current_account,options
		end
		render "bills/start_work", layout: false
	end

	post :end_work, provides: [:html, :json] do
		@client = current_account.current_client
		@t = Time.now
		@bill = @client.current_bill
		if @bill
			@worksession = @bill.current_session
		end
		render "bills/end_work"
	end

	get :get_session_start, provides: [:json] do
		@client = current_account.current_client
		@start = @client.session_start
		render "bills/get_session_start"
	end

	put :end_work_handler, map: "/bills/end_work_handler/:id", provides: [:json] do
		@t = Time.now
		@worksession = WorkSession.find(params[:id])
		@worksession.active = false
		@worksession.description = params[:work_session][:description]
		@worksession.ende = @t
		profit = ((@t - @worksession.start)/3600)*@worksession.bill.client.pay
		@worksession.profit = profit
		@worksession.bill.add_profit profit.round(2)
		@status = @worksession.save
		if @status
			options = current_account.emailsetting.attributes.except("_id", "created_at", "updated_at", "account_id")  
			send_notification_email(current_account,options)
		end
		redirect "/"
	end

#
end