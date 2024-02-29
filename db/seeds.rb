require 'open-uri'
require 'json'

# Define the file path at the beginning to ensure it's available for the `unless` condition
file_path = 'top_rated_movies.json'

unless File.exist?(file_path)
  all_movies = []
  current_page = 1
  total_pages = 1 # Start with 1 to ensure the loop enters at least once

  while current_page <= total_pages
    # The URL of the API endpoint, including the current page
    url = "https://api.themoviedb.org/3/movie/top_rated?api_key=4e391b71f394b0de0f008b1259a5f188&page=#{current_page}"

    # Open the URL and read the content
    reading = URI.open(url).read

    # Parse the JSON content
    parsing = JSON.parse(reading)

    # Append the results of the current page to all_movies
    all_movies.concat(parsing["results"])

    # Update total_pages based on the API response
    total_pages = parsing["total_pages"]

    # Increment the current_page to fetch the next page in the next iteration
    current_page += 1
  end

  # Once all pages have been fetched and combined, write the aggregated data to the file
  File.write(file_path, JSON.pretty_generate({"results" => all_movies}))
end

# Read and parse the JSON data from the file
file_content = File.read(file_path)
parsed_json = JSON.parse(file_content)

# Loop through each movie in the JSON data
parsed_json["results"].each do |movie|
  Movie.find_or_create_by(title: movie["title"]) do |m|
    m.overview = movie["overview"]
    m.poster_url = "https://image.tmdb.org/t/p/original#{movie["poster_path"]}" unless movie["poster_path"].nil?
    m.rating = movie["vote_average"]
    # Add more fields here based on your Movie model attributes
  end
end
