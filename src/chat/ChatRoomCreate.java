package chat;

import java.io.IOException;
import chat.ChatDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ChatRoomCreate
 */
//@WebServlet("/ChatRoomCreate")
public class ChatRoomCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChatRoomCreate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ChatDAO chatDAO = new ChatDAO();
		String userID = request.getParameter("userID");
		String chatName = request.getParameter("chatName");
		String chatPW = request.getParameter("chatPW");
		String chatIntro = request.getParameter("chatIntro");
		chatDAO.createChatRoom(userID, chatName, chatPW, chatIntro);
		
	}

}
