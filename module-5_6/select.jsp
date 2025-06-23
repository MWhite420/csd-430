<%@ page import="java.util.*, bean.StateBean" %>
<jsp:useBean id="bean" class="bean.StateBean" scope="page" />
<html>
<head>
    <title>Select State</title>
</head>
<body>
    <h2>Select a State ID</h2>
    <form action="display.jsp" method="post">
        <select name="state_id">
            <%
                try {
                    List<Integer> ids = bean.getAllStateIds();
                    for (Integer id : ids) {
            %>
                        <option value="<%= id %>"><%= id %></option>
            <%
                    }
                } catch (Exception e) {
            %>
                    <option>Error: <%= e.getMessage() %></option>
            <%
                    e.printStackTrace(); // logs to Tomcat console
                }
            %>
        </select>
        <input type="submit" value="View State">
    </form>
</body>
</html>
