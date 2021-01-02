package model;

public class OrderingDTO {

	private String id; 
	private String order_info;
	private String delivery_info;
	private String basket;
	private String message;
	private int total_price;
	private String payment;
	private String order_name;
	private String delivery_name;
	private String postdate;
	private int idx;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getOrder_name() {
		return order_name;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}
	public String getDelivery_name() {
		return delivery_name;
	}
	public void setDelivery_name(String delivery_name) {
		this.delivery_name = delivery_name;
	}
	public String getPostdate() {
		return postdate;
	}
	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOrder_info() {
		return order_info;
	}
	public void setOrder_info(String order_info) {
		this.order_info = order_info;
	}
	public String getDelivery_info() {
		return delivery_info;
	}
	public void setDelivery_info(String delivery_info) {
		this.delivery_info = delivery_info;
	}
	public String getBasket() {
		return basket;
	}
	public void setBasket(String basket) {
		this.basket = basket;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
}
