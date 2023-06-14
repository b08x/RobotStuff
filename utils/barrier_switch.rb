#!/usr/bin/env ruby

# Define the hosts
server_host = ''
client_host = ''

# Define the state classes
class Server
  def initialize(host)
    @host = host
  end

  def start
    puts "Starting server on #{@host}"
    `ssh b08x@#{@host} barriers -f --no-tray --debug INFO --name soundbot --disable-crypto --disable-client-cert-checking -c ~/.config/Debauchee/soundbot.conf --address :24800`
  end

  def stop
    puts "Stopping server on #{@host}"
    `ssh b08x@#{@host} killall barriers`
  end
end

class Client
  def initialize(host, server_host)
    @host = host
    @server_host = server_host
  end

  def start
    puts "Starting client on #{@host}"
    `ssh b08x@#{@host} barrierc -f --debug INFO --name ninjabot --disable-crypto #{@server_host}:24800`
  end

  def stop
    puts "Stopping client on #{@host}"
    `ssh b08x@#{@host} killall barrierc`
  end
end

# Parse the command line arguments
if ARGV.length != 1
  puts 'Usage: ruby barrier_switcher.rb --server|--client'
  exit 1
elsif ARGV[0] == '--server'
  server_host = `hostname`.strip
  client_host = server_host == 'ninjabot' ? 'soundbot' : 'ninjabot'
elsif ARGV[0] == '--client'
  client_host = `hostname`.strip
  server_host = client_host == 'ninjabot' ? 'soundbot' : 'ninjabot'
else
  puts 'Usage: ruby barrier_switcher.rb --server|--client'
  exit 1
end

# Initialize the server and client
server = Server.new(server_host)
client = Client.new(client_host, server_host)

# Switch the Barrier client and server if necessary
if ARGV[0] == '--server'
  client.stop
  server.stop
  client.start
  server.start
elsif ARGV[0] == '--client'
  server.stop
  client.stop
  server.start
  client.start
end
