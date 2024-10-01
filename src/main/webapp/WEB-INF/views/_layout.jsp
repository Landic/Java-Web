<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String pageBody = (String)request.getAttribute("body");
    if(pageBody == null){
        pageBody = "not_found.jsp";
    }
    String contextPath = request.getContextPath();
%>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/css/site.css">
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo03" aria-controls="navbarTogglerDemo03" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <a class="navbar-brand" href="<%=contextPath%>/">Java Web</a>
        <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link <%= "home.jsp".equals(pageBody) ? "active" : "" %>" aria-current="page" href="<%=contextPath%>/">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <%= "web_xml.jsp".equals(pageBody) ? "active" : "" %>" href="<%=contextPath%>/web-xml">WebXml</a>
                </li>
            </ul>
            <form class="d-flex" role="search">
                <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success" type="submit">Search</button>
            </form>
        </div>
    </div>
</nav>
<main class="container">
    <jsp:include page='<%=pageBody %>'/>
</main>
<div class="spacer"></div>
    <footer class="bg-body-tertiary px-3 py-2">&copy; 2024, ITSTEP KN-P-213</footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="<%=contextPath%>/js/site.js"></script>
</body>
</html>
