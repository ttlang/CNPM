$( function() {
    $( "#birth" ).datepicker({ dateFormat: 'dd/mm/yy' });
  } );


//kiểm tra độ dài cho phần nhập liệu
$(document).ready(function(){
	document.getElementById("name").pattern = ".{5,50}";
	document.getElementById("name").title = "là chữ cái và không quá 100 kí tự";
	document.getElementById("job").pattern = ".{5,50}";
	document.getElementById("job").title = "là chữ cái và không quá 50 kí tự";
	document.getElementById("address").pattern = ".{0,300}";
	document.getElementById("address").title = "là chữ cái và không quá 50 kí tự";
	
});



$(document).ready(function(){
	$("#avatar").change(function(){
		var file_data = $('#avatar').prop('files')[0];   
	    var form_data = new FormData();                  
	    form_data.append('file', file_data);

	    
	    $.ajax({
	                url: '/upload/avatar',
	                dataType: 'text',
	                cache: false,
	                contentType: false,
	                processData: false,
	                data: form_data,                         
	                type: 'post',
	                success: function(result){
	                	if(result.startsWith('https')){
	        				swal("Cập nhật thành công")
	                    $("#account_avatar").attr('src',result); 
	        			}else{
	        				swal('Cập nhật thất bại \n'+result)
	        			}
	                }
	     });
	})
});



$("#account_info").bind('submit', function (e) {
    name=$("#name").val();
    birth=$("#birth").val();
   	gender= $("input:radio[name ='radio']:checked").val();
    job=$("#job").val();
    address=$("#address").val();
    form_data ={name:name,birth:birth,gender:gender,job:job,address:address}
	$.ajax({
		url : '/account/update/info',
		dataType : 'text',
		data : form_data,
		success : function(result) {
			  swal(result)
		}

	});
    return false;
});
