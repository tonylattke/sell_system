class CostumersController < ApplicationController

  def index
    
  end

  def barcode
    @pdf=render_to_string(action: 'barcode', layout: "barcode", formats: [:pdf])
    self.content_type = 'text/html'

    File.open(file="#{Rails.root}/tmp/a.pdf",'w:binary') do |io|
      io.write(@pdf)
    end

    render text: "wrote #{file}"
  end

  def report
    @clients = Client.all
    render :layout => 'report', formats: [:pdf]
  end

end
