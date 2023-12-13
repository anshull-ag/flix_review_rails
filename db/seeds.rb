# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
 User.find_or_create_by(email:"admin@gmail.com", encrypted_password: "admin@123", name: "Admin", role: "admin")

 category1 = Category.find_or_create_by(name: "Bollywood")
 category2 = Category.find_or_create_by(name: "Hollywood")
 category3 = Category.find_or_create_by(name: "Tollywood")

 movies_data = [
  {
    name: "Avtar",
    rating: "4.5",
    description: "A great action movie",
    released_date: "1/05/2009",
    star_cast: "Sam Worthington, Zoe Saldana",
    category: category2,
    image_path: "avtar.jpeg",
  },
  {
    name: "The Joker",
    rating: "4.5",
    description: "When a new detective is caught by a vicious psychopath and locked in a basement, he must use the knowledge he learned from some of the best detectives at Poker Night, then match wits against his captor.",
    released_date: "1/02/2015",
    star_cast: "Beau Mirchoff, Halston Sage",
    category: category2,
    image_path: "joker.jpg",
  },
  {
    name: "Vikram",
    rating: "4.8",
    description: "A special investigator discovers a case of serial killings is not what it seems to be, and leading down this path is only going to end in a war between everyone involved.",
    released_date: "3/06/2022",
    star_cast: "Kamal Haasan, Vijay Sethupathi",
    category: category3,
    image_path: "vikram.jpg",
  },
  {
    name: "Animal",
    rating: "5",
    description: "A father, who is often away due to work, is unable to comprehend the intensity of his son's love. Ironically, this fervent love and admiration for his father and family creates conflict between the father and son.",
    released_date: "3/11/2023",
    star_cast: "Ranbir Kapoor, Anil Kapoor, Bobby Deol",
    category: category1,
    image_path: "animal.jpg",
  },
]


def create_movie(movie_data)
  movie = Movie.create(
    name: movie_data[:name],
    rating: movie_data[:rating],
    description: movie_data[:description],
    released_date: movie_data[:released_date],
    star_cast: movie_data[:star_cast],
    category: movie_data[:category],
  )


  movie.main_image.attach(io: File.open(Rails.root.join("app/assets/images", movie_data[:image_path])), filename: movie_data[:image_path])
end

movies_data.each do |movie_data|
  create_movie(movie_data)
end
