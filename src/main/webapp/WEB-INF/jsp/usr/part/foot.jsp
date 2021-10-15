<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class=" py-4">
	<div class="foo_div1 text-center ">
		<p class="text-base font-bold">Copyright(c) 2021 (주)호전 인터네셔널
			co.,ltd</p>
		<p class="text-base ">All rights reserved.</p>
	</div>
</div>
</div>

<c:if test="${activeProfile == 'production'}">
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async
		src="https://www.googletagmanager.com/gtag/js?id=UA-179726983-1"></script>
	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag() {
			dataLayer.push(arguments);
		}
		gtag('js', new Date());

		gtag('config', 'UA-179726983-1');
	</script>
</c:if>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
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
				if ($('.toast')) {
					window.toastr.remove();
				}
				
				$("#alarm").focus();

				var msg = "해당배역에 대한 알림이왔습니다.";
				
				var targetName = "alarm";
				var targetType = "id";
				var toastr = setPositionOfAlarm(targetType,targetName,msg);
				
			});
		});
	}
	
</script>

</body>
</html>
