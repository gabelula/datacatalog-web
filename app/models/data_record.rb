class DataRecord < ActiveRecord::Base
  belongs_to :owner,        :class_name => "User"
  belongs_to :contact,      :dependent => :destroy
  belongs_to :catalog,      :dependent => :destroy

  has_many :data_record_locations, :dependent => :destroy
  has_many :locations, :through => :data_record_locations

  has_many :sponsors, :dependent => :destroy
  has_many :organizations, :through => :sponsors
  has_one  :lead_organization, :through => :sponsors,
                               :source  => :organization,
                               :conditions => { "sponsors.lead" => true }
  has_many :collaborators, :through => :sponsors,
                           :source  => :organization,
                           :conditions => { "sponsors.lead" => false }

  has_many :authors, :dependent => :destroy

  has_one :wiki, :dependent => :destroy
  # BAD FIX
  has_many :contact, :dependent => :destroy

  has_many :documents, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :ratings,   :dependent => :destroy
  has_many :notes,     :dependent => :destroy

  before_validation_on_create :make_slug
  after_save :link_organizations

  validates_presence_of :description
  validates_presence_of :lead_organization_name
  validates_presence_of :slug, :if => :has_title?
  validates_presence_of :title
  validates_presence_of :year
  validates_presence_of :owner_id

  named_scope :sorted, lambda {|sort|
    { :include => [:organizations, :owner, :locations, :documents, :tags],
      :order   => ["users.role = 'ministry_user' DESC", sort.presence, "locations.lft DESC", "data_records.created_at DESC"].compact.join(", ") }
  } 

  named_scope :by_location, lambda {|country|
    target_country = Location.find(country)

    { :include => :locations,
      :conditions => [
        "data_record_locations.location_id = :id OR (locations.lft <= :lft AND locations.rgt >= :rgt)",
        { :id => target_country.id, :lft => target_country.lft, :rgt => target_country.rgt }
      ]
    }
  }

  named_scope :by_ministry, lambda {|ministry|
    { :conditions => { :owner_id => ministry } }
  }

  named_scope :by_organization, lambda {|organization|
    { :include => :organizations, :conditions => { "organizations.id" => organization } }
  }

  named_scope :by_release_year, lambda {|year|
    { :conditions => { :year => year } }
  }

  named_scope :by_tags, lambda {|*tags|
    { :include => :tags, :conditions => { "tags.name" => tags }}
  }

  accepts_nested_attributes_for :authors, :allow_destroy => true, :reject_if => lambda {|author| author[:name].blank? }
  accepts_nested_attributes_for :contact
  accepts_nested_attributes_for :catalog
  accepts_nested_attributes_for :documents, :allow_destroy => true
  accepts_nested_attributes_for :data_record_locations, :allow_destroy => true

  acts_as_taggable
  acts_as_commentable

  def self.browse(filters, sort_string=nil)
    filters.apply(sorted(sort_string))
  end

  def self.available_years
    all(:select => "DISTINCT(year)", :order => "year DESC").map(&:year)
  end

  def lead_organization_name=(name)
    @lead_organization_name = name
  end

  def lead_organization_name
    if defined?(@lead_organization_name)
      @lead_organization_name
    else
      lead_organization.try(:name) || owner.try(:affiliation).try(:name)
    end
  end

  def collaborator_list=(comma_separated_list)
    @collaborator_list = comma_separated_list
  end

  def collaborator_list
    if defined?(@collaborator_list)
      @collaborator_list
    else
      collaborators.map(&:name).join(", ")
    end
  end

  def ministry
    return unless owner.ministry_user?
    owner
  end

  def to_param
    slug
  end

  def downloads
    warn "DataRecord#downloads is deprecated (called from #{caller.first})"
    []
  end

  def annotations_by(user)
    notes.all(:conditions => { :user_id => user.id })
  end

  def ratings_average
    (ratings_total / [1, ratings_count].max).round
  end

  def build_contact_from_owner
    build_contact(:name  => owner.try(:display_name),
                  :email => owner.try(:email))
  end

  private

  def make_slug
    self.slug = Slugs.make(self, title)
  end

  def has_title?
    title.present?
  end

  def at_least_one_location
    errors.add_to_base(t(:message_must_cover_at_least_one_region)) if data_record_locations.empty?
  end

  def link_organizations
    if lead_organization_name.present?
      lead = Organization.find_or_create_by_name(lead_organization_name)
      sponsors.find_or_create_by_organization_id(:lead => true, :organization_id => lead.id)
    end

    if collaborator_list.present?
      collaborator_list.split(/\s*,\s*/).map(&:strip).each do |collab_name|
        collab = Organization.find_or_create_by_name(collab_name)
        sponsors.find_or_create_by_organization_id(:lead => false, :organization_id => collab.id)
      end
    end
  end
end
