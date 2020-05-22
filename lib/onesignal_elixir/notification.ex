defmodule OnesignalElixir.Notification do
  defstruct app_id: :init, contents: %{}

  @doc """
      Onesignal Rest API endpoint
      Url
  """
  def build_url() do
    "https://onesignal.com/api/v1/notifications"
  end

  @doc """
      Build Header using respective rest_api_key of onesignal account
      rest-api-key
  """
  def build_header() do
    token = get_rest_api_key()
    [Authorization: "Basic #{token}", "Content-Type": "Application/json; Charset=utf-8"]
  end

  @doc """
      Get rest_api_key as per the config
  """
  def get_rest_api_key() do
    Application.get_env(:onesignal_elixir, :rest_api_key)
  end

  @doc """
      Get app_id as per the config
  """
  def get_app_id() do
    Application.get_env(:onesignal_elixir, :app_id)
  end
end
