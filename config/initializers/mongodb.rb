MongoMapper.setup(YAML.load_file(Rails.root.join('config', 'database.yml')), Rails.env, {
  :logger    => Rails.logger, 
  :passenger => true
})

module IdentityMapAddition
  def self.included(model)
    model.plugin MongoMapper::Plugins::IdentityMap
  end
end

MongoMapper::Document.append_inclusions(IdentityMapAddition)