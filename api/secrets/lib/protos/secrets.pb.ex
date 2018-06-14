defmodule Yapi.Status do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    code:    integer,
    message: String.t
  }
  defstruct [:code, :message]

  field :code, 1, type: Yapi.Code, enum: true
  field :message, 2, type: :string
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

defmodule Yapi.PaginationRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    page:      integer,
    page_size: integer
  }
  defstruct [:page, :page_size]

  field :page, 1, type: :int32
  field :page_size, 2, type: :int32
end

defmodule Yapi.PaginationResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    page_number:   integer,
    page_size:     integer,
    total_entries: integer,
    total_pages:   integer
  }
  defstruct [:page_number, :page_size, :total_entries, :total_pages]

  field :page_number, 1, type: :int32
  field :page_size, 2, type: :int32
  field :total_entries, 3, type: :int32
  field :total_pages, 4, type: :int32
end

defmodule Yapi.ListRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    pagination: Yapi.PaginationRequest.t
  }
  defstruct [:pagination]

  field :pagination, 1, type: Yapi.PaginationRequest
end

defmodule Yapi.ListResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    pagination: Yapi.PaginationResponse.t,
    secrets:    [Yapi.Secret.t]
  }
  defstruct [:pagination, :secrets]

  field :pagination, 1, type: Yapi.PaginationResponse
  field :secrets, 2, repeated: true, type: Yapi.Secret
end

defmodule Yapi.DescribeRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    id:   String.t,
    name: String.t
  }
  defstruct [:id, :name]

  field :id, 1, type: :string
  field :name, 2, type: :string
end

defmodule Yapi.DescribeResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    status: Yapi.Status.t,
    secret: Yapi.Secret.t
  }
  defstruct [:status, :secret]

  field :status, 1, type: Yapi.Status
  field :secret, 2, type: Yapi.Secret
end

defmodule Yapi.CreateRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    secret: Yapi.Secret.t
  }
  defstruct [:secret]

  field :secret, 1, type: Yapi.Secret
end

defmodule Yapi.CreateResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    status: Yapi.Status.t,
    secret: Yapi.Secret.t
  }
  defstruct [:status, :secret]

  field :status, 1, type: Yapi.Status
  field :secret, 2, type: Yapi.Secret
end

defmodule Yapi.UpdateRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    secret: Yapi.Secret.t
  }
  defstruct [:secret]

  field :secret, 1, type: Yapi.Secret
end

defmodule Yapi.UpdateResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    status: Yapi.Status.t,
    secret: Yapi.Secret.t
  }
  defstruct [:status, :secret]

  field :status, 1, type: Yapi.Status
  field :secret, 2, type: Yapi.Secret
end

defmodule Yapi.DeleteRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    id:   String.t,
    name: String.t
  }
  defstruct [:id, :name]

  field :id, 1, type: :string
  field :name, 2, type: :string
end

defmodule Yapi.DeleteResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    status: Yapi.Status.t
  }
  defstruct [:status]

  field :status, 1, type: Yapi.Status
end

defmodule Yapi.Code do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :OK, 0
  field :CANCELLED, 1
  field :UNKNOWN, 2
  field :INVALID_ARGUMENT, 3
  field :DEADLINE_EXCEEDED, 4
  field :NOT_FOUND, 5
  field :ALREADY_EXISTS, 6
  field :PERMISSION_DENIED, 7
  field :UNAUTHENTICATED, 16
  field :RESOURCE_EXHAUSTED, 8
  field :FAILED_PRECONDITION, 9
  field :ABORTED, 10
  field :OUT_OF_RANGE, 11
  field :UNIMPLEMENTED, 12
  field :INTERNAL, 13
  field :UNAVAILABLE, 14
  field :DATA_LOSS, 15
end

defmodule Yapi.SecretService.Service do
  @moduledoc false
  use GRPC.Service, name: "yapi.SecretService"

  rpc :List, Yapi.ListRequest, Yapi.ListResponse
  rpc :Describe, Yapi.DescribeRequest, Yapi.DescribeResponse
  rpc :Create, Yapi.CreateRequest, Yapi.CreateResponse
  rpc :Update, Yapi.UpdateRequest, Yapi.UpdateResponse
  rpc :Delete, Yapi.DeleteRequest, Yapi.DeleteResponse
end

defmodule Yapi.SecretService.Stub do
  @moduledoc false
  use GRPC.Stub, service: Yapi.SecretService.Service
end

