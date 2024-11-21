# Define Boost paths (check and modify these paths if needed)
BOOST_INCLUDE = /opt/homebrew/Cellar/boost/1.86.0_2/include
BOOST_LIB = /opt/homebrew/Cellar/boost/1.86.0_2/lib

# Define the source files for the server and client
SERVER_SRC = src/server.cpp
CLIENT_SRC = src/client.cpp

# Define the output executable directory and files
BIN_DIR = bin
SERVER_BIN = $(BIN_DIR)/server
CLIENT_BIN = $(BIN_DIR)/client

# Default target (compiles server and client)
all: $(SERVER_BIN) $(CLIENT_BIN)

# Create the bin directory if it doesn't exist
$(BIN_DIR):
		mkdir -p $(BIN_DIR)

# Rule to compile the server binary
$(SERVER_BIN): $(SERVER_SRC) | $(BIN_DIR)
		g++ -std=c++17 -pthread -I$(BOOST_INCLUDE) -L$(BOOST_LIB) -o $(SERVER_BIN) $(SERVER_SRC) -lboost_system -lboost_thread-mt -lboost_filesystem

# Rule to compile the client binary
$(CLIENT_BIN): $(CLIENT_SRC) | $(BIN_DIR)
		g++ -std=c++17 -pthread -I$(BOOST_INCLUDE) -L$(BOOST_LIB) -o $(CLIENT_BIN) $(CLIENT_SRC) -lboost_system -lboost_thread-mt -lboost_filesystem

# Clean target to remove the binaries
clean:
		rm -rf $(BIN_DIR)

# PHONY target (not linked to actual files)
.PHONY: all clean
