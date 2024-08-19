package Search;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import util.DatabaseUtil;


public class SearchHistoryDAO {
	// 검색 기록 저장
    public int createSearchHistory (String searchWord) {
    	String sql = "insert into search_history (search_word) values (?)";
    	String deleteSqlString = "delete from search_history where search_word=?";
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		// 원래 있던 값 삭제
    		PreparedStatement pstmt = conn.prepareStatement(deleteSqlString);
    		pstmt.setString(1, searchWord);
    		pstmt.executeUpdate();
    		
    		// 등록
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, searchWord);

    		return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return -1;
    }
	
	// 검색 기록 모두 불러오기
	public List<SearchHistory> readSearchLists () {
		String sql = "select * from search_history";
		List<SearchHistory> result = new ArrayList<>();
		
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	SearchHistory sh = new SearchHistory(
                		rs.getString(1)
                );
                result.add(sh);
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
    // 전체 검색 기록 목록에도 저장
    public int createSearchHistoryAll (String searchWord) {
    	String sql = "insert into search_history_all (search_word, search_num) values (?, 1)";
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		// 등록
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, searchWord);

    		return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return -1;
    }
    
    // 전체 검색 기록에서 searchNum 변경
    public int updateSearchNum (String searchWord, int num) {
    	String sql = "update search_history_all set search_num=? where search_word=?";
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		// 등록
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, num + 1);
    		pstmt.setString(2, searchWord);

    		return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return -1;
    }
    
	// 전체 검색 기록 불러오기
	public List<SearchHistoryAll> readSearchListsAll () {
		String sql = "select * from search_history_all";
		List<SearchHistoryAll> result = new ArrayList<>();
		
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	SearchHistoryAll sha = new SearchHistoryAll(
                		rs.getString(1)
                );
                result.add(sha);
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 전체 검색 기록 중 특정 키워드 찾기
	public List<SearchHistoryAll> readOneSearchHistoryAll (String word) {
		String sql = "select * from search_history_all where search_word=?";
		List<SearchHistoryAll> result = new ArrayList<>();
		
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, word);
            ResultSet rs = pstmt.executeQuery();
            
            if(rs.next()) {
            	SearchHistoryAll sha = new SearchHistoryAll(
                		rs.getString(1),
                		rs.getInt(2)
                );
                result.add(sha);
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 전체 검색 기록 검색수 높은 순서 내림차순으로 불러오기
	public List<SearchHistoryAll> readSearchListsAllDesc () {
		String sql = "select * from search_history_all order by search_num desc";
		List<SearchHistoryAll> result = new ArrayList<>();
		
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	SearchHistoryAll sha = new SearchHistoryAll(
                		rs.getString(1)
                );
                result.add(sha);
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
}
