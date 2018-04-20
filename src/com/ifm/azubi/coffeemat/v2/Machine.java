package com.ifm.azubi.coffeemat.v2;

//<editor-fold desc="Imports">

import java.util.HashMap;
import java.util.Map;

import static com.ifm.azubi.coffeemat.v2.Ingredient.IngredientType.BEANS;
import static com.ifm.azubi.coffeemat.v2.Ingredient.IngredientType.WATER;
import static com.ifm.azubi.coffeemat.v2.Ingredient.Unit.GRAM;
import static com.ifm.azubi.coffeemat.v2.Ingredient.Unit.MILLILITRE;
import static com.ifm.azubi.coffeemat.v2.PersistentData.getBeanAmount;
//</editor-fold>

public class Machine {
    private Display display = new Display();

    private Map<Integer, Recipe> recipesToButton = new HashMap<>();

    private Button smallCoffeeButton = new Button(this, 1);
    private Button largeCoffeeButton = new Button(this, 2);
    private Button warmWaterButton = new Button(this, 3);
    private Button shutdownButton = new Button(this, 6);

    private Containment beanContainment = new Containment(getBeanAmount());
    private Containment waterContainment = new Containment(PersistentData.getWaterAmount());

    public Machine() {
        PersistentData.load();
        PersistentData.setCapacityBean(1000);
        PersistentData.setCapacityWater(3000);

        Recipe smallCoffee = new Recipe("SmallCoffee");
        smallCoffee.addIngredient(new Ingredient(BEANS, GRAM, 10));
        smallCoffee.addIngredient(new Ingredient(WATER, MILLILITRE, 200));
        recipesToButton.put(1, smallCoffee);

        Recipe largeCoffee = new Recipe("LargeCoffee");
        largeCoffee.addIngredient(new Ingredient(BEANS, GRAM, 20));
        largeCoffee.addIngredient(new Ingredient(WATER, MILLILITRE, 300));
        recipesToButton.put(2, largeCoffee);

        Recipe warmWater = new Recipe("WarmWater");
        warmWater.addIngredient(new Ingredient(WATER, MILLILITRE, 350));
        recipesToButton.put(3, warmWater);
    }

    public void pressed(Button button) {
        Recipe recipe = recipesToButton.get(button.getButtonId());
        if (recipe == null) {
            if (button.getButtonId() == 7) {
                shutdown();
            }
            throw new IllegalArgumentException("Ungültige ButtonID. ");
        }
        display.setMessage("Beans ->\t" + PersistentData.getBeanAmount());
        display.output();
        display.setMessage("Water ->\t" + PersistentData.getWaterAmount());
        display.output();

        if (checkRequirements(recipe)) {
            make(recipe);
        }
    }
    //<editor-fold desc="hasEnough's & checkRequirements">

    private boolean hasEnoughWater(int requiredAmount) {
        return (waterContainment.getAmount() >= requiredAmount);
    }

    private boolean hasEnoughBeans(int requiredAmount) {
        return (beanContainment.getAmount() >= requiredAmount);
    }

    public boolean checkRequirements(Recipe recipe) {
        for (Ingredient ingredient : recipe.getIngredients()) {
            if (ingredient.getType() == WATER) {
                if (!hasEnoughWater(ingredient.getAmount())) {
                    display.setMessage("Bitte Wasserbehälter füllen.");
                    display.output();
                    return false;
                }
            } else if (ingredient.getType() == BEANS) {
                if (!hasEnoughBeans(ingredient.getAmount())) {
                    display.setMessage("Bitte Bohnenbehälter füllen.");
                    display.output();
                    return false;
                }
            }
        }
        return true;
    }
    public void checkCapacities(boolean b) {
        if (b) {
            if (PersistentData.getBeanAmount() > PersistentData.getCapacityBean()) {
                PersistentData.setBeanAmount(PersistentData.getCapacityBean());
            }
            if (PersistentData.getWaterAmount() > PersistentData.getCapacityWater()) {
                PersistentData.setWaterAmount(PersistentData.getCapacityWater());
            }
        }
    }
    //</editor-fold">

    private void make(Recipe recipe) {
        for (Ingredient ingredient : recipe.getIngredients()) {
            if (ingredient.getType() == BEANS) {
                beanContainment.take(ingredient.getAmount());
            } else if (ingredient.getType() == WATER) {
                if (hasEnoughWater(ingredient.getAmount())) {
                    waterContainment.take(ingredient.getAmount());
                } else {
                    display.setMessage("Bitte den Wasserbehälter füllen");
                    display.output();
                }

            }
        }
    }

    private void shutdown() {
        display.setMessage("Herunterfahren");
        display.output();
        PersistentData.save();
    }

    public void status() {
        display.setMessage("Beans ->\t" + beanContainment.getAmount());
        display.output();
        display.setMessage("Water ->\t" + waterContainment.getAmount());
        display.output();
    }
    //<editor-fold desc="Getters & Setters">

    public Button getSmallCoffeeButton() {
        return smallCoffeeButton;
    }

    public Map<Integer, Recipe> getRecipesToButton() {
        return recipesToButton;
    }

    public Button getLargeCoffeeButton() {
        return largeCoffeeButton;
    }

    public Button getWarmWaterButton() {
        return warmWaterButton;
    }

    public Button getShutdownButton() {
        return shutdownButton;
    }
    public Display getDisplay() {
        return display;
    }

    //</editor-fold>
}