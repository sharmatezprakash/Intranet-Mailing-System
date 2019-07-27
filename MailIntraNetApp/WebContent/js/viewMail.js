/**
 * 
 */
var listOfCheckIds=[];
var allChecked = false;

function goBack(){
	let actionURL;
	if(isSender){
		actionURL = 'sentbox.jsp';
	}else{
		actionURL = 'Inbox.jsp';
	}
	$('#goBackForm').attr('action', actionURL);
	$('#goBackForm').submit();
}

function allChkboxClicked(){
	if(allChecked){
		alert('all unchecked');
		$(".mail-checkbox").prop("checked", false );
		allChecked=false;
	}else{
		alert('all checked');
		$(".mail-checkbox").prop( "checked", true );
		allChecked=true;
	}
	allChecked=$("#all-chkbox").is(':checked');
	console.log(allChecked);
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
	alert("Check box " + id + " clicked " + listOfCheckIds.join());
	if(listOfCheckIds.includes(id)){
		alert('removing');
		listOfCheckIds.splice( $.inArray(id, listOfCheckIds) ,1 );
	}else{
		alert('adding');
		listOfCheckIds.push(id);
	}
	alert(listOfCheckIds.join());
}

function markAsRead(){
	alert("Mark as read inbox");
}

function deleteMail(){
	$("#DeleteMail_isSender").val(isSender);
	$("#DeleteMail_mailId").val(mailId);
	$('#DeleteMail').submit();	
}

function loadInbox(){
	alert("Load Inbox submit form");
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
