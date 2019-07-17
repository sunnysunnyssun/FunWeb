package comment;

import java.sql.Timestamp;

public class CommentDTO {

	private int num;
	private String name;
	private String contnet;
	private Timestamp date;
	private int boardNum;
	public CommentDTO(int num, String name, String contnet, Timestamp date, int boardNum) {
		this.num = num;
		this.name = name;
		this.contnet = contnet;
		this.date = date;
		this.boardNum = boardNum;
	}
	public CommentDTO(String name, String contnet, Timestamp date, int boardNum) {
		this.name = name;
		this.contnet = contnet;
		this.date = date;
		this.boardNum = boardNum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContnet() {
		return contnet;
	}
	public void setContnet(String contnet) {
		this.contnet = contnet;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	
	
}
