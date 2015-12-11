class Postcode < ActiveRecord::Base

  def self.search(query)
    query = query.gsub(/-|ー/, "")
    query.tr!("０-９", "0-9")
    postcode = self.where(postcode: query).first
    if postcode.present?
      return postcode
    else
      return { message: "not found." }
    end
  end
end
