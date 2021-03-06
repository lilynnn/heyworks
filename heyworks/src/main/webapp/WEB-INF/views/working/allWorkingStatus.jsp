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
	.title-box{font-size:21px; font-weight:600;}
    #searchForm{
        width:80%;
        margin:auto;
    }
    #searchForm>*{
        float:left;
        margin:5px;
    }
    .select{width:15%;}
    .text{width:25%;}
    .searchBtn{Width:10%;}

    .date-box{font-size:25px; font-weight:600;}

    .table-bordered th{font-size:15px; text-align:center;}
    .table-bordered td{font-size:14px;}
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
                	전사 근태현황
            </div><br><br>
			
            <div class="date-box" style="margin-bottom:50px; background:rgba(24, 121, 201, 0.2);" align="center" >
            	<!--<img src="resources/images/left-arrow.png" id="left" style="width: 20px; height: 20px;">  -->
                <span id="today" name="today">
                
                </span>             
                <!--<img src="resources/images/right-arrow.png" id="right" style="width: 20px; height: 20px;"> -->
            </div>

            <script>
            	$(document).ready(function(){
                    var today = new Date();

                    var year = today.getFullYear(); // 년도
                    var month = today.getMonth() + 1; // 월
                    var date = today.getDate(); // 일

                    document.getElementById("today").innerHTML = year + "-" + 0 + month + "-" + 0 + date;
                })
            </script>
            
            <!-- 
            <script>
            $("#left").click(function(){
            	
            	var sysdate = $("#today").text();
            	var sysdateArr = sysdate.split("-"); 
            	//console.log(sysdateArr); // ['2022', '02', '21']
            	
            	var stDate = new Date(sysdateArr[0], sysdateArr[1]-1, sysdateArr[2]);    
            	var agoSt = new Date(stDate.setDate(stDate.getDate() -1+1)).toISOString().substring(0,10);
            	
                //console.log(agoSt);                       	
                
            	document.getElementById("today").innerHTML = agoSt;
            	
            })
            
            $("#right").click(function(){
            	
            	var sysdate = $("#today").text();
            	var sysdateArr = sysdate.split("-"); 
            	//console.log(startDateArr); // ['2022', '02', '21']
            	
            	var stDate = new Date(sysdateArr[0], sysdateArr[1]-1, sysdateArr[2]);    
            	var nextSt = new Date(stDate.setDate(stDate.getDate() +1+1)).toISOString().substring(0,10);	

                //console.log(nextSt);                  	
                
            	document.getElementById("today").innerHTML = nextSt;

            })
            </script>
             -->

			<div id="search-area">
	            <form id="searchForm" action="allTnaSearch.wo" method="Get" style="margin-left:520px">
	            	<input type="hidden" name="cpage" value="1">
	                <div class="select">
	                    <select class="custom-select" name="condition" >
	                        <option value="userName">이름</option>
	                        <option value="tnaStatus">근태상태</option>
	                    </select>
	                </div>
	                <div class="text">
	                    <input type="text" class="form-control" name="keyword" value="${ keyword }">
	                </div>
	                <button type="submit" class="searchBtn btn btn-secondary">Search</button>
	            </form>
            </div>
			<c:if test="${ not empty condition }">
				<script>
					$(function(){
						$("#search-area option[value=${condition}]").attr("selected", true);
					})
				</script>
			</c:if>
			
            <br><br><br><br>

            <table class="table-bordered">
                <thead class="tb-head">
                    <tr height="40px">
                        <th colspan="4">사원 정보</th>
                        <th colspan="7">근무 정보</th>
                    </tr>
                    <tr height="43px">
                        <th width="95px">사번</th>
                        <th width="90px">이름</th>
                        <th width="90px">소속</th>
                        <th width="95px">직급</th>
                        <th width="80px">출근시각</th>
                        <th width="80px">퇴근시각</th>
                        <th width="80px">휴게시간</th>
                        <th width="80px">근무시간</th>
                        <th width="80px">연장근무</th>
                        <th width="90px">근태상태</th>
                        <th width="60px">상세</th>
                    </tr>
                </thead>
                <tbody id="tnaTbody" align="center" class="tb-body">
                	<c:forEach var="w" items="${wlist}">
	                    <tr height="37px">
	                        <td>${ w.userNo }</td>
	                        <td>${ w.userName }</td>
	                        <td>${ w.deptName }</td>
	                        <td>${ w.jobName }</td>
	                        <td>${ w.clockIn }</td>
	                        <td>${ w.clockOut }</td>
	                        <td>01:00</td>
	                        <td>${ w.workTime }시간 </td>
	                        <td>${ w.overTime }시간</td>
                        	<td>
                                <c:if test="${w.tnaStatus eq'연장근무'}">
                                <font color="red">${w.tnaStatus}</font></c:if>
                                <c:if test="${w.tnaStatus eq'정상근무'}">
                                <font color="green">${w.tnaStatus}</font></c:if>
                                <c:if test="${w.tnaStatus eq'휴가'}">
                                <font color="blue">${w.tnaStatus}</font></c:if>
                            </td>
                            <td><a href="tnaUpdateForm.wo?userNo=${w.userNo}"><img src="resources/images/edit.png" style="width: 15px; height: 20px;"></a></td>
	                    </tr>
                    </c:forEach>
                </tbody>
                
             </table>
             <br>
            
             <div id="pagingArea">
                <ul class="pagination">
                	<c:choose>
              			<c:when test="${ pi.currentPage eq 1 }">
                    		<li class="page-item disabled"><a class="page-link" href="#"><<</a></li>
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="allTnaMain.wo?cpage=${ pi.currentPage-1 }"><<</a></li>
                    	</c:otherwise>
                    </c:choose>
                    
                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                    	<li class="page-item"><a class="page-link" href="allTnaMain.wo?cpage=${ p }">${ p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ pi.currentPage eq pi.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">>></a></li>
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="allTnaMain.wo?cpage=${ pi.currentPage+1 }">>></a></li>
                    	</c:otherwise>
                    </c:choose>
                </ul>
             </div>
             
                

        </div>

        
    </div>
</body>
</html>