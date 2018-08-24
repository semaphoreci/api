# Semaphore 2.0: Public API

Official Semaphore 2.0 Public API.

### Types of APIs

Semaphore 2.0 API supports two protocols:

- A gRPC API defined in this repository
- A JSON/Rest protocol based on this gRPC API

The Public API is defined as a set of gRPC services and a set of gRPC API
configuration files that dictate how are resources exposed to the public.

The protocol conversion is based on
[gRPC Gateway](https://github.com/grpc-ecosystem/grpc-gateway).  The gRCP
Gateway server is defined in the
[Public API Gateway](https://github.com/renderedtext/public-api-gateway)
repository.

Note:

- The gRPC API is currently not exposed to the public. This is planned but not
  yet achieved.
- The REST/JSON API is publicly available.

### Resources, API Versioning, File names

- Each resource has its own dedicated API. An example would be the workflow
resource which is exposed via the WorkflowsAPI.

- Each API has a version that is part of the namespace. Example for the
WorkflowAPI would be `semaphore.workflows.v1alpha`.

- Each API is independently versioned.

- The name of the file that defines the API should follow the
`<resource_name_plural>.<version>.proto` scheme. Example would be
`workflows.v1alpha.proto`.

- The yaml specification should follow the same pattern. Example:
`workflows.v1alpha.yml`.

### API versions

API versions are incremental numbers, `v1`, `v2`...

Every API version can be alpha, beta, and stable.

- Alpha versions: Aggressive changes are expected without prior notifications.
  Not ready for production usage. Naming pattern `<version>alpha`, example
  `v2alpha`.

- Beta versions: No aggressive changes can be made on beta resources, only
  backward compatible changes. Naming pattern `<version>beta`, example `v1beta`.

- Stable versions: Are subject to no modifications, only security patches.
  Naming pattern `<version>`, example `v1`.

### Resource objects

Resource objects have 3 components:

- `spec` - This is defined by the user and describes the desired state of system. Fill this in when creating or updating an object.
- `status` - This is filled in by the server and reports the current state of the system. Only semaphore components should fill this in.
- `metadata` - This is metadata about the resource, such as its name, type, api version, annotations, and labels. This contains fields that maybe updated both by the end user and the system (e.g. annotations)

All objects that represent a physical resource whose state may vary from the user's desired intent **should** have a `spec` and a `status`. Objects whose state cannot vary from the user's desired intent **may** have only `spec`, and **may** rename `spec` to a more appropriate name. Example: [secrets.v1beta.proto](https://github.com/semaphoreci/api/blob/master/semaphore/secrets.v1beta.proto)
