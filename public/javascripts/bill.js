function printBill(){
	print();
}

function deleteBill(id){
	var bill = id;
	if(confirm("Wirklich löschen?")){
		$.post("/bills/destroy/"+bill,{id: bill},function(data){});
	}
}