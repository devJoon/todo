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
 * Servlet implementation class TodoAddServlet
 */
@WebServlet("/TodoAddServlet")
public class TodoAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public TodoAddServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//한글깨짐 방지 인코딩 지정
		request.setCharacterEncoding("UTF-8");
		
		String title = request.getParameter("title");
		String name = request.getParameter("name");
		String seq = request.getParameter("sequence");
		
		// System.out.println("title : " + title + ", name : " + name + ", sequence : " + seq);		
		
		TodoDao dao = new TodoDao();
		TodoDto todo = new TodoDto();
		
		todo.setTitle(title);
		todo.setName(name);
		todo.setSequence(Integer.parseInt(seq));
		
		dao.addTodo(todo);
				
		response.sendRedirect("/MainServlet");
	}
}
