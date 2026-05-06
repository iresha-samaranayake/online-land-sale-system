<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Land History</title></head>
<body>
<h2>My Land History</h2>
<table border="1">
    <tr><th>Title</th><th>Status</th><th>Created Date</th></tr>
    <c:forEach items="${history}" var="land">
        <tr>
            <td>${land.title}</td>
            <td>${land.status}</td>
            <td>${com.landselling.Online_land_sales_portal.Util.DateUtil.formatDateTime(land.createdAt)}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>