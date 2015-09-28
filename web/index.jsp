<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html>
<head>
    <title>Chat</title>
    <meta charset="UTF-8">
</head>

<body>

<form>
    <input type="text" name="input" id="textMessage">
    <input type="button" value="Send" onclick="send(textMessage.value)">
    <input type="button" value="Disconnect" onclick="onClose()">
</form>

<textarea rows="30" cols="150" id="messagesTextArea" readonly></textarea>

<textarea style="color: darkblue; background-color: whitesmoke; font-weight: bold"
          rows="3" cols="150" id="infoArea" readonly>
</textarea>

<script type="text/javascript" language="javascript">
    var messagesTextArea = document.getElementById("messagesTextArea");
    var infoArea = document.getElementById("infoArea");
    var textMessage = document.getElementById("textMessage");
    var wsUri = "ws://" + window.location.host + "/FinalProject_war_exploded/";
    var output;

    function init() {
        websocket = new WebSocket(wsUri);
        testWebSocket(websocket);
    }

    function testWebSocket(websocket) {

        websocket.onopen = function (evt) {
            onOpen(evt)
        };
        websocket.onclose = function (evt) {
            onClose(evt)
        };
        websocket.onmessage = function (evt) {
            onMessage(evt)
        };
        websocket.onerror = function (evt) {
            onError(evt)
        };
    }

    function onOpen(evt) {
        writeInfoToScreen("Connected to " + wsUri);
    }

    function onClose(evt) {
        websocket.close();
        writeInfoToScreen("Disconnected");
    }

    function onMessage(evt) {
        messagesTextArea.value += "RESPONSE: " + evt.data + "\n";
    }

    function onError(evt) {
        writeInfoToScreen("ERROR: " + evt.data);
    }

    function send(message) {
        if (websocket.readyState === websocket.OPEN) {
            websocket.send(message);
            messagesTextArea.value += "SENT: " + message + "\n";
            textMessage.value = "";
        } else {
            writeInfoToScreen("You are not connected to the server");
        }
    }

    function writeInfoToScreen(message) {
        infoArea.value = message;
    }

    window.addEventListener("load", init, false);

</script>
<div id="output"></div>

</body>
</html>