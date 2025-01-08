<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% 
    request.setAttribute("bodyClass", "main");
%>
<jsp:include page="../inc/header.jsp" />
				<script type="text/javascript" src="/resources/js/select.js"></script>
            	<!-- #content 영역 시작 -->
            	
				<div id="content">
					<div class="seach-area">
						<select class="select" id="startYear" name="startYear" title="년도"></select>
						<select class="select" id="startMonth" name="startMonth" title="월"></select>
						~
						<select class="select" id="endYear" name="endYear" title="년도"></select>
						<select class="select" id="endMonth" name="endMonth" title="월"></select>
					</div>
					<p class="total">Total : <span id="apitotal"></span></p>
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
								<c:forEach var="list" items="${apiData}">
									<li>
										<ul class="flex">
											<li>-</li>
											<li>${list.year}</li>
											<li>${list.month}</li>
											<li>${list.metro}</li>
											<li>${list.city}</li>
											<li>${list.cntr}</li>
											<li>${list.powerUsage}</li>
											<li>${list.bill}</li>
											<li>${list.unitCost}</li>
										</ul>
									</li>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<li class="no-data">준비된 정보가 없습니다.</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>  
				<!-- #content 영역 끝 -->
<jsp:include page="../inc/footer.jsp" />