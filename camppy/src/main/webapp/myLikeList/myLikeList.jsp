<%@page import="camppy.member.MemberDAO"%>
<%@page import="camppy.member.MemberDTO"%>
<%@page import="camppy.commu.db.CommuDAO"%>
<%@page import="java.util.List"%>
<%@page import="camppy.main.action.PageDTO"%>
<%@page import="camppy.mypage.LikeDTO"%>
<%@page import="camppy.mypage.LikeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="myLikeList/myLikeList.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
a, button, input, select, h1, h2, h3, h4, h5, * {
	margin: 0;
	padding: 0;
	border: none;
	text-decoration: none;
	/*  appearance: none; */
	background: none;
}
</style>
<title>Document</title>
</head>
<body>

	<!-- 헤더들어가는 곳 -->
	<jsp:include page="/inc/top.jsp" />

	<!-- 헤더들어가는 곳 -->

	<%
	//세션에서 로그인정보, 예약정보 가져오기
	String nickname = (String) session.getAttribute("nickname");
	String id = (String) session.getAttribute("id");
	int memberid= (int)session.getAttribute("memberid");
	CommuDAO commuDAO = new CommuDAO();
	MemberDTO memberDTO = new MemberDTO();
	MemberDAO memberDAO = new MemberDAO();
	memberDTO = memberDAO.getMember(id);
	
	
	%>

	<div class="mypageProfile">
		<img class="mypageUserIcon"
			src="memberimg/<%=memberDTO.getMember_img() %>" />
		<div class="profileNickname"><%=nickname%></div>
		<button type="button"
			onclick="openCenteredPopup('update.me', 'ReviewPopup', 850, 650)"
			class="updateButton">
			<div class="updateProfile">프로필수정</div>
		</button>
		<div class="mypageProfileNum">
			<div class="myArticle">작성글</div>
			<div class="myArticleNum"><%=commuDAO.myCountids(memberid) %></div>
			<div class="myReply">댓글</div>
			<div class="myReplyNum"><%=commuDAO.myCountrv(memberid) %></div>
		</div>
	</div>
	<div class="mypageNavi">
		<div class="tab" id="tab1" onclick="location.href='likeList.my'">찜
			리스트</div>
		<div class="tab" id="tab2"
			onclick="location.href='myContentsList.commu'">작성한 글</div>
		<div class="tab" id="tab3"
			onclick="location.href='mypageReviewList.rv'">작성 리뷰</div>
		<div class="tab" id="tab4" onclick="location.href='mypage_reserve.re'">예약
			내역</div>
	</div>



	<%
	PageDTO pageDTO = (PageDTO) request.getAttribute("pageDTO");
	List<LikeDTO> likeList = (List<LikeDTO>) request.getAttribute("likeList");
	LikeDTO likeDTO = new LikeDTO();
	LikeDAO likeDAO = new LikeDAO();

	request.setCharacterEncoding("UTF-8");
	%>
	
	<div class="reviewTop">
		<div class="reviewCount">찜 리스트</div>

		<button type="button" onclick="selectedDel();" class="selectDel">
			<div>선택해제</div>
		</button>
		<label class="selectAll"> <b>전체선택</b>&nbsp;<input
			type="checkbox" class="selectCheck" id="cboxAll">
		</label>

	</div>


	<div class="allbody">
		<div class="likeList">
		<%
		for (int i = 0; i < likeList.size(); i++) {
			likeDTO = likeList.get(i);
		%>
				<img class="likeListPhoto" src="campimg/<%=likeDTO.getCamp_img()%>" />
				<div class="likeList2">
					<div class="likeListTitle"><%=likeDTO.getCamp_name()%></div>
					<div class="likeListAdd">
						<%=likeDTO.getCamp_addr()%>
					</div>
					<div class="likeListTag">
						<%=likeDTO.getFacility()%>
					</div>
					<div class="likeListTell"><%=likeDTO.getTel()%></div>

					
						<img src="myLikeList/hearts.png" class=hearts>
						<div class="likeNum"><%=likeDAO.getlikecount(likeDTO.getCamp_id())%></div>
					
				
				<!-- 			  //선택삭제 -->
				<div class="eachCheck">
					<input type="checkbox" name="cbox" class="eachCheckbox"
						value="<%=likeDTO.getCamp_like_id()%>">
				</div></div>
<!-- 				</div> -->
				<%
				}
				%>			
			
			<%
			// 시작 페이지 1페이지 Prev 없음
			// 시작 페이지 11, 21, 31 Prev 보임
			%>
			<div class="pagination">
			<% 
			if (pageDTO.getStartPage() > pageDTO.getPageBlock()) {
			%>
			<a
				href="likeList.my?pageNum=<%=pageDTO.getStartPage() - pageDTO.getPageBlock()%>">Prev</a>
			<%
			}
			%>


			<%
			// for(int i=시작하는 페이지 번호; i<=끝나는 페이지 번호; i++)
			for (int i = pageDTO.getStartPage(); i <= pageDTO.getEndPage(); i++) {
			%>
			<a href="likeList.my?pageNum=<%=i%>" class="page"><%=i%></a>
			<%
			}
			%>

 
			<%
			// 끝페이지번호 전체페이지수 비교 -> 전체페이지수 클 때 -> Next 보임
			if (pageDTO.getEndPage() < pageDTO.getPageCount()) {
			%>
			<a
				href="likeList.my?pageNum=<%=pageDTO.getStartPage() + pageDTO.getPageBlock()%>">Next</a>
			<%
			}
			%>


		
	</div>


	<!-- 푸터들어가는 곳 -->
	<jsp:include page="/inc/bottom.jsp" />
	<!-- 푸터들어가는 곳 -->



	<script type="text/javascript">
		$(document).ready(function() {
			// 전체선택 체크박스 클릭 시
			$("#cboxAll").on("click", function() {
				$("input:checkbox[name=cbox]").prop("checked", this.checked);
			});

			// 개별 체크박스 클릭 시
			$(document).on("click", "input:checkbox[name=cbox]", function(e) {
				var chks = document.getElementsByName("cbox");
				var chksChecked = 0;

				for (var i = 0; i < chks.length; i++) {
					var cbox = chks[i];

					if (cbox.checked) {
						chksChecked++;
					}
				}
				if (chks.length == chksChecked) {
					$("#cboxAll").prop("checked", true);
				} else {
					$("#cboxAll").prop("checked", false);
				}
			});

			// 전체선택 체크박스 상태 변경 시
			$(document).on("change", "#cboxAll", function() {
				var chks = document.getElementsByName("cbox");

				for (var i = 0; i < chks.length; i++) {
					var cbox = chks[i];
					cbox.checked = this.checked;
				}
			});
		});
		//선택삭제
		function selectedDel() {
			var campLikeIds = [];
			var selectedRows = [];

			// 선택된 체크박스와 해당 행을 찾아서 배열에 추가
			$("input:checkbox[name='cbox']:checked").each(function() {
				campLikeIds.push($(this).val());
				selectedRows.push($(this).closest(".likeListBody"));
			});

			if (campLikeIds.length === 0) {
				alert("해제 할 캠핑장을 선택하세요.");
				return;
			}

			// 사용자에게 삭제 여부를 확인하는 대화 상자 표시
			var confirmMessage = "선택한 캠핑장을 해제 하시겠습니까?";
			if (confirm(confirmMessage)) {
				$.ajax({
					type : "POST",
					url : "myLikeList/deleteSelectedLike.jsp",
					data : {
						campLikeIds : campLikeIds.join("|")
					},
					success : function(result) {
						console.log(result);

						// 삭제가 성공한 경우 선택된 행을 화면에서 제거
						if (result.trim() === "success") {
							for (var i = 0; i < selectedRows.length; i++) {
								selectedRows[i].remove();
							}
							location.reload();
						} else {
							alert("해제 실패");
						}
					},
					error : function(xhr, status, error) {
						alert(error);
					}
				});
			}
		}
	</script>





</body>

</html>
