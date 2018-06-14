syntax = "proto3";

service SecretService {
  rpc List(ListRequest) returns (ListResponse);
  rpc Describe(DescribeRequest) returns (DescribeResponse);
  rpc Create(CreateRequest) returns (CreateResponse);
  rpc Update(UpdateRequest) returns (UpdateResponse);
  rpc Delete(DeleteRequest) returns (DeleteResponse);
}

message Secret {
  message Metadata {
    string name = 1;
    string id = 2;
  }

  message Entry {
    string name = 1;
    string value = 2;
    string fingerprint = 3;
  }

  Metadata metadata = 1;

  Map<string, string> data = 2;
}

message PaginationRequest {
  int32 page = 1;
  int32 page_size = 2;
}

message PaginationResponse {
  int32 page_number = 1;
  int32 page_size = 2;
  int32 total_entries = 3;
  int32 total_pages = 4;
}

message ListRequest {
  PaginationRequest pagination = 1;
}

message ListRequest {
  PaginationResponse pagination = 1;

  repeated
}
