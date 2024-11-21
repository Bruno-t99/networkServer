// src/client.cpp
#include <iostream>
#include <boost/asio.hpp>

using boost::asio::ip::tcp;

int main() {
    // Create an I/O context
    boost::asio::io_context io_context;

    // Create a socket and connect it to the server at IP and port
    tcp::socket socket(io_context);
    tcp::resolver resolver(io_context);
    boost::asio::connect(socket, resolver.resolve("127.0.0.1", "8080"));

    // Read the server's response
    char buf[128];
    size_t len = socket.read_some(boost::asio::buffer(buf));

    // Print the server's message
    std::cout.write(buf, len);
    std::cout << std::endl;

    // Close the socket
    socket.close();

    return 0;
}
