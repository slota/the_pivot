class Concert < ActiveRecord::Base
  belongs_to :venue
  before_validation :generate_url

  def generate_url
    self.url = "#{date}-#{band.parameterize}"
  end
end
