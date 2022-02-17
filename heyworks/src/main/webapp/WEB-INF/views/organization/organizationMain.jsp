<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조직도</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/013417db0e.js" crossorigin="anonymous"></script>
<style>
    .outer{
        width:1200px;
        height:1200px;
        margin:auto;
    }
    .outer>div{float:left;}
    .contents{
        margin: auto;
        margin-top:20px;
        margin-left:40px;
        width: 900px;
        height: 900px;
    }
    .contents .searchbar {
        margin-top: 30px;
        margin-bottom: 50px;
    }
    .contents .input-group {
        width: 350px;
    }
    .chart {
        width: 900px;
        padding-bottom: 40px;
        border-bottom: 1px solid lightgray;
    }
    .chart dl{
        display: inline-block;
        width: 160px;
        height: 72px;
        margin-top: 20px;
        margin-right: 16px;
        position: relative;
        cursor: pointer;
    }
    .chart .picture {
        position: absolute;
        top: 0;
        left: 0;
        width: 70px;
        height: 70px;
        border: 1px solid #d2d2d2;
        border-radius: 4px;
    }
    .chart .name {
        padding-top: 3px;
        padding-bottom: 5px;
        font-weight: bold;
    }
    .chart .name, .chart .teams, .chart .position {
        margin-left: 80px;
        width: 136px;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
    }
    .chart-area .deptName {
        margin-top: 30px;
    }
    .detail1 {
        width: 250px;
        height: 80px;
    }
    .detail1 .image {
        float: left;
        width:80px;
        height:80px;
    }
    .image img {
        width: 80px;
        height: 80px;
        border-radius: 50%;
    }
    .detail1 .inform {
        width: 160px;
        height: 80px;
    }
    .inform ul {
        padding-left: 13px;
        margin-top: 8px;
        list-style: none;
    }
    .image, .inform {
        display: inline-block;
    }
    .modal-body { margin-left: 10px; }
    .detail2 table {
        font-size: 14px;
        margin-top: 10px;
    }
    .detail2 th {
        width: 82px;
        height: 20px;
        text-align: left;
    }
    .myModal { margin-top: 50%; }
    /* modal position(center)*/
    .modal {
        text-align: center;
    }
    @media screen and (min-width: 768px) {
        .modal:before {
        display: inline-block;
        vertical-align: middle;
        content: " ";
        height: 100%;
        }
    }
    .modal-dialog {
        display: inline-block;
        text-align: left;
        vertical-align: middle;
    }
</style>
</head>
<body>
    
    <div class="outer">
   
      <jsp:include page="../common/menubar.jsp" />
      <jsp:include page="organizationSidebar.jsp" />
   
        <div class="contents">
          
            <!--검색바-->
            <form class="searchbar">
                <div class="input-group">
                  <input type="text" class="form-control" placeholder="사번 / 이름 검색">
                  <div class="input-group-btn">
                    <button class="btn btn-default" type="submit" style="height: 34px;">
                      <i class="glyphicon glyphicon-search"></i>
                    </button>
                  </div>
                </div>
            </form>
            
            <!--조직도-->
            <div class="chart-area">

                <!--소속임직원-->
                
                <c:forEach var="d" items="${ dept }">
                	<div class="deptName">
                    	<i class="fa-solid fa-bars" style="font-size: 20px;"> ${ d.deptName }</i>
                	</div>
                	<div class="chart">
	                	<c:forEach var="e" items="${ organ }">
	                		<c:if test="${ e.deptCode eq d.deptCode }">
			                    <dl data-toggle="modal" data-target="#myModal">
			                        <dt class="name">${ e.userName }</dt>
			                        <dd class="picture">
			                            <img class="image" width="70px" height="70px" src="" style="display: inline-block;">
			                        </dd>
			                        <dd class="teams">${ e.deptName }</dd>
			                        <dd class="position">${ e.jobCode }</dd>
			                    </dl>
		                    </c:if>
	                    </c:forEach>
                	</div>
                </c:forEach>
                
                
	<!-- 임직원 상세보기 모달창 -->
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog modal-sm">
    
            <!-- Modal content-->
            <div class="modal-content">

                <div class="modal-header">
                	<h5 class="modal-title">직원정보</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <div class="modal-body">
                    <div class="detail1">
                        <div class="image">
                            <img src="사진">
                        </div>
                        <div class="inform">
                            <ul>
                                <li><b>${ e.userName }</b></li>
                                <li>SAMJO | ${ e.deptName }</li>
                                <li>${ e.job_code) }</li>
                            </ul>
                        </div>
                    </div>
                    <div class="detail2">
                        <table>
                            <tr>
                                <th>이메일</th>
                                <td>${ e.email }</td>
                            </tr>
                            <tr>
                                <th>사내전화</th>
                                <td>${ e.call }</td>
                            </tr>
                            <tr>
                                <th>휴대전화</th>
                                <td>${ e.phone }</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="modal-footer" style="text-align: center;">
                    <button type="button" class="btn">쪽지보내기</button>
                    <button type="button" class="btn btn-primary">이메일 복사</button>
                </div>
            </div>
    
        </div>
    </div>

    
   

</body>
</html>