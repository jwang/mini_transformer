module MiniTransformer
  class Entry
    attr_accessor :key_name, :description
    
    def to_json(*a)
      {
        'key-name'   => self.key_name,
        'description'  => self.description
      }.to_json(*a)
    end
    
  end
end