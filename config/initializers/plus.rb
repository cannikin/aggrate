begin
  PLUS_CONFIG = YAML.load(File.read(File.join(Rails.root, 'config', 'plus.yml')))[Rails.env].symbolize_keys
  Plus.options = PLUS_CONFIG
rescue => e
  Rails.logger.error "Error while initializing Plus: #{e.message}: #{e.backtrace}"
end
