defmodule CreditStake.CustomError do
	# credo:disable-for-this-file Credo.Check.Consistency.ExceptionNames
	
	@moduledoc false
#	defexception message: "something went wrong"
	defexception [:message]
end

#defimpl Plug.Exception, for: CreditStake.Error do
#	def status(_exception), do: 422
#	#		def actions(_exception), do: "asas"
#
#	def actions(_exception) do
#		[
#			%{
#				label: "Run seeds",
#				handler: {Code, :eval_file, "priv/repo/seeds.exs"}
#			}
#		]
#	end
#end