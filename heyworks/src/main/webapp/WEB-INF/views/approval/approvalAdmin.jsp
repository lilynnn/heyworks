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
		height:2000px;
	    margin:auto;
	}
	.outer>div{float:left;}
    .elec-outer{
        margin: auto;
        width: 900px;
        height: 2000px;
        margin-left:20px;
        margin-top:20px;
    }
    #btns{width: 100%;}
    .table-striped *{
        height: 40px;
        font-size: 13px;
    }
    .table-striped th{background-color: rgb(241, 244, 248);}
    .table-striped td{text-align: center;}
    .table-striped a{
        font-size: 10px;
        width: 65px;
        height: 25px;
    }
    .subject{
        color: black;
        font-size: 20px;
        font-weight: 800;
    }
    .subject:hover{
        color: black;
        text-decoration: none;
    }
    #insert-area{
        border: 1px solid lightgray;
        padding: 5px;
        padding-top: 10px;
        width: 100%;
        height: 1800px;
    }
    #insert-area>*{
        float: left;
    }
    #insert-area>p{
        width: 100%;
        font-size: 15px;
        font-weight: 700;
    }
    .check-user{
        border: 1px solid lightgray;
        margin-left: 10px;
        font-size: 12px;
        width: 210px;
        margin-bottom: 20px;
        margin-left: 60px;
    }
    .check-user>p{
        background-color: rgb(241, 244, 248);
        width: 100%;
        height: 40px;
        text-align: center;
        line-height: 40px;
        margin-bottom: 0px;
    }
    .check-user>select{
        width: 100%;
        height: 40px;
        text-align: center;
    }
    .check-user>input{
        width: 100%;
    }
    .table{font-size:12px;}
    .table a{width:100%; font-size:12px;}
    select {
		width: 100px;
		padding: .1em;
		border: 1px solid #999;
		font-family: inherit;
		border-radius: 0px;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
		text-align:center;
	}
	select::-ms-expand {
		display: none;
	}
