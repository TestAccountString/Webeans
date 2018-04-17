<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="javax.swing.text.html.HTMLDocument" %>
<%
    String adressat = "world";
    String test = "Info";
    String newSession = "Session ID: " + session.getId();
   //String button = request.getParameter("htmlButtonName");
    final Map<String, String> cookies = new HashMap();

    //<editor-fold>
    Cookie[] cookieArray = request.getCookies();
    for (int j = 0; j < 300; j++) {
        cookies.put(Integer.toString(j), Integer.toString(j));
        Cookie cookies2 = new Cookie(Integer.toString(j), Integer.toString(j));
        response.addCookie(cookies2);
    }
    if (request.getParameter("adressat") != null) {
        adressat = request.getParameter("adressat");
        Cookie adressatCookie = new Cookie("adressat", adressat); // Speichert im Browser (hält bis Löschung oder CookieTimeout)
        response.addCookie(adressatCookie);
    } else if (cookies.containsKey("adressat")) {
        adressat = cookies.get("adressat");
    }

    //</editor-fold>
    //<editor-fold>
    if (session.isNew()) {
        newSession = newSession + " <- I am a new session! ";
    }
    test = Long.toString(session.getCreationTime()) + " - Last time accessed: " + session.getLastAccessedTime();
    session.setAttribute("adressat", adressat); // Speichert im Session-Storage (hält bis Neustart oder SessionTimeout)
    //</editor-fold>
    final String greeting = "Hello " + adressat + ", here I am!";
    final String recentSession = "This was my last session: " + test + " - Impressive?";

%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>${param.adressat}</title> <!-- Expression-Language -->
</head>
<body>
<!-- response.getWriter().write(greeting); -->

<%=greeting%><br>
<%=recentSession%><br>
<%=newSession%><br>
<form name="buttonForm" action="test.jsp" method="get">
    <input type="submit" value="ClickyButtonV1" name="htmlButtonName">Clicky1</input>
    <input type="submit" value="ClickyButtonV2" name="htmlButtonName">Clicky2</input>
</form>
</body>
</html>