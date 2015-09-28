package main;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

@ServerEndpoint("/")

public class ChatServer {
private static final Set<Session> sessions = Collections.synchronizedSet(new HashSet<Session>());

    @OnOpen
    public void onOpen(Session usersSession) {
        sessions.add(usersSession);
    }

    @OnClose
    public void onClose(Session usersSession) {
        sessions.remove(usersSession);
    }

    @OnMessage
    public void onMessage (String message, Session usersSession) throws IOException, EncodeException{
        //usersSession.getBasicRemote().sendText("only my message "+message);
        for (Session peer : sessions){
            peer.getBasicRemote().sendText("public message "+ message);
        }
    }

    @OnError
    public void onError(Throwable t) {
        t.printStackTrace();
    }

}
