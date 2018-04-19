<%@ page import="com.ifm.azubi.coffeemat.v2.Ingredient" %>
<%@ page import="com.ifm.azubi.coffeemat.v2.Machine" %>
<%@ page import="com.ifm.azubi.coffeemat.v2.PersistentData" %>
<%
    Machine machine = new Machine();
    PersistentData.load();
    String buttonParam = request.getParameter("button");
    String display = machine.getDisplay().getMessage();
    String waterContainment = request.getParameter("wasserBehaelter");
    String beanContainment = request.getParameter("bohnenBehaelter");
    String url_var = "drawable/coffeecup_empty.png";


    if (buttonParam != null) {
        switch (Integer.parseInt(buttonParam)) {
            case 1:
                machine.getSmallCoffeeButton().press();
                url_var = "drawable/fillingMug.gif";
                break;
            case 2:
                machine.getLargeCoffeeButton().press();
                url_var = "drawable/coffeecup_full.png";
                break;
            case 3:
                machine.getWarmWaterButton().press();
                url_var = "drawable/waterCup_full.png";
                break;
            case 4:
                machine.status();
                url_var = "drawable/c64.gif";
                break;
            case 5:
                //int fillArea = getPara;
                PersistentData.setBeanAmount(machine.getBeanContainment().give(400));
                break;
            case 6:
                PersistentData.setWaterAmount(machine.getWaterContainment().give(600));
                break;
            default:
                break;
        }
    }
    PersistentData.save();
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
    <form action="index.jsp" method="get" name="water">
        <div id="wasserBehaelter" style="display: inline; width: 49%; float: left;">
            Wasserbeh&auml;lter: <%=machine.getWaterContainment().getAmount() + "" +
                Ingredient.Unit.MILLI_LITRE%>
            <div style="background-color: #1ca3ec; display:inline-block; width: 500px">&nbsp</div>
            <br>
        </div>
    </form>
    <form action="index.jsp" method="get" name="bohnenBehaelter">
        <div id="bohnenBehaelter" style="display:inline">
            Bohnenbeh&auml;lter: <%=machine.getBeanContainment().getAmount() + "" + Ingredient.Unit.GRAM%>
            <div style="background-color: #412c1b ; display:inline-block; width: 500px">&nbsp</div>
        </div>
    </form>
</div>
<form action="index.jsp" method="get">
    <img id="gefaess" src="<%=url_var%>" style="display: inline; width: 300px;float:left;"/>
</form>
<div style="clear:both; display:inline-block">
    <form name="buttons" action="index.jsp" method="get">
        <div style=" width: 415px ;">
            <textarea style="float:right ;width: 49%; height:100px; overflow: hidden"
                      placeholder=" – Coffeemat – " name="wasser"><%=display%></textarea>
            <textarea name="bohnen" style="float: right; width: 49%; height:100px"
                      placeholder="Füllwert angeben"></textarea></div>
        <div id="knoepfe"><br>
            <input type="submit" name="button" value="1" id="knopfKleinerKaffee"
                   class="knopfGroesse ">Klein</input><br>
            <input type="submit" name="button" value="2" id="knopfGrosserKaffee"
                   class="knopfGroesse ">Gro&szlig;</input><br>
            <input type="submit" name="button" value="3" id="knopfHeissesWasser"
                   class="knopfGroesse ">Wasser</input><br>
            <input type="submit" name="button" value="4" id="knopfStatus"
                   class="knopfGroesse">Status</input><br>
            <input type="submit" name="button" value="5" id="bohnenFuellenButton"
                   class="knopfGroesse">Bohnenbeh&auml;lter
            f&uuml;llen</input><br>
            <input type="submit" name="button" value="6" id="wasserFuellenButton"
                   class="knopfGroesse">Wasserbeh&auml;lter
            f&uuml;llen</input>
        </div>
    </form>
</div>
<div id="resteBehaelter" style="clear:both"><%=machine.getBeanContainment().getAmount()%>
</div>
<%=buttonParam%>
</body>
</html>