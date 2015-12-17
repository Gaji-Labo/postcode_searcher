class Postcode < ActiveRecord::Base

  def self.search(query)
    query = query.gsub(/-|ー/, "")
    query.tr!("０-９", "0-9")
    return if query.length <= 3

    if query.length == 7
      postcode = self.where(postcode: query).first
    else
      postcode = self.where("postcode like ?", "#{query}%")
    end

    if postcode.present?
      return postcode
    else
      return { message: "not found." }
    end
  end
end
