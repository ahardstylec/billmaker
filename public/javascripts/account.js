function change_mail_activ(){
	var check = $("#mail").attr("checked");
	$.post("set_email_active",{checked: check},function(data){});
}