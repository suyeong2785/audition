<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class=" py-4">
	<div class="foo_div1 text-center ">
		<p class="text-base font-bold">Copyright(c) 2021 DLS co.,ltd</p>
		<p class="text-base ">All rights reserved.</p>
	</div>
</div>

</div>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script>
	var loginedMemberName = '<c:out value="${loginedMember.name}"/>';

	var stompClient = null;

	function connect(username) {
		var socket = new SockJS('/hello');
		stompClient = Stomp.over(socket);
		stompClient.connect({
			username : username,
		}, function() {
			console.log('Web Socket is connected');
			stompClient.subscribe('/users/queue/messages', function(message) {
				$("#message").text(message.body);
			});
		});
	}

</script>

</body>
</html>