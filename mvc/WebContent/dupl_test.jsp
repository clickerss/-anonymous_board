<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.0.min.js"></script>
<script type="text/javascript">
/* $(document).ready(function(){
	$('#testbutton').on("click", function(){
		$.ajax({
			type : "post",
			url : "testdup",
			cache : false,
			data : $("#id").serialize(),
			success : function(data){
				alert("ajax 성공")
				$("#test").append(data);				
			}
		});	
	})
}) */

function test_check(){
	$.ajax({
		type : "post",
		url : "testdup",
		cache : false,
		data : $("#id").serialize(),
		success : function(data){
			alert("ajax 성공")
			$("#test").append(data);				
		}
	});
	return;
}

/* $(document).ready(function(){
	jQuery.ajax({
		type:"POST",
		url:"/testdup",
		dataType:"JSON",
		cache : false,
		success: function(data){
			alert("aa")
		},
		complete: function(data){
			alert("bb")
		},
		error: function(xhr, status, error){
			alert("에러발생")
		}
	});
});
 */
</script>
</head>
<body>

<form id="form1">
ID : <input type="text" name="id" id="id">
<button type="button" id="testbutton" onclick="test_check()">dd</button>
</form>
<div id="test"></div>
</body>
</html>