<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Feedback Submitted</title>
	<style>
		table {
			border-collapse: collapse;
            width: 70%;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
        }
        th {
            background-color: #f2f2f2;
        }
	</style>
</head>
<body>
<%-- Feedback Results Page --%>
<h2>Thank you for your feedback!</h2>
<p> Below is the results of your submitted feedback:</p>

<%
	String name = request.getParameter("name");
	String email = request.getParameter("email");
    String visitDate = request.getParameter("visitDate");
    String rating = request.getParameter("rating");
    String comments = request.getParameter("comments");
%>
<table>
	<tr>
		<th>Customer Information</th>
	</tr>
	<tr>
		<td>Name: <%= name %></td>
		
	</tr>
	<tr>
		<td>Email: <%= email %></td>
	</tr>
	<tr>
        <td>Date of Visit: <%= visitDate %></td>
    </tr>
    <tr>
        <td>Rating: <%= rating %></td>
    </tr>
    <tr>
        <td>Additional comments or suggestions: <%= comments %></td>
    </tr>
</table>

</body>
</html>