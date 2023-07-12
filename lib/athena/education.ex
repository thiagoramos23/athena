defmodule Athena.Education do
  @moduledoc """
  All the main functions for the education subdomain
  """
  alias Athena.Education.Finder.CourseFinder

  defdelegate featured_course(opts), to: CourseFinder
  defdelegate not_featured_courses(opts), to: CourseFinder
end
