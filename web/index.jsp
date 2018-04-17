<%@ page import="javax.servlet.http.Cookie" %>
<%
    String buttonParam = request.getParameter("button");
    String display = "";
    String url_var = "drawable/coffeecup_empty.png";
    if (buttonParam != null && buttonParam != "Status" && buttonParam != "Wasser") {
        url_var = "drawable/coffeecup_full.png";
    } else if (buttonParam == "Wasser") {
        url_var = "drawable/waterCup_full.png";
    }

    display = buttonParam;
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Skizze</title>
    <link rel="stylesheet" type="text/css" href="stylesheet.css">
</head>

<body>
<div id="oben">
    <div id="wasserBehaelter" style="display: inline; width: 49%; float: left;">Wasserbeh&auml;lter: 2450ml
        <div style="background-color: #1ca3ec; display:inline; width: 500px">&nbsp</div>
    </div>
   <div id="bohnenBehaelter" style="display:inline">Bohnenbeh&auml;lter: 860g</div>
   <div style="background-color: #412c1b ; display:inline; width: 500px">&nbsp</div>
</div>
    <form action="index.jsp" method="get">
        <img id="gefaess" src="<%=url_var%>" style="display: inline; width: 300px;float:left;"/>
    </form>
 <div style="clear:both; display:inline-block">
       <form name="buttons" action="index.jsp" method="get">
         <textarea name="display" style="overflow: -moz-scrollbars-vertical;float:right" placeholder="Coffeemat 3.0">
               <%=display%>
         </textarea>
          <div id="knoepfe">
            <input type="submit" name="button" value="Klein"      id="knopfKleinerKaffee"     class="knopfGroesse">Klein</input>
            <input type="submit" name="button" value="Gro&szlig;" id="knopfGrosserKaffee"     class="knopfGroesse">Gro&szlig;</input>
            <input type="submit" name="button" value="Wasser"     id="knopfHeissesWasser"     class="knopfGroesse">Wasser</input>
            <input type="submit" name="button" value="Status"     id="knopfStatus"            class="knopfGroesse">Status</input>
          </div>
       </form>
    </div>
 </div>
<div id="resteBehaelter" style="clear:both">40g</div>
 <%=buttonParam%>
</body>
</html>