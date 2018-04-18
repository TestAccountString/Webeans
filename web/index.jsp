<%@ page import="com.ifm.azubi.coffeemat.v2.Button"%>
<%@ page import="com.ifm.azubi.coffeemat.v2.Ingredient" %>
<%@ page import="com.ifm.azubi.coffeemat.v2.Machine" %>
<%
    Machine machine = new Machine();
    String buttonParam = request.getParameter("button");
    String display = machine.getDisplay().getMessage();
    String waterContainment = request.getParameter("wasserBehaelter");
    String beanContainment  = request.getParameter("bohnenBehaelter");
    String url_var = "drawable/coffeecup_empty.png";
    machine.getWaterContainment().setAmount(585);
    Cookie waterAmount = new Cookie("waterAmount", Integer.toString(machine.getWaterContainment().getAmount()));

  //  while(waterAmount != null) {
        if (buttonParam != null && Integer.parseInt(buttonParam) != 3 && Integer.parseInt(buttonParam) != 4) {
            int buttonId = Integer.parseInt(buttonParam);
            Button button = new Button(machine, buttonId);
            if (machine.checkRequirements(machine.getRecipesToButton().get(button.getButtonId()))) {
                machine.pressed(button);
            } else {

            }
      // }
    }
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
    <form action ="index.jsp" method="get" name ="water">
    <div id="wasserBehaelter" style="display: inline; width: 49%; float: left;">Wasserbeh&auml;lter: <%=machine.getWaterContainment().getAmount()+""+Ingredient.Unit.MILLI_LITRE%>
        <div style="background-color: #1ca3ec; display:inline; width: 500px">&nbsp</div>
    </div>
    </form>
    <form action ="index.jsp" method="get" name ="bohnenBehaelter">
   <div id="bohnenBehaelter" style="display:inline">Bohnenbeh&auml;lter: <%=machine.getBeanContainment().getAmount()+""+Ingredient.Unit.GRAM%></div>
   <div style="background-color: #412c1b ; display:inline; width: 500px">&nbsp</div>
    </form>
</div>

<form action="index.jsp" method="get">
        <img id="gefaess" src="<%=url_var%>" style="display: inline; width: 300px;float:left;"/>
    </form>
     <div style="clear:both; display:inline-block">
       <form name="buttons" action="index.jsp" method="get">
         <textarea style="width: 293px; height:86px; overflow: -moz-scrollbars-vertical;float:right" placeholder="Coffeemat 3.0"><%=display%></textarea>
          <div id="knoepfe">
            <input type="submit" name="button" value="1"     id="knopfKleinerKaffee"     class="knopfGroesse">Klein</input>
            <input type="submit" name="button" value="2"     id="knopfGrosserKaffee"     class="knopfGroesse">Gro&szlig;</input>
            <input type="submit" name="button" value="3"     id="knopfHeissesWasser"     class="knopfGroesse">Wasser</input>
            <input type="submit" name="button" value="4"     id="knopfStatus"            class="knopfGroesse">Status</input>
            <input type="submit" name="button" value="5" id="bohnenFuellenButton"        c lass="knopfGroesse">Bohnenbeh&auml;lter f&uuml;llen</input>
          </div>
       </form>
    </div>
<div id="resteBehaelter" style="clear:both"><%=machine.getBeanContainment().getAmount()%></div>
 <%=buttonParam%>
</body>
</html>