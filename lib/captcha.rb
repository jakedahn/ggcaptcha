module Captcha
  require 'digest'

  class Generate
    def self.hash(string)
      Digest::SHA2.hexdigest(string)
    end

    def self.shapes
      time = Time.now
      shapes = ["triangle", "diamond", "circle", "square"]
      random_key = rand(shapes.size)
      duplicate_shape = shapes[random_key]
      shapes.collect! { |shape| self.hash("#{shape}--#{time}")}
      shapes << self.hash("#{duplicate_shape}-duplicate--#{time}")

      validation_token = self.hash("#{shapes[random_key]}#{shapes.last}")
      
      return { :shape => shapes, :token => validation_token }
    end

  end
end
