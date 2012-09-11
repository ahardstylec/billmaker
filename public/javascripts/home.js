
$(document).ready(function(){
	$("a").click(function(){
		$(this).blur();
	});

	$("a.start_work").bind('click',start_work);
	$("a.end_work").bind('click',end_work);

});

function change_current_client(){
	var new_client = $("select#clients").val();
	$.post("clients/change_current_client",{client: new_client},function(data){
		location.href= "/";
	});
}

start_work = function(event){
	event.preventDefault();
	$(".end_img").attr('src','images/finish64.png');
	$(".end_work").attr("disabled", "");

	$(".start_work").attr("disabled", "disabled");
	$(".start_img").attr('src','images/bussy64.png');

	$.post("bills/start_work.json",{client: $("select#clients").val()},function(data){
		$("#worksession_infos").html(data.html);
		sessionstart = new Date();
		show_timer();
	});
};

end_work = function(event){
	event.preventDefault();
	$(".end_img").attr('src','images/bussy64.png');
	$(".end_work").attr("disabled", "disabled");

	$(".start_img").attr('src','images/start64.png');
	$(".start_work").attr("disabled", "");
	var id = $("#activesession").val();
	$.post("bills/end_work",{id: id},function(data){
		$("#worksession_infos").html("Gerade ist keine Work Session aktiv");
	});
};

show_timer = function(){
	thelement= $("#tick");
	var start;
	var money;
	var worktime = "";
	jQuery.ajaxSetup({async:false});
	$.get("/bills/get_session_start.json",{},function(data){
		start =  data.sessionstart;
		worktime = data['working_time'];
		money = data.money;
	});
	jQuery.ajaxSetup({async:true});
	// alert("");
	thelement.html("<b style='font-size:14;color:blue;'>"+worktime+"</b>");
	$(".money").html(money);
	setTimeout("show_timer()",5000);
}