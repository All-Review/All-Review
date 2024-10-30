package Search;

public class SearchHistory {
	private String searchWord;
	
	public SearchHistory () {}
	public SearchHistory (String searchWord) {
		super();
		this.searchWord = searchWord;
	}
	
	public String getSearchWord() {
		return searchWord;
	}
	
	public void setSearchWord() {
		this.searchWord = searchWord;
	}

}