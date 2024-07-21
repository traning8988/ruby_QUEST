require 'webrick' # インストールしたWEBrickを呼び出す

srv = WEBrick::HTTPServer.new({ :DocumentRoot => './',
                                :BindAddress => '127.0.0.1',
                                :Port => 8000})
srv.mount('/war1.cgi', WEBrick::HTTPServlet::CGIHandler, 'war1.rb')
srv.mount('/foo.html', WEBrick::HTTPServlet::FileHandler, 'hoge.html')
# Ctrl+Cでサーバーを停止するためのシグナルハンドラを設定
trap("INT"){ srv.shutdown }
srv.start
