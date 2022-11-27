defmodule CreditStakeWeb.PaginationView do
	use CreditStakeWeb, :view
	
	def pagination(scrivener, module_name, tmp) do
		%{
			data: render_many(scrivener.entries, module_name, tmp),
			meta: %{
				page: scrivener.page_number,
				per: scrivener.page_size,
				total_pages: scrivener.total_pages,
				total_counts: scrivener.total_entries
			}
		}
	end
end
