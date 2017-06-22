$(function() {
	$("#friend_list_btn").click(function() {
		var id_acc = $("#friend_list_btn").val();
		//		alert(id_acc);

		$.ajax({
			url : '/account/get_friend_list',
			type : 'POST',
			dataType : 'json',
			data : {
				id_acc : id_acc
			},
			success : function(result) {
				$("#friend_list_title").text("Danh sách bạn bè");
				console.log(result);
				var htmlContent ="";
				
				for (i = 0; i < result.length; i++) {
					
					htmlContent+='<img src="'+result[i].avatar+'" class="img-circle" alt="'+result[i].name+'" width="50" height="50">'
						+'<a href="/account/viewinfo/acc'+result[i].idAcc+'"><span class="text-info"> '+result[i].name+'</span>';
					

				}
				$("#friend_list_content").html(htmlContent);

								$('#friend_list').modal('show');
			}
		});

	});

});


// xử lý cho nút kết bạn
	$(function(){
		$("#add_friend").click(function(){
			var id_acc =$("#add_friend").val();
			$.ajax({
				url : '/account/friend-request-new',
				type : 'POST',
				dataType : 'text',
				data : {
					id_acc : id_acc
				},success : function(result) {
					var s =result.split("|");
					if(s[0]=="1"){
						
						swal("Thành công!", s[1], "success");
						
						
					}else{
						
						swal("Thất bại!", s[1], "error");
						
						
						
					}
					
				}
			});
			
		});
		
		
	});

