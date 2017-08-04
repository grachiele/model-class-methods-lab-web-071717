class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.joins(:boats => :classifications).where("classifications.name = 'Catamaran'")
  end

  def self.sailors
    Captain.joins(:boats => :classifications).where("classifications.name = 'Sailboat'").distinct
  end

  def self.talented_seamen
    self.joins(:boats => :classifications).where("captains.id IN (?) AND classifications.name = 'Motorboat'", self.sailors.pluck(:id))
  end

  def self.non_sailors
    self.joins(:boats => :classifications).where("captains.id NOT IN (?)", self.sailors.pluck(:id)).distinct
  end

end
