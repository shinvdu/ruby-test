require 'socket'

server = TCPServer.open(2222)
sockets = [server]
log = STDOUT
while true
    ready = select(sockets)
    readable = ready[0]

    readable.each do |socket|
        if socket == server
            client = server.accept
            sockets << client
            client.puts "reversal service v0.01 running on #{Socket.gethostname}"
            log.puts "Accepted connection from #{client.peeraddr[2]}"
        else
            input = socket.gets

            if !input
                log.puts "Client on #{socket.peeraddr[2]} disconnected."
                sockets.delete (socket)
                socket.close
                next
            end

            input.chop!
            if (input == "quit")
                socket.puts("Bye!")
                log.puts "Closing connection to #{socket.peeraddr[2]}"
                sockets.delete (socket)
                socket.close
            else
                socket.puts(input.reverse)
            end
        end
    end
end



