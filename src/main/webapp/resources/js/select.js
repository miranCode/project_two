$(document).ready(function(){ 
	// select year
	var startYear = 2021;
    var endYear = 2024;
    
    // select#selectYear에 option 추가
    for (var year = startYear; year <= endYear; year++) {
        $('#startYear').append('<li data-value="' + year + '">' + year + '</li>');
        $('#endYear').append('<li data-value="' + year + '">' + year + '</li>');
    }
    
    // select month
    var startMonth = 01;
    var endMonth = 12;
	
    for (var month = startMonth; month <= endMonth; month++) {
        $('#startMonth').append('<li data-value="' + month + '">' + month + '</li>');
        $('#endMonth').append('<li data-value="' + month + '">' + month + '</li>');
    }
	// select metro 
    
    // select style 
 	$('.select').wrap('<div class="select_area"></div>').wrap('<div class="select_box"></div>');
 	$('.select_area').append("<div class='select_title'><span></span><i class='xi-angle-down'></i></div>");

 	// 기존 태그를 새로운 태그로 변경하면서 id와 class를 그대로 유지
 	$('.select').each(function() {
 	    var id = $(this).attr('id'); // 기존 id
 	    var classes = $(this).attr('class'); // 기존 클래스
 	    var name = $(this).attr('name');
 	    var title = $(this).attr('title');
 	    
 	    $(this).parent().siblings('.select_title').children('span').html(title);
 	    // 새로운 태그로 교체 (예: div -> p)
 	    $(this).replaceWith(function() {
 	        return $('<ul>', { // 새로운 태그로 변경
 	            id: id, // 기존 id를 그대로 적용
 	            class: classes, // 기존 클래스를 그대로 적용
 	            name: name,
 	            html: $(this).html() // 기존 HTML 내용도 그대로 적용
 	        });
 	    });
 	});
 	$('.select option').each(function() {
 		var dataValue = $(this).attr('value');
 		$(this).replaceWith(function() {
 			return $('<li>', { // 새로운 태그로 변경
 				'data-value' : dataValue,
 	            html: $(this).html() // 기존 HTML 내용도 그대로 적용
 	        });
 		})
 	});
 	
 	$('.select li').click(function(){
 		var txt = $(this).html();
 		var dataValue = $(this).attr('data-value');
 		$(this).parents('.select_box').siblings('.select_title').children('span').html(txt);
 		$(this).parents('.select_box').siblings('.select_title').attr('data-value', dataValue);
 	})

 	$('.select_area').click(function(){
 		$(this).toggleClass('open');
 	})
	
	
})