<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    // 페이지마다 각 title 설정 
    String pageTitle = (String) request.getAttribute("pageTitle");
    if (pageTitle == null) {
    	pageTitle = "";	
    }
	 // 페이지마다 각 bodyClass 설정 
    String bodyClass = (String) request.getAttribute("bodyClass");
    if (bodyClass == null) {
        bodyClass = ""; 
    }
%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- css 불러오기 -->
        <link rel="stylesheet" type="text/css" href="/resources/css/layout.css?after" />
        <link rel="stylesheet" type="text/css" href="/resources/js/slick-1.8.1/slick/slick.css"/>
        <!-- // css 불러오기 -->
        <!-- 아이콘 불러오기 -->
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
        <!-- 내부 링크 -->
        <script type="text/javascript" src="/resources/js/jquery-3.7.1.min.js"></script>
        <script type="text/javascript" src="/resources/js/slick-1.8.1/slick/slick.min.js"></script>
        <script type="text/javascript" src="/resources/js/select.js"></script>
		<title><%= pageTitle %></title>
	</head>
	<body class="<%= bodyClass %>">
		<!-- wrap 영역 시작 -->
        <div id="wrap">
            <!-- header 영역 시작 -->
            <header id="header" class="">
            	<!-- 로고 및 유틸 영역 시작 -->
                <div class="header-top">
                    <h1 class="logo">
                        <a href="/">
                            에러검열단
                            <span>전력사용량 예측 모니터링 대시보드</span>
                        </a>
                    </h1>
                    <button id="more-gnb">
                        <span></span>
                        <span></span>
                        <span></span>
                    </button>
                </div>
                <!-- 로고 및 유틸 영역 끝 -->
                <!-- #gng 영역 시작 -->
                <nav id="gnb">
                </nav>
                <!-- #gng 영역 끝 -->
            </header>
            <!-- header 영역 끝 -->
            <!-- #container 영역 시작 -->
            <div id="container">
            	<!-- #content 영역 시작 -->
				<div id="content">
					<select class="select" id="startYear" name="startYear" title="년도"></select>
					<select class="select" id="startMonth" name="startMonth" title="월"></select>
					~
					<select class="select" id="endYear" name="endYear" title="년도"></select>
					<select class="select" id="endMonth" name="endMonth" title="월"></select>
					<select class="select" id="selectMetro" name="metro" title="행정구역">
						<c:forEach var="metroCd" items="${metroData}">
							<option value="${metroCd.code}">${metroCd.name}</option>
						</c:forEach>
					</select>
					<style>
						ul.table{margin-top:30px}
						ul.table > li{width: 100%;}
						ul.table > li:first-child{border-top:1px solid #ddd; box-sizing:border-box; background: #f5f5f5; color:#999; font-size: 14px; line-height:1.3}
						ul.table > li ul li{
							width:calc(100%/8);
							padding:10px; 
							box-sizing:border-box; 
							text-align:center; 
							border:1px solid #ddd;
							border-top:0;
							border-right: 0;
						}
						ul.table > li ul li:last-child{border-right:1px solid #ddd;}
						
						ul.table > li ul li:first-child,
						ul.table > li ul li:nth-child(2),
						ul.table > li ul li:nth-child(5),
						ul.table > li ul li:last-child{width:calc(30%/4);}
						
						ul.table > li ul li:nth-child(3),
						ul.table > li ul li:nth-child(4),
						ul.table > li ul li:nth-child(6),
						ul.table > li ul li:nth-child(7){width:calc(70%/4);}
					</style>
					<ul class="table">
						<li>
					    	<ul class="flex">
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
						<c:forEach var="data" items="${apiData}">
						    <li>
						    	<ul class="flex">
						    		<li>${data.year}</li>
						    		<li>${data.month}</li>
						    		<li>${data.metro}</li>
						    		<li>${data.city}</li>
						    		<li>${data.cntr}</li>
						    		<li>
						    			<fmt:formatNumber value="${data.powerUsage}" type="number" pattern="#,##0 kWh"/>
						    		</li>
						    		<li>
						    			<fmt:formatNumber value="${data.bill}" type="number" pattern="#,##0 원"/>
						    		</li>
						    		<li>${data.unitCost} 원</li>
						    	</ul>
						    </li>
						</c:forEach>
					</ul>
				</div>  
				<!-- #content 영역 끝 -->
            </div>
            <!-- #container 영역 끝 -->
            <!-- footer 영역 시작 -->
            <footer id="footer">
            </footer>
            <!-- footer 영역 끝 -->
        </div>
        <!-- wrap 영역 끝 -->
	</body>
</html>
