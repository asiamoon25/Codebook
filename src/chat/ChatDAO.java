package chat;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ChatDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public ChatDAO() {
		try {
			String url = "jdbc:oracle:thin:@localhost:1521:xe"; // userDatabase에 접속
			String id = "jungho"; // 접속 계정은 admin 비밀번호 1234
			String pw = "1234";
			// Class.forName("com.mysql.jdbc.Driver");
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, id, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int findBNO() {
		String sql = "SELECT CHAT_ROOM_BNO FROM CHAT_ROOM";
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		try {
			pstmt2 = conn.prepareStatement(sql);
			rs2 = pstmt2.executeQuery();
			int getBNO = 0;
			while (rs2.next()) {
				getBNO = rs2.getInt("CHAT_ROOM_BNO");
			}
				return getBNO + 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				pstmt2.close();
				rs2.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return -2;
	}
	
	public ArrayList<ChatRoom> showChatRoom(String userID) {
		String sql = "SELECT * FROM CHAT_ROOM WHERE CHAT_ROOM_BNO IN (SELECT CHAT_ROOM_BNO FROM CHAT_USER WHERE USERID = ?) ORDER BY LATEST_VIEW_DATE DESC";
		ArrayList<ChatRoom> list = null;
		try {
			list = new ArrayList<ChatRoom>();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ChatRoom chatRoom = new ChatRoom();
				chatRoom.setOperator(rs.getString("OPERATOR"));
				chatRoom.setRoomName(rs.getString("ROOMNAME"));
				chatRoom.setRoomPW(rs.getString("ROOMPW"));
				chatRoom.setRoomIntro(rs.getString("ROOMINTRO"));
				chatRoom.setRoomBNO(rs.getInt("CHAT_ROOM_BNO"));
				chatRoom.setOpenDate(rs.getString("OPEN_DATE"));
				list.add(chatRoom);
			}
			pstmt.close();
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<ChatRoom> showAllChatRoom() {
		String sql = "SELECT * FROM CHAT_ROOM ORDER BY LATEST_VIEW_DATE DESC";
		ArrayList<ChatRoom> list = null;
		try {
			list = new ArrayList<ChatRoom>();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ChatRoom chatRoom = new ChatRoom();
				chatRoom.setOperator(rs.getString("OPERATOR"));
				chatRoom.setRoomName(rs.getString("ROOMNAME"));
				chatRoom.setRoomPW(rs.getString("ROOMPW"));
				chatRoom.setRoomIntro(rs.getString("ROOMINTRO"));
				chatRoom.setRoomBNO(rs.getInt("CHAT_ROOM_BNO"));
				chatRoom.setOpenDate(rs.getString("OPEN_DATE"));
				list.add(chatRoom);
			}
			pstmt.close();
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public boolean checkSameRoom(String bno, String userID) {
		String sql = "SELECT USERID FROM CHAT_USER WHERE CHAT_ROOM_BNO = ?";
		ResultSet rs1 = null;
		PreparedStatement pstmt1 = null;
		try {
			pstmt1 = conn.prepareStatement(sql);
			pstmt1.setString(1, bno);
			rs1 = pstmt1.executeQuery();
			while(rs1.next()) {
				if(rs1.getString("USERID").equals(userID)) {
					return true;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				pstmt1.close();
				rs1.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}
	
	public int inviteFriends(String roomBNO, String friendID) {
		String sql = "INSERT INTO CHAT_USER VALUES(?,?)";
		try {
			if(checkSameRoom(roomBNO, friendID)) {
				return 0;
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, friendID);
			pstmt.setString(2, roomBNO);
			pstmt.executeUpdate();
			pstmt.close();
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
			//오류가 생기는 경우는 친구의 아이디를 잘못 입력한 경우 임으로 오류를 출력하지 않음.
		}
	}
	
	public void createChatRoom(String userID,String name,String PW, String Intro) {
		String sql = "INSERT INTO CHAT_ROOM(OPERATOR, CHAT_ROOM_BNO, ROOMNAME, ROOMPW, ROOMINTRO) values (?,?,?,?,?)";
		PreparedStatement pstmt1 = null;
		try {
			int bno = findBNO();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setInt(2, bno);
			pstmt.setString(3, name);
			pstmt.setString(4, PW);
			pstmt.setString(5, Intro);
			pstmt.executeUpdate();
			sql = "INSERT INTO CHAT_USER VALUES(?,?)";
			pstmt1 = conn.prepareStatement(sql);
			pstmt1.setString(1, userID);
			pstmt1.setInt(2, bno);
			pstmt1.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
				pstmt1.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public ArrayList<ChatMessage> findChatMessage(int chatRoomBNO,int startNum, int endNum) {
		String sql = "select * from (select rownum rn, userid, chat_room_bno, message, send_date from (select * from chat_message order by send_date desc) where chat_room_bno = ? order by send_date desc) where rn between ? and ?";
		ArrayList<ChatMessage> list = null;
		ChatMessage chatMessage = null;
		try {
			list = new ArrayList<>();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, chatRoomBNO);
			pstmt.setInt(2, startNum);
			pstmt.setInt(3, endNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				chatMessage = new ChatMessage();
				chatMessage.setUserID(rs.getString(2));
				chatMessage.setChatRoomBNO(rs.getString(3));
				chatMessage.setMessage(rs.getString(4));
				chatMessage.setSendDate(rs.getString(5));
				list.add(chatMessage);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
				rs.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public void insertMessage(String userID, String roomBNO, String message) {
		String sql = "INSERT INTO CHAT_MESSAGE (USERID, CHAT_ROOM_BNO, MESSAGE) VALUES (?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, roomBNO);
			pstmt.setString(3, message);
			pstmt.executeUpdate();
			sql = "UPDATE CHAT_ROOM SET LATEST_VIEW_DATE = to_char(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') WHERE CHAT_ROOM_BNO = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, roomBNO);
			pstmt.executeUpdate();
			pstmt.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<ChatRoom> searchChatRoom(String by, String text){
		String searchText = "%"+text+"%";
		ArrayList<ChatRoom> list = null;
		String sql = "SELECT * FROM CHAT_ROOM WHERE "+by+" like ?";
		try {
			list = new ArrayList<ChatRoom>();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchText);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ChatRoom chatRoom = new ChatRoom();
				chatRoom.setOperator(rs.getString("OPERATOR"));
				chatRoom.setRoomName(rs.getString("ROOMNAME"));
				chatRoom.setRoomPW(rs.getString("ROOMPW"));
				chatRoom.setRoomIntro(rs.getString("ROOMINTRO"));
				chatRoom.setRoomBNO(rs.getInt("CHAT_ROOM_BNO"));
				chatRoom.setOpenDate(rs.getString("OPEN_DATE"));
				list.add(chatRoom);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int exitChatRoom(String userID, String roomBNO) {
		String sql = "DELETE FROM CHAT_USER WHERE USERID = ? AND CHAT_ROOM_BNO = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, roomBNO);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
