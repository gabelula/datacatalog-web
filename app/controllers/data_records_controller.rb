class DataRecordsController < ApplicationController
  before_filter :require_user, :only => [:new, :create]
  before_filter :find_data_record, :only => [:show, :edit, :update]
  before_filter :require_owner_or_admin, :only => [:edit, :update]

  include BrowseTableSorts

  def index
    @filters = Filters.new(params[:filters])
    @data_records = DataRecord.browse(@filters, sort_order).paginate(:page => params[:page], :per_page => 25)
  end

  def show
    @comments = @data_record.root_comments
    @comment = @data_record.comment_threads.new(
      :reports_problem => params.has_key?(:reports_problem),
      :parent_id       => params[:parent_id]
    )
  end
  
  def new
    @data_record = current_user.data_records.new
    initialize_data_record_associations
  end

  def create
    @data_record = DataRecord.new(params[:data_record])

    if current_user.admin?
      @data_record.owner_id = params[:data_record][:owner_id]
    else
      @data_record.owner_id = current_user.id
    end

    if @data_record.save
      flash[:notice] =  t(:message_your_data_has_been_submitted)
      redirect_to @data_record
    else
      #initialize_data_record_associations
      render :new
    end
  end

  def edit
    initialize_data_record_associations
  end

  def update
    if current_user.admin?
      @data_record.owner_id = params[:data_record][:owner_id]
    else
      @data_record.owner_id = current_user.id
    end

    if @data_record.update_attributes(params[:data_record])
      flash[:notice] = t(:message_your_data_has_been_updated)
      redirect_to @data_record
    else
      initialize_data_record_associations
      render :edit
    end
  end

  private

  def initialize_data_record_associations
    @data_record.documents.build if @data_record.documents.empty?
    @data_record.authors.unshift Author.new(:affiliation_name => @data_record.lead_organization_name)
    @data_record.build_contact_from_owner if @data_record.contact.blank?
    @data_record.data_record_locations.build(:location_id => Location.global.id) if @data_record.locations.empty?
  end

  def find_data_record
    @data_record = DataRecord.find_by_slug(params[:id], :include => [:organizations, :locations, :authors, :contact, :tags, :comment_threads, :ratings, :favorites])
  end

  def require_owner_or_admin
    unless current_user == @data_record.owner || current_user.admin?
      flash[:notice] = t(:message_you_dont_have_permission_to_do_that)
      redirect_to @data_record
    end
  end
end
