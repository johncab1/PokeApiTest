require "test_helper"

class PokemonsControllerTest < ActionDispatch::IntegrationTest
  test "visiting the index" do
    get root_path
    assert_select "h1", text: "Pokemon test"
  end

  test "search for an existing pokemon" do
    pokemon = pokemons(:charmander)
    params = {
      name: pokemon.name
    }

    assert_no_difference "Pokemon.count", "No new pokemons created" do
      post search_path, params: params
    end

    assert_equal "charmander's number is 4", flash[:notice]
    assert_redirected_to root_path
  end

  test "search for a new pokemon" do
    param = {
      name: "pikachu"
    }

    assert_difference "Pokemon.count" do
      post search_path, params: param
    end

    assert_equal "pikachu's number is 25", flash[:notice]
    assert_redirected_to root_path
  end

  test "search for an invalid pokemon" do
    param = {
      name: "pika"
    }

    assert_no_difference "Pokemon.count" do
      post search_path, params: param
    end

    assert_equal "No pokemon found", flash[:error]
    assert_redirected_to root_path

  end

  test "search for an invalid pokemon with multiple names" do
    param = {
      name: "pika pika"
    }

    assert_no_difference "Pokemon.count" do
      post search_path, params: param
    end

    assert_equal "No pokemon found", flash[:error]
    assert_redirected_to root_path

  end
end
