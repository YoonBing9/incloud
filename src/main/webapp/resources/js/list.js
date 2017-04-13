let index = 0;
$(document).ready(function () {
	$('nav .list-group-item').click(function(){
		let part1 = $(this).parents().eq(2).find('h4').html();
		let part2 = $(this).attr('id');
		$('#list').append(
			"<div class=\"panel panel-primary\">"
		      +"<div class=\"panel-heading\">"
	      	+part1
	      	+"<button type=\"button\" class=\"glyphicon glyphicon-remove\"></button>"
	      +"</div>"
	      +"<div class=\"panel-body\">"
	      	+"<input type=\"hidden\" name=\"ListVOList["+index+"].part1\" value="+part1+">"
	      	+"<input type=\"hidden\" name=\"ListVOList["+index+"].part2\" value="+part2+">"
	      	+"<h4>"
	      	+part2
	      	+"</h4>"
	      	+"<h5>기간</h5>"
	      	+"<div class=\"input-daterange input-group\" id=\"datepicker\">"
			    +"<input type=\"text\" class=\"input-sm form-control\" name=\"ListVOList["+index+"].start\" />"
			    +"<span class=\"input-group-addon\">to</span>"
			    +"<input type=\"text\" class=\"input-sm form-control\" name=\"ListVOList["+index+"].end\" />"
			+"</div>"
			+"<br>"
			+"<h5>그래프</h5>"
			+"<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"ListVOList["+index+"].graph[0]\" value=\"line\">Line</label>"
			+"<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"ListVOList["+index+"].graph[1]\" value=\"histogram\">Histogram</label>"
			+"<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"ListVOList["+index+"].graph[2]\" value=\"bubble\">Bubble</label>"
			+"<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"ListVOList["+index+"].graph[2]\" value=\"motion\">Motion</label>"
	      +"</div>"
		+"</div>"		
		);
		$(document).find(".input-daterange").removeClass('hasDatepicker').datepicker({
			format : "yyyy/mm",
			minViewMode : 1
		});
		$('html, body').stop().animate( { scrollTop : document.body.scrollHeight }, 1000 );
		index++;
		
		if(part2 == "KOSPI") {
			$("input:checkbox[value=bubble]").parent().hide();
			$("input:checkbox[value=motion]").parent().hide();
		}
	});
	
	$(document).on('click','.glyphicon-remove',function(){
		$(this).parents().eq(1).remove();
	});
	
	/*$(document).on('click','.glyphicon-remove',function(){
		$(this).parent().parent().addClass('panel-primary-remove');
		$(this).parent().parent().delay(1000).fadeOut(0, function(){
			$(this).remove();
		});
	});*/
});