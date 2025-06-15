<%-- 
Mark White 
CSD430 
Assignment 2 - JSP to display JavaBean data 
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="bean.MovieFact" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Favorite Movie</title>
    <link rel="stylesheet" type="text/css" href="MyStyle.css">
    <style>
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #444;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #ccc;
        }
        h1, .caption {
            text-align: center;
        }
    </style>
</head>
<body>
    <h1>Inception: Movie Overview</h1>
    <p class="caption">This page highlights key facts about the movie <em>Inception</em></p>

    <%
        // List to hold MovieFact JavaBean objects
        ArrayList<MovieFact> facts = new ArrayList<MovieFact>();

        // Creating and adding facts using the MovieFact JavaBean
        facts.add(new MovieFact("Director", "Who directed the movie?", "Christopher Nolan"));
        facts.add(new MovieFact("Release Date", "When was the movie released?", "July 13, 2010"));
        facts.add(new MovieFact("Genre", "Movie's primary genre", "Science Fiction, Thriller"));
        facts.add(new MovieFact("Lead Actor", "Main character role", "Leonardo DiCaprio as Dom Cobb"));
        facts.add(new MovieFact("Notable Feature", "Unique aspect of the film", "Dream within a dream concept"));
        facts.add(new MovieFact("Duration", "Length of the film", "148 minutes, or 2hr 28m"));
    %>

    <!-- Display the movie facts in a formatted HTML table -->
    <table>
        <tr>
            <th>Category</th>
            <th>Description</th>
            <th>Detail</th>
        </tr>
        <%
            for (MovieFact fact : facts) {
        %>
        <tr>
            <td><%= fact.getCategory() %></td>
            <td><%= fact.getDescription() %></td>
            <td><%= fact.getDetail() %></td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>