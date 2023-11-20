defmodule AthenaWeb.CheckoutLive.Index do
  use AthenaWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="py-24 bg-transparent sm:py-32">
      <div class="px-6 mx-auto max-w-7xl lg:px-8">
        <div class="max-w-2xl mx-auto sm:text-center">
          <h2 class="text-3xl font-bold tracking-tight text-gray-100 sm:text-4xl">
            Simple no-tricks pricing
          </h2>
          <p class="mt-6 text-lg text-gray-300 leading-8">
            Distinctio et nulla eum soluta et neque labore quibusdam. Saepe et quasi iusto modi velit ut non voluptas in. Explicabo id ut laborum.
          </p>
        </div>
        <div class="max-w-2xl mx-auto mt-16 bg-white rounded-3xl ring-1 ring-gray-200 sm:mt-20 lg:mx-0 lg:flex lg:max-w-none">
          <div class="p-8 sm:p-10 lg:flex-auto">
            <h3 class="text-2xl font-bold tracking-tight text-gray-900">Lifetime membership</h3>
            <p class="mt-6 text-base text-gray-600 leading-7">
              Lorem ipsum dolor sit amet consect etur adipisicing elit. Itaque amet indis perferendis blanditiis repellendus etur quidem assumenda.
            </p>
            <div class="flex items-center mt-10 gap-x-4">
              <h4 class="flex-none text-sm font-semibold text-indigo-300 leading-6">
                What’s included
              </h4>
              <div class="flex-auto h-px bg-gray-900"></div>
            </div>
            <ul
              role="list"
              class="mt-8 text-sm text-gray-600 grid grid-cols-1 gap-4 leading-6 sm:grid-cols-2 sm:gap-6"
            >
              <li class="flex gap-x-3">
                <svg
                  class="flex-none w-5 h-6 text-indigo-600"
                  viewBox="0 0 20 20"
                  fill="currentColor"
                  aria-hidden="true"
                >
                  <path
                    fill-rule="evenodd"
                    d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z"
                    clip-rule="evenodd"
                  />
                </svg>
                Private forum access
              </li>
              <li class="flex gap-x-3">
                <svg
                  class="flex-none w-5 h-6 text-indigo-600"
                  viewBox="0 0 20 20"
                  fill="currentColor"
                  aria-hidden="true"
                >
                  <path
                    fill-rule="evenodd"
                    d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z"
                    clip-rule="evenodd"
                  />
                </svg>
                Member resources
              </li>
              <li class="flex gap-x-3">
                <svg
                  class="flex-none w-5 h-6 text-indigo-600"
                  viewBox="0 0 20 20"
                  fill="currentColor"
                  aria-hidden="true"
                >
                  <path
                    fill-rule="evenodd"
                    d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z"
                    clip-rule="evenodd"
                  />
                </svg>
                Entry to annual conference
              </li>
              <li class="flex gap-x-3">
                <svg
                  class="flex-none w-5 h-6 text-indigo-900"
                  viewBox="0 0 20 20"
                  fill="currentColor"
                  aria-hidden="true"
                >
                  <path
                    fill-rule="evenodd"
                    d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z"
                    clip-rule="evenodd"
                  />
                </svg>
                Official member t-shirt
              </li>
            </ul>
          </div>
          <div class="p-2 -mt-2 lg:mt-0 lg:w-full lg:max-w-md lg:flex-shrink-0">
            <div class="py-10 text-center bg-transparent rounded-2xl ring-1 ring-inset ring-gray-900/5 lg:flex lg:flex-col lg:justify-center lg:py-16">
              <div class="max-w-xs px-8 mx-auto">
                <p class="text-base font-semibold text-gray-600">Pay once, own it forever</p>
                <p class="flex items-baseline justify-center mt-6 gap-x-2">
                  <span class="text-5xl font-bold tracking-tight text-gray-900">$349</span>
                  <span class="text-sm font-semibold tracking-wide text-gray-600 leading-6">USD</span>
                </p>
                <a
                  href="#"
                  class="block w-full px-3 py-2 mt-10 text-sm font-semibold text-center text-white bg-indigo-300 rounded-md shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-300"
                >
                  Get access
                </a>
                <p class="mt-6 text-xs text-gray-600 leading-5">
                  Invoices and receipts available for easy company reimbursement
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket |> push_navigate(to: ~p"/")}
  end
end
