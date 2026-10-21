require 'sinatra'
require_relative './services/scanner'

class Test < Sinatra::Base
  get '/' do
    active_ips = Scanner.scan_ports
    html = "<h1>LunetteRuby Dashboard</h1>"
    html += "<p>IP addresses that have port 80 open:</p>"

    if active_ips.empty?
      html += "<p style='color: red;'>No IP addresses have port 80 open.</p>"
    else
      html += "<p>#{active_ips.join('<br>')}</p>"
    end
  end
end