</style>
</head>
<body>
	
	<div class="outer">
		<jsp:include page="../common/menubar.jsp" />
		<jsp:include page="sidebar.jsp" />
		
		<div class="elec-outer">

        <a href="" class="subject">?????????????????????</a>
        <br><br>

        <table align="center" class="table-striped">
            <thead>
                <tr align="center">
                    <th width="50"><input type="checkbox" onclick="allCheck(this);"></th>
                    <th width="100">??????</th>
                    <th width="100">??????</th>
                    <th width="100">???</th>
                    <th width="100">??????</th>
                    <th width="100">????????????</th>
                    <th width="250">?????????</th>
                    <th width="100"><button class="btn btn-sm btn-danger" onclick="deleteAdmin();">????????????</button></th>
                </tr>
            </thead>
            <tbody>
            <c:choose>
            	<c:when test="${!empty adlist}">
            		<c:forEach var="ad" items="${adlist}">
	                <tr>
	                    <td><input type="checkbox" value="${ad.userNo}" name="userlist" class="boxes"></td>
	                    <td>${ad.userNo}</td>
	                    <td>${ad.userName}</td>
	                    <td>${ad.deptName}</td>
	                    <td>${ad.jobName}</td>
	                    <td>${ad.call}</td>
	                    <td>${ad.email}</td>
	                    <td>${ad.adminYn}</td>
	                </tr>
	                </c:forEach>
                </c:when>
                <c:otherwise>
                	<tr>
                		<th>???????????? ????????? ????????? ????????????.</th>
                	</tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>

        <br><br>
        <button class="btn btn-sm" style="background-color:rgb(235, 235, 236);">???????????? ????????? ????????????</button>
        <br><br>

        <div id="insert-area">
            <p>&nbsp;&nbsp;&nbsp;???????????? ????????? ??????</p>

            <div class="check-user">
                <p>????????? ???????????????</p>
                <select name="deptCode" onchange="selectAdmin(this.value);" id="deptCode">
                	<option value="0">????????????</option>
                	<c:if test="${!empty deptList}">
	                	<c:forEach var="d" items="${deptList}">
	                    	<option value="${d.deptCode}">${d.deptName}</option>
	                    </c:forEach>
                    </c:if>
                </select> 
            </div>
            <div class="check-user">
                <p>????????? ??????????????????</p>
                <input type="text" class="form-control" id="keyword" onkeyup="enterAdmin(this.value);">
            </div>

            <div style="margin-left: 60px; margin-top: 20px;">
            <table class="table" style="border-bottom:1px; solid; lightgray; overflow: auto; height:500px;">
                <thead>
                    <tr align="center">
                        <th width="100">??????</th>
                        <th width="100">??????</th>
                        <th width="80">???</th>
                        <th width="80">??????</th>
                        <th width="100">????????????</th>
                        <th width="220">?????????</th>
                        <th width="80"></th>
                    </tr>
                </thead>
                <tbody>
    
                </tbody>
            </table>
            </div>
        </div>

        <div>
            <p id="checkName1"></p>
            <p id="checkName2"></p>
            <p id="checkName3"></p>
            <p id="checkName4"></p>
        </div>

        <!-- checkbox??? ????????? ???????????? -->
        <div id="chuga" style="display: none;">
            <p>????????? ?????? ???????????? ???????????? ?????????????????????????</p>
            <button class="btn btn-sm btn-outline-primary">????????????</button>
        </div>

    	</div>
	</div>

    <script>
        /*?????? ??????*/
        function allCheck(check){
            const confirm = check.checked;
            if(confirm){
                $(".boxes").attr("checked", true);
            }else{
                $(".boxes").attr("checked", false);
            }
        }

        function selectAdmin(value,num){
            $.ajax({
                url:"searchAdmin.el",
                data:{
                	deptCode:value,
                	userName:"n"
                },
                success:function(result){

                    let list = "";

                    for(let i in result){
                        list += "<tr align='center'>"
                              + "<td class='uno'>" + result[i].userNo + "</td>"
                              + "<td>" + result[i].userName + "</td>"
                              + "<td>" + result[i].deptName + "</td>"
                              + "<td>" + result[i].jobName + "</td>"
                              + "<td>" + result[i].call + "</td>"
                              + "<td>" + result[i].email + "</td>"
                              + "<td><a href='registerad.el?uno=" + result[i].userNo + "' class='btn btn-sm btn-outline-primary'>??????</a></td>"
                              + "</tr>"       
                    }
                    $(".table>tbody").html(list);

                },error:function(){
                    console.log("??????????????? ajax?????? ??????!");
                }

            })
        }
        
        function enterAdmin(value){
            $("#keyword").keyup(function(e){
                if(e.keyCode == 13){
                    $.ajax({
                        url:"searchAdmin.el",
                        data:{
                        	userName:value,
                        	deptCode:$("#deptCode").val()
                        },
                        success:function(result){
                            
                            let list = "";

                            for(let i in result){
                                list += "<tr align='center'>"
                                      + "<td class='uno'>" + result[i].userNo + "</td>"
                                      + "<td>" + result[i].userName + "</td>"
                                      + "<td>" + result[i].deptName + "</td>"
                                      + "<td>" + result[i].jobName + "</td>"
                                      + "<td>" + result[i].call + "</td>"
                                      + "<td>" + result[i].email + "</td>"
                                      + "<td><a href='registerad.el?uno=" + result[i].userNo + "' class='btn btn-sm btn-outline-primary'>??????</a></td>"
                                      + "</tr>"       
                            }
                            $(".table>tbody").html(list);

                        },error:function(){
                            console.log("??????????????? ajax?????? ??????!");
                        }
                    })
                }
            })
        }
        
		function deleteAdmin(){
        	
			var arraynum = [];
			
			$("input:checkbox[class='boxes']:checked").each(function(){
				arraynum.push($(this).parent().next().text());
			})
			
			console.log(arraynum);
			
			location.href="deletead.el?adno=" + arraynum;
        	
        }
    </script>

	
</body>
</html>