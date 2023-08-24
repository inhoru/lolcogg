package gg.lolco.common.websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import gg.lolco.model.service.MemberService;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class ChattingServer extends TextWebSocketHandler {
	private final ObjectMapper mapper;
	private final MemberService service;
	private final Map<String, WebSocketSession> clients;
	
	public ChattingServer(ObjectMapper mapper, MemberService service) {
		this.mapper = mapper;
		this.service = service;
		clients = new HashMap<>();
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		clients.put(session.getId(), session);
		log.info("One user has entered the chatroom.");
		log.info("[{} users participating now]", clients.size());
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("Message: " + message.getPayload());
		final ChatMessage chatMessage = mapper.readValue(message.getPayload(), ChatMessage.class);
		
		switch(chatMessage.getType()) {
			case ENTER:
				addSessionInfo(session, chatMessage);
				updateChatroom(String.valueOf(clients.size()), chatMessage.getSenderNickname() + "님이 입장하셨습니다.");
				break;
				
			case MSG: 
				sendToAll(chatMessage);
				break;
				
			case SHOUT:
				sendToAll(chatMessage);
				break;
				
			case PROHIBIT:
				prohibit(chatMessage);
				break;
				
			case BAN:
				ban(chatMessage);
				break;
				
			default:
				break;
		}	
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		clients.remove(session.getId());
		String notification = String.valueOf(session.getAttributes().get("nickname"));
		
		if ((Boolean) session.getAttributes().get("isBanned")) {
			log.info("One user has been banned from the chatroom.");
			log.info("[{} users participating now]", clients.size());
			service.ban(String.valueOf(session.getAttributes().get("nickname")));
			notification += "님이 강퇴되었습니다.";
		} else {
			log.info("One user has left the chatroom.");
			log.info("[{} users participating now]", clients.size());
			notification += "님이 퇴장하셨습니다.";
		}
		
		updateChatroom(String.valueOf(clients.size()), notification);
	}
	
	private void addSessionInfo(WebSocketSession session, ChatMessage chatMessage) {
		session.getAttributes().put("nickname", chatMessage.getSenderNickname());
		session.getAttributes().put("isBanned", chatMessage.isBanned());
	}
	
	private void updateChatroom(String userCount, String notification) {
		sendToOne("관리자", generateChatMessage(MessageTypes.ADMIN, null, null, getNicknames()));
		sendToAll(generateChatMessage(MessageTypes.COUNT, null, null, userCount));
		sendToAll(generateChatMessage(MessageTypes.NOTIFICATION, null, null, notification));
	}
	
	private String getNicknames() {
		return clients.values()
						.stream()
						.map(client -> String.valueOf(client.getAttributes().get("nickname")))
						.collect(Collectors.joining(","));
	}
	
	private void sendToAll(ChatMessage chattingMessage) {
		try {
			for (Map.Entry<String, WebSocketSession> client : clients.entrySet()) {
				send(client.getValue(), chattingMessage);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void sendToOne(String receiver, ChatMessage chatMessage) {
		try {
			for (Map.Entry<String, WebSocketSession> client : clients.entrySet()) {
				if(isSameReceiver(client.getValue(), receiver)) {
					send(client.getValue(), chatMessage);
					break;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private void send(WebSocketSession session, ChatMessage chattingMessage) throws IOException {
		session.sendMessage(new TextMessage(mapper.writeValueAsString(chattingMessage)));
	}
	
	private void prohibit(ChatMessage chatMessage) {
		sendToOne(chatMessage.getReceiverNickname(), chatMessage);
		sendToAll(generateChatMessage(MessageTypes.NOTIFICATION, null, null, chatMessage.getReceiverNickname() + "님이 30초 동안 채팅 금지되었습니다."));
	}
	
	private void ban(ChatMessage chatMessage) throws IOException {
		WebSocketSession target = clients.values().stream()
													.filter(client -> isSameReceiver(client, chatMessage.getReceiverNickname()))
													.findAny()
													.orElse(null);
		
		if (target != null) {
			target.getAttributes().put("isBanned", chatMessage.isBanned());
			sendToOne(chatMessage.getReceiverNickname(), chatMessage);
			target.close();
		}
	}
	
	private boolean isSameReceiver(WebSocketSession session, String receiver) {
		return String.valueOf(session.getAttributes().get("nickname")).equals(receiver);
	}
	
	private ChatMessage generateChatMessage(MessageTypes type, String sender, 
											String receiver, String content) 
	{
		return ChatMessage.builder()
							.type(type)
							.senderNickname(sender)
							.receiverNickname(receiver)
							.content(content)
							.build();
	}
	
}
