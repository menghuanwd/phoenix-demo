defmodule CreditStakeWeb.ErrorView do
  use CreditStakeWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  def render("500.json", assigns) do
    %{message: assigns.reason.message}
  end

  def render("404.json", assigns) do
    %{message: assigns.reason.message}
  end

  def render("400.json", assigns) do
    %{message: assigns.reason.message}
  end


  #  def render("404.html", _assigns) do
  # 	  "Page Not Found"
  #  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    #    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}

    %{message: Phoenix.Controller.status_message_from_template(template)}
  end
end
