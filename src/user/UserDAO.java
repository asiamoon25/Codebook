package user;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public UserDAO() {
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

	public boolean checkUser(String userID) {
		String sql = "SELECT USERID FROM USERDATA WHERE USERID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (rs.getString(1).equals(userID)) {
					return true; // 아이디 일치시에만 true값 리턴
				}
			}
			return false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	public int login(String userID, String userPW) {
		String sql = "SELECT userPW FROM userdata WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString("userPW").equals(userPW)) {
					return 1; // 성공 리턴값
				} else {
					return 0; // 비밀번호 불일치 리턴값
				}
			}
			return -1; // 아이디 존재 안할때의 리턴값
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
		return -2; // 오류 리턴값
	}

	public int signUp(User user) {
		String sql = "insert into userdata(USERNAME, USERID,USERPW, USEREMAIL, USERGENDER, USERBIRTHDATE, USERTYPE) values (?,?,?,?,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserName());
			pstmt.setString(2, user.getUserID());
			pstmt.setString(3, user.getUserPW());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserGender());
			pstmt.setString(6, user.getUserBirthDate());
			pstmt.setString(7, user.getUserType());
			return pstmt.executeUpdate(); // 유저 등록 성공
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 유저 등록 실패
	}
	
	public int makeUserFolder(String userID) {
		String path = "C:\\JavaWorksapce\\Test01\\WebContent\\user_data\\" + userID;
		File Folder = new File(path);
		if (!Folder.exists()) {
			try {
				Folder.mkdir();
				return 1;
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			System.out.println("이미 유저의 폴더가 있기에 생성하지 못했습니다.");
		}
		return -2;
	}
	
	public String showUserImg (String userID) {
		String sql = "SELECT USERPROFILEIMG FROM USERDATA WHERE USERID = ?";
		String imgFileName = null;
		String path = null;
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				path = rs.getString(1);
			}
			if(path == null) {
				imgFileName = "image/default_user_img.png";				
			}else {
				imgFileName = "user_data/"+userID+"/"+path;				
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
		return imgFileName;
	}
	public int rcCheck(String userID, int boardBNO) {
		String sql = "SELECT BOARDBNO FROM USERRECOMMEND WHERE USERID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs= pstmt.executeQuery();
			while(rs.next()) {
				if(rs.getInt(1) == boardBNO) {
					return 1;
				}
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
		return -1;
	}
	
	public int recommendControll(String userID, int boardBNO) {
		String sql = "UPDATE USERRECOMMEND SET ";
		
		return -1;
	}
}
