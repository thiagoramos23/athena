defmodule Athena.Factory do
  use ExMachina.Ecto, repo: Athena.Repo

  def course_factory(attrs) do
    %Athena.Catalog.Course{
      name: "E-Learning Course",
      description: "This course will make your head blow away. It is the best course that you will see forever.",
      cover_image_url:
        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fquizandsurveymaster.com%2Fpromote-an-online-course-with-a-quiz%2F&psig=AOvVaw15DSLmQKr1nNFJ2SD5ALqw&ust=1654536662482000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCIjD68TrlvgCFQAAAAAdAAAAABAD",
      labels: "learning,e-learning,math",
      price: 199_099
    }
    |> merge_attributes(attrs)
  end
end
