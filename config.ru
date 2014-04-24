require 'rack'
require 'pry-debugger'
require 'rack/websocket'
require 'haml'
require 'json'

class SocketApp < Rack::WebSocket::Application
  def on_open env
    ChatChannel.connections << connection
    msg = { username: username(env), message: 'just connected' }
    ChatChannel.broadcast msg.to_json
  end

  def on_close env
    ChatChannel.connections.delete(connection)
    msg = { username: username(env), message: 'just disconnected' }
    ChatChannel.broadcast msg.to_json
  end

  def on_message env, msg
    ChatChannel.broadcast msg
  end

  def connection
    @websocket_handler.instance_variable_get("@connection")
  end

  def username(env)
    Rack::Request.new(env).params['username']
  end
end

class ChatChannel
  @@connections = []

  def self.connections
    @@connections
  end

  def self.broadcast msg
    connections.each do |connection|
      connection.send msg
    end
  end
end

class ChatApp
  def call(env)
    if env['HTTP_UPGRADE'] == "websocket"
      SocketApp.new.call(env)
    else
      template = File.read('index.haml')
      text = Haml::Engine.new(template).render
      [200, {"Content-Type" => "text/html"}, [File.read('index.html')]]
    end
  end
end

run ChatApp.new