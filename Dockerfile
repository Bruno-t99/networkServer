FROM ubuntu:20.04

# Set non-interactive mode to avoid timezone prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y build-essential cmake g++ libboost-all-dev && \
    ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the application files
COPY . /app

# Compile the server code
RUN g++ -std=c++17 -pthread -o server src/server.cpp -lboost_system -lboost_thread -lboost_filesystem

# Expose port 8080
EXPOSE 8080

# Run the server
CMD ["./server"]

