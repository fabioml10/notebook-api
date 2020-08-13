class Contact < ApplicationRecord
  belongs_to :kind
  has_many :phones
  accepts_nested_attributes_for :phones, allow_destroy: true
  has_one :address
  accepts_nested_attributes_for :address, update_only: true #nao cria novos registros, sempre atualzia o ultimo

  def kind_description
    self.kind.description
  end

  def as_json(options={})
    super(
      root: true,
      except: [:updated_at, :created_at],
      # methods: [:kind_description, :test_i18n],
      include: [:kind, :phones, :address]
      )
  end

  def test_i18n
    I18n.t('hello')
  end
end
