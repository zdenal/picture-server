require 'sinatra'
require 'open3'

post '/svg2pdf/:name/:width' do
  width = params['width'].to_i > 14_000 ? 14_000 : params['width'].to_i

  graph_file = Tempfile.open(['graph', '.jpg']) do |file|
    file.write(params['data'])
    file
  end

  command = "rsvg-convert -f pdf -w #{width} #{graph_file.path}"

  stdout, status = Open3.capture2(command)

  content_type 'pdf'
  attachment params['name'] << '.pdf'
  stdout
end
