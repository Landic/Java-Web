<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h1>Java web. JSP</h1>
<img src="img/Java_Logo%202.png" alt="logo" width="100"/>

<p>
    JSP - Java Server Pages - технологія веб-розробки з динамічним формуванням
    HTML сторінок. Аналогічно до PHP, ранніх ASP є надбудовою над HTML, що розширює його
    додаючи
</p>
<ul>
    <li>Вирази</li>
    <li>Змінні</li>
    <li>Алгоритмічні конструкції (умови, цикли)</li>
    <li>Взаємодію з іншими файлами-сторінками</li>
</ul>
<p>
    Основу JSP складають спеціалізовані теги &lt;% %> та &lt;%= %> <br/>
    Тег &lt;% %> включаэ в себе Java-код, тег &lt;%= %> виводить результат
    (є скороченою формою оператора <code>print()</code>).
</p>
<h2>Вирази</h2>
<p>
    Вирази частіше все задаються тегом, що виводить, у якому може бути
    довільний вираз (коректний для Java). Виведення результату здійснюється
    у тому місці, де знаходиться тег: <br/>
    &lt;%= %&gt; = <%= 2 + 3%>
</p>
<h2>Змінні</h2>
<p>
    Змінні, їх оголошення та призначення (без виведення результату)
    оформлюється у блоці &lt;% %&gt;
    <%
        String str = "Hello, World!";
        double[] prices = {10.0,20.0,30.0,40.0};
    %>
</p>
<pre>
        &lt;
            String str = "Hello, World!";
            double[] prices = {10.0,20.0,30.0,40.0};
        %&gt;
</pre>
<p>
    Виведення значень змінних - знов тег <br/>
    &lt;%= str%&gt; &rarr; <%= str %>
</p>
<h2>Алгоритмічні конструкції</h2>
<% for(int i = 0; i < prices.length; i++){%>
<i><%= prices[i] %></i>&emsp;
<%}%>
<pre>
    &lt;% for (int i = 0; i < prices.length; i++)
    { %&gt;
        &lt;i&gt&lt;%= prices[i] %&gt;&lt;/i&amp;
    &lt;% } %&gt;
</pre>
<h2>Взаємодія з файлами</h2>
&lt;jsp:include page="WEB-INF/fragment.jsp"/&gt;
<jsp:include page="../fragment.jsp"/>

<h2>HW 01.10</h2>
<table style="border: 1px solid black; border-collapse: collapse; text-align: center;" width="200">
    <% for(int i = 0; i < prices.length; i++){%>
        <tr>
            <td style="border: 1px solid black; border-collapse: collapse;"><%=i+1%></td>
            <td style="border: 1px solid black; border-collapse: collapse;"><%= prices[i] %></td>
        </tr>
    <%}%>
</table>