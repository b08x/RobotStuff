#!/usr/bin/env ruby
require 'logging'
require 'tty-command'

# Set up logging configuration
Logging.color_scheme('bright',
  :levels => {
    :info  => :green,
    :warn  => :yellow,
    :error => :red,
    :fatal => [:white, :on_red]
  },
  :date => :blue,
  :logger => :cyan,
  :message => :magenta
)

# Configure appenders
stdout_appender = Logging.appenders.stdout(
  'stdout',
  :layout => Logging.layouts.pattern(
    :pattern => '[%d] %-5l %c: %m\n',
    :color_scheme => 'bright'
  ),
  :level => :debug
)

# Create a logger with appenders
$logger = Logging.logger['BarrierSwitcher']
$logger.add_appenders(stdout_appender)

# Set the log level
$logger.level = :debug

# Create a new TTY::Command instance
cmd = TTY::Command.new(output: $logger)

# Define the hosts
server_host = ''
client_host = ''

# Define the state classes
class Server
  def initialize(host, cmd)
    @host = host
    @cmd = cmd
  end

  def start
    $logger.info "Starting server on #{@host}"
    @cmd.run("ssh b08x@#{@host} barriers -f --no-tray --debug INFO --name soundbot --disable-crypto --disable-client-cert-checking -c ~/.config/Debauchee/soundbot.conf --address :24800")
  end

  def stop
    if running?
      $logger.info "Stopping server on #{@host}"
      @cmd.run("ssh b08x@#{@host} killall barriers")
    end
  end

  def running?
    !@cmd.run("ssh b08x@#{@host} pgrep barriers").out.strip.empty?
  end
end

class Client
  def initialize(host, server_host, cmd)
    @host = host
    @server_host = server_host
    @cmd = cmd
  end

  def start
    sleep 2 # Add a delay to ensure the server has stopped before starting the client
    $logger.info "Starting client on #{@host}"
    @cmd.run("ssh b08x@#{@host} barrierc -f --debug INFO --name ninjabot --disable-crypto #{@server_host}:24800")
  end

  def stop
    if running?
      $logger.info "Stopping client on #{@host}"
      @cmd.run("ssh b08x@#{@host} killall barrierc")
    end
  end

  def running?
    !@cmd.run("ssh b08x@#{@host} pgrep barrierc").out.strip.empty?
  end
end

# Parse the command line arguments
if ARGV.length != 1
  $logger.error 'Usage: ruby barrier_switcher.rb --server|--client'
  exit 1
elsif ARGV[0] == '--server'
  server_host = `hostname`.strip
  client_host = server_host == 'ninjabot' ? 'soundbot' : 'ninjabot'
elsif ARGV[0] == '--client'
  client_host = `hostname`.strip
  server_host = client_host == 'ninjabot' ? 'soundbot' : 'ninjabot'
else
  $logger.error 'Usage: ruby barrier_switcher.rb --server|--client'
  exit 1
end

# Initialize the server andclient
server = Server.new(server_host, cmd)
client = Client.new(client_host, server_host, cmd)

# Switch the Barrier client and server if necessary
if ARGV[0] == '--server'
  if client.running?
    client.stop
  end
  unless server.running?
    server.start
  end
elsif ARGV[0] == '--client'
  if server.running?
    server.stop
  end
  unless client.running?
    client.start
  end
end


# # Create a new TTY::Command instance
# cmd = TTY::Command.new(output: $logger)
#
# # Define the commands to be run on the server and client
# server_commands = [
#   "killall -q jackd",
#   "killall -q darkice",
#   "jackd -dalsa -dhw:1,0 -p1024 -n3 -s &",
#   "sleep 2",
#   "darkice -c /home/pi/darkice.cfg &"
# ]
#
# client_commands = [
#   "killall -q mplayer",
#   "mplayer http://soundbot.local:8000/stream.ogg"
# ]
#
# # Execute the commands on the server
# server_commands.each do |command|
#   cmd.run("ssh pi@#{server_host} '#{command}'")
# end
#
# # Execute the commands on the client
# client_commands.each do |command|
#   cmd.run("ssh pi@#{client_host} '#{command}'")
# end
