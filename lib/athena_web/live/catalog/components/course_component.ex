defmodule AthenaWeb.Catalog.Component.CourseComponent do
  use Phoenix.Component

  def course(assigns) do
    ~H"""
    <div class="bg-white">
      <div class="px-4 py-12 mx-auto max-w-7xl sm:px-6 lg:px-8 lg:py-24">
        <div class="space-y-12">
          <ul role="list" class="space-y-12 sm:grid sm:space-y-0 ">
            <li>
              <div class="space-y-4">
                <div class="aspect-w-3 aspect-h-2">
                <!--  <img class="object-cover rounded-lg shadow-lg" src="https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80" alt=""> -->
                  <img class="object-cover rounded-lg shadow-lg" src={"#{assigns.course.cover_image_url}"} alt="">
                </div>

                <div class="space-y-2">
                  <div class="space-y-5 sm:space-y-4 md:max-w-xl lg:max-w-3xl xl:max-w-none">
                    <h2 class="text-3xl font-semibold tracking-tight sm:text-2xl"><%= assigns.course.name %></h2>
                    <p class="text-gray-500 text-md text-"><%= assigns.course.description %></p>
                  </div>
                  <div class="space-y-1 text-lg font-medium leading-6">
                    <h3 class="text-indigo-700 text-semibold">Price: $<%= assigns.course.price / 100 %></h3>
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
