function printBill(){
	print();
}

function deleteBill(){

	if(confirm("Wirklich löschen?")){
		$.post("/bills/destroy",{id: $(this).attr('id')},function(data){});
	}
}