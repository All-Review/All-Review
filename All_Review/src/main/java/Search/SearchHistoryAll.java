package Search;

public class SearchHistoryAll {
	private String searchWord;
	private int searchNum;
	
	public SearchHistoryAll () {}
	public SearchHistoryAll (String searchWord, int searchNum) {
		super();
		this.searchWord = searchWord;
		this.searchNum = searchNum;
	}
	
	public SearchHistoryAll (String searchWord) {
		super();
		this.searchWord = searchWord;
	}
	
	public String getSearchWord() {
		return searchWord;
	}
	
	public void setSearchWord() {
		this.searchWord = searchWord;
	}
	
	public int getSearchNum() {
		return searchNum;
	}
	
	public void setSearchNum() {
		this.searchNum = searchNum;
	}

}
