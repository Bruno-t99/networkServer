#include <iostream>
#include <boost/asio.hpp>

using boost::asio::ip::tcp;

int main() {
    // Create an I/O context
    boost::asio::io_context io_context;

    // Create an endpoint (IP address and port)
    tcp::endpoint endpoint(tcp::v4(), 8080);

    // Create an acceptor to listen for incoming connections
    tcp::acceptor acceptor(io_context, endpoint);

    std::cout << "Server is running on port 8080..." << std::endl;

    while (true) {
        // Wait for a client to connect
        tcp::socket socket(io_context);
        acceptor.accept(socket);
        std::cout << "Client connected!" << std::endl;

        // Formulate a valid HTTP/1.1 response
        std::string response = 
            "HTTP/1.1 200 OK\r\n"
            "Content-Type: text/plain\r\n"
            "Content-Length: 13\r\n"
            "Connection: close\r\n"
            "\r\n"
            "Hello, World!";

        // Send the response to the client
        boost::asio::write(socket, boost::asio::buffer(response));

        // Close the socket after communication
        socket.close();
        std::cout << "Connection closed." << std::endl;
    }

    return 0;
}
