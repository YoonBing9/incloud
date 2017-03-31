let index = 0;
$(document).ready(function () {
	$('nav .list-group-item').click(function(){
		let part1 = $(this).parent().parent().parent().children().children().children().html();
		let part2 = $(this).text();
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
			+"<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"ListVOList["+index+"].graph[0]\" value=\"A\">A Graph</label>"
			+"<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"ListVOList["+index+"].graph[1]\" value=\"B\">B Graph</label>"
			+"<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"ListVOList["+index+"].graph[2]\" value=\"C\">C Graph</label>"
	      +"</div>"
		+"</div>"		
		);
		$(document).find(".input-daterange").removeClass('hasDatepicker').datepicker();
		$('html, body').stop().animate( { scrollTop : document.body.scrollHeight }, 1000 );
		index++;
	});
	
	$(document).on('click','.glyphicon-remove',function(){
		$(this).parent().parent().addClass('panel-primary-remove');
		$(this).parent().parent().delay(1000).fadeOut(0, function(){
			$(this).remove();
		});
	});
});