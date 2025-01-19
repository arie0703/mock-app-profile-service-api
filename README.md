# mock-app-profile-service-api

Mock アプリ開発 (Rails API)

### Ruby Version

3.3.5

### Rails Version

8.0.1

## Command

Migration

`docker-compose run --rm api rails db:migrate`

Rollback

`docker-compose run --rm api rails db:rollback STEP={N}`

## API Request

Create Member

```sh
curl -X POST "http://localhost:3000/api/v1/members" \
-H "Content-Type: application/json" \
-d '{
  "member": {
    "name": "John Doe",
    "email": "john.doe@example.com",
    "password": "password123",
    "image_url": "http://example.com/path/to/image.jpg",
    "organization_id": "1"
  }
}'

```

Sign In

```sh
curl -X POST "http://localhost:3000/api/v1/sign_in" \
-H "Content-Type: application/json" \
-d '{
  "member": {
    "email": "john.doe@example.com",
    "password": "password123"
  }
}' | jq .
```

Sign Out

```sh
curl -X DELETE "http://localhost:3000/api/v1/sign_out" \
-H "Content-Type: application/json" | jq .
```
