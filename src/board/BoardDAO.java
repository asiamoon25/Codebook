package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import chat.ChatRoom;

public class BoardDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	
	public BoardDAO() {
		try {
			// mysql 접속시
			// String url = "jdbc:mysql://localhost:3306/userDatabase"; //userDatabase에 접속
			// String id = "admin"; //접속 계정은 admin 비밀번호 1234
			// String pw = "1234";
			// oracle 접속시
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
		String sql = "SELECT BOARDBNO FROM USERBOARD";
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		try {
			pstmt2 = conn.prepareStatement(sql);
			rs2 = pstmt2.executeQuery();
			int getBNO = 0;
			while (rs2.next()) {
				getBNO = rs2.getInt("BOARDBNO");
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

	public int countBoard(String category) {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM USERBOARD WHERE CATEGORY = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return count;
	}
	public int countBoard_search(String searchText,String category) {
		int count = 0;
		String text = "%"+searchText+"%";
		String sql = "SELECT COUNT(*) FROM USERBOARD WHERE CATEGORY = (?) AND TITLE LIKE ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category);
			pstmt.setString(2, text);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return count;
	}

	public int writeBoard(Board board) {
		String sql = "INSERT INTO USERBOARD(BOARDBNO,USERID,TITLE,CONTENT) VALUES (?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, findBNO());
			pstmt.setString(2, board.getUserID());
			pstmt.setString(3, board.getTitle());
			pstmt.setString(4, board.getContent());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	public String matchName(String userID) {
		String sql ="SELECT USERNAME FROM USERDATA WHERE USERID=?";
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		try {
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setString(1, userID);
			rs2 = pstmt2.executeQuery();
			while(rs2.next()) {
				return rs2.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt2.close();
				rs2.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public String matchIDfromBoardBNO(int boardBNO) {
		String sql ="SELECT USERID FROM USERBOARD WHERE BOARDBNO=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardBNO);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	// 리스트 페이지에 보여줄 로직(페이징 처리)
	public Board getBoard(int boardBNO) {
		// 페이징 처리를 위한 sql / 인라인뷰, rownum 사용
		String sql = "SELECT BOARDBNO, USERID, TITLE, CONTENT, VIEWS, RECOMMEND, WRITEDATE, CATEGORY FROM USERBOARD WHERE BOARDBNO = ? ";
		Board board = null;
		try {
			pstmt = conn.prepareStatement(sql); // sql 정의
			pstmt.setInt(1, boardBNO); // sql 물음표에 값 매핑
			rs = pstmt.executeQuery(); // sql 실행
			if (rs.next()) { // 데이터베이스에 데이터가 있으면 실행
				board = new Board(); // list 객체 생성
				do {
					// 반복할 때마다 ExboardDTO 객체를 생성 및 데이터 저장
					board.setBoardBNO(rs.getInt("BOARDBNO"));
					board.setUserID(rs.getString("USERID"));
					board.setUserName(matchName(rs.getString("USERID")));
					board.setTitle(rs.getString("TITLE"));
					board.setContent(rs.getString("CONTENT"));
					board.setViews(rs.getInt("VIEWS"));
					board.setRecommend(rs.getInt("RECOMMEND"));
					board.setWriteDate(rs.getString("WRITEDATE"));
					board.setCategory(rs.getString("CATEGORY"));
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return board; // list 반환
	}
	public int checkView(int boardBNO) {
		String sql = "SELECT COUNT(BOARDBNO) FROM USERVIEWS WHERE BOARDBNO = ?";
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		int views = 0;
		try {
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, boardBNO);
			rs2 = pstmt2.executeQuery();
			while(rs2.next()) {
				views = rs2.getInt(1);
			}
			pstmt2.close();
			rs2.close();
			return views;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int checkRecommends(int boardBNO) {
		String sql = "SELECT COUNT(BOARDBNO) FROM USERRECOMMEND	WHERE BOARDBNO = ?";
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		int recommends = 0;
		try {
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, boardBNO);
			rs2 = pstmt2.executeQuery();
			while(rs2.next()) {
				recommends = rs2.getInt(1);
			}
			pstmt2.close();
			rs2.close();
			return recommends;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public void update_View_RC(int boardBNO) {
		String sql = "UPDATE USERBOARD SET VIEWS = ?, RECOMMEND = ? WHERE BOARDBNO = ?";			
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, checkView(boardBNO));
				pstmt.setInt(2, checkRecommends(boardBNO));
				pstmt.setInt(3, boardBNO);
				pstmt.executeUpdate();
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
	
	
	public List<Board> getList_category(int startRow, int endRow, String category) {
		// 페이징 처리를 위한 sql / 인라인뷰, rownum 사용
		String sql = "SELECT * FROM "
				+ "(SELECT ROWNUM RN,USERID, BOARDBNO, TITLE, CONTENT, VIEWS, RECOMMEND, WRITEDATE FROM "
				+ "(SELECT * FROM USERBOARD WHERE CATEGORY = ? ORDER BY BOARDBNO DESC)) WHERE RN BETWEEN ? AND ?";
		List<Board> list = null;
		try {
			pstmt = conn.prepareStatement(sql); // sql 정의
			pstmt.setString(1, category);
			pstmt.setInt(2, startRow); // sql 물음표에 값 매핑
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery(); // sql 실행
			if (rs.next()) { // 데이터베이스에 데이터가 있으면 실행
				list = new ArrayList<>(); // list 객체 생성
				do {
					// 반복할 때마다 ExboardDTO 객체를 생성 및 데이터 저장
					Board board = new Board();
					board.setBoardBNO(rs.getInt("BOARDBNO"));
					board.setUserName(matchName(rs.getString("USERID")));
					board.setTitle(rs.getString("TITLE"));
					board.setContent(rs.getString("CONTENT"));
					board.setViews(rs.getInt("VIEWS"));
					board.setRecommend(rs.getInt("RECOMMEND"));
					board.setWriteDate(rs.getString("WRITEDATE"));
					list.add(board); // list에 0번 인덱스부터 board 객체의 참조값을 저장
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list; // list 반환
	}
	public List<Board> getList_search(int startRow, int endRow,String category, String searchText) {
		// 페이징 처리를 위한 sql / 인라인뷰, rownum 사용
		String text = "%"+searchText+"%";
		String sql = "SELECT * FROM "
				+ "(SELECT ROWNUM RN, USERID, BOARDBNO, TITLE, CONTENT, VIEWS, RECOMMEND, WRITEDATE FROM "
				+ "(SELECT * FROM USERBOARD WHERE CATEGORY = (?) AND TITLE LIKE ? ORDER BY BOARDBNO DESC)) WHERE RN BETWEEN ? AND ? ";
		List<Board> list = null;
		try {
			pstmt = conn.prepareStatement(sql); // sql 정의
			pstmt.setString(1, category); // sql 물음표에 값 매핑
			pstmt.setString(2, text); // sql 물음표에 값 매핑
			pstmt.setInt(3, startRow); // sql 물음표에 값 매핑
			pstmt.setInt(4, endRow);
			rs = pstmt.executeQuery(); // sql 실행
			if (rs.next()) { // 데이터베이스에 데이터가 있으면 실행
				list = new ArrayList<>(); // list 객체 생성
				do {
					// 반복할 때마다 ExboardDTO 객체를 생성 및 데이터 저장
					Board board = new Board();
					board.setBoardBNO(rs.getInt("BOARDBNO"));
					board.setUserName(matchName(rs.getString("USERID")));
					board.setTitle(rs.getString("TITLE"));
					board.setContent(rs.getString("CONTENT"));
					board.setViews(rs.getInt("VIEWS"));
					board.setRecommend(rs.getInt("RECOMMEND"));
					board.setWriteDate(rs.getString("WRITEDATE"));
					list.add(board); // list에 0번 인덱스부터 board 객체의 참조값을 저장
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list; // list 반환
	}
	
	public int plusBoardRecommend(String userID, int boardBNO) {
		String sql = "INSERT INTO USERRECOMMEND (USERID, BOARDBNO) VALUES (?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setInt(2, boardBNO);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return -1;
	}
	public int minusBoardRecommend(String userID, int boardBNO) {
		String sql = "DELETE FROM USERRECOMMEND WHERE USERID = ? AND BOARDBNO = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setInt(2, boardBNO);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return -1;
	}
	public int sessionCheck(String sessionID, int boardBNO) {
		String sql = "SELECT SESSIONID FROM USERVIEWS WHERE BOARDBNO = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardBNO);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				if(rs.getString(1).equals(sessionID)) {
					return 0;
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return 1;
	}
	
	public void plusView(String sessionID, int boardBNO) {
		String sql = "INSERT INTO USERVIEWS(SESSIONID,BOARDBNO) VALUES (?,?)";
		int sessionCheck = sessionCheck(sessionID, boardBNO);
		try {
			if(sessionCheck == 1) {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sessionID);
			pstmt.setInt(2, boardBNO);
			pstmt.executeUpdate();
			pstmt.close();
			}else {
				return;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteBoard(String userID, String boardBNO) {
		String sql = "DELETE FROM USERBOARD WHERE USERID = ? AND BOARDBNO = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, boardBNO);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
