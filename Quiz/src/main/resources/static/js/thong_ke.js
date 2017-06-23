function thong_ke_trac_nghiem(e) {
	var idPost = $(e).val();
	$
			.ajax({
				url : '/check-trac-nghiem',
				type : 'POST',
				dataType : 'text',
				data : {
					idPost : idPost
				},
				success : function(result1) {
					if (result1 == "0") {

						swal("Lỗi!", "Bạn phải chọn câu trả lời mới có thể xem thống kê!", "error")
					} else {
						$
								.ajax({
									url : '/thong-ke-trac-nghiem',
									type : 'POST',
									dataType : 'json',
									data : {
										idPost : idPost
									},
									success : function(result) {

										var d1, d2, d3, d4 = 0;

										d1 = result["1"];
										d2 = result["2"];
										d3 = result["3"];
										d4 = result["4"];
										if (d1 == null) {
											d1 = 0;
										}
										if (d2 == null) {
											d2 = 0;
										}
										if (d3 == null) {
											d3 = 0;
										}
										if (d4 == null) {
											d4 = 0;
										}
										if (d1 != 0 || d2 != 0 || d3 != 0
												|| d4 != 0) {
											var ctx = document.getElementById(
													"myChart").getContext('2d');

											window.myPieChart = new Chart(
													ctx,
													{
														type : 'pie',
														data : {
															labels : [
																	"Đáp án 1",
																	"Đáp án 2",
																	"Đáp án 3",
																	"Đáp án 4" ],
															datasets : [ {
																backgroundColor : [
																		"#e74c3c",
																		"#3498db",
																		"#f1c40f",
																		"#34495e"

																],
																data : [ d1,
																		d2, d3,
																		d4 ]
															} ]
														},
														options : {

															tooltips : {
																callbacks : {
																	label : function(
																			tooltipItems,
																			data) {
																		return data.labels[tooltipItems.index]
																				+ " : "
																				+ data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index]
																				+ ' Người lựa chọn';
																	}
																}
															}

														}

													});

											$('#modal_thong_ke').modal('show');
											$(".thong_ke").attr("value",idPost);
										} else {

											swal(
													"Lỗi!",
													"không có dữ liệu để vẽ biểu đồ!",
													"error")
										}

									}
								});
					}
				}
			});
}

$(function() {

	$('#modal_thong_ke').on('hidden.bs.modal', function(e) {
		myPieChart.destroy();

	})

});



function xem_nguoi_chon_trac_nghiem(e){
	var idPost =$(e).val();
	$('#modal_thong_ke').modal('hide');
	
	$.ajax({
		url : '/nguoi-chon-trac-nghiem',
		type : 'POST',
		dataType : 'json',
		data : {
			idPost : idPost
		},
		success : function(result1) {
			console.log(result1);
//			alert(result1);
			var htmlCode ="";
			for(i=0;i<result1.length;i++){
				htmlCode+='<img src="'+result1[i].avatar+'" class="img-circle" alt="'+result1[i].name+'" width="50" height="50">'
				+'<a href="/account/viewinfo/acc'+result1[i].idAcc+'"><span class="text-info text-center"> '+result1[i].name+'</span></a>'+'<span class="text-danger">&nbsp;&nbsp;&nbsp;&nbsp; chọn đáp án '+result1[i].dapAn+'</span><br/>'
				
				
			}
			$("#ds_nguoi_chon").html("");
			$("#ds_nguoi_chon").html(htmlCode);
			 $('#modal_danh_sach_nguoi_chon').modal('show');

		}
	});
	
	
}


