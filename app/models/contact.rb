class Contact < ApplicationRecord
  def as_json(options={})
    super(root: true)
  end
end
