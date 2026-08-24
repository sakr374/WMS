Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Allow requests from any origin (including 'null' which is what file:/// sends)
    origins '*'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Authorization'] # Ensures the token makes it through
  end
end
