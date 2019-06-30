defmodule OnesignalElixir.BuilderTest do
    use ExUnit.Case
    alias OnesignalElixir.{Notification,Builder}

    test "include a segment" do
        notification = OnesignalElixir.new()
                        |> Builder.include_segment("Active Users")
        
        refute Enum.empty?(notification.included_segments)
        assert Enum.all?(notification.included_segments,
              &(&1 in ["Active Users"]))
    end


    test "include multiple segments" do
        notification = OnesignalElixir.new()
                        |> Builder.include_segments(["Active Users", "Paid Users"])
        
        refute Enum.empty?(notification.included_segments)
        assert Enum.all?(notification.included_segments,
              &(&1 in ["Active Users", "Paid Users"]))
    end

    test "exclude a segment" do
        notification = OnesignalElixir.new()
                        |> Builder.exclude_segment("Active Users")
        
        refute Enum.empty?(notification.excluded_segments)
        assert Enum.all?(notification.excluded_segments,
              &(&1 in ["Active Users"]))
    end


    test "exclude multiple segments" do
        notification = OnesignalElixir.new()
                        |> Builder.exclude_segments(["Active Users", "Paid Users"])
        
        refute Enum.empty?(notification.excluded_segments)
        assert Enum.all?(notification.excluded_segments,
              &(&1 in ["Active Users", "Paid Users"]))
    end    

    test "adding content to notification" do
        notification = OnesignalElixir.new() 
                        |> Builder.add_content(:en, "Welcome to One Signal") 
                        |> Builder.add_content(:es, "Bienvenido a One Signal")            

        assert notification.contents == %{:en => "Welcome to One Signal", :es => "Bienvenido a One Signal"}
    end


    test "adding title to notification" do
        notification = OnesignalElixir.new() 
                        |> Builder.add_heading(:en, "Hello") 
                        |> Builder.add_heading(:es, "Hola")                        

        assert notification.headings == %{:en => "Hello", :es => "Hola"}
    end    

    test "adding subtitle to notification" do
        notification = OnesignalElixir.new() 
                        |> Builder.add_subtitle(:en, "Welcome") 
                        |> Builder.add_subtitle(:es, "Bienvenido")                        

        assert notification.subtitles == %{:en => "Welcome", :es => "Bienvenido"}
    end

    test "adding url to notification" do
        notification = OnesignalElixir.new() 
                        |> Builder.add_url("https://xcelerator.ninja")

        assert notification.url == "https://xcelerator.ninja"
    end    

    test "adding app url to notification" do
        notification = OnesignalElixir.new() 
                        |> Builder.add_app_url("https://xcelerator.ninja/home")

        assert notification.app_url == "https://xcelerator.ninja/home"
    end    

    test "adding big picture to notification" do
        notification = OnesignalElixir.new() 
                        |> Builder.big_picture("https://xcelerator.ninja/static/media/main-logo.ff98436a.png")

        assert notification.big_picture == "https://xcelerator.ninja/static/media/main-logo.ff98436a.png"
    end

    test "add buttons to notification" do
        notification = OnesignalElixir.new() 
                        |> Builder.buttons([{"Share","ic_menu_share"},{"Send","ic_menu_send"}])
        refute Enum.empty?(notification.buttons)
        assert Enum.all?(notification.buttons,
              &(&1 in  [
                            %{icon: "ic_menu_share", id: "id0", text: "Share"},
                            %{icon: "ic_menu_send", id: "id1", text: "Send"}
                        ]))
    end

    test "setting priority to notification" do
        notification = OnesignalElixir.new()
                        |> Builder.set_priority(10)

        assert notification.priority == 10
    end

    test "setting ttl to notification" do
        notification = OnesignalElixir.new()
                        |> Builder.set_ttl(86400)

        assert notification.ttl == 86400
    end

    test "setting send after to notification" do
        notification = OnesignalElixir.new()
                        |> Builder.set_send_after("2015-09-24 14:00:00 GMT-0700")

        assert notification.send_after == "2015-09-24 14:00:00 GMT-0700"
    end

    test "set grouping to notification" do
        notification = OnesignalElixir.new()
                        |> Builder.set_grouping("campaign_123")

        assert notification.android_group == "campaign_123"
    end

    test "add data to notification" do
        notification = OnesignalElixir.new()
                        |> Builder.add_data(%{entity: "user", id: 23})

        assert notification.data == %{entity: "user", id: 23}
    end

    test "include player ids" do
      notification = OnesignalElixir.new()
      |> Builder.include_player_ids(["player-id-1", "player-id-2"])
      
      refute Enum.empty?(notification.include_player_ids)
      assert notification.include_player_ids == ["player-id-1", "player-id-2"] 
    end

    test "include external user ids" do
      notification = OnesignalElixir.new()
      |> Builder.include_external_user_ids(["user-id-1", "user-id-2"])
      
      refute Enum.empty?(notification.include_external_user_ids)
      assert notification.include_external_user_ids == ["user-id-1", "user-id-2"] 
    end

end
