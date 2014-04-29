require 'socket'

host, port = ARGV
 begin 
     STDOUT.print "Connnecting..."
     STDOUT.flush
     s = TCPSocket.open(host,port)
     STDOUT.puts "done"

     local, peer = s.addr, s.peeraddr
     STDOUT.print "Connected to #{peer[2]}:#{peer[1]}"
     STDOUT.print "Using local port #{local[1]}"

     begin
         sleep(0.5)
         msg = s.read_nonblock(4096)
         STDOUT.puts msg.chop
     rescue SystemCallError
     end

     loop do
         STDOUT.print '> '
         STDOUT.flush
         local = STDIN.gets
         break if !local

         s.puts(local)
         s.flush

         response = s.readpartial(4096)
         puts(response.chop)
     end
 rescue
     puts $!
 ensure
     s.close if s
 end


