package chat;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * Servlet implementation class InviteFriends
 */
@WebServlet("/InviteFriends.do")
public class InviteFriends extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InviteFriends() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String friendID = request.getParameter("friendID");
		String roomBNO = request.getParameter("roomBNO");
		ChatDAO chatDAO = new ChatDAO();
		int result = chatDAO.inviteFriends(roomBNO, friendID);
		if(result == -1) {
			response.setContentType("application/x-json; charset=UTF-8");
			response.getWriter().print("error");
		}else if(result == 0) {
			response.setContentType("application/x-json; charset=UTF-8");
			response.getWriter().print("overlap");
		}
	}

}
