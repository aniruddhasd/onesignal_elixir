defmodule OnesignalElixir.Util do

    @doc """
        If param is nil returns and empty array
        Else returns params
    """
    def prepare_param_enum(param) do
        if is_nil(param) do
            []
        else
            param
        end
    end

    @doc """
        If param is nil returns and empty map
        Else returns params
    """
    def prepare_param_map(param) do
        if is_nil(param) do
            %{}
        else
            param
        end
    end
    
end