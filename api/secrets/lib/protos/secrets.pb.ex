defmodule Yapi.Request do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    apiVersion: String.t,
    kind:       String.t,
    req_id:     String.t,
    org_id:     String.t
  }
  defstruct [:apiVersion, :kind, :req_id, :org_id]

  field :apiVersion, 1, type: :string
  field :kind, 2, type: :string
  field :req_id, 3, type: :string
  field :org_id, 4, type: :string
end

defmodule Yapi.Response do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    apiVersion: String.t,
    kind:       String.t,
    req_id:     String.t,
    org_id:     String.t,
    status:     Yapi.Response.Status.t
  }
  defstruct [:apiVersion, :kind, :req_id, :org_id, :status]

  field :apiVersion, 1, type: :string
  field :kind, 2, type: :string
  field :req_id, 3, type: :string
  field :org_id, 4, type: :string
  field :status, 6, type: Yapi.Response.Status
end

defmodule Yapi.Response.Status do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    code:    integer,
    message: String.t
  }
  defstruct [:code, :message]

  field :code, 1, type: Yapi.Response.Code, enum: true
  field :message, 2, type: :string
end

defmodule Yapi.Response.Code do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :OK, 0
  field :NOT_OK, 1
end

defmodule Yapi.Secret do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    metadata: Yapi.Secret.Metadata.t,
    data:     [Yapi.Secret.Entry.t]
  }
  defstruct [:metadata, :data]

  field :metadata, 1, type: Yapi.Secret.Metadata
  field :data, 2, repeated: true, type: Yapi.Secret.Entry
end

defmodule Yapi.Secret.Metadata do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    name: String.t,
    id:   String.t
  }
  defstruct [:name, :id]

  field :name, 1, type: :string
  field :id, 2, type: :string
end

defmodule Yapi.Secret.Entry do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    name:  String.t,
    value: String.t
  }
  defstruct [:name, :value]

  field :name, 1, type: :string
  field :value, 2, type: :string
end

defmodule Yapi.GetRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    request: Yapi.Request.t,
    id:      String.t,
    name:    String.t
  }
  defstruct [:request, :id, :name]

  field :request, 1, type: Yapi.Request
  field :id, 2, type: :string
  field :name, 3, type: :string
end

defmodule Yapi.GetResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    response: Yapi.Response.t,
    secret:   Yapi.Secret.t
  }
  defstruct [:response, :secret]

  field :response, 1, type: Yapi.Response
  field :secret, 2, type: Yapi.Secret
end

defmodule Yapi.CreateRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    request: Yapi.Request.t,
    secret:  Yapi.Secret.t
  }
  defstruct [:request, :secret]

  field :request, 1, type: Yapi.Request
  field :secret, 2, type: Yapi.Secret
end

defmodule Yapi.CreateResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    response: Yapi.Response.t,
    secret:   Yapi.Secret.t
  }
  defstruct [:response, :secret]

  field :response, 1, type: Yapi.Response
  field :secret, 2, type: Yapi.Secret
end

defmodule Yapi.SecretService.Service do
  @moduledoc false
  use GRPC.Service, name: "yapi.SecretService"

  rpc :Get, Yapi.GetRequest, Yapi.GetRequest
  rpc :Create, Yapi.CreateRequest, Yapi.CreateResponse
end

defmodule Yapi.SecretService.Stub do
  @moduledoc false
  use GRPC.Stub, service: Yapi.SecretService.Service
end

