package chat;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class ChatDataLoad
 */
@WebServlet("/ChatDataLoad.do")
public class ChatDataLoad extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChatDataLoad() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int endNum = Integer.parseInt(request.getParameter("endNum"));
		int roomBNO = Integer.parseInt(request.getParameter("roomBNO"));
		int startNum = endNum-9;
		ChatDAO chatDAO = new ChatDAO();
		ArrayList<ChatMessage> list = chatDAO.findChatMessage(roomBNO ,startNum ,endNum);
		JSONObject obj = new JSONObject();
		for(int i = 0; i < list.size(); i++) {
			ChatMessage cm = list.get(i);
			String message = cm.getUserID();
			message += "/"+cm.getMessage();
			message += "/"+cm.getSendDate();
			obj.put(i, message);
		}
		response.setContentType("application/x-json; charset=UTF-8");
		response.getWriter().print(obj);
	}

}
