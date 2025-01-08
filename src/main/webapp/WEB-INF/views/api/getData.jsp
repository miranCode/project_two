<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% request.setAttribute("bodyClass", "main"); %>
<jsp:include page="../inc/header.jsp" />
<script>
$(document).ready(function() {
    // 초기 데이터 로딩
    loadData("전체");

    // 탭 클릭 시 데이터 로딩
    $('div.tab > button').click(function() {
    	console.log("클릭");
        var tabType = $(this).text().trim(); // 클릭한 버튼의 텍스트 가져오기
        $(this).addClass('on');
        $(this).siblings().removeClass('on');
        loadData(tabType); // 해당 탭에 맞는 데이터 로드
    });
    
    console.log(loadData);
    
	// AJAX 요청으로 데이터 불러오기
	function loadData(type) {
		$('#loading').addClass('open');  // 로딩 인디케이터 표시
		$("#selectList").removeClass('open');
		setTimeout(function() {
			$.ajax({
		        url: '/getData', // Spring Controller의 URL
		        method: 'GET',
		        data: { type: type }, // 데이터 요청
		        beforeSend:function(){ 
		        	// 요청 전에 실행할 코드
		        	$('#loading').addClass('open');
		        	$("#selectList").removeClass('open');
		        },
		        success: function(response) {
		            console.log(response); // 응답 확인 (디버깅용)
		            var html = '';
		            if (response.length > 0) {
		                $.each(response, function(index, item) {
		                    html += '<li>';
		                    html += '<ul class="flex">';
		                    html += '<li>' + (index + 1) + '</li>';
		                    html += '<li>' + item.year + '</li>';
		                    html += '<li>' + item.month + '</li>';
		                    html += '<li>' + item.metro + '</li>';
		                    html += '<li>' + item.city + '</li>';
		                    html += '<li>' + item.cntr + '</li>';
		                    html += '<li>' + item.powerUsage.toLocaleString('ko-KR') + ' kWh</li>';
		                    html += '<li>' + item.bill.toLocaleString('ko-KR') + ' 원</li>';
		                    html += '<li>' + item.unitCost.toLocaleString('ko-KR') + ' 원</li>';
		                    html += '</ul>';
		                    html += '</li>';
		                });
		                $("#selectList").addClass('open');
		                $("#selectList").html(html);  // 테이블 내용 업데이트
		                $("#apitotal").text(response.length); // Total 값 갱신
		            } else {
		                $("#selectList").html('<li class="no-data">준비된 정보가 없습니다.</li>');
		            }
		        },
		        error: function(xhr, status, error) {
		            console.log("Error:", error); // 오류 발생 시 확인
		        },
		        complete: function() {
		            $('#loading').removeClass('open');  // 로딩 인디케이터 숨김
		        }
			});
		}, 1000);
	}
});
</script>
<div id="content">
	<div class="tab-area">
		<div class="flex">
			<div class="tit">합계</div>
			<div class="tab">
	        	<button type="button" class="on">전체</button>
	        	<button type="button">시군구</button>
	        	<button type="button">시도</button>
	        </div>
	    </div>
    	<c:if test="${not empty metroName}">
    		<div class="flex">
				<div class="tit">시도</div>
				<div class="tab">
					<button type="button" class="on">전체</button>
			    	<c:forEach var="name" items="${metroName}">
			    		<button type="button">${name.metro}</button>
			    	</c:forEach>
		    	</div>
		    </div>
    	</c:if>
    	<c:if test="${not empty cntrName}">
    		<div class="flex">
				<div class="tit">계약종별</div>
				<div class="tab">
					<button type="button" class="on">전체</button>
			    	<c:forEach var="name" items="${cntrName}">
			    		<button type="button">${name.cntr}</button>
			    	</c:forEach>
		    	</div>
		    </div>
    	</c:if>
    </div>
    <p class="total">Total : <span id="apitotal">0</span></p>
    <ul class="table table-header">
        <li>
            <ul class="flex">
                <li>No</li>
                <li>년도<br />(year)</li>
                <li>월<br />(month)</li>
                <li>시도명<br />(metro)</li>
                <li>시군구명<br />(city)</li>
                <li>계약종별<br />(cntr)</li>
                <li>전력사용량<br />(powerUsage)</li>
                <li>전기요금<br />(bill)</li>
                <li>평균판매단가<br />(unitCost)</li>
            </ul>
        </li>
    </ul>
    
    <!-- 데이터가 들어갈 부분 -->
    <ul class="table" id="selectList">
    </ul>
    <ul id="loading">
    	<li>
        	<i class="xi-spinner-1 xi-spin"></i>
        	로딩중
        </li>
    </ul>

    <div class="pagination"></div>
</div>

<jsp:include page="../inc/footer.jsp" />


