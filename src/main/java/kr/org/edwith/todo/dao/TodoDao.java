package kr.org.edwith.todo.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.org.edwith.todo.dto.TodoDto;

// TODO : 1) about connection pool
public class TodoDao {
	
	private static String dburl = "jdbc:mysql://localhost:3306/todolist";
	private static String dbuser = "todouser";
	private static String dbpasswd = "todo123!@#";
	
	public int addTodo(TodoDto todo) {
		
		int insertCount = 0;

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		String sql = "INSERT INTO todo (title, name, sequence) VALUES ( ?, ?, ? )";

		try (Connection conn = DriverManager.getConnection(dburl, dbuser, dbpasswd);
				PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, todo.getTitle());
			ps.setString(2, todo.getName());
			ps.setInt(3,  todo.getSequence());

			insertCount = ps.executeUpdate();

		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return insertCount;		
	}
	
	public List<TodoDto> getTodos() {
		List<TodoDto> todolist = new ArrayList<>();
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		String sql = "SELECT id, title, name, sequence, type, regdate FROM todo "
				   + "ORDER BY sequence, regdate";
		try (Connection conn = DriverManager.getConnection(dburl, dbuser, dbpasswd);
				PreparedStatement ps = conn.prepareStatement(sql)) {

			try (ResultSet rs = ps.executeQuery()) {

				while (rs.next()) {
					
					TodoDto todo = new TodoDto();
					todo.setId(rs.getLong(1));
					todo.setTitle(rs.getString(2));
					todo.setName(rs.getString(3));
					todo.setSequence(rs.getInt(4));
					todo.setType(rs.getString(5));
					todo.setRegdate(rs.getString(6));
					todolist.add(todo);
					
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return todolist;
	}
	
	public int updateTodo(TodoDto todo) {
		int updateCount = 0;
				
		Connection conn = null;
		PreparedStatement ps = null;
		
		try {
			Class.forName( "com.mysql.jdbc.Driver" );
			
			conn = DriverManager.getConnection ( dburl, dbuser, dbpasswd );
			
			String sql = "update todo set type = ? where id = ?";
			
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, todo.getType());
			ps.setLong(2,  todo.getId());
			
			updateCount = ps.executeUpdate();

		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(ps != null) {
				try {
					ps.close();
				}catch(Exception ex) {}
			} // if
			
			if(conn != null) {
				try {
					conn.close();
				}catch(Exception ex) {}
			} // if
		} // finally
		
		return updateCount;		
	}
	
	/* For test */
	public static void main(String[] args) {		
		/*
		TodoDao dao = new TodoDao();
		
		List<TodoDto> list = dao.getTodos();
		
		for(TodoDto todo : list) {
			System.out.println(todo);
		}
		
		TodoDto todo = new TodoDto();
		todo.setType("DOING");
		todo.setId(2);
		
		int r = dao.updateTodo(todo);
		System.out.println(r);
		*/
	}	
}
