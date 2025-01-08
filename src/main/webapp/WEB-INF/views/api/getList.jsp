<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% 
    request.setAttribute("bodyClass", "main");
%>
<jsp:include page="../inc/header.jsp" />
            	<!-- #content 영역 시작 -->
            	<script>
            	$(document).ready(function() {
            		$('div.tab > button').click(function(){
            			$(this).addClass('on');
            			$(this).siblings().removeClass('on');
            		})
            	});
            	</script>
				<div id="content">
					<div class="tab flex">
						<button type="button" id="" class="on">전체</button>
						<button type="button" id="">시군구별</button>
						<button type="button" id="">시도별</button>
					</div>
					<p class="total">Total : <span id="apitotal">${apiDataSize}</span></p>
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
					<ul class="table" id="selectList">
						<c:choose>
							<c:when test="${not empty apiData}">
								<c:forEach var="list" items="${apiData}" varStatus="no">
									<li>
										<ul class="flex">
											<li><fmt:formatNumber value="${no.index + 1}" groupingUsed="true" /></li>
											<li>${list.year}</li>
											<li>${list.month}</li>
											<li>${list.metro}</li>
											<li>${list.city}</li>
											<li>${list.cntr}</li>
											<li><fmt:formatNumber value="${list.powerUsage}" groupingUsed="true" /> kWh</li>
											<li><fmt:formatNumber value="${list.bill}" groupingUsed="true" /> 원</li>
											<li><fmt:formatNumber value="${list.unitCost}" groupingUsed="true" /> 원</li>
										</ul>
									</li>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<li class="no-data">준비된 정보가 없습니다.</li>
							</c:otherwise>
						</c:choose>
					</ul>
					<div class="pagination"></div>
				</div>  
				<!-- #content 영역 끝 -->
<jsp:include page="../inc/footer.jsp" />