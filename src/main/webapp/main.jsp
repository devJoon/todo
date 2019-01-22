<%@page import="kr.org.edwith.todo.dto.TodoDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>나의 해야할 일들</title>
<link href="main.css" rel="stylesheet" type="text/css">
</head>
    
<body onLoad="initClickEvent()">
    
    <header>
        
	<span id="title">나의 해야할 일들</span>
        
    <form action="/TodoFormServlet" method="get">
    <input type="submit" id="addtodo" value="새로운 TODO 등록"/>
    </form>
        
    </header>
    
    <div id="tables">
    <table id="todo_table">
        <tr>
            <th>
            TODO
            </th>
        </tr>
          
        <c:forEach items="${todolist }" var="todo" begin="0">
        	<c:if test="${todo.getType() eq 'TODO'}">
        		<tr id="${todo.getId() }" class="TODO">
        			<td>
        			<div class="task_title">${todo.getTitle()}</div>
        			<div class="task_info">등록날짜:${todo.getRegdate() }, ${todo.getName() }, 우선순위  ${todo.getSequence() }
        			<input type="button" value="→"/>
        			<%-- <input type="button" value="→" onclick="updateTask(${todo.getId() }, 'TODO')"/> --%>
        			</div>
        			</td>
        		</tr>
        	</c:if>
        </c:forEach>
        
    </table>
    <table id="doing_table">        
        <tr>
            <th>
            DOING
            </th>
        </tr>
        
        <c:forEach items="${todolist }" var="todo" begin="0">
        	<c:if test="${todo.getType() eq 'DOING'}">
        		<tr id="${todo.getId() }" class="DOING">
        			<td>
        			<div class="task_title">${todo.getTitle()}</div>
        			<div class="task_info">등록날짜:${todo.getRegdate() }, ${todo.getName() }, 우선순위  ${todo.getSequence() }
        			<input type="button" value="→"/>
        			<%-- <input type="button" value="→" onclick="updateTask(${todo.getId() }, 'DOING')"/> --%>
        			</div>
        			</td>
        		</tr>
        	</c:if>
        </c:forEach>
            
    </table>
    <table id="done_table">
        <tr>
            <th>
            DONE
            </th>
        </tr>
          
        <c:forEach items="${todolist }" var="todo" begin="0">
        	<c:if test="${todo.getType() eq 'DONE'}">
        		<tr id="${todo.getId() }" class="DONE">
        			<td>
        			<div class="task_title">${todo.getTitle()}</div>
        			<div class="task_info">등록날짜:${todo.getRegdate() }, ${todo.getName() }, 우선순위  ${todo.getSequence() }
        			</div>
        			</td>
        		</tr>
        	</c:if>
        </c:forEach>
        
    </table>
    </div>
        
</body>
<script type="text/javascript">
		
 	
	function updateTask(id, type) {
	
		var httpRequest = new XMLHttpRequest();

		if (!httpRequest) {
			alert('Failed to create XMLHttpRequest instance.');
			return false;
		}
												
		// anonymous function 형태로 redrawTask() 를 콜백함수로 등록
		httpRequest.onreadystatechange = function(){
			return redrawTask(httpRequest, id, type);
		};
								
		httpRequest.open('POST', '/TodoTypeServlet');
		httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		
		// 해당 parameter로 전달된 값은 servlet의 httprequest에서 getParameter() 함수로 꺼낼 수 있음				
		httpRequest.send('id=' + encodeURI(id) + '&type=' + encodeURI(type));
		
	}

	function redrawTask(httpRequest, id, type) {
		if (httpRequest.readyState === XMLHttpRequest.DONE) {
			
			if (httpRequest.status === 200 && httpRequest.responseText == "SUCCESS") {
				
				var row = document.getElementById(id); // find row to copy								
				var clone = row.cloneNode(true); // copy row
				var tblnext;
				
				// 기존 button 삭제
				var button = clone.getElementsByTagName("input");										
				button[0].parentNode.removeChild(button[0]);
				
				if (type == 'TODO') {
					clone.setAttribute("class", "DOING");
					tblnext = document.getElementById("doing_table");
					
					// 새로운 button 을 만들어 eventListener 등록
					var newbutton = document.createElement("INPUT");
					newbutton.setAttribute("type", "button");
					newbutton.setAttribute("value", "→");
					newbutton.addEventListener('click', function(){updateTask(id, 'DOING')} );															
					clone.getElementsByClassName("task_info")[0].appendChild(newbutton);					
					
				}
				else if (type == 'DOING') {
					clone.setAttribute("class", "DONE");																					
					tblnext = document.getElementById("done_table");
				}							    

			    row.parentNode.removeChild(row);			    
			    tblnext.appendChild(clone);
								
			} else {
				alert('AJAX request에 뭔가 문제가 있어요. 응답코드 : ' + httpRequest.status);			
				console.log(httpRequest.responseText); // get response from servlet
			}
		}
	}
	
	// 각 table 의 → 버튼에 클릭이벤트를 추가 (HTML 로드시 호출)
	function initClickEvent() {

		var tables = document.getElementsByTagName("table")
		
		for (var i=0; i<tables.length-1; i++) {
			var table = tables[i];
			var rows = table.getElementsByTagName("tr");

			for (var j=1; j<rows.length; j++) {
				// closure 형태로 사용해야 updateTask 의 parameter 값이 제대로 바인딩 됨.
				(function(){ 
				var row = rows[j];
				var input = row.getElementsByTagName("input")[0];
				input.addEventListener("click", function(){ updateTask(row.id, row.className); } );
				}());				
			}
		}
	}
	
</script>
    
</html>