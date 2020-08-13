class Contact < ApplicationRecord
  belongs_to :kind

  def kind_description
    self.kind.description
  end
  
  def as_json(options={})
    super(
      root: true,
      except: [:updated_at, :created_at],
      methods: [:kind_description]
      )
  end
end
