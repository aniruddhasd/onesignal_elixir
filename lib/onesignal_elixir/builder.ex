defmodule OnesignalElixir.Builder do
    require Logger
    alias OnesignalElixir.Util
    @doc """
        Notification.new()
        |> Builder.include_segment("Active Users")

        %{included_segments: ["Active Users"]}
    """
    def include_segment(notification,segment_name) do
        Map.get_and_update(notification,:included_segments, fn current_value ->
            {current_value,Enum.concat(Util.prepare_param_enum(current_value),[segment_name])}
        end) |> elem(1)
    end

    @doc """
        Notification.new()
        |> Builder.include_segments(["Active Users", "Paid Users"])

        %{included_segments: ["Active Users"]}
    """
    def include_segments(notification,segments) do
        Map.get_and_update(notification,:included_segments, fn current_value ->
            {current_value,Enum.concat(Util.prepare_param_enum(current_value),segments)}
        end) |> elem(1)
    end

    @doc """
        Notification.new()
        |> Builder.exclude_segment("Active Users")

        %{excluded_segments: ["Active Users"]}
    """
    def exclude_segment(notification,segment_name) do
        Map.get_and_update(notification,:excluded_segments, fn current_value ->
            {current_value,Enum.concat(Util.prepare_param_enum(current_value),[segment_name])}
        end) |> elem(1)
    end

    @doc """
        Notification.new()
        |> Builder.exclude_segments(["Active Users", "Paid Users"])

        %{excluded_segments: ["Active Users", "Paid Users"]}
    """
    def exclude_segments(notification,segments) do
        Map.get_and_update(notification,:excluded_segments, fn current_value ->
            {current_value,Enum.concat(Util.prepare_param_enum(current_value),segments)}
        end) |> elem(1)
    end

    @doc """
        Notification.new()
        |> Builder.add_content(:en, "Welcome to One Signal")
        |> Builder.add_content(:es, "Bienvenido a One Signal")

        %{contents: %{en: "Welcome to One Signal", es: "Bienvenido a One Signal"}}
    """
    def add_content(notification,language,content) do
        Map.get_and_update(notification,:contents, fn current_value ->
            {current_value, Map.put_new(current_value,language,content)}
        end) |> elem(1)
    end

    @doc """
        Notification.new()
        |> Builder.add_heading(:en, "Hello")
        |> Builder.add_heading(:es, "Hola")

        %{headings: %{en: "Hello", es: "Hola"}}
    """
    def add_heading(notification,language,heading) do
        Map.get_and_update(notification,:headings, fn current_value ->
            {current_value, Map.put_new(Util.prepare_param_map(current_value),language,heading)}
        end) |> elem(1)
    end

    @doc """
        Notification.new()
        |> Builder.add_subtitle(:en, "Welcome")
        |> Builder.add_subtitle(:es, "Bienvenido")

        %{subtitles: %{en: "Welcome", es: "Bienvenido"}}
    """
    def add_subtitle(notification,language,subtitle) do
        Map.get_and_update(notification,:subtitles, fn current_value ->
            {current_value, Map.put_new(Util.prepare_param_map(current_value),language,subtitle)}
        end) |> elem(1)
    end

    @doc """
        Notification.new()
        |> Builder.add_filters(filters)

        %{filters: [
                    %{field: "last_session", hours_ago: "1.2", relation: ">"},
                    %{operator: "AND"},
                    %{field: "app_version", relation: "=", value: "2"},
                    %{operator: "OR"},
                    %{field: "first_session", hours_ago: "1.2", relation: "<"},
                    %{operator: "AND"},
                    %{field: "tag", key: "key2", relation: "=", value: "value2"}
                    ]}
    """
    def add_filters(notification,filters) do
        Map.put(notification,:filters,filters)
    end

    @doc """
        Notification.new()
        |> Builder.add_url("https://xcelerator.ninja")

        %{url: "https://xcelerator.ninja"}
    """
    def add_url(notification, url) do
        Map.put(notification,:url, url)
    end

    @doc """
        Notification.new()
        |> Builder.add_app_url("https://xcelerator.ninja")

        %{app_url: "https://xcelerator.ninja"}
    """
    def add_app_url(notification, app_url) do
        Map.put(notification,:app_url, app_url)
    end

    @doc """
        Notification.new()
        |> Builder.big_picture("https://xcelerator.ninja/static/media/main-logo.ff98436a.png")

        %{big_picture: "https://xcelerator.ninja/static/media/main-logo.ff98436a.png"}
    """
    def big_picture(notification, big_picture) do
        Map.put(notification, :big_picture, big_picture)
    end


    @doc """
        Notification.new()
        |> Builder.buttons([{"Share","ic_menu_share"},{"Send","ic_menu_send"}])

        %{buttons:  [
                        %{icon: "ic_menu_share", id: "id0", text: "Share"},
                        %{icon: "ic_menu_send", id: "id1", text: "Send"}
                    ]}
    """
    def buttons(notification, buttons_data) do
        buttons = Enum.map_reduce(buttons_data, 0,fn (button_data, acc)->
            {%{id: "id"<>Integer.to_string(acc), text: elem(button_data,0), icon: elem(button_data,1)},acc + 1}
        end) |> elem(0)
        Map.put(notification, :buttons, buttons)
    end

    @doc """
        10 being highest priority
        Notification.new()
        |> Builder.set_priority(10)

        %{priority: 10}
    """
    def set_priority(notification, priority) do
        Map.put(notification, :priority, priority)
    end

    @doc """
        The default is 259,200 seconds (3 days).
        Max value to set is 2419200 seconds (28 days).
        Notification.new()
        |> Builder.set_ttl(86400)

        %{ttl: 86400}
    """
    def set_ttl(notification, ttl) do
        Map.put(notification, :ttl, ttl)
    end

    @doc """
        "2015-09-24 14:00:00 GMT-0700"
        Max value to set is 2419200 seconds (28 days).
        Notification.new()
        |> Builder.set_send_after("2015-09-24 14:00:00 GMT-0700")

        %{send_after: "2015-09-24 14:00:00 GMT-0700"}
    """
    def set_send_after(notification, send_after) do
        Map.put(notification, :send_after, send_after)
    end

    @doc """
        Notification.new()
        |> Builder.set_grouping("campaign_123")

        %{android_group: "campaign_123"}
    """
    def set_grouping(notification, group) do
        Map.put(notification, :android_group, group)
    end

    @doc """
        Notification.new()
        |> Builder.add_data(%{entity: "user", id: 23})

        %{data: %{entity: "user", id: 23}}
    """
    def add_data(notification, data_map) do
        if is_map(data_map) do
            Map.put(notification, :data, data_map)
        else
            notification
        end
    end

    @doc """
        Notification.new()
        |> Builder.include_external_user_ids(["user-id-1", "user-id-2"])

        %{include_external_user_ids: ["user-id-1"]}
    """
    def include_external_user_ids(notification,user_ids) do
        Map.get_and_update(notification,:include_external_user_ids, fn current_value ->
            {current_value,Enum.concat(Util.prepare_param_enum(current_value),user_ids)}
        end)
        |> elem(1)
    end

    @doc """
        Notification.new()
        |> Builder.include_player_ids(["player-id-1", "player-id-2"])

        %{include_player_ids: ["player-id-1"]}
    """
    def include_player_ids(notification,player_ids) do
        Map.get_and_update(notification,:include_player_ids, fn current_value ->
            {current_value,Enum.concat(Util.prepare_param_enum(current_value),player_ids)}
        end)
        |> elem(1)
    end
end
