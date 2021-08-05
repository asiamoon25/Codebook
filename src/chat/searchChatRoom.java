package chat;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class FindChatRoom
 */
@WebServlet("/searchChatRoom.do")
public class searchChatRoom extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public searchChatRoom() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String[] text = ((String)request.getParameter("text")).split("/");
		String by = null;
		if(text[0].equals("방 이름")) {
			by = "ROOMNAME";
		}else if(text[0].equals("방장 ID")) {
			by = "OPERATOR";
		}else if(text[0].equals("방 설명")) {
			by = "ROOMINTRO";
		}
		String searchText = text[1];
		JSONObject obj = new JSONObject();
		obj.put("searchBy", by);
		obj.put("searchText", searchText);
		response.setContentType("application/x-json; charset=UTF-8");
		response.getWriter().print(obj);
	}

}
