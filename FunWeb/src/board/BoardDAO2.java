package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import member.MemberBean;

public class BoardDAO2 {
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	

	public Connection getConnection() throws Exception{	
//	 	-- Connection : java.sql		
			Context init = new InitialContext();
//			-- Context : javax.naming
//			-- InitialContext() : javax.naming
			DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
//			-- init.lookup : object 타입 리턴 (- > DataSource 형 변환)
//			-- DataSource : java.sql;
			Connection con = ds. getConnection();
//			-- getConnection : DataSource -> Connection 형 변환 메서드
			return con;		
		}	
	
	
	public void cleaning(Connection con, PreparedStatement ps, ResultSet rs) {
//		-- PreparedStatement : java.sql
//		-- ResultSet : java.sql
			if(rs!=null) {
				try {rs.close();} 
				catch (SQLException ex) {}		
			}
			if(ps!=null) {				
				try {ps.close();} 
				catch (SQLException ex) {}				
			}
			if(con!=null) {				
				try {con.close();} 
				catch (SQLException ex) {}				
			}			
		}
			
	
	public int getBoardCount() {
		int num=0;		
		try {			
			 con = getConnection();
			String sql = "select count(*) from board";		
			ps = con.prepareStatement(sql);	
			rs = ps.executeQuery();
			if(rs.next()) {			
//				num = rs.getInt("count(*)");	
//				컬럼명 "count(*)" 혹은 아래 컬럼 인덱스 1로 값 불러오기 (컬럼은 인덱스 1부터 시작됨)
				num = rs.getInt(1);
			}
//			else {	num=0;	}	count 함수사용 -> 함수를 사용하게 되면 데이터가 null이여도 결과값이 0으로 나오게 된다. 그러므로 따로 else문은 필요가 없다.					
		} catch (Exception e) {
			e.printStackTrace();
		} 		
		finally {	// 예외 발생 상관없이 처리되는 문장
			cleaning(con, ps, rs);
		}
		return num;
	}
	
	
	public int getBoardCount(String search) {
		
		int num=0;		
		try {			
			 con = getConnection();
//			String sql = "select count(*) from board where subject like '%검색어%";	
			String sql = "select count(*) from board where subject like ? ";		
			ps = con.prepareStatement(sql);	
			ps.setString(1, "%"+search+"%");
			rs = ps.executeQuery();
			
			if(rs.next()) {			
				num = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 		
		finally {	// 예외 발생 상관없이 처리되는 문장
			cleaning(con, ps, rs);
		}
		return num;
	}
	
	
//	public List getBoardList() {
	public List<BoardBean> getBoardList(int startRow, int pageSize) {

		List<BoardBean> BoardList = new ArrayList<>();
		
		try {			
			con = getConnection();
//			String sql = "select * from board order by num desc";		
			
			// 방법1
			//limit 페이징 여기서부터 시작해서 여기까지 보여줌. 근데 시작하고 싶은 행번호에서 -1을하고 pagesize를 설정하면됨.
			
			String sql = "select * from board order by num desc limit "+(startRow-1)+", "+pageSize;
			ps = con.prepareStatement(sql);			
			
			// "select * from board order by num desc limit 시작행-1, 한화면에 보여줄 글개수"
			// 시작행-1 --> limit 행, 해당 행은 노출되지 않고 다음 행부터 노출됨. limit 0행을 하면 1행부터 노출되므로.
			// 노출하고 싶은 행에서 -1을 해서 행을 설정해줘야함. 3행부터 보여주고 싶다면 3-1값을 입력해야함.
			// --> limit mysql에만 있는 것으로 오라클에는 없음. 오라클은 페이지 사이즈로 할 수 없음. endRow값을 구해서 구문을 작성해야함.
			
			
			// 방법2
//			String sql = "select * from board order by num desc limit ?,?";		
//			ps.setInt(startRow);
//			ps.setInt(pageSize-1);	
//			ps = con.prepareStatement(sql);			
			rs = ps.executeQuery();	
			
		while(rs.next()){	
				BoardBean bb = new BoardBean();
				
				bb.setNum(rs.getInt("num"));
				bb.setSubject(rs.getString("subject"));
				bb.setName(rs.getString("name"));			
				bb.setDate(rs.getDate("date"));
				bb.setReadcount(rs.getInt("readcount"));
	
				BoardList.add(bb);	
//				BoardList.add("string"); // boardBena객체만 저장되므로 스트링형은 저장이 안된다
			}			
		} catch (Exception e) {		// 예외가 발생하면
			e.printStackTrace();
		} 		
		finally {	// 예외 발생 상관없이 처리되는 문장
			cleaning(con, ps, rs);
		}
		return BoardList;
	}
	
	
	public List<BoardBean> getBoardList(int startRow, int pageSize, String search) {

		List<BoardBean> BoardList = new ArrayList<>();
		
		try {			
			con = getConnection();

			String sql = "select * from board where subject like ? order by num desc limit ?,?";	
			ps = con.prepareStatement(sql);			
			ps.setString(1, "%"+search+"%");
			ps.setInt(2, startRow-1);
			ps.setInt(3, pageSize);	
			rs = ps.executeQuery();	
			
		while(rs.next()){	
				BoardBean bb = new BoardBean();
				
				bb.setNum(rs.getInt("num"));
				bb.setSubject(rs.getString("subject"));
				bb.setName(rs.getString("name"));			
				bb.setDate(rs.getDate("date"));
				bb.setReadcount(rs.getInt("readcount"));
	
				BoardList.add(bb);	
			}			
		} catch (Exception e) {		// 예외가 발생하면
			e.printStackTrace();
		} 		
		finally {	// 예외 발생 상관없이 처리되는 문장
			cleaning(con, ps, rs);
		}
		return BoardList;
	}
	
	
	public int insertBoard(BoardBean bb) {
		
		int num=0;
		int result=-1;
		try {
			con = getConnection();
			
			String sql ="select max(num) from board";	// num값의 max를 구하는 함수.
			// max 함수사용 -> 함수를 사용하게 되면 데이터가 null이여도 결과값이 0으로 나오게 된다. 그러므로 따로 else문은 필요가 없다.
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
			if(rs.next()) { // rs.next가 null인데 
				num=rs.getInt("max(num)")+1;	// or 	rs.getInt(1);
			}
			
			sql ="insert into board (num, pass, name, subject, content, readcount, date, file) values(?,?,?,?,?,0,now(),?)";
											// table내 모든 컬럼이 순서대로 배열되어있으면 생략해도 됨.
//			String sql ="insert into board values(?,?,?,?,?,?,?)";
			
			ps = con.prepareStatement(sql);
			ps.setInt(1,num);
			ps.setString(2,bb.getPass());
			ps.setString(3,bb.getName());
			ps.setString(4,bb.getSubject());
			ps.setString(5,bb.getContent());
//			ps.setInt(6, bb.getReadcount());	
			ps.setString(6,bb.getFile());
			
			result =ps.executeUpdate(); 
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 예외 발생 상관없이 처리되는 문장
			cleaning(con, ps, rs);
		}
		return result;
	}
	
	
	public BoardBean getBoard(int num) {
		BoardBean bb = new BoardBean();
		
		try {
			con = getConnection();
			String sql = "select * from board where num=?";
			
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);

			rs = ps.executeQuery();
			
				
			while(rs.next()) {
				bb.setNum(num);
				bb.setSubject(rs.getString("subject"));
				bb.setName(rs.getString("name"));
				bb.setDate(rs.getDate("date"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setFile(rs.getString("file"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 예외 발생 상관없이 처리되는 문장
			cleaning(con, ps, rs);
		}
		return bb;
	}

	
	public int updateReadcount(int num) {
		
		int result =0;
		try {
			con = getConnection();
			String sql = "update board set readcount=readcount+1 where num=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			result = ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 구문오류 : " + e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Exception 오류 : " + e.getMessage());
		} finally {	// 예외 발생 상관없이 처리되는 문장
			cleaning(con, ps, rs);
		}
		return result;		
	}
	
	public int numCheck(int num, String pass) {
		
		int result = -1;
		
		try {
			con = getConnection();
			
			String sql ="select * from board where num =?";
			
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, num);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				if(pass.equals(rs.getString("pass"))) {
					result= 1;	// num값과 비밀번호가 일치하는 게시글이 존재
				}
				else {
					result= 0;	// num값과 비밀번호 일치 X
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;	// -1인 경우 구문에러
	}
	
	public int updateBoard(BoardBean bb) {
		int result = -1;
		try {
			con = getConnection();
			
			String sql= "update board set subject=?, content=?, date=now()"
					+ "where num=? and pass=?";
			
			ps = con.prepareStatement(sql);
			
			ps.setString(1, bb.getSubject());
			ps.setString(2, bb.getContent());
			ps.setInt(3, bb.getNum());
			ps.setString(4, bb.getPass());
			
			result = ps.executeUpdate();
			
			return result;
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 : " + e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("오류 : " + e.getMessage());
		}	finally {// 예외 발생 상관없이 처리되는 문장
			cleaning(con, ps, rs);
		}
		return result;
		
		}
	
	
	public int deleteBoard(int num, String pass) {
		int result = -1;
		try {
			con = getConnection();
			
			String sql= "delete from board where num=? and pass=?";
			
			ps = con.prepareStatement(sql);
			
	
			ps.setInt(1, num);
			ps.setString(2, pass);
			
			result = ps.executeUpdate();
			
			return result;
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 : " + e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("오류 : " + e.getMessage());
		}	finally {// 예외 발생 상관없이 처리되는 문장
			cleaning(con, ps, rs);
		}
		return result;
		
		}
		
		
		
}
	
	
