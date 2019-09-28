class DefaultSerializer
  include FastJsonapi::ObjectSerializer

  attribute :id do |object|
    object.id_external
  end

  # Library Netflix/fast_jsonapi wasn't designed to avoid JSONAPI.org convention.
  # To follow the format expected by specs, i had to remove the convention.
  def serializable_hash
    data = super

    if data[:data].is_a? Hash
      data[:data][:attributes]
    elsif data[:data].is_a? Array
      data[:data].map{ |x| x[:attributes] }
    elsif data[:data] == nil
      nil
    else
      data
    end
  end
end
