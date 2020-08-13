class Contact < ApplicationRecord
  belongs_to :kind
  has_many :phones

  def kind_description
    self.kind.description
  end

  def as_json(options={})
    super(
      root: true,
      except: [:updated_at, :created_at],
      methods: [:kind_description, :test_i18n]
      )
  end

  def test_i18n
    I18n.t('hello')
  end
end
