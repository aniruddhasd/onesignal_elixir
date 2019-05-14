defmodule OnesignalElixir.Filter do

    require Logger
    def new() do
        []
    end

    @doc """
        filters = Filter.new() 
                |> Filter.last_session(">","5.2")
    """
    def last_session(current_filters,relation,hours_ago) do
        combine_filters(current_filters,%{field: "last_session", relation: relation, hours_ago: hours_ago})
    end

    @doc """
        filters = Filter.new() 
                |> Filter.first_session(">","1.2")
    """
    def first_session(current_filters,relation,hours_ago) do
        combine_filters(current_filters,%{field: "first_session", relation: relation, hours_ago: hours_ago})
    end

    @doc """
        filters = Filter.new() 
                |> Filter.session_count("=","20")
    """
    def session_count(current_filters,relation, value) do
        combine_filters(current_filters,%{field: "session_count", relation: relation, value: value})
    end

    @doc """
        filters = Filter.new() 
                |> Filter.session_time(">","2.5")
    """
    def session_time(current_filters,relation, value) do
        combine_filters(current_filters,%{field: "session_time", relation: relation, value: value})
    end

    @doc """
        filters = Filter.new() 
                |> Filter.amount_spent(">","1.2")
    """
    def amount_spent(current_filters,relation, value) do
        combine_filters(current_filters,%{field: "amount_spent", relation: relation, value: value})
    end

    @doc """
        filters = Filter.new() 
                |> Filter.bought_sku(">","com.xcelerator.ninja","1499")
    """
    def bought_sku(current_filters,relation, key, value) do
        combine_filters(current_filters,%{field: "bought_sku", relation: relation, key: key, value: value})
    end

    @doc """
        filters = Filter.new() 
                |> Filter.language("!=","es")
    """
    def language(current_filters,relation, value) do
        combine_filters(current_filters,%{field: "language", relation: relation, value: value})
    end

    @doc """
        filters = Filter.new() 
                |> Filter.app_version("=","3")
    """
    def app_version(current_filters,relation, value) do
        combine_filters(current_filters,%{field: "app_version", relation: relation, value: value})
    end

    @doc """
        filters = Filter.new() 
                |> Filter.location("1000", "12.972442","77.580643")
    """
    def location(current_filters,radius, latitude, longitude) do
        combine_filters(current_filters,%{field: "location", radius: radius, lat: latitude, long: longitude})
    end

    @doc """
        filters = Filter.new() 
                |> Filter.email("abc@xyzdomain.com")
    """
    def email(current_filters,value) do
        combine_filters(current_filters,%{field: "email", value: value})
    end

    @doc """
        filters = Filter.new() 
                    |> Filter.country("=","in",)
    """
    def country(current_filters,relation,value) do
        combine_filters(current_filters,%{field: "country", value: value, relation: relation})
    end

    @doc """
        filters = Filter.new() 
                    |> Filter.tag("=", "vip", "true")
        filters = Filter.new() 
                    |> Filter.tag("exists", "username")
    """
    def tag(current_filters,relation, key, value \\ nil) do
        filter = %{field: "tag", relation: relation, key: key}
        filter = case relation do
            "exists" -> filter
            "not_exists" -> filter
            _ -> Map.put(filter,:value, value)
        end
        combine_filters(current_filters,filter)
    end

    @doc """
        operator("OR")

        %{operator: "OR"}
    """
    defp operator(operator) do
        %{"operator": operator}
    end


    @doc """
        filters = Filter.new() 
                    |> Filter.app_version("=","2") 
                    |> Filter.add_operator("OR") 
                    |> Filter.first_session("<","1.2")

        [%{field: "app_version", relation: "=", value: "2"},
        %{operator: "OR"},
        %{field: "first_session", hours_ago: "1.2", relation: "<"}]
    """
    def add_operator(current_filters, operator) do
        if length(current_filters) > 0 do
            current_filters ++ [operator(operator)]    
        else
            current_filters
        end
    end

    @doc """
        If existing filter is empty, then just takes new filter, creates a list
    """
    defp combine_filters(_current_filters = [],filter) do
        [filter]
    end

    @doc """
        Takes existing filter and appends new filter to the list
    """
    defp combine_filters(current_filters = [_|_],filter) do
        current_filters ++ [filter]
    end
    
    @doc """
        #Todo
        Need to validate the filter expression created
    """
    def validate_filter_expression(expression) do
        expression
    end
end