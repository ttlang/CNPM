$(document)
				.ready(
						function() {
							$("#participation")
									.click(
											function(e) {
												var id_room = $("#id_room2")
														.val();
												$
														.ajax({
															url : "/participationroom",
															type : "POST",
															data : {
																id_room : id_room
															},
															success : function(
																	response) {
																console
																		.log(response);
																if (!response) {
																	swal({
																		  title: "Thất bại!",
																		  text: "Đăng ký tham gia phòng thất bại! Có lẻ bạn đã tham gia phòng này!",
																		  type: "error",
																		  showCancelButton: false,
																		  confirmButtonColor: "#DD6B55",
																		  confirmButtonText: "OK",
																		  closeOnConfirm: false
																		},
																		function(){
																			location.reload();
																		});
																	
																	
																} else {
// 																	alert("Đăng ký tham gia phòng thành công!")
																	
																	swal({
																		  title: "Thành công!",
																		  text: "Đăng ký tham gia phòng thành công!",
																		  type: "success",
																		  showCancelButton: false,
																		  confirmButtonColor: "#b3f0ff",
																		  confirmButtonText: "OK",
																		  closeOnConfirm: false
																		},
																		function(){
																			location.reload();
																		});
																	
																	
																	
																	
																	
																}
																$("#id_room2")
																		.val("");
// 																window.location = "/";
															}
														});

											});

							$("#search_room")
									.click(
											function() {
												var id_room = $("#id_room2")
														.val();
												$
														.ajax({
															url : "/searchroom",
															type : "POST",
															data : {
																id_room : id_room
															},
															success : function(
																	response) {
																if (response == "false") {
// 																	alert("Phòng không tồn tại!");
																	swal("Lỗi!", "Phòng không tồn tại!", "error")
																	
																	$(
																			"#id_room2")
																			.val(
																					"");
																	$(
																			"#participation")
																			.attr(
																					'disabled',
																					'disabled');
																	return false;
																} else {
																	$(
																			"#room_name_participation")
																			.val(
																					response);
																	$(
																			"#participation")
																			.removeAttr(
																					'disabled');
																	return true;
																}
															}

														});

											});

							$("#createroom")
									.click(
											function() {
												var name_room = $("#name_room")
														.val().trim();
												if (!name_room
														|| name_room == undefined
														|| name_room == ""
														|| name_room == 0) {
													
													swal("Lỗi!", "Bạn cần nhập tên phòng!", "error")
// 													alert("Bạn cần nhập tên phòng!");
													return false;
												} else {
													$
															.ajax({
																url : "/createroom",
																type : "POST",
																data : {
																	name_room : name_room
																},
																success : function(
																		response) {
																	if (response == "false") {
																		swal("Lỗi!", "Tạo phòng thất bại!", "error")
// 																		alert("Tạo phòng thất bại!");
																		return false;
																	} else {
																		$(
																				"#id_room")
																				.val(
																						response);
																	}
																}

															});
													$("#name_room").val("");
													return true;
												}

											});
						}

				);
		var clipboard = new Clipboard('.btn-copy');

		clipboard.on('success', function(e) {
			console.log(e);
		});

		clipboard.on('error', function(e) {
			console.log(e);
		});