module MiniTransformer
  class Book
    attr_accessor :id, :title, :uid, :type, :introduction, :key_list

    def to_json(*a)
      {
        'uid'   => self.uid,
        'type'  => self.type,
        'title' => self.title,
        'id'    => self.id,
        'introduction' => self.introduction,
        "key-list" => self.key_list.to_json
      }.to_json(*a)
    end

  end
end
