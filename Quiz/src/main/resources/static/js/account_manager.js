function deleteMem(merberID){
				var IDroom=$("#IDroom").val();
				var form_data = {
						merberID : merberID,
						IDroom:IDroom
					};
					$.ajax({
						url : '/deleteMember',
						dataType : 'text',
						data : form_data,
						success : function(result) {
							if(result>0){
								swal({
									  title: "Thành công!",
									  text: "xóa thành viên thành công!",
									  type: "success",
									  showCancelButton: false,
									  confirmButtonColor: "#b3f0ff",
									  confirmButtonText: "OK",
									  closeOnConfirm: false
									},
									function(){
										location.reload();
									});
							}else{
								swal({
									  title: "Thất bại!",
									  text: "xóa thành viên thất bại!",
									  type: "error",
									  showCancelButton: false,
									  confirmButtonColor: "#DD6B55",
									  confirmButtonText: "OK",
									  closeOnConfirm: false
									},
									function(){
										location.reload();
									});
							}
						}
					});
				
					
			}
			// thêm thành viên
			function addMem(merberID){
				var IDroom=$("#IDroom").val();
				var form_data = {
						merberID : merberID,
						IDroom:IDroom
					};
					$.ajax({
						url : '/addMem',
						dataType : 'text',
						data : form_data,
						success : function(result) {
							if(result>0){
								swal({
									  title: "Thành công!",
									  text: "thêm thành công!",
									  type: "success",
									  showCancelButton: false,
									  confirmButtonColor: "#b3f0ff",
									  confirmButtonText: "OK",
									  closeOnConfirm: false
									},
									function(){
										location.reload();
									});
								
								
							}else{
								swal({
									  title: "Thất bại!",
									  text: "thêm thất bại!",
									  type: "error",
									  showCancelButton: false,
									  confirmButtonColor: "#DD6B55",
									  confirmButtonText: "OK",
									  closeOnConfirm: false
									},
									function(){
										location.reload();
									});
								
								
							}
						}
					});
				
			}
		

	