<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h1>Файл налаштувань <code>web.xml</code></h1>
<p>
    Файл <code>web.xml</code> дозволяє доналаштувати веб-сервер (Tomcat або інші)
    під даний проєкт.
</p>
<h2>Фільтри та іх область дії</h2>
<p>
    Для фільтрів <code>web.xml</code> особливо важливий, оскільки гарантує порядок
    виконання фільтрів (якщо їх декілька). В області дії фільтрів поширеною є практика
    шаблонних адрес на кшталт <code>/*</code> <code>/api/*</code>
</p>
<pre>
&lt;!-- Реєстрація фільтрів -->
  &lt;filter>
    &lt;filter-name>charsetFilter&lt;/filter-name>
    &lt;filter-class>itstep.learning.filters.CharsetFilter&lt;/filter-class>
  &lt;/filter>
  &lt;filter-mapping>
    &lt;filter-name>charsetFilter&lt;/filter-name>
    &lt;url-pattern>/*&lt;/url-pattern>
  &lt;/filter-mapping>
</pre>
<h2>Сервлети та маршрутизація</h2>
<p>
    До появи анотацій на кшталт <code>@WebServlet</code> сервлети реєструвались
    у файлі <code>web.xml</code> із зазначенням їх маршрутів (роутингу).
</p>
<pre>
  &lt;servlet>
    &lt;servlet-name>webXmlServlet&lt;/servlet-name>
    &lt;servlet-class>itstep.learning.servlets.WebXmlServlet&lt;/servlet-class>
  &lt;!-- webXmlServlet = new itstep.learning.servlets.WebXmlServlet() -->
  &lt;/servlet>
    &lt;!-- Та їх маршрутизація (mapping) -->
  &lt;servlet-mapping>
    &lt;servlet-name>webXmlServlet&lt;/servlet-name>
    &lt;url-pattern>/web-xml&lt;/url-pattern>
  &lt;/servlet-mapping>
</pre>
<h2>Сторінки помилок</h2>
<p>
    у <code>web.xml</code> можна закласти адреси для всіх типів помилок:
    як за кодом помилки, так і за типом винятку, що трапляється при обробці
</p>
<pre>
    &lt;error-page>
        &lt;error-code>404&lt/error-code>
        &lt;location>/WEB-INF/views/_layout.jsp&lt/location>
    &lt;/error-page>
</pre>
