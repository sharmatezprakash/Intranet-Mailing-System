/**
 * 
 */
var listOfCheckIds=[];
var allChecked = false;

function allChkboxClicked(){
	if(allChecked){
		$(".mail-checkbox").prop("checked", false );
		allChecked=false;
	}else{
		$(".mail-checkbox").prop( "checked", true );
		allChecked=true;
	}
	allChecked=$("#all-chkbox").is(':checked');
//	$("#dropdown-anchor").html("All");
}

function viewInbox(index){
	$("#mailIndex").val(index);
	$("#viewMailForm").submit();
}

function starredClick(id){
	let spanid = 'starred-' + id;
	let isMarked = $("#"+spanid).hasClass("showStarred");
	
	if(isMarked){
		$("#"+ spanid).css({"color": "#d5d5d5"});
	}else{
		$("#"+ spanid).css({"color": "#f78a09"});
	}
	$("#markStarredForm_ID").val(id);
	$("#markStarredForm_isMarked").val(isMarked);
	$("#markStarredForm_isSender").val(true);
	$("#markStarredForm_start").val(startMail);
	$("#markStarredForm").submit();
}

function chkboxClick(id){
	if(listOfCheckIds.includes(id)){
		listOfCheckIds.splice( $.inArray(id, listOfCheckIds) ,1 );
	}else{
		listOfCheckIds.push(id);
	}
}

function markAsRead(){
	alert("Mark as read inbox");
}

function deleteMails(){
	$("#DeleteMail_isSender").val(true);
	$("#DeleteMail_deleteMultiple").val(true);
	
//	console.log(allChecked);
	
	if(allChecked){
		if(arrayOfMailIds.length == listOfCheckIds.length){
//			console.log('length matches');
			$("#DeleteMail_mailId").val(arrayOfMailIds.join());
		}else{
//			console.log('length not matches');
			let i = 0;
			
//			console.log(arrayOfMailIds.join());
//			console.log(listOfCheckIds.join());
			
			for(i = 0; i < listOfCheckIds.length; i++){
//				console.log(arrayOfMailIds.includes(listOfCheckIds[i]));
				if(arrayOfMailIds.includes(listOfCheckIds[i])){
//					console.log('item index ' +  $.inArray(listOfCheckIds[i], arrayOfMailIds));
					arrayOfMailIds.splice( $.inArray(listOfCheckIds[i], arrayOfMailIds) ,1 );
//					console.log(arrayOfMailIds.join());
				}
			}
//			console.log("setting " + arrayOfMailIds.join());
			$("#DeleteMail_mailId").val(arrayOfMailIds.join());
		}
	}else{
//		console.log("all not checked");
		$("#DeleteMail_mailId").val(listOfCheckIds.join());
	}
	$('#DeleteMail').submit();
}

function loadSentbox(loadFrom = 0){
	$("#GetMails_start").val(loadFrom);
	$("#getMails").submit();
}

function uncheckAll(){
	alert("None checked " + $("#dropdown-anchor").text());
	$("#dropdown-anchor").text("None");
}

function checkRead(){
	alert("Read checked " + $("#dropdown-anchor").html());
	$("#dropdown-anchor").html("Read");
}

function checkUnread(){
	alert("Unread checked");
	$("#dropdown-anchor").text("Unread");
}

$("#search-btn").click(function(){
	/* Write search code */
	alert("search clicked");
});
