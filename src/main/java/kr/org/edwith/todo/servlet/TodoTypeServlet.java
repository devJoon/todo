package kr.org.edwith.todo.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.org.edwith.todo.dao.TodoDao;
import kr.org.edwith.todo.dto.TodoDto;

/**
 * Servlet implementation class TodoTypeServlet
 */
@WebServlet("/TodoTypeServlet")
public class TodoTypeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public TodoTypeServlet() {
        super();
    }

	/* AJAX 요청 시, TodoDto 의 type을 update 한다. */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/*
		Enumeration<String> params = request.getParameterNames(); 
		while(params.hasMoreElements()){
		 String paramName = params.nextElement();
		 System.out.println("Parameter Name : "+paramName+", Value : "+request.getParameter(paramName));
		}
		*/
		
		TodoDao dao = new TodoDao();
		TodoDto todo = new TodoDto();
				
		todo.setId(Integer.parseInt(request.getParameter("id")));
		String type = (String)request.getParameter("type");
		
		if (type.equals("TODO"))
			todo.setType("DOING");
		else if (type.equals("DOING"))
			todo.setType("DONE");
		
		int result = dao.updateTodo(todo);
				
		response.setContentType("text/html;charset=UTF-8");
		
		// reponse to AJAX request
		if (result==1) 
			response.getWriter().print("SUCCESS");
		else
			response.getWriter().print("FAILURE");		
	}
}
