# Generate controller

```
rails generate controller api::v1::users
```

# Open users_controller.rb

```
class Api::V1::UsersController < ApplicationController
  # GET /api/v1/users/:id
  def show
    render json: User.find(params[:id])
  end
end
```

# Add router for each controller

navigate to `config/routes.rb`

```
Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:show]
    end
  end
end
```

## Create Token controller

```
rails generate controller api::v1::tokens create
```
