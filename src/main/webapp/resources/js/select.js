$(document).ready(function() {
    // select year
    var startYear = 2021;
    var endYear = 2024;

    // select#selectYear에 option 추가
    for (var year = startYear; year <= endYear; year++) {
        $('#startYear').append('<li data-value="' + year + '">' + year + '</li>');
        $('#endYear').append('<li data-value="' + year + '">' + year + '</li>');
    }

    // select month
    var startMonth = 1; // 01 -> 1
    var endMonth = 12;

    for (var month = startMonth; month <= endMonth; month++) {
        $('#startMonth').append('<li data-value="' + month + '">' + month + '</li>');
        $('#endMonth').append('<li data-value="' + month + '">' + month + '</li>');
    }
    
    // select Sum
    var selectSum;

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
        $(this).replaceWith(function() {
            return $('<ul>', {
                id: id, 
                class: classes, 
                name: name,
                html: $(this).html()
            });
        });
    });

    $('.select option').each(function() {
        var dataValue = $(this).attr('value');
        $(this).replaceWith(function() {
            return $('<li>', { 
                'data-value' : dataValue,
                html: $(this).html() 
            });
        });
    });

    // 초기값 설정
    $('#startYear').parents('.select_box').siblings('.select_title').children('span').html('2021');
    $('#endYear').parents('.select_box').siblings('.select_title').children('span').html('2024');
    $('#startMonth').parents('.select_box').siblings('.select_title').children('span').html('1');
    $('#endMonth').parents('.select_box').siblings('.select_title').children('span').html('10');
    
    var startYearValue =  parseInt($('#startYear').parents('.select_box').siblings('.select_title').children('span').text());
    var endYearValue =  parseInt($('#endYear').parents('.select_box').siblings('.select_title').children('span').text());
    var startMonthValue =  parseInt($('#startMonth').parents('.select_box').siblings('.select_title').children('span').text());
    var endMonthValue =  parseInt($('#endMonth').parents('.select_box').siblings('.select_title').children('span').text());

    
    $.ajax({
        url: '/getHome', // 요청을 보낼 URL
        type: 'GET', // 요청 방식 (GET)
        data: {
            startYear: startYearValue,  // 전달할 데이터
            endYear: endYearValue,
            startMonth: startMonthValue,
            endMonth: endMonthValue
        },
        success: function(data) {            
            console.log('startYearValue:', startYearValue);
            console.log('endYearValue:', endYearValue);
            console.log('startMonthValue:', startMonthValue);
            console.log('endMonthValue:', endMonthValue);
        },
        error: function(xhr, status, error) {
            console.log("에러 발생:", error); // 오류 처리
        }
    });
    
    $.ajax({
        url: '/getApi', // 요청을 보낼 URL
        type: 'GET', // 요청 방식 (GET)
        data: {
            startYear: startYearValue,  // 전달할 데이터
            endYear: endYearValue,
            startMonth: startMonthValue,
            endMonth: endMonthValue
        },
        success: function(data) {            
            console.log("서버에서 받은 데이터: ", data);
            
            console.log('startYearValue:', startYearValue);
            console.log('endYearValue:', endYearValue);
            console.log('startMonthValue:', startMonthValue);
            console.log('endMonthValue:', endMonthValue);
            
            var htmlData = extractApiData(data);
            console.log(htmlData);  // 추출한 apiData를 콘솔에 출력

            if (htmlData && htmlData.length > 0) {
                var htmlContent = '';
                htmlData.forEach(function(item) {
                    htmlContent += `
                        <li>
                            <ul class="flex">
                                <li>-</li>
                                <li>${item.year}</li>
                                <li>${item.month < 10 ? '0' + item.month : item.month}</li>  
                                <li>${item.metro}</li>
                                <li>${item.city}</li>
                                <li>${item.cntr}</li>
                                <li>${item.powerUsage} kWh</li>
                                <li>${item.bill} 원</li>
                                <li>${item.unitCost} 원</li>
                            </ul>
                        </li>
                    `;
                });

                // #selectList라는 id를 가진 요소에 동적으로 생성된 HTML 삽입
                $('#selectList').html(htmlContent);
                $('#apitotal').html(htmlData.length);
            } else {
                // 데이터가 없으면 "데이터가 없습니다" 메시지 출력
                $('#selectList').html('<li class="no-data">데이터가 없습니다.</li>');
            }
        },
        error: function(xhr, status, error) {
            console.log("에러 발생:", error); // 오류 처리
        }
    });
    
    function extractApiData(html) {
        var apiData = null;

        // script 태그 내에서 var apiData = ...; 패턴을 찾기 위한 정규식
        var regex = /var apiData\s*=\s*(\[\{.*\}\]);/;
        var match = html.match(regex);

        if (match && match[1]) {
            try {
                // JSON 형식의 문자열을 객체로 변환
                apiData = JSON.parse(match[1]);
            } catch (e) {
                console.error('apiData 파싱 실패:', e);
            }
        }

        return apiData;
    }
    
    // 값 선택 후 AJAX 요청
    $('.select li').click(function() {
        var txt = $(this).html();
        var dataValue = $(this).attr('data-value');
        $(this).parents('.select_box').siblings('.select_title').children('span').html(txt);
        $(this).parents('.select_box').siblings('.select_title').attr('data-value', dataValue);
        
        var startYearValue =  parseInt($('#startYear').parents('.select_box').siblings('.select_title').children('span').text());
        var endYearValue =  parseInt($('#endYear').parents('.select_box').siblings('.select_title').children('span').text());
        var startMonthValue =  parseInt($('#startMonth').parents('.select_box').siblings('.select_title').children('span').text());
        var endMonthValue =  parseInt($('#endMonth').parents('.select_box').siblings('.select_title').children('span').text());
       
        $.ajax({
            url: '/getApi', // 요청을 보낼 URL
            type: 'GET', // 요청 방식 (GET)
            data: {
                startYear: startYearValue,  // 전달할 데이터
                endYear: endYearValue,
                startMonth: startMonthValue,
                endMonth: endMonthValue
            },
            success: function(data) {
                console.log("서버에서 받은 데이터: ", data);
                var htmlData = extractApiData(data);
                console.log(htmlData);  // 추출한 apiData를 콘솔에 출력

                if (htmlData && htmlData.length > 0) {
                    var htmlContent = '';
                    htmlData.forEach(function(item) {
                        htmlContent += `
                            <li>
                                <ul class="flex">
                                    <li>-</li>
                                    <li>${item.year}</li>
                                    <li>${item.month < 10 ? '0' + item.month : item.month}</li>  <!-- 월 형식화 (01, 02, ...) -->
                                    <li>${item.metro}</li>
                                    <li>${item.city}</li>
                                    <li>${item.cntr}</li>
                        			<li>${item.powerUsage} kWh</li>
                                	<li>${item.bill} 원</li>
                                	<li>${item.unitCost} 원</li>

                                </ul>
                            </li>
                        `;
                    });

                    // #selectList라는 id를 가진 요소에 동적으로 생성된 HTML 삽입
                    $('#selectList').html(htmlContent);
                    $('#apitotal').html(htmlData.length);
                } else {
                    // 데이터가 없으면 "데이터가 없습니다" 메시지 출력
                    $('#selectList').html('<li class="no-data">데이터가 없습니다.</li>');
                }
            },
            error: function(xhr, status, error) {
                console.log("에러 발생:", error); // 오류 처리
            }
        });
    });
    // select_area 클릭 시 open 클래스 토글
    $('.select_area').click(function() {
    	$(this).toggleClass('open').siblings().removeClass('open');
    });
});
