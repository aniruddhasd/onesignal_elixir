defmodule OnesignalElixir.FilterTest do
    use ExUnit.Case
    alias OnesignalElixir.{Filter}

    test "include last session filter" do
        filters = Filter.new() 
                |> Filter.last_session(">","5.2")
        
        refute Enum.empty?(filters)
        assert Enum.all?(filters,
              &(&1 in [%{field: "last_session", hours_ago: "5.2", relation: ">"}]))
    end
    
    test "include first session filter" do
        filters = Filter.new() 
                |> Filter.first_session("<","1")
        
        refute Enum.empty?(filters)
        assert Enum.all?(filters,
              &(&1 in [%{field: "first_session", hours_ago: "1", relation: "<"}]))
    end

    test "include session count filter" do
        filters = Filter.new() 
                |> Filter.session_count("=","2")
        
        refute Enum.empty?(filters)
        assert Enum.all?(filters,
              &(&1 in [%{field: "session_count", value: "2", relation: "="}]))
    end

    test "include session time filter" do
        filters = Filter.new() 
                |> Filter.session_time(">","10")
        
        refute Enum.empty?(filters)
        assert Enum.all?(filters,
              &(&1 in [%{field: "session_time", value: "10", relation: ">"}]))
    end

    test "include amount spent filter" do
        filters = Filter.new() 
                |> Filter.amount_spent(">","100")
        
        refute Enum.empty?(filters)
        assert Enum.all?(filters,
              &(&1 in [%{field: "amount_spent", value: "100", relation: ">"}]))
    end    

    test "include sku bought filter" do
        filters = Filter.new() 
                |> Filter.bought_sku("<","com.xcelerator.ninja","1499")
        
        refute Enum.empty?(filters)
        assert Enum.all?(filters,
              &(&1 in [%{field: "bought_sku", key: "com.xcelerator.ninja", value: "1499", relation: "<"}]))
    end

    test "include language filter" do
        filters = Filter.new() 
                |> Filter.language("!=","es")
        
        refute Enum.empty?(filters)
        assert Enum.all?(filters,
              &(&1 in [%{field: "language", value: "es", relation: "!="}]))
    end

    test "include app version filter" do
        filters = Filter.new() 
                |> Filter.app_version("=","3")
        
        refute Enum.empty?(filters)
        assert Enum.all?(filters,
              &(&1 in [%{field: "app_version", value: "3", relation: "="}]))
    end

    test "include location filter" do
        filters = Filter.new() 
                |> Filter.location("1000", "12.972442","77.580643")
        
        refute Enum.empty?(filters)
        assert Enum.all?(filters,
              &(&1 in [%{field: "location", radius: "1000", lat: "12.972442", long: "77.580643"}]))
    end

    test "include email filter" do
        filters = Filter.new() 
                    |> Filter.email("abc@xyzdomain.com")
        
        refute Enum.empty?(filters)
        assert Enum.all?(filters,
              &(&1 in [%{field: "email", value: "abc@xyzdomain.com"}]))
    end

    test "include country filter" do
        filters = Filter.new() 
                    |> Filter.country("=","in")
        
        refute Enum.empty?(filters)
        assert Enum.all?(filters,
              &(&1 in [%{field: "country", value: "in", relation: "="}]))
    end

    test "add simple tag filter" do
        filters = Filter.new() 
                    |> Filter.tag("=", "vip", "true")
        refute Enum.empty?(filters)
        assert Enum.all?(filters,
              &(&1 in [%{field: "tag", key: "vip", value: "true", relation: "="}]))
    end

    test "add exists tag filter" do
        filters = Filter.new() 
                    |> Filter.tag("exists", "username")
        refute Enum.empty?(filters)
        assert Enum.all?(filters,
              &(&1 in [%{field: "tag", key: "username", relation: "exists"}]))
    end

    test "add a  filter expression" do
        filters = Filter.new() 
                    |> Filter.app_version("=","2") 
                    |> Filter.add_operator("OR") 
                    |> Filter.first_session("<","1.2")
        refute Enum.empty?(filters)
        assert Enum.all?(filters,
              &(&1 in [%{field: "app_version", relation: "=", value: "2"},
                        %{operator: "OR"},
                        %{field: "first_session", hours_ago: "1.2", relation: "<"}]))
    end
end