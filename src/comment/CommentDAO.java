package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public CommentDAO() {
		try {
			String url = "jdbc:oracle:thin:@localhost:1521:xe"; // userDatabase에 접속
			String id = "jungho"; // 접속 계정은 admin 비밀번호 1234
			String pw = "1234";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, id, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public int countComment(int boardBNO) {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM USERComment WHERE BOARDBNO = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardBNO);
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

	public int findBNO() {
		String sql = "SELECT COMMENTBNO FROM USERCOMMENT ORDER BY COMMENTBNO ASC";
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		try {
			pstmt2 = conn.prepareStatement(sql);
			rs2 = pstmt2.executeQuery();
			int getBNO = 0;
			while (rs2.next()) {
				getBNO = rs2.getInt("COMMENTBNO");
			}
			return getBNO + 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
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

	public int writeComment(Comment comment) {
		String sql = "INSERT INTO USERCOMMENT(BOARDBNO,COMMENTBNO,USERID,CONTENT) VALUES (?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, comment.getBoardBNO());
			pstmt.setInt(2, findBNO());
			pstmt.setString(3, comment.getUserID());
			pstmt.setString(4, comment.getContent());
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
	public void updateCommentRC(int commentBNO) {
		String sql = "UPDATE USERCOMMENT SET RECOMMEND = (SELECT count(COMMENTBNO) FROM USERRECOMMEND WHERE COMMENTBNO = ?) WHERE COMMENTBNO = ?";
		PreparedStatement pstmt1 = null;
		try {
			pstmt1 = conn.prepareStatement(sql);
			pstmt1.setInt(1, commentBNO);
			pstmt1.setInt(2, commentBNO);
			pstmt1.executeUpdate();
			pstmt1.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int plusCommnetRC(String id, String bno) {
		String sql = "SELECT USERID FROM USERRECOMMEND WHERE USERID = ? AND COMMENTBNO = ?";
		boolean check = true;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, bno);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return 0;
			}
			if(check) {
				sql = "INSERT INTO USERRECOMMEND(USERID, COMMENTBNO) VALUES (?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, bno);
				return pstmt.executeUpdate();
			}
		}catch(Exception e) {
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
	public void deleteCommentRC(String id, String bno) {
		String sql = "DELETE FROM USERRECOMMEND WHERE USERID = ? AND COMMENTBNO = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, bno);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public List<Comment> commentList(int boardBNO,int startnum, int endnum) {
		List<Comment> list = null;
		String sql = "SELECT * FROM "
				+ "(SELECT ROWNUM RN, COMMENTBNO, BOARDBNO, USERID, CONTENT, WRITEDATE, RECOMMEND FROM "
				+ "(SELECT * FROM USERCOMMENT WHERE BOARDBNO = ? ORDER BY COMMENTBNO DESC)) WHERE RN BETWEEN ? AND ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardBNO);
			pstmt.setInt(2, startnum);
			pstmt.setInt(3, endnum);
			rs = pstmt.executeQuery();
			list = new ArrayList<>();
				while (rs.next()) {
					Comment com = new Comment();
					com.setBoardBNO(rs.getString("BOARDBNO"));
					com.setCommentBNO(rs.getString("COMMENTBNO"));
					com.setContent(rs.getString("CONTENT"));
					com.setRecommend(rs.getString("RECOMMEND"));
					com.setUserID(rs.getString("USERID"));
					com.setWriteDate(rs.getString("WRITEDATE"));
					list.add(com);
				}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	public int plusCommentRecommend(String userID, int CommentBNO) {
		String sql = "INSERT INTO USERRECOMMEND (USERID, COMMENTBNO) VALUES (?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setInt(2, CommentBNO);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
	public String showCommentImg(String commentBNO) {
		String sql ="SELECT A.USERPROFILEIMG,B.USERID, B.COMMENTBNO FROM USERDATA A, USERCOMMENT B WHERE B.COMMENTBNO = ? AND A.USERID=B.USERID";
		String imgFileName = null;
		String path = null;
		String userID = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, commentBNO);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				path = rs.getString(1);
				userID = rs.getString(2);
			}
			if(path == null) {
				imgFileName = "image/default_user_img.png";				
			}else {
				imgFileName = "user_data/"+userID+"/"+path;				
			}
			pstmt.close();
			rs.close();
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
		return imgFileName;
	}
	public int deleteComment(String commentBNO) {
		String sql = "DELETE FROM USERCOMMENT WHERE COMMENTBNO = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, commentBNO);
			return pstmt.executeUpdate();
		}catch(Exception e ) {
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
	
}
