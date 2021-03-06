<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .outer{
        width:1200px;
        height:1200px;
        margin:auto;
    }
    .outer>div{float:left;}
    .all-status{
       width: 950px;
	   height:100%;
	   display:inline-block;
       padding-left:30px;
       padding-top:30px;
    }
    #searchForm{
        width:80%;
        margin:auto;
    }
    #searchForm>*{
        float:left;
        margin:5px;
    }
    .select{width:10%;}
    .text{width:25%;}
    .searchBtn{Width:10%;}

    .date-box{font-size:25px; font-weight:700;}
    .table-bordered th{font-size:14px; text-align:center;}
    .table-bordered td{font-size:13px;}
    .tb-body tr{height:37px;}
    
    #pagingArea{width:fit-content;margin:auto;}
</style>
</head>
<body>

    <div class="outer">

        <jsp:include page="../common/menubar.jsp"/>
        <jsp:include page="workingSidebar.jsp"/>

        <div class="all-status">

            <div class="title-box">
                <h3 style="font-size:20px;">전사 근무현황</h3>
            </div><br>

            <div class="date-box" style="margin-bottom:50px;" align="center">
                <label id="sysdate">2022-02-18</label>
            </div>

			<div id="search-area">
	            <form id="searchForm" action="AllLeaveSearch.wo" method="Get" style="margin-left:560px">
	            	<input type="hidden" name="cpage" value="1">
	                <div class="select">
	                    <select class="custom-select" name="condition" >
	                        <option value="deptName">소속</option>
	                        <option value="userName">이름</option>
	                    </select>
	                </div>
	                <div class="text">
	                    <input type="text" class="form-control" name="keyword" value="${ keyword }">
	                </div>
	                <button type="submit" class="searchBtn btn btn-secondary">검색</button>
	            </form>
            </div>

            <br><br><br><br>

            <table class="table-bordered">
                <thead class="tb-head">
                    <tr height="43px">
                        <th colspan="4">사원 정보</th>
                        <th colspan="6">근무 정보</th>
                    </tr>
                    <tr height="43px">
                        <th width="100px">사번</th>
                        <th width="95px">이름</th>
                        <th width="95px">소속</th>
                        <th width="95px">직급</th>
                        <th width="87px">출근시각</th>
                        <th width="87px">퇴근시각</th>
                        <th width="87px">휴게시간</th>
                        <th width="87px">근무시간</th>
                        <th width="87px">연장근무</th>
                        <th width="95px">근태상태</th>
                    </tr>
                </thead>
                <tbody id="tnaTbody" align="center" class="tb-body">

                </tbody>
                
             </table>
             
             <div id="pagingArea">
             
		    
		     </div>
            
             <script>
              $(function(){
                  selectAllList();
              });
              
             
        	   // 근무현황 리스트 조회해오는 ajax
              function selectAllList(cpage){
        			
              	var listCount; // 총 게시글 수
              	var boardLimit; // 한 페이지에 나타낼 글 수 
              	var pageLimit; // 페이징바에 나타낼 페이지 수 
              	var cpage; // 현재 페이지
              	var startPage; // 페이징바의 시작수
              	var endPage; // 페이징바의 끝수 
              	
              	$.ajax({
              		url:"selectAllTna.woss",
              		data: {cpage:cpage},
              		success:function(obj){
              			
              			var tlist = obj.tlist;
              			var pi = obj.pi;
              			
              		/* 	cpage = pi.currentPage;
              			startPage = pi.startPage;
              			endPage = pi.endPage; */
              			     			
              			//console.log(startPage); 1
              			//console.log(endPage); 3
              			//console.log(cpage); 1
						/* 
              			console.log(tlist[0]);
              			console.log(tlist);
              			 */
      					let list = "";
      					for(let i=0; i<=9; i++){
      						list += "<tr>"
						     + "<td>" + tlist[i].userNo + "</td>"
						     + "<td>" + tlist[i].userName + "</td>"
						     + "<td>" + tlist[i].deptName + "</td>"
						     + "<td>" + tlist[i].jobName + "</td>"
						     + "<td>" + tlist[i].clockIn + "</td>"
						     + "<td>" + tlist[i].clockOut + "</td>"
						     + "<td>" + "01:00" + "</td>"
						     + "<td>" + tlist[i].workTime + "시간" + "</td>"
						     + "<td>" + tlist[i].overTime + "시간" + "</td>"
						     + "<td>" + tlist[i].tnaStatus + "</td>"
						     + "</tr>";	    	   	    	   
					}
      					
					$("#tnaTbody").html(list);
				
					// 페이징
					let page = "";
					page += "<ul class=" + "pagination" + ">"
					      + "<li class=" + "page-item" + "><a class=" + "page-link" + " href=" + "allTnaMain.wo?cpage=" + ">" + cpage + "</a></li>"
					      + "<li class=" + "page-item" + "><a class=" + "page-link" + + "</a></li>"
					      + "<li class=" + "page-item" + "><a class=" + "page-link" + " id=" +"next" + " href=" + "selectAllTna.wo?cpage=>" + "Next" + "</a></li>"
					      + "</ul>"
					$("#pagingArea").html(page);
               		},error:function(){
               			console.log("전사 근무현황 ajax통신 실패");
               		}
               	})
	        	 
	         	}
             </script>
            
            
            <!--
             <div id="pagingArea">
             
                <ul class="pagination">
                	<c:choose>
              			<c:when test="${ pi.currentPage eq 1 }">
                    		<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="selectAllTna.wo?cpage=${ pi.currentPage-1 }">Previous</a></li>
                    	</c:otherwise>
                    </c:choose>
                    
                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                    	<li class="page-item"><a class="page-link" href="selectAllTna.wo?cpage=${ p }">${ p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ pi.currentPage eq pi.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="selectAllTna.wo?cpage=${ pi.currentPage+1 }">Next</a></li>
                    	</c:otherwise>
                    </c:choose>
                </ul>
                
             </div>
               -->

        </div>

        
    </div>
</body>
</html>