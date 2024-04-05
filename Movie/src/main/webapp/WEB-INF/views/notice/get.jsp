<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<style>


.red{
	border: 1px solid red;
	
}
.noti ul, .noti li{
	list-style: none;
}
.border_none{
	border:none;
}
.flex_center{
	display : flex;
	justify-content : center;
	align-items : center;
	text-align:center;
}
.flex{
	display : flex;
}
.top-block{
	height: 174px;
	}
.noti .title_area{
	background-color: #eaeaea;
	display : flex;
	justify-content : center;
	align-items : center;
	width:85px;
}
.noti .option_area{
	display:flex;
}

.noti .group_area{
	display:flex;
	width:100%;
	min-height:46px;
}

.noti .upload_area{
	width:100%;
}
.noti .file_upload{
	text-align:center;
	height:60px;
}
.noti .file_upload button{
	margin-top:7px;
}
 .noti .option_area{
padding: 10px 10px 0 10px;
}

/* 댓글 */
.noti .pull-right{
	float: right;
	
}
.noti .panel-head{
	height:56px;
}
</style>


<div class="noti container ">
			
	<!-- 바디영역 : 컨테이너 -->
	<div class="top-block">
		<!-- header에 가지리않기 위한 블록 -->
	</div>
	<div class="row">
		<div class="col-lg-12">
			<h2 class="page-header">공지 사항 (#<c:out value="${notice.bno}"/>)</h2>
		</div>
		<!-- end col-lg-12 -->
	</div>
	<div class="row">
		
			<div class="col-lg-12 ">


			<div class="border">

				<div class="group_area ">
					<div class="title_area border-bottom">
						<label>제목</label>
					</div>
					<div class="option_area border-bottom">
						
						<input class="border_none"  name='title' value='<c:out value="${notice.title}"/>' readonly="readonly">

					</div>
				</div>
				<div class="group_area ">
					<div class="title_area border-bottom">
						<label>글쓴이</label>
					</div>
					<div class="option_area border-bottom">
						<input class="border_none"  name='title' value='<c:out value="${notice.writer}"/>' readonly="readonly">
					</div>
				</div>
				<div class="group_area border-bottom">
					<div class="title_area">
						<label>첨부파일</label>
					</div>
					<div class="option_area">

					</div>
				</div>

				<div class="group_area content">
					<div class="title_area">
						<label>내용</label>
					</div>
					<div class="option_area">
						<textarea class="border_none" rows="8" name='content' readonly="readonly"><c:out value="${notice.content}"/></textarea>
					</div>


				</div>
			</div>
		<sec:authentication property="principal" var="pinfo"/>

        <sec:authorize access="isAuthenticated()">
	        <%-- <c:if test="${pinfo.username eq notice.writer}"> --%>
				<button data-oper='modify' class="border btn btn-default"
					onclick="location.href='/notice/modify?bno=<c:out value="${notice.bno}"/>'">수정하기</button>
			<%-- </c:if> --%>
		</sec:authorize> 
		
		<button data-oper='list' class="border btn btn-info"
				onclick="location.href='/notice/list'">뒤로가기</button> 
		
		<!-- <button data-oper='modify' class="border btn btn-default">등록하기</button>
		<button data-oper='list' class="border btn btn-info">뒤로가기</button> -->
		

		<form id='operForm' action="/notice/modify" method="get">
			
			<input type='hidden' id='bno' name='bno' value='<c:out value="${notice.bno}"/>'>
			<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
			<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
			<!-- 웹상에서 뒤로가기 버튼누를경우 Criteria 파라미터도 추가해서 전달해준다. -->
			
		
		</form>
		
		
		
		</div>	

	</div>
	<!-- end row -->

	<div class='row'><!-- 댓글 목록 영역 -->

		<div class="col-lg-12 ">

			<!-- /.panel -->
			<div class=" border">
	
				<div class="panel-head p-3 "><!-- 댓글그룹의 헤더 -->
					<i class="fa fa-comments fa-fw"></i> Reply
					 <sec:authorize access="isAuthenticated()">
        			<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
        			</sec:authorize>
				</div>


				<!-- /.panel-heading -->
				<div class="panel-body">

					<ul class="chat border">
						
					</ul>
					<!-- ./ end ul -->
				</div>
				<!-- /.panel .chat-panel -->

				<div class="panel-footer">
				
				</div>
			</div>
		</div>
		<!-- ./ col-lg-12 -->
	</div><!--end 댓글 목록 영역 -->
	
	<!-- 댓글 수정,등록용 Modal -->
	 <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"
                aria-hidden="true">&times;</button>
              <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <label>Reply</label> 
                <input class="form-control" name='reply' value='New Reply!!!!'>
              </div>      
              <div class="form-group">
                <label>Replyer</label> 
                <input class="form-control" name='replyer' value='replyer'>
              </div>
              <div class="form-group">
                <label>Reply Date</label> 
                <input class="form-control" name='replyDate' value='2018-01-01 13:13'>
              </div>
      
            </div>
		<div class="modal-footer">
        <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
        <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
        <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
        <button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
      </div>          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->
	<!-- 콘테이너 -->
</div>




<script type="text/javascript" src="/resources/js/notiReply.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<script type="text/javascript" >

$(document).ready(function(){
	
	var bnoValue = '<c:out value="${notice.bno}"/>';
	var replyUL = $(".chat");
	
	showList(1);
	
		
	function showList(page){
			
		console.log("show list " + page);
		// replyService.getList 함수를 호출하여 목록을 가져옵니다.notiReply.js에 있는 객체입니다.	
		replyService.getList({bno:bnoValue,page: page|| 1}, function(replyCnt, list){	
		
		console.log("replyCnt: " + replyCnt);// 댓글 수를 콘솔에 출력합니다.
		console.log("list: " + list);// 목록을 콘솔에 출력합니다.
		console.log("list");// "list" 문자열을 콘솔에 출력합니다.
		
		// 만약 page가 -1이면, 마지막 페이지를 계산하여 다시 showList 함수를 호출합니다.
		if(page == -1){
			//-1이면 마지막 페이지를 찾아서 다시 호출
			pageNum = Math.ceil(replyCnt/10.0);
			showList(pageNum);
			return;
		}
		
		var str="";
		// 만약 목록이 null이거나 비어있다면 함수를 종료합니다.
		if(list == null || list.length == 0){
			return;
		}
		// list를 순회하며 li를 생성합니다.
		for(var i = 0, len = list.length || 0; i < len; i++){
			str +="<li class='left clearfix border-bottom red' data-rno='" + list[i].rno+"'>";
			//수정과 삭제에 필요한 댓글번호(rno)는 'data-rno'속성을 만들어서 추가
			str +=" <div><div class='header pt-2'><strong >["
				+list[i].replyer+"] " + list[i].replyer+"</strong>";
			str +="		<small class='pull-right px-3 '>"
				+replyService.displayTime(list[i].replyDate)+"</small></div>";
				//notiRely.js/replyService.displayTime를 이용한 시간 처리
			str +="		<p class='mt-2'>"+list[i].reply+"</p></div></li>";
		}
		//생성된 li태그 내용을 replyUL 요소에 삽입합니다.
		replyUL.html(str);
		// 댓글 페이지를 표시하는 함수를 호출합니다.
		showReplyPage(replyCnt);
		
		});//end function
	
	}//end showList	
		
	/*<div class="panel-footer">에 댓글 페이지 번호를 출력하는 로직 */
	var pageNum =1;
	var replyPageFooter = $(".panel-footer");
	
	function showReplyPage(replyCnt){
		
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum -9;
		
		var prev = startNum !=1;
		var next = false;
		
		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0);
		}
		
		if(endNum * 10 < replyCnt){
			next = true;
		}
		
		var str = "<ul class='pagination pull-right'>";
	      
	  	if(prev){
	    	str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
	    }
	      
	    for(var i = startNum ; i <= endNum; i++){
	        
	      var active = pageNum == i? "active":"";
	        
	      str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
	   	}
	      
	    if(next){
	      str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
	    }
	    
		str += "</ul></div>";
		
		console.log(str);
		replyPageFooter.html(str);
	}
		
	replyPageFooter.on("click", "li a", function(e){
		// 페이지의 번호를 클릭했을 때 새로운 댓글리스트을 가져온다.
		e.preventDefault();
		console.log("page click");
			
		var targetPageNum = $(this).attr("href");
			
		pageNum = targetPageNum;
			
		showList(pageNum);
	});
		
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	    
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	    
	$("#modalCloseBtn").on("click", function(e){
	    	
	  modal.modal('hide');
	});
	$("#addReplyBtn").on("click", function(e){
	    	//댓글쓰기 버튼 누르면 모달창이 보이게 된다.
	        
	    	 modal.find("input").val("");
	         modal.find("input[name='replyer']").val(replyer);
	         modalInputReplyDate.closest("div").hide();
	         modal.find("button[id !='modalCloseBtn']").hide();
	         
	         modalRegisterBtn.show();
	         
	         $(".modal").modal("show");
	        
	      });
	modalRegisterBtn.on("click",function(e){
	//모달 등록 이벤트 핸들러
			    
	// 입력된 댓글, 댓글 작성자, bno 값을 가져와서 reply 객체에 저장합니다.
	var reply = {
		reply: modalInputReply.val(),// 모달에서 입력한 댓글 내용
		replyer:modalInputReplyer.val(),// 모달에서 입력한 댓글 작성자
		bno:bnoValue// bno 값
	};
			        
	// replyService의 add 함수를 호출하여 댓글을 추가합니다.
	// reply 객체와 결과를 처리하는 콜백 함수를 전달합니다.
	replyService.add(reply, function(result){
			          
	alert(result);// 결과를 알리는 팝업을 표시합니다
			      
	// 모달에 입력된 값을 초기화합니다.
	modal.find("input").val("");
	modal.modal("hide");
			          
	// 댓글 목록을 갱신하기 위해 showList 함수를 호출합니다.
	// -1을 인수로 전달하여 마지막 페이지를 다시 로드합니다.
	showList(-1);
			          
	});
			        
});
	
//댓글 li 클릭시 이벤트 처리  
$(".chat").on("click", "li", function(e){
		    	  
	var rno = $(this).data("rno");//클릭한 li요소에서 rno 데이터 속성을 가져온다.
		        
	replyService.get(rno, function(reply){
		        
	modalInputReply.val(reply.reply);
	modalInputReplyer.val(reply.replyer);
	modalInputReplyDate.val(replyService.displayTime( reply.replyDate))
	.attr("readonly","readonly");
	//모달 창의 입력란에 댓글 작성일을 표시하고, readonly속성을 추가하여 수정하지 못한다.
	modal.data("rno", reply.rno);
	          
	modal.find("button[id !='modalCloseBtn']").hide();
	modalModBtn.show();
	modalRemoveBtn.show();
		          
	$(".modal").modal("show");
		              
	});
});  

//댓글 수정 이벤트
modalModBtn.on("click", function(e){
  	// 모달창에 있는 'data-rno'값을 이용
	var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
     	
	replyService.update(reply, function(result){
     	        
     alert(result);
     modal.modal("hide");
     showList(pageNum);
     	    
    });
     	  
});

//댓글 삭제 이벤트
modalRemoveBtn.on("click", function(e){
	
	// 모달창에 있는 'data-rno'값을 이용
	var rno = modal.data("rno");
	
	replyService.remove(rno, function(result){
		
		alert(result);
		modal.modal("hide");//모달 숨기기
		showList(pageNum);//리스트 갱신
	});
	
});

$(document).ajaxSend(function(e, xhr, options) { 
	//Ajax요청전에 CSRF토큰을 요청 헤더에 추가하는 작업을 수행한다. 보안상의 이유로 필요한 경우에 사용
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); //헤더의 이름과 값을 지정
}); 
		

var replyer = null;

<sec:authorize access="isAuthenticated()">

replyer = '<sec:authentication property="principal.username"/>';   

</sec:authorize>
/* 토큰 없으면 등록,수정시 405에러발생 */
var csrfHeaderName ="${_csrf.headerName}"; 
var csrfTokenValue="${_csrf.token}";

});
</script>


<script>
$(document).ready(function(){
var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e){
		//수정하기 버튼 실행
		operForm.attr("action", "/notice/modify").submit();//modify페이지로 이동
	});
	  
	$("button[data-oper='list']").on("click", function(e){
		//삭제하기 버튼 실행
		operForm.find("#bno").remove();
		operForm.attr("action","/notice/list")//list페이지로 돌아간다.
		operForm.submit();
		    
	});
});
</script>	


