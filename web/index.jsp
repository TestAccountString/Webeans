<%@ page import="com.ifm.azubi.coffeemat.v2.Ingredient" %>
<%@ page import="com.ifm.azubi.coffeemat.v2.Machine" %>
<%@ page import="com.ifm.azubi.coffeemat.v2.PersistentData" %>
<%
    PersistentData.load();
    // PersistentData.setWaterAmount(0);
    PersistentData.save();
    Machine machine = new Machine();
    String beanPercentage = Integer.toString((PersistentData.getBeanAmount() / PersistentData.getCapacityBean()) * 100) + "%";
    String waterPercentage = Integer.toString((PersistentData.getWaterAmount() / PersistentData.getCapacityWater()) * 100) + "%";
    String buttonParam = request.getParameter("button");
    String display = machine.getDisplay().getMessage();
    String waterContainment = request.getParameter("wasserBehaelter");
    String beanContainment = request.getParameter("bohnenBehaelter");
    String scrapBeansTogether = request.getParameter("fuellwertBeans");
    String scrapWaterTogether = request.getParameter("fuellwertWater");
    String url_var = "drawable/coffeecup_empty.png";
    if (buttonParam == null) {
        buttonParam = "8";
    }
    switch (Integer.parseInt(buttonParam)) {
        case 1:
            display = "Brewing small Coffee...";
            machine.getSmallCoffeeButton().press();
            url_var = "drawable/coffeecup_full.png";
            display = "Done - Enjoy your "
                    + machine.getRecipesToButton().get(1).getIngredients().get(0).getAmount() + " "
                    + machine.getRecipesToButton().get(1).getIngredients().get(0).getUnit() + " bean & "
                    + machine.getRecipesToButton().get(1).getIngredients().get(1).getAmount() + " "
                    + machine.getRecipesToButton().get(1).getIngredients().get(1).getUnit() + " water mixture.";
            break;
        case 2:
            machine.getLargeCoffeeButton().press();
            url_var = "drawable/coffeecup_full.png";
            display = "Done - Enjoy your "
                    + machine.getRecipesToButton().get(2).getIngredients().get(0).getAmount() + " "
                    + machine.getRecipesToButton().get(2).getIngredients().get(0).getUnit() + " "
                    + machine.getRecipesToButton().get(2).getIngredients().get(0).getType() + " "
                    + machine.getRecipesToButton().get(2).getIngredients().get(1).getAmount() + " "
                    + machine.getRecipesToButton().get(2).getIngredients().get(1).getUnit() + " water mixture.";
            break;
        case 3:
            machine.getWarmWaterButton().press();
            url_var = "drawable/waterCup_full.png";
            display = "Done Enjoy your "
                    + machine.getRecipesToButton().get(3).getIngredients().get(0).getAmount() + " "
                    + machine.getRecipesToButton().get(3).getIngredients().get(0).getUnit() + " "
                    + machine.getRecipesToButton().get(3).getIngredients().get(0).getType();
            break;
        case 4:
            machine.status();
            display = machine.getDisplay().getMessage();
            url_var = "drawable/c64.gif";
            break;
        case 5:
            try {
                if (PersistentData.getBeanAmount() < PersistentData.getCapacityBean()) {
                    PersistentData.setBeanAmount(PersistentData.getBeanAmount() + Integer.parseInt(scrapBeansTogether));
                }
            } catch (NumberFormatException nfe) {
                nfe.getMessage();
            }
            break;

        case 6:
            try {
                if (PersistentData.getWaterAmount() < PersistentData.getCapacityWater()) {
                    PersistentData.setWaterAmount(PersistentData.getWaterAmount() + Integer.parseInt(scrapWaterTogether));
                }
            } catch (NumberFormatException nfe) {
                nfe.getMessage();
            }
            break;
        case 7:
            machine.getShutdownButton().press();
        default:
            break;
    }
    machine.checkCapacities(true);
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
    <form action="index.jsp" method="get" name="bohnenBehaelter">
        <div id="wasserBehaelter" style="display:inline">
            Wasserbehälter:<%=PersistentData.getWaterAmount()%> <%=Ingredient.Unit.MILLI_LITRE%>
            <div style="width: 500px; background-color: white; border: 1px groove lightslategray">
                <progress class="barWidth" value="<%=PersistentData.getWaterAmount()%>" max="<%=PersistentData.getCapacityWater()%>"></progress>
            </div>
        </div>
    </form>
    <form action="index.jsp" method="get" name="bohnenBehaelter">
        <div id="bohnenBehaelter" style="display:inline;">
            Bohnenbehälter:<%=PersistentData.getBeanAmount()%> <%=Ingredient.Unit.GRAM%>
            <div style="width: 500px; background-color: white; border: 1px dashed lightslategray">
                <progress class="barWidth" value="<%=PersistentData.getBeanAmount()%>" max="<%=PersistentData.getCapacityBean()%>"></progress>
            </div>
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
            <textarea name="fuellwertBeans" style="float: right; width: 49%; height:100px"
                      placeholder="Bohnen F&uuml;llwert angeben"></textarea>
            <textarea name="fuellwertWater" style="float: right; width: 49%; height:100px"
                      placeholder="Wasser F&uuml;llwert angeben"></textarea>
        </div>
        <div id="knoepfe"><br>
            <input type="submit" name="button" value="1" id="knopfKleinerKaffee" class="knopfGroesse ">Klein</input><br>
            <input type="submit" name="button" value="2" id="knopfGrosserKaffee"
                   class="knopfGroesse ">Gro&szlig;</input><br>
            <input type="submit" name="button" value="3" id="knopfHeissesWasser" class="knopfGroesse ">Wasser</input>
            <br>
            <input type="submit" name="button" value="4" id="knopfStatus" class="knopfGroesse">Status</input><br>
            <input type="submit" name="button" value="5" id="bohnenFuellenButton" class="knopfGroesse">Bohnenbeh&auml;lter
            f&uuml;llen</input>
            <input type="submit" name="button" value="6" id="wasserFuellenButton" class="knopfGroesse">Wasserbeh&auml;lter
            f&uuml;llen</input>
            <input type="submit" name="button" value="7" id="shutdownButton" class="knopfGroesse">Shutdown</input>
        </div>
    </form>
</div>
<div id="resteBehaelter" style="clear:both"><%=PersistentData.getBeanAmount()%>
</div>
</body>
</html>