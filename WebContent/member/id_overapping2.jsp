<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String id = request.getParameter("id");
MemberDAO dao = new MemberDAO();
boolean overId = dao.overlapId(id);
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복확인</title>
<link href="../bootstrap3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="../bootstrap3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
    function checkId(){
    	var f = document.overlapFrm;
        var id = f.id.value;
        var w = document.getElementById("warning");
        if(id==""){
        	w.innerHTML = "아이디를 입력하세요";
        	w.style.color = "red";
            return;
        }
        if(id.length<4||id.length>12){
        	w.innerHTML = "※ 4~12자 사이로 입력하세요";
        	w.style.color = "red";
            return;
        }
        if(id.charCodeAt(0)>=48&&id.charCodeAt(0)<=57){
        	w.innerHTML = "※ 첫글자는 숫자로 시작할수 없습니다";
        	w.style.color = "red";
            return;
        }
        for(var i=0 ; i<id.length ; i++){
            if((id.charCodeAt(i)>=48&&id.charCodeAt(i)<=57)||
            (id.charCodeAt(i)>=65&&id.charCodeAt(i)<=90)||
            (id.charCodeAt(i)>=97&&id.charCodeAt(i)<=122)){
            }
            else{
            	w.innerHTML = "※ 특수문자나 공백은 사용할 수 없습니다.";
            	w.style.color = "red";
                return;
            }
        }
        location.href = './id_overapping2.jsp?id='+id;
    }
    function idUse() {
    	opener.document.regiform.user_id.value = 
            document.overlapFrm.retype_id.value;
        self.close();
	}
    </script>
</head>
<body>
	<%if(overId) {%>
	    <div class="container">
	    <h3 class="text-info">입력한 아이디 : <%=id %></h3>
	    <h3>사용가능한 아이디입니다.</h3>
	    <form name="overlapFrm">
	        <input type="text" name="retype_id" size="20" value="<%=id %>" readonly="readonly">
	        <input class="btn btn-success" type="button" value="아이디사용하기" onclick="idUse();">
	    </form>
	    </div>
    <%}else { %>
    <div class="container">
    <h3 class="text-info">입력한 아이디 : <%=id %></h3>
    <h3 class="text-danger">중복된 아이디가 있습니다. <br /> 다른아이디를 입력하세요</h3>
    <form name="overlapFrm">
        <input type="text" name="id" size="20" value="<%=id %>">
        <input class="btn btn-danger" type="button" value="중복확인" onclick="checkId();">
    </form>
    <h4 id="warning"></h4>
    </div>
    <%} %>
    
</body>

</html>