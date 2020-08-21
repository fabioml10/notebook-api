class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate#, :custom_att

  belongs_to :kind do
    link(:related) { contact_kind_url(object.id) }
  end

  has_many :phones do
    link(:related) { contact_phones_url(object.id) }
  end

  has_one :address do
    link(:related) { contact_address_url(object.id) }
  end

  def attributes(*args)
    h = super(*args)
    # h[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?)
    h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    h
  end

  # def custom_att
  #   "Custom Attrinutes"
  # end
end
