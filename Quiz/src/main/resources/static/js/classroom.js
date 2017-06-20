function closeModalLike() {
	$("#modal-like").removeClass("show").addClass("fade");
	$("#list-account-like").empty();
}
function detailAccountLikePost(id_post) {
	$.ajax({
		url : "/listAccountLike",
		type : "POST",
		data : {
			id_post : id_post
		},
		success : function(response) {
			$("#list-account-like").html(response);
		}
	});

	$("#modal-like").addClass("show").removeClass("fade");
}

function likeThisPost(post_info) {
	var id_post = post_info.id.substring(4);
	// alert(id_post);
	$.ajax({
		url : "/likeOrUnlikePost",
		type : "POST",
		data : {
			id_post : id_post
		},
		success : function(response) {
			if (response == "true") {
				var type = $(post_info).find("#lbl-like").attr("type");
				var lblLike = $(post_info).find("#lbl-like");
				if (type == 0) {
					lblLike.attr("type", 1)
					lblLike.text("Bỏ thích");
				} else {
					lblLike.attr("type", 0)
					lblLike.text("Thích");
				}
			}
		}
	});

}

/**
 * lấy form post
 * 
 * @param type
 * @returns form html
 */
function getHtmlFormPost(type) {
	$.ajax({
		url : "/getHtmlFormPost",
		type : "POST",
		data : {
			type : type
		},
		success : function(response) {
			$("#div-content-post").html(response);
		}
	});
}
/**
 * đã xong, thêm mới 1 bài đăng dạng thông báo vào room
 * 
 * @param form_post
 * @returns khung thông tin bài đăng
 * 
 */
function addStatusPost(form_post) {
	var content_post = $(form_post).find("#content_post").val();
	var id_room = $("#id-room").val();
	$.ajax({
		url : "/postStatusInRoom",
		type : "POST",
		data : {
			id_room : id_room,
			content_post : content_post
		},
		success : function(response) {
			if (response && response.trim().length != 0) {
				$("#list-post").prepend(response);
				$(form_post).find("#content_post").empty();
				$(form_post).find("#content_post").val("");
				autoNotify("#"+$(response)[5].id);
			}
		}
	});
	return false;
}
/**
 * chưa làm xong
 * 
 * @param form_post
 * @returns
 */
function addQuizPost(form_post) {
	var id_room = $("#id-room").val();
	var noiDungCauHoi = $(form_post).find("#content_post").val();
	var dapAnDung = $(form_post).find("input:radio[name ='radio_da']:checked")
			.val();
	var dapAnA = $(form_post).find("#da1").val();
	var dapAnB = $(form_post).find("#da2").val();
	var dapAnC = $(form_post).find("#da3").val();
	var dapAnD = $(form_post).find("#da4").val();
	alert("Câu hỏi: " + noiDungCauHoi + "\nĐáp án A: " + dapAnA
			+ "\nĐáp  án B: " + dapAnB + "\nĐáp án C: " + dapAnC
			+ "\nĐáp án D: " + dapAnD + "\nĐáp án đúng: " + dapAnDung);
	console.log(id_room);
	$.ajax({
		url : "/postQuizInRoom",
		type : "POST",
		data : {
			nd : noiDungCauHoi,
			da1 : dapAnA,
			da2 : dapAnB,
			da3 : dapAnC,
			da4 : dapAnD,
			daDung : dapAnDung,
			id_room : id_room
		},
		success : function(response) {
			if (response && response.trim().length != 0) {
				$("#list-post").prepend(response);
				$(this).find("#content_post").empty();
			}
		}
	});
	return false;
}
/**
 * chưa làm xong
 * 
 * @param form_post
 * @returns
 */
function addFilePost(form_post) {
	$.ajax({
		url : "/postFileInRoom",
		type : "POST",
		data : {},
		success : function(response) {
			if (response && response.trim().length != 0) {
				$("#list-post").prepend(response);
				$(this).find("#content_post").empty();
			}
		}
	});
	return false;
}

