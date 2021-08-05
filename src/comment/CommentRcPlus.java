package comment;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CommentRcPlus
 */
@WebServlet("/CommentRcPlus.do")
public class CommentRcPlus extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentRcPlus() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String userID = request.getParameter("id");
		String commentBNO = request.getParameter("bno");
		CommentDAO commentDAO = new CommentDAO();
		int result = commentDAO.plusCommnetRC(userID, commentBNO);
		if(result == 0) {
			commentDAO.deleteCommentRC(userID, commentBNO);
		}
		commentDAO.updateCommentRC(Integer.parseInt(commentBNO));
		response.getWriter().print(result);
	}

}
