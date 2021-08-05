package comment;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

/**
 * Servlet implementation class CommentWrite
 */
//@WebServlet("/CommentWrite.do")
public class CommentWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CommentWrite() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// oGet(request, response);
		String userID = (String)request.getParameter("userID");
		String boardBNO = (String)request.getParameter("boardBNO");
		String content = (String)request.getParameter("comment");
		String commentBNO = (String)request.getParameter("commentBNO");
		CommentDAO commentDAO = new CommentDAO();
		if(commentBNO != null) {
			System.out.println(commentBNO);
			int result = commentDAO.deleteComment(commentBNO);
			JSONObject obj = new JSONObject(); // 경고메세지\
			obj.put("result", result);
			response.setContentType("application/x-json; charset=UTF-8");
			response.getWriter().print(obj);
		}else {
			Comment commentInsert = new Comment();
			commentInsert.setBoardBNO(boardBNO);
			commentInsert.setUserID(userID);
			commentInsert.setContent(content);
			int result = commentDAO.writeComment(commentInsert);
			JSONObject obj = new JSONObject(); // 경고메세지\
			obj.put("result", result);
			response.setContentType("application/x-json; charset=UTF-8");
			response.getWriter().print(obj);			
		}
	}

}
