defmodule Yapi.Secrets.RequestMeta do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    api_version: String.t,
    kind:        String.t,
    req_id:      String.t,
    org_id:      String.t,
    user_id:     String.t
  }
  defstruct [:api_version, :kind, :req_id, :org_id, :user_id]

  field :api_version, 1, type: :string
  field :kind, 2, type: :string
  field :req_id, 3, type: :string
  field :org_id, 4, type: :string
  field :user_id, 5, type: :string
end

defmodule Yapi.Secrets.ResponseMeta do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    api_version: String.t,
    kind:        String.t,
    req_id:      String.t,
    org_id:      String.t,
    user_id:     String.t,
    status:      Yapi.Secrets.ResponseMeta.Status.t
  }
  defstruct [:api_version, :kind, :req_id, :org_id, :user_id, :status]

  field :api_version, 1, type: :string
  field :kind, 2, type: :string
  field :req_id, 3, type: :string
  field :org_id, 4, type: :string
  field :user_id, 5, type: :string
  field :status, 6, type: Yapi.Secrets.ResponseMeta.Status
end

defmodule Yapi.Secrets.ResponseMeta.Status do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    code:    integer,
    message: String.t
  }
  defstruct [:code, :message]

  field :code, 1, type: Yapi.Secrets.ResponseMeta.Code, enum: true
  field :message, 2, type: :string
end

defmodule Yapi.Secrets.ResponseMeta.Code do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :OK, 0
  field :CREATION_FAILED, 1
  field :NOT_FOUND, 2
end

defmodule Yapi.Secrets.Secret do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    metadata: Yapi.Secrets.Secret.Metadata.t,
    data:     [Yapi.Secrets.Secret.Entry.t]
  }
  defstruct [:metadata, :data]

  field :metadata, 1, type: Yapi.Secrets.Secret.Metadata
  field :data, 2, repeated: true, type: Yapi.Secrets.Secret.Entry
end

defmodule Yapi.Secrets.Secret.Metadata do
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

defmodule Yapi.Secrets.Secret.Entry do
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

defmodule Yapi.Secrets.GetRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    metadata: Yapi.Secrets.RequestMeta.t,
    id:       String.t,
    name:     String.t
  }
  defstruct [:metadata, :id, :name]

  field :metadata, 1, type: Yapi.Secrets.RequestMeta
  field :id, 2, type: :string
  field :name, 3, type: :string
end

defmodule Yapi.Secrets.GetResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    metadata: Yapi.Secrets.ResponseMeta.t,
    secret:   Yapi.Secrets.Secret.t
  }
  defstruct [:metadata, :secret]

  field :metadata, 1, type: Yapi.Secrets.ResponseMeta
  field :secret, 2, type: Yapi.Secrets.Secret
end

defmodule Yapi.Secrets.CreateRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    metadata: Yapi.Secrets.RequestMeta.t,
    secret:   Yapi.Secrets.Secret.t
  }
  defstruct [:metadata, :secret]

  field :metadata, 1, type: Yapi.Secrets.RequestMeta
  field :secret, 2, type: Yapi.Secrets.Secret
end

defmodule Yapi.Secrets.CreateResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    metadata: Yapi.Secrets.ResponseMeta.t,
    secret:   Yapi.Secrets.Secret.t
  }
  defstruct [:metadata, :secret]

  field :metadata, 1, type: Yapi.Secrets.ResponseMeta
  field :secret, 2, type: Yapi.Secrets.Secret
end

defmodule Yapi.Secrets.SecretService.Service do
  @moduledoc false
  use GRPC.Service, name: "Yapi.Secrets.SecretService"

  rpc :Get, Yapi.Secrets.GetRequest, Yapi.Secrets.GetResponse
  rpc :Create, Yapi.Secrets.CreateRequest, Yapi.Secrets.CreateResponse
end

defmodule Yapi.Secrets.SecretService.Stub do
  @moduledoc false
  use GRPC.Stub, service: Yapi.Secrets.SecretService.Service
end

