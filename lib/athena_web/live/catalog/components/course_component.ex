defmodule AthenaWeb.Catalog.Component.CourseComponent do
  use Phoenix.Component

  def course(assigns) do
    ~H"""
    <div class="my-3 bg-white rounded-md shadow-md mx-4">
      <div class="mx-auto">
        <div>
          <ul role="list" class="space-y-12 sm:grid sm:space-y-0 ">
            <li>
              <div class="space-y-4">
                <div class="h-60 aspect-w-3">
                  <img class="object-cover shadow-lg" src={"#{assigns.course.cover_image_url}"} alt="">
                </div>

                <div class="space-y-2">
                  <div class="px-3 space-y-5 sm:space-y-4 md:max-w-xl lg:max-w-3xl xl:max-w-none">
                    <h2 class="text-3xl font-semibold tracking-tight sm:text-2xl"><%= assigns.course.name %></h2>
                    <p class="text-gray-500 text-md text-"><%= assigns.course.description %></p>
                  </div>
                  <div class="px-4 pb-3">
                    <h3 class="text-indigo-700 font-semibold text-lg">$<%= assigns.course.price / 100 %></h3>
                  </div>
                </div>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
    """
  end
end