function deletePost(form_post) {
	var id_post = $(form_post).find("#idpost-close").val();
	alert("xóa post id: " + id_post);
	$
			.ajax({
				url : "/deletepost",
				type : "POST",
				data : {
					id_post : id_post
				},
				success : function(response) {
					if (response) {
						$("#divcontent" + id_post).remove();
						alert("Bạn đã xóa bài đăng thành công!");
					} else {
						alert("Bạn không phải người đăng, hoặc quản trị viên!\n Xóa thất bại!");
					}
				}
			});

	return false;
}
function deleteComment(form_comment) {
	var id_comment = $(form_comment).find("#idcomment-close").val();
	// alert("xóa comment id: " + id_comment);
	$
			.ajax({
				url : "/deletecomment",
				type : "POST",
				data : {
					id_comment : id_comment
				},
				success : function(response) {
					if (response) {
						$("#comment" + id_comment).remove();
					} else {
						alert("Bạn không phải người bình luận , hoặc quản trị viên!\n Xóa thất bại!");
					}
				}
			});

	return false;
}

function addComment(id_comment) {
	var comment = document.getElementById(id_comment);
	var id = id_comment.substring(12);
	var comment_value = comment.value;
	if (comment_value) {
		$.ajax({
			url : "/addcomment",
			type : "POST",
			data : {
				idpost : id,
				comment_value : comment_value
			},
			success : function(response) {
				alert(response);
				comment.value = "";
				if ((response)) {
					$("#list_comment" + id).html(response);
				} else {
					alert("Bình luận thất bại!");
				}

			}
		});
	} else {
		alert("chưa có com mẹ j hết!");
	}
}

function newPostItem(form_post) {
	var content_post = $(form_post).find("#content_post").val();
	var id_room = $(form_post).find("#id-room").val();
	$(this).find("#content_post").val("");
	if (content_post) {
		$.ajax({
			url : "/postinroom",
			type : "POST",
			data : {
				id_room : id_room,
				content_post : content_post
			},
			success : function(response) {
				alert(response);
				if (response && response.trim().length != 0) {
					$("#list-post").prepend(response);
					$(form_post).find("#content_post").val("");
				}
			}

		});
	} else {
		alert("chưa có vẹo gì hết!");
	}

	event.preventDefault();
	return false;
}

/*
 * $(function() { $("#post").submit(function(e) { var content_post =
 * $(this).find("#content_post").val(); var id_room =
 * $(this).find("#id-room").val(); $(this).find("#content_post").val(""); if
 * (content_post) { $.ajax({ url : "/postinroom", type : "POST", data : {
 * id_room : id_room, content_post : content_post }, success :
 * function(response) { alert(response); if (response && response.trim().length !=
 * 0) { $("#list-post").prepend(response);
 * $(this).find("#content_post").val(""); } }
 * 
 * }); } else { alert("chưa có vẹo gì hết!"); }
 * 
 * event.preventDefault(); return false; }); });
 */

// thành viên rời khỏi phòng
function leaveRoom(merberID) {
	var IDroom = $("#leaveRoomID").val();
	var form_data = {
		merberID : merberID,
		IDroom : IDroom
	};

	swal(
			{
				title : "Bạn có muốn rời khỏi phòng này?",
				text : "bạn sẽ không xem tham gia được các hoạt động của phòng này nữa",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "Vâng,rời khỏi phòng!",
				closeOnConfirm : true
			}, function() {
				$.ajax({
					url : '/leaves/room',
					dataType : 'text',
					data : form_data,
					type : 'POST',
					success : function(result) {
						if (result == 'true') {
							window.location.href = '/home'
						}else{
							swal(result);
						}
					}
				});

			});

}

// xóa phòng

