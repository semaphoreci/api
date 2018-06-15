{:ok, _, _} = GRPC.Server.start([Secrets.GrpcApi], 50_051)

ExUnit.start()
