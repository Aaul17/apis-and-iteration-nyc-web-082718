require 'rest-client'
require 'json'
require 'pry'

def get_character_movie_urls_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  character_array = response_hash["results"].select do |results_hash|
    results_hash["name"].downcase.include?(character.downcase)
  end

  character_array.map do |character_hash|
    character_hash["films"]
  end.flatten
end

  # NOTE: in this demonstration we name many of the variables _hash or _array.
  # This is done for educational purposes. This is not typically done in code.
def get_character_movies_from_api(film_urls)
  film_urls.map do |film_url|
    response = RestClient.get(film_url)
    JSON.parse(response)
  end
end
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

def print_movies(films_array)
  films = films_array.map do |film_hash|
    film_hash["title"]
  end.join(", ")
  puts films# some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  film_urls = get_character_movie_urls_from_api(character)
  films_array = get_character_movies_from_api(film_urls)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
