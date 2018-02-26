# http://til.obiefernandez.com/posts/8c31a92080-rails-5-attributes-api-jsonb-postgres-columns
class JsonbType < ActiveModel::Type::Value
  include ActiveModel::Type::Helpers::Mutable

  def type
    :jsonb
  end

  def deserialize(value)
    if value.is_a?(::String)
      Oj.load(value,{}) rescue nil
    else
      value
    end
  end

  def serialize(value)
    if value.nil?
      nil
    else
      Oj.dump(value,{})
    end
  end

  def accessor
    ActiveRecord::Store::StringKeyedHashAccessor
  end
end

ActiveRecord::Type.register(:jsonb, JsonbType, override: true)