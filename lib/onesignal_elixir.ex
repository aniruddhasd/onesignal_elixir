defmodule OnesignalElixir do
  @moduledoc """
  Documentation for OnesignalElixir.

  ## Configuration
    def deps do
      [
        {:onesignal_elixir, "~> 0.1.0"}
      ]
    end

    config :onesignal_elixir,
      rest_api_key: "YOUR-ONESIGNAL-REST-API-KEY",
      app_id: "YOUR-ONESIGNAL-APP-ID"

  ## Usage
    iex(1)> alias OnesignalElixir.{Notification,Builder,Filter}
    [OnesignalElixir.Notification, OnesignalElixir.Builder, OnesignalElixir.Filter]

    iex(2)> filters = Filter.new() |> Filter.last_session(">","1.2") |> Filter.add_operator("AND") |> Filter.tag("exists", "email")               [                                                                                                                                               %{field: "last_session", hours_ago: "1.2", relation: ">"},
      %{operator: "AND"},
      %{field: "tag", key: "email", relation: "exists"}
    ]
    iex(3)> body = OnesignalElixir.new() |> Builder.add_content(:en, "Welcome to One Signal") |> Builder.add_content(:es, "Bienvenido a One Signal")|> Builder.add_heading(:en, "Hello") |> Builder.add_heading(:es, "Hola") |> Builder.add_subtitle(:en, "Welcome") |> Builder.add_subtitle(:es, "Bienvenido") |> Builder.add_filters(filters)
    %{
      __struct__: OnesignalElixir.Notification,
      app_id: "YOUR-ONESIGNAL-APP-ID",
      contents: %{en: "Welcome to One Signal", es: "Bienvenido a One Signal"},
      filters: [
        %{field: "last_session", hours_ago: "1.2", relation: ">"},
        %{operator: "AND"},
        %{field: "tag", key: "email", relation: "exists"}
      ],
      headings: %{en: "Hello", es: "Hola"},
      subtitles: %{en: "Welcome", es: "Bienvenido"}
    }
    iex(4)> OnesignalElixir.send_notification(body)                                                                                              {:ok,                                                                                                                                          %{
      "external_id" => nil,
      "id" => "GENERATED_NOTIFICATION_ID",
      "recipients" => 6
    }}

    iex(5)> body = OnesignalElixir.new() |> Builder.add_content(:en, "Welcome to One Signal") |> Builder.add_content(:es, "Bienvenido a One Signal")|> Builder.add_heading(:en, "Hello") |> Builder.add_heading(:es, "Hola") |> Builder.add_subtitle(:en, "Welcome") |> Builder.add_subtitle(:es, "Bienvenido") |> Builder.include_segment("Active Users")
    %{
      __struct__: OnesignalElixir.Notification,
      app_id: "YOUR-ONESIGNAL-APP-ID",
      contents: %{en: "Welcome to One Signal", es: "Bienvenido a One Signal"},
      headings: %{en: "Hello", es: "Hola"},
      included_segments: ["Active Users"],
      subtitles: %{en: "Welcome", es: "Bienvenido"}
    }

    iex(6)> OnesignalElixir.send_notification(body)
    {:ok,
    %{
      "external_id" => nil,
      "id" => "GENERATED_NOTIFICATION_ID",
      "recipients" => 5
    }}

  """
  alias OnesignalElixir.{Notification,API}

    @doc """
        Create new Notification structure
    """
    def new() do
        %Notification{
            app_id: Notification.get_app_id(),
            contents: %{}
        }
    end

    @doc """
        Send notification
        Accept notification data in the body part.
        Attach default header based on onesignal config
        Make a POST call
    """
    def send_notification(body) do
        headers = Notification.build_header()
        url = Notification.build_url()
        API.post(url, body, headers)
    end
end
