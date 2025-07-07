#!/bin/bash

echo "🚀 Setting up PIPSAP Development Environment"
echo "=============================================="

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    exit 1
fi

echo "📦 Starting Redis and Kafka services..."
docker-compose up -d

echo "⏳ Waiting for services to be ready..."
sleep 10

echo "🔍 Checking service status..."

# Check Redis
if docker-compose ps redis | grep -q "Up"; then
    echo "✅ Redis is running on localhost:6379"
else
    echo "❌ Redis failed to start"
fi

# Check Kafka
if docker-compose ps kafka | grep -q "Up"; then
    echo "✅ Kafka is running on localhost:9092"
else
    echo "❌ Kafka failed to start"
fi

echo "ℹ️  Using existing MySQL database at localhost:33306"

echo ""
echo "🎉 Setup complete! You can now start your Spring Boot application."
echo ""
echo "To start the application:"
echo "  ./mvnw spring-boot:run"
echo ""
echo "To stop all services:"
echo "  docker-compose down"
echo ""
echo "To view logs:"
echo "  docker-compose logs -f" 