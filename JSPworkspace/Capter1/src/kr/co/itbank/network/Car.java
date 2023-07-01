package kr.co.itbank.network;
//반드시 패키지는 뒤에서 부터!!
//찾는 시간 때문에?

/*
 * class의 조건 
 *  1. 클래스의 접근권한은 public
 *  2. 클래스 내의 변수는 반드시!! private
 *  3. 멤버 변수마다 반드시 getter/setter
 *  4. getter/setter 반드시 public
 *  5. getter의 파라미터는 없어야합니다.
 *  6. setter는 반드시 파라미터가 있어야합니다.
 *  7. 생성자는 default 생성자만 가능
 */

public class Car {
	private int speed;
	private String color;
	
	public int getSpeed() {
		return speed;
	}
	public void setSpeed(int speed) {
		this.speed = speed;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	
}