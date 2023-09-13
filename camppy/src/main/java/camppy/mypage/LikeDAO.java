package camppy.mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;



import camppy.main.action.PageDTO;

public class LikeDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//1,2단계 디비 연결 메서드 정의 -> 필요로 할 때 호출 사용
	public Connection getConnection() throws Exception {
			Context init = new InitialContext();
			DataSource ds=(DataSource)init.lookup("java:comp/env/c1d2304t3");
			con=ds.getConnection();

		return con;
	}//getConnection()
		
		
		
	//기억장소 해제 메서드()
	public void dbClose() {
		//-> con, pstmt, rs 기억장소 해제
		if(rs != null){try {rs.close();} catch (SQLException e) {}}
		if(pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
		if(con != null) {try {con.close();} catch (SQLException e) {}}
	}//dbClose()
	

	public List<LikeDTO> getLikeList(PageDTO pageDTO) {
		System.out.println("LikeDAO getLikeList()");
		
		List<LikeDTO> likeList = null;
		
		try {
			con=getConnection();
			System.out.println("rs");
			String sql = "select c.camp_name, c.facility, c.tel, c.camp_img, cl.camp_like_id, cl.camp_id, cl.member_id, ca.camp_addr\n"
					+ "					from camp c left join camp_like cl\n"
					+ "					on c.camp_id = cl.camp_id\n"
					+ "					left join camp_addr ca\n"
					+ "					on c.camp_id = ca.camp_id\n"
					+ "					where cl.member_id = ?\n"
					+ "					order by cl.camp_like_id desc\n"
					+ "					limit ?, ?";
			pstmt=con.prepareStatement(sql);
			System.out.println("memberid="+ pageDTO.getMemberid());
			pstmt.setInt(1, pageDTO.getMemberid());
			pstmt.setInt(2, pageDTO.getStartRow()-1);//시작행-1
			pstmt.setInt(3, pageDTO.getPageSize());//몇 개
			rs=pstmt.executeQuery();
			System.out.println("rs1"+rs);
			likeList=new ArrayList<>();
			while(rs.next()) {
				LikeDTO likeDTO = new LikeDTO();
				likeDTO.setCamp_like_id(rs.getInt("camp_like_id"));
				likeDTO.setCamp_id(rs.getInt("camp_id"));
				likeDTO.setMember_id(rs.getInt("member_id"));
				likeDTO.setCamp_name(rs.getString("camp_name"));
				likeDTO.setCamp_addr(rs.getString("camp_addr"));
				likeDTO.setFacility(rs.getString("facility"));
				likeDTO.setTel(rs.getString("tel"));
				likeDTO.setCamp_img(rs.getString("camp_img"));
				
				likeList.add(likeDTO);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {dbClose();}
		return likeList;
	}//getLikeList()

	
	public int getLikeCount(PageDTO pageDTO) {
		System.out.println("LikeDAO getLikeCount()");
		int count=0;
		try {
			con=getConnection();
			
			String sql="select count(*) from camp_like where member_id =?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pageDTO.getMemberid());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {dbClose();}
		return count;
	}//getLikeCount()
	
	
	


	public void insertLike(LikeDTO likeDTO) {
		try {
			con=getConnection();
			String sql = "insert into camp_like(member_id, camp_id) values(?,?)";
			pstmt=con.prepareStatement(sql);
			
			/* pstmt.setInt(1, likeDTO.getCamp_like_id()); */
			pstmt.setInt(1, likeDTO.getMember_id());
			pstmt.setInt(2, likeDTO.getCamp_id());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbClose();
		}
	}
	
	public void deleteLike(LikeDTO likeDTO) {
		try {
			con=getConnection();
			String sql = "DELETE FROM camp_like\r\n"
					+ "    WHERE member_id = ? AND camp_id = ?";
			pstmt=con.prepareStatement(sql);
			
			/* pstmt.setInt(1, likeDTO.getCamp_like_id()); */
			pstmt.setInt(1, likeDTO.getMember_id());
			pstmt.setInt(2, likeDTO.getCamp_id());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbClose();
		}
	}
	
	public int checklike(int campId, int memberid) {
		System.out.println("LikeDAO checklike()");
		int check = 0;
		try {
			con = getConnection();
			
			String sql = "select *\r\n"
					+ "from camp_like\r\n"
					+ "where member_id = ? and camp_id = ?;";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, memberid);
			pstmt.setInt(2, campId);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				check=rs.getInt("camp_like_id");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {dbClose();}
		return check;
	
	}



	public int getlikecount(int campId) {
		int likecount=0;
		try {
			
			con=getConnection();
			
			String sql = "select count(*) as likecount\r\n"
					+ "from camp_like where camp_id = ?;";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, campId);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				likecount=rs.getInt("likecount");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbClose();
		}
		return likecount;
	}
	
	
	
	

}//LikeDAO 
