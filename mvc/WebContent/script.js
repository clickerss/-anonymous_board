// 이메일인증번호 확인
function checkCode(){
	
}








// 아이디 비밀번호 양식 컨펌
function infoConfirm(){
	if(document.reg_frm.id.value.length == 0){
		alert("아이디는 필수사항 입니다.");
		reg_frm.id.focus();
		return;
	}
	
	if(document.reg_frm.id.value.length <4){
		alert("아이디는 4글자 이상이어야 합니다.");
		reg_frm.id.focus();
		return;
	}
	
	if(document.reg_frm.pw.value.length ==0){
		alert("비밀번호는 필수사항 입니다.");
		reg_frm.pw.focus();
		return;
	}
	
	if(document.reg_frm.pw.value != document.reg_frm.pw_check.value){
		alert("비밀번호가 일치하지 않습니다.");
		reg_frm.pw.focus();
		return;
	}
	
	if(document.reg_frm.name.value.length ==0){
		alert("이름은 필수사항 입니다.");
		reg_frm.pw.focus();
		return;
	}
	
	if(document.reg_frm.id.value.length ==0){
		alert("아이디는 필수사항 입니다.");
		reg_frm.id.focus();
		return;
	}
	
	if(document.reg_frm.eMail.value.length ==0){
		alert("메일은 필수사항 입니다.");
		reg_frm.eMail.focus();
		return;
	}
	
	document.reg_frm.submit();
	
}

// 사용자 정보 수정
function updateInfoConfirm(){
	if(document.reg_frm.pw.value ==""){
		alert("패스워드를 입력하세요.");
		document.reg_frm.pw.focus();
		return;
	}
	
	if(document.reg_frm.pw.value != document.reg_frm.pw_check.value){
		alert("패스워드가 일치하지 않습니다");
		reg_frm.pw.focus();
		return;
	}
	
	if(document.reg_frm.eMail.value.length ==0){
		alert("메일은 필수사항 입니다.");
		reg_frm.eMail.focus();
		return;
	}
	
	document.reg_frm.submit();
}