require 'barby'
require 'barby/outputter/svg_outputter'
require 'barby/outputter/rmagick_outputter'

module BarbyBarcode
  
  class << self
  
    IMAGE_STORAGE_PATH = 'barcodes/:id/:id.:style.png'
  
    def encode_svg(bar_code)
      qr = Barby::QrCode.new(bar_code.encode_string.strip)
      bar_code.source =  qr.to_svg
      bar_code.level =   qr.level.to_s.upcase
      bar_code.version = qr.size
    end
  
    def encode_png_boundles(bar_code)
      qr = Barby::QrCode.new(bar_code.encode_string.strip)
      File.open(make_storage_file_name(:id=> bar_code.id, :style=> 'thumbnail'), 'w' ) do |f|
        f.write qr.to_png(:margin=>3, :xdim=>4)
      end
      File.open(make_storage_file_name(:id=> bar_code.id, :style=> 'preview'), 'w' ) do |f|
        f.write qr.to_png(:margin=>4, :xdim=>7)
      end
    end
  
    def image_path(opts)
      opts[:style] ||= 'thumbnail'
      IMAGE_STORAGE_PATH.gsub(':id', opts[:id].to_s).gsub(':style', opts[:style])
    end
  
    private
  
      def make_storage_file_name(opts)
        file_path = "public/assets/%s" % image_path(opts)
        path      = file_path.match('.+/').to_s and FileUtils.makedirs(path)
        file_path
      end
  
  end # self << class

end