package chat;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ExitChatRoom
 */
@WebServlet("/ExitChatRoom.do")
public class ExitChatRoom extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExitChatRoom() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String userID = request.getParameter("userID");
		String roomBNO = request.getParameter("roomBNO");
		ChatDAO chatDAO = new ChatDAO();
		int result = chatDAO.exitChatRoom(userID, roomBNO);
		response.getWriter().print(result);
	}

}
