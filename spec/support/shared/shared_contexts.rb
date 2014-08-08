shared_context "mocked client" do
  let(:mocked_client) do
    client = Retsy::Client.new(
      login_url: "http://rets.com/login",
      version: rets_version,
    )
    client.instance_variable_set(
      "@response_arguments",
      mocked_response_arguments,
    )
    client
  end

  let(:rets_version) { "1.8" }

  let(:mocked_response_arguments) do
    {
      member_name: "Propertybase GmbH",
      user: "xxxxRETS  718,0,idx2014,xxxxRETS  718",
      broker: "0,0",
      metadata_version: "01.01.00000",
      metadata_timestamp: "2014-03-27T13:06:52",
      min_metadata_timestamp: "2014-03-27T13:06:52",
      timeout_seconds: "1800",
      get_object: "/rets/GetObject",
      login: "/rets/Login",
      logout: "/rets/Logout",
      search: "/rets/Search",
      get_metadata: "/rets/GetMetadata",
    }
  end
end
