module MiniTransformer
  class KeyList
    attr_accessor :name, :key_label, :description_label, :entries
    
    def to_json(*a)
      {
        'name'   => self.name,
        'key-label'  => self.key_label,
        'description-label' => self.description_label#,
      }.to_json(*a)
    end
    
  end
end