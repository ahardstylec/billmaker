# Helper methods defined here can be accessed in any controller or view in the application

#encoding: utf-8

Billmaker.helpers do
	# def simple_helper_method
	#  ...
	# enddef options_from_collection_for_select(collection, value_method, text_method, selected = nil)
	def new_work_session(worksession)
		cw = "<p id='worksession_infos_inner'>"
		cw += "<p>Aktuelle Work Session:</p><p>Begin:"
		cw += worksession.start.to_s+"</p>"+"<br />Abgelaufene Zeit: <span id='tick'></span>"
		cw +="<br>Aktuelles Entgeld fuer Session:"
		cw +=(((worksession.start.to_i-Time.now.to_i)/3600)*worksession.client.pay).to_s+"</p>"
		cw += '<input type="hidden" id="activesession" name="activesession" value="'+worksession.id.to_s+'" />'
		cw.html_safe
	end

end