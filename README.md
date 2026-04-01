# README

This is a simple Rails blog application that demonstrates the use of GitHub Actions for continuous integration (CI) and continuous deployment (CD), Docker for containerization, Kubernetes for orchestration, and the basics of Rails development.

[deployment link](https://blog.titanforgesystems.com.br/)

## Features

- User authentication
- CRUD operations for blog posts
- Responsive design
- Dockerized application for easy deployment
- CI/CD pipelines for automated testing and deployment

## Getting Started

### Prerequisites for Local Development

- Docker compose

but it's highly recommended to have Ruby and Rails installed locally for development and testing.

### Running the Application Locally

1. Clone the repository:

   ```bash
   git clone https://github.com/faboborgeslima/rails-blog.git
   cd rails-blog
   ```

2. Create a `.env` using the provided `.env.example`:

   ```bash
   cp .env.example .env
   ```

3. Install dependencies:

   ```bash
   bundle install
   yarn install
   ```

   or with Docker:

   ```bash
   docker run --rm -v $(pwd):/app -w /app ruby:3.0 bash -c "bundle install && yarn install"
   ```

4. Start the application:

   ```bash
    docker compose up
   ```

5. Set up the database:
   ```bash
   docker compose exec -it web rails db:migrate
   ```