function deleteRoom() {
	var id_room = $("#id-room").val();
	var password;
	var form_data = {
		id_room : id_room
	};

	swal({
		title : "Xóa phòng!",
		text : "Nhập mật khẩu của bạn để xác nhận xóa",
		type : "input",
		inputType : "password",
		showCancelButton : true,
		closeOnConfirm : false,
		animation : "slide-from-top",
		inputPlaceholder : "mật khẩu của bạn"
	}, function(inputValue) {
		// alert(inputValue)
		if (inputValue === "") {
			swal.showInputError("bạn phải điền gì đó!");
			return false
		} else {
			$.ajax({
				url : '/account/getUserPassword',
				dataType : 'text',
				data : form_data,
				type : 'POST',
				success : function(result) {
					password = result;

					if (password === inputValue) {

						$.ajax({
							url : '/deleteRoom',
							dataType : 'text',
							data : form_data,
							type : 'POST',
							success : function(result) {
								// swal(result);

								swal({
									title : "Xóa phòng",
									text : result,
									confirmButtonColor : "#54ddc8",
									confirmButtonText : "Xác nhận",
									closeOnConfirm : false,
								}, function(isConfirm) {
									if (isConfirm) {
										window.location = '/home';
									}
								});

							}
						});
					} else {
						swal.showInputError("mật khẩu không đúng!");

					}
				}
			});

		}

	});

}

// cua tao viet

function addPicPost(form_post) {
	var file_data = $('#pic_post').prop('files');
	var content_post = $(form_post).find("#content_post").val();
	var id_room = $("#id-room").val();
	
	console.log(file_data);
	
	var form_data = new FormData();
	
	// đưa các file vào formData
	for (var i = 0; i < file_data.length; i++) {
		form_data.append('f'+i, file_data[i]);
	}
	// đưa nội dung bài post vào form_data
	form_data.append('content_post', content_post);
	
	// đưa số lượng file vào form_data
	form_data.append('num', file_data.length);
	
	// đưa mã phòng vào form data
	form_data.append('id_room', id_room);
	
	console.log(content_post);
	console.log(id_room);
	swal({
		  title: "Đăng Bài",
		  text: "xác nhận đăng bài",
		  type: "info",
		  showCancelButton: true,
		  closeOnConfirm: false,
		  showLoaderOnConfirm: true,
		},
		function(){
		 
			$.ajax({
			      url: "/upload/picture",
			      data: form_data,
			      type: "POST",
			      enctype: 'multipart/form-data',
			      processData: false,
			      contentType: false,
			      success: function (result) {
			    	  if(result=='1'){
			    		  swal({
							  title: "Đăng bài thành công",
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
							  title: "Đăng bài thất bại",
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
					return false;
			    }
				
				
				
				
			});
			
			
		});
	
	
		
	return false;

}


// bài đăng là file

function addFilePost(form_post){
	
	var file_data = $('#file_post').prop('files');
	var content_post = $(form_post).find("#content_post").val();
	var id_room = $("#id-room").val();
	
	console.log(file_data);
	
	var form_data = new FormData();
	
	// đưa các file vào formData
		form_data.append('file', file_data[0]);
	// đưa nội dung bài post vào form_data
	form_data.append('content_post', content_post);
	// đưa mã phòng vào form data
	form_data.append('id_room', id_room);
	
	console.log(content_post);
	console.log(id_room);
	swal({
		  title: "Đăng Bài",
		  text: "xác nhận đăng bài",
		  type: "info",
		  showCancelButton: true,
		  closeOnConfirm: false,
		  showLoaderOnConfirm: true,
		},
		function(){
		 
			$.ajax({
			      url: "/upload/file",
			      data: form_data,
			      type: "POST",
			      enctype: 'multipart/form-data',
			      processData: false,
			      contentType: false,
			      success: function (result) {
			    	  
			    	  if(result=='1'){
			    		  swal({
							  title: "Đăng bài thành công",
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
							  title: "Đăng bài thất bại",
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
			    	  
			    	 
			    	  
					return false;
			    }
				
				
				
				
			});
			
			
		});
	
	
		
	return false;

	
	
}


