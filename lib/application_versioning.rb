module ApplicationVersioning
  def self.version
    File.read(Rails.root.join('VERSION')).chomp.freeze
  end
end

ProgImage.const_set('VERSION', ApplicationVersioning.version)
