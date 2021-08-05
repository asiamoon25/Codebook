package chat.server;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import chat.ChatDAO;
 
@ServerEndpoint(value="/ChatServer/{roomBNO}", configurator = GetHttpSession.class)
public class ChatServer{
	public static ConcurrentHashMap<Session, HttpSession> userList = new ConcurrentHashMap<>();
	public static List<String> roomList = new ArrayList<>();
	public ChatServer() {
		super();
		System.out.println("채팅 서버가 시작했습니다.");
	}
    /**
     * @param session
     * @param config
     */
    @OnOpen
    public void onOpen(Session session, EndpointConfig config, @PathParam("roomBNO") String roomBNO) {
    	ChatDAO chatDAO = new ChatDAO();
    	System.out.println("세션ID : "+session.getId());
    	HttpSession httpSession = (HttpSession) config.getUserProperties().get("HTTP_SESSION");
    	session.getUserProperties().put("roomBNO", roomBNO);
    	System.out.println("HTTP세션ID :"+httpSession.getId()+" 방 번호:"+roomBNO);
    	for(int i =  0; i < roomList.size(); i++) {
    		if(!roomList.get(i).equals(roomBNO)) {
    			roomList.add(roomBNO);    			
    		}
    	}
    	userList.put(session, httpSession);
    }
    
    @OnMessage
	public void onMsg(String message, Session session, @PathParam("roomBNO") String roomBNO) throws IOException{
    	ChatDAO chatDAO = new ChatDAO();
    	Session s = session;
    	String[] m = message.split("/");
    	String tomessage = m[0];
    	String sender = m[1];
    	chatDAO.insertMessage(sender, roomBNO, tomessage);
    	for(Map.Entry<Session, HttpSession> entry : userList.entrySet()) {
    		Session target = entry.getKey();
    		if(!target.getId().equals(s.getId()) && target.isOpen() && s.getUserProperties().get("roomBNO").equals(target.getUserProperties().get("roomBNO"))) {
    			target.getBasicRemote().sendText(message);
    		}
        }
	}
    
    @OnError
    public void onError(Throwable t) {
    	t.printStackTrace();
    }
    
    @OnClose
	public void onClose(Session session) {
    	userList.remove(session);
    	System.out.println("현재 접속자: "+userList.size());
	}
}