<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="com.google.gson.*" %>
<%@ page import="java.util.*" %>
<style>
  body {
    font-family: Arial, sans-serif;
  }
  .success {
    color: green;
  }
  .error {
    color: red;
  }
  table {
    width: 100%;
    border-collapse: collapse;
  }
  th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
  }
  th {
    background-color: #f2f2f2;
  }
</style>


<h1>API Testing for /auth</h1>
<h1>API Testing for /auth</h1>
<table>
  <thead>
  <tr>
    <th>Request</th>
    <th>Response</th>
  </tr>
  </thead>
  <tbody>
  <%
    Gson gson = new Gson();
    String[] testCases = {
            "GET /auth",
            "GET /auth?username=234&password=123",
            "GET /auth?username=234&password=wrong",
            "GET /auth?username=234&password=123"
    };

    for (String testCase : testCases) {
      String responseMessage = "";
      try {
        URL url = new URL("http://localhost:8080/MyProject/auth" + (testCase.contains("?") ? testCase.substring(testCase.indexOf("?")) : ""));
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        if (testCase.contains("username=234&password=123")) {
          conn.setRequestProperty("Authorization", "Basic " + Base64.getEncoder().encodeToString("234:123".getBytes()));
        } else if (testCase.contains("username=234&password=wrong")) {
          conn.setRequestProperty("Authorization", "Basic " + Base64.getEncoder().encodeToString("234:wrong".getBytes()));
        } else {
          conn.setRequestProperty("Authorization", ""); // Без заголовка
        }

        int responseCode = conn.getResponseCode();
        InputStream inputStream = (responseCode == 200) ? conn.getInputStream() : conn.getErrorStream();
        BufferedReader in = new BufferedReader(new InputStreamReader(inputStream));
        StringBuilder responseBuilder = new StringBuilder();
        String line;

        while ((line = in.readLine()) != null) {
          responseBuilder.append(line);
        }
        in.close();
        responseMessage = responseBuilder.toString();
      } catch (Exception e) {
        responseMessage = "Error: " + e.getMessage();
      }

      JsonObject jsonResponse = gson.fromJson(responseMessage, JsonObject.class);
      String status = jsonResponse.has("status") ? jsonResponse.get("status").getAsString() : "";
      String responseClass = status.equals("success") ? "success" : "error";

  %>
  <tr>
    <td><%= testCase %></td>
    <td class="<%= responseClass %>"><%= responseMessage %></td>
  </tr>
  <%
    }
  %>
  </tbody>
</table>