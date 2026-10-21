require 'socket'
require 'thread'

# a scanner namespace to check for open ports on the 254 IP addresses of the the local network
module Scanner
  def self.scan_ports
    open_ips = []
    threads = []
    mutex = Mutex.new

    1.upto(254) do |i|
      threads << Thread.new do
        ip = "192.168.0.#{i}"
        begin
          # try to connect to IP `192.168.0.x`, on port 80 with timeout
          socket = Socket.tcp("192.168.0.#{i}", 80, connect_timeout: 1)
          socket.close

          mutex.synchronize do
            open_ips << ip
            puts "Port 80 open on #{ip}"
          end
        rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT, Errno::EHOSTUNREACH
          puts "Port 80 closed"

        end
      end
    end

    threads.each { |thr| thr.join }
    open_ips
  end
end
