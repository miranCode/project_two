<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% 
    request.setAttribute("bodyClass", "");
%>
<jsp:include page="../inc/header.jsp" />
	<script>
	$(document).ready(function() {
		$('.copyBtn').click(function() {
			var copyText = $(this).parent().siblings().children('textarea');
			copyText.select();
			document.execCommand("copy");
			alert("복사되었습니다.");
		})
	});
	</script>
	<!-- #content 영역 시작 -->
	<div id="content">
		<ul class="info">
			<!--  -->
			<li>
				<p>사이트</p>
				<div>
					<dl>
						<dt>자주 사용하는 사이트</dt>
						<dd>
							<ul class="flex">
								<li><a class="link" href="https://www.xml-sitemaps.com/" target="_blank">사이트맵 제작</a></li>
								<li><a class="link" href="https://www.privacy.go.kr/front/per/inf/perInfStep01.do" target="_blank">개인정보처리방침</a></li>
								<li><a class="link" href="https://xpressengine.github.io/XEIcon/library-2.3.3.html" target="_blank">XEicon</a></li>
								<li><a class="link" href="https://help.naver.com/service/5626/contents/19713?lang=ko" target="_blank">네이버검색추가등록</a></li>
							</ul>
						</dd>
					</dl>
				</div>
			</li>
			<!--  -->
			<!--  -->
			<li>
				<p>css</p>
				<div>
					<dl>
						<dt>display: flex</dt>
						<dd class="flex-area">
							<jsp:include page="./markup/flexmarkup.jsp" />
							<div id="copy-style">
								<div>
									<div class="flex">
										<p>style</p>
										<button class="copyBtn">복사하기</button>
									</div>
									<div>
										<textarea readonly>
.flex{display:flex;}
.flex.flex-wrap{flex-wrap:wrap;}
.flex.ju-between{justify-content: space-between;}
.flex.ju-center{justify-content: center;}
.flex.ju-end{justify-content: end;}
.flex.ju-around{justify-content: space-around;}
.flex.ju-evenly{justify-content: space-evenly;}
.flex.column{flex-direction: column}
.flex.column-reverse{flex-direction: column-reverse}
.flex.row{flex-direction: row}
.flex.row-reverse{flex-direction: row-reverse}
.flex.al-center{align-items: center;}
.flex.al-start{align-items: start;}
.flex.al-end{align-items: end;}
										</textarea>
									</div>
								</div>
							</div>
						</dd>
					</dl>
					<dl>
						<dt>img css
							<span>object-fit :  cover / contain / none / scale-down</span>
							<span>aspect-ratio</span>
						</dt>
						<dd class="img-area">
							<ul class="flex ju-between">
								<li>
									<p>1:1 <span>div.img-box.box100 > img</span></p>
									<div class="img-box box100">
										<img src="/resources/img/img01.jpg" />
									</div>
								</li>
								<li>
									<p>4:3 <span>div.img-box.box75 > img</span></p>
									<div class="img-box box75" style="margin-right:10px;">
										<img src="/resources/img/img01.jpg" />
									</div>
								</li>
								<li>
									<p>2:1 <span>div.img-box.box50 > img</span></p>
									<div class="img-box box50" style="margin-right:10px;">
										<img src="/resources/img/img01.jpg" />
									</div>
								</li>
								<li>
									<p>16:9 <span>div.img-box.box16 > img</span></p>
									<div class="img-box box16" style="margin-right:10px;">
										<img src="/resources/img/img01.jpg" />
									</div>
								</li>
								<li>
									<p>A4 <span>div.img-box.a4 > img</span></p>
									<div class="img-box a4" style="margin-right:10px;">
										<img src="/resources/img/img01.jpg" />
									</div>
								</li>
							</ul>
							<!-- copy-style -->
							<div id="copy-style">
								<div>
									<div class="flex">
										<p>style</p>
										<button class="copyBtn">복사하기</button>
									</div>
									<div>
										<textarea readonly>
.img-box{position:relative; width:100%; overflow:hidden}
.img-box img{object-fit: cover; width:100%; height:100%;}
.img-box.box100{aspect-ratio:1;}
.img-box.box50{aspect-ratio:2/1;}
.img-box.box75{aspect-ratio:4/3;}
.img-box.box16{aspect-ratio:16/9;}
.img-box.a4{aspect-ratio:1/1.414;}
										</textarea>
									</div>
								</div>
							</div>
							<!-- // copy-style  -->
						</dd>
					</dl>
					<dl>
						<dt>sns</dt>
						<dd>
							<jsp:include page="./markup/snsmarkup.jsp" />
							<!-- copy-style -->
							<div id="copy-style">
								<div>
									<div class="flex">
										<p>style</p>
										<button class="copyBtn">복사하기</button>
									</div>
									<div>
										<textarea readonly>
<jsp:include page="./markup/snsmarkup.jsp" />
										</textarea>
									</div>
								</div>
							</div>
							<!-- // copy-style  -->
														<!-- copy-style -->
							<div id="copy-style">
								<div>
									<div class="flex">
										<p>style</p>
										<button class="copyBtn">복사하기</button>
									</div>
									<div>
										<textarea readonly>
/* sns 스타일 */
ul.sns-area li{width:6rem; margin-right:1rem; overflow:hidden}
.icon{position:relative; width:100%; aspect-ratio:1; border-radius:11px; background:#ddd;}
.icon i{position:absolute; top:50%; left:50%; transform: translate(-50%, -50%); color:#fff; font-size:3rem}
.icon.kakao{background-color: #ffc000;}
.icon.naver{background-color:#0ac73e;}
.icon.instagram{background: radial-gradient(circle farthest-corner at 32% 106%,#ffe17d 0%,#ffcd69 10%,#fa9137 28%,#eb4141 42%,transparent 82%), linear-gradient(135deg,#234bd7 12%,#c33cbe 58%);}
.icon.facebook{background-color: #0082cd;}
.icon.youtube{background-color: #ff1d1d;}
.icon.twitter{background-color:#1d9bf0;}
										</textarea>
									</div>
								</div>
							</div>
							<!-- // copy-style  -->
						</dd>
					</dl>
					<dl>
						<dt>text-overflow:ellipsis</dt>
						<dd></dd>
					</dl>
				</div>
			</li>
			<!--  -->
		</ul>
	</div>
	<!-- #content 영역 끝 -->
<jsp:include page="../inc/footer.jsp" />