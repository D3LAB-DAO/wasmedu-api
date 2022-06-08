# Run

```bash
npm start

docker build -t cosmo-rust:1.0 .
make cosm-build OWNER="tkxkd0159" PROJ="ch3" LEC="lesson1"
```

# .env

```
PORT=3000
NODE_ENV=development
```

# API

**POST** Do rust fmt  
_Request_

```http request
POST /rust/fmt HTTP/1.1
Host: localhost:3000
Content-Type: application/json

target_rust_code_encoded_with_base64
```

_Response_

```json
{
  "code": "success",
  "result": "Zm4gbWFpbigpIHsKICAgIHByaW50bG4hKCJ0ZXN0IGZ1bmN0aW9uIik7Cn0K"
}
```