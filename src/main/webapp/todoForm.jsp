<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>할일 등록</title>
<link href="todoForm.css" rel="stylesheet" type="text/css">
</head>

<body>
    
    <header>
	할일 등록
    </header>
        
    <div id="inputdiv">
        
        <form action="/TodoAddServlet" method="post" id="inputform">
		어떤 일인가요?<br>
        <input type="text" class="textbox" name="title" placeholder="swift 공부하기(24자까지)" maxlength="24" style="width:400px"><br>
		누가 할일인가요?<br>
        <input type="text" class="textbox" name="name" placeholder="홍길동" style="width:200px"><br>
		우선순위를 선택하세요<br>

        <div id="select">
            <input type="radio" name="sequence" value="1" style="margin-left:0px">1순위
            <input type="radio" name="sequence" value="2">2순위
            <input type="radio" name="sequence" value="3">3순위
        </div>    

        <br>
                
        <input type="button" id="clear" value='내용지우기' onclick="clearForm()" />
        <input type="submit" id="submit" value="제출" onclick="return checkForm()"/>   
        
        </form>
        
        <form action="/MainServlet" method="get">
        <input type="submit" id="previous" value="< 이전"/>
        </form>
        
    </div>
    
</body>
    
<script type="text/javascript">

	function checkForm() {
		var tb = document.getElementsByClassName("textbox");
	    var rb = document.getElementsByName("sequence");
	    var i;
	    
	    for (i=0; i<tb.length; i++) {
	        if (tb[i].value.trim() == "") {
	        	alert("값을 모두 입력해주세요.")
	        	return false;
	        }	        	
	    }
	    
	    if (rb[0].checked == false && 
	    	rb[1].checked == false && 
	    	rb[2].checked == false) {
	    	alert("우선순위를 선택해주세요.")
        	return false;
	    }
	    
	    return true;	    
	}

	function clearForm() {
	    var tb = document.getElementsByClassName("textbox");
	    var rb = document.getElementsByName("sequence");
	    var i;
	    
	    for (i=0; i<tb.length; i++) {
	        tb[i].value = "";
	    }
	    
	    for(var i=0;i<rb.length;i++)
	      rb[i].checked = false;
	}    
    
</script>
    
</html>