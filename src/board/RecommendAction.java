package board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import board.BoardDAO;

/**
 * Servlet implementation class RecommendAction
 */
//@WebServlet("/RecommendAction")
public class RecommendAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecommendAction() {
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
		//doGet(request, response);
		String userID = request.getParameter("userID");
		int boardBNO = Integer.parseInt(request.getParameter("boardBNO"));
		int result = 0;
		BoardDAO boardDAO = new BoardDAO();
		int action = Integer.parseInt(request.getParameter("action"));
		if(action == 1) {
			result = boardDAO.plusBoardRecommend(userID, boardBNO);			
			boardDAO.update_View_RC(boardBNO);
		}else if(action == -1) {
			result = boardDAO.minusBoardRecommend(userID, boardBNO);
			boardDAO.update_View_RC(boardBNO);
		}
		JSONObject obj = new JSONObject(); // 경고메세지\
		obj.put("result", result);
		response.setContentType("application/x-json; charset=UTF-8");
		response.getWriter().print(obj);
	}

}
