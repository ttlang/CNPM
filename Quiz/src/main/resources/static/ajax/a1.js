function check_email() {
	email = $("#email").val();
	var form_data = {
		email : email
	};
	$.ajax({
		url : '/account/check_email',
		dataType : 'text',
		data : form_data,
		success : function(result) {
			$("#err").text("");
			$("#err").text(result);
		}

	});
}
// change_password.html // check pass and repass
	$(document).ready(function(){
		$("#change_pass").click(function(){
			var password =$("#pass_new").val();
			var repassword =$("#repass_new").val();
			if(password==repassword){
				$("#err").text('');
				return true;
			}else{
				$("#err").text('');
				$("#err").text('mật khẩu nhập lại không đúng');
				return false;
			}
			
			
		});
		
	});
