require 'rails_helper'

feature 'user can view a list of cocktail recipes', %Q{

As a lover of fine whiskey cocktails
I want to browse through cocktail recipes
So that I can find a drink I’d like to make

*******Acceptance Criteria*****************************

-I can visit an index page that lists 10 recipes at a time
-I can visit a unique page for each recipe
-Each recipe page show the recipe’s components, directions, substitutions
} do

  scenario 'user can successfully view a list of all cocktail recipes' do
    recipes = FactoryGirl.create_list(:recipe_with_ingredients, 3)

    # component = FactoryGirl.create(:component)
    # ingredient = FactoryGirl.create(:ingredient, recipe: recipe, component: component)

    visit root_path
    click_link 'All Drinks'

    expect(page).to have_content('All Drinks')

    recipes.each do |recipe|
      expect(page).to have_content(recipe.name)
    end
  end

  scenario 'user can view all details for an individual cocktail' do
    recipe = FactoryGirl.create(:recipe_with_ingredients)
    # component = FactoryGirl.create(:component)
    # ingredient = FactoryGirl.create(:ingredient, recipe: recipe, component: component)

    visit root_path
    click_on 'All Drinks'
    click_link recipe.name

    expect(page).to have_content(recipe.name)
    expect(page).to have_content(recipe.directions)

    recipe.ingredients.each do |ingredient|
      expect(page).to have_content(ingredient.component.name)
      expect(page).to have_content(ingredient.category.name)
    end

# recipe.components.first.name
# recipe.ingredients.first.component.name

  end
end
