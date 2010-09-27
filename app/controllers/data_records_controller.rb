class DataRecordsController < ApplicationController
  before_filter :require_user, :only => [:new, :create]
  before_filter :initialize_data_record, :only => :new

  def index
    @filters = Filters.new(params[:filters])

    records = @filters.apply(DataRecord.ministry_records_first)
    @data_records = records.paginate(:page => params[:page], :per_page => 25)
  end

  def show
    @data_record = DataRecord.find_by_slug(params[:id])
    @comments = @data_record.root_comments
    @comment = @data_record.comment_threads.new(
      :reports_problem => params.has_key?(:reports_problem),
      :parent_id       => params[:parent_id]
    )
  end
  
  def new
  end

  def create
    @data_record = DataRecord.new(params[:data_record])

    if current_user.admin?
      @data_record.owner_id = params[:data_record][:owner_id]
    else
      @data_record.owner_id = current_user.id
    end

    if @data_record.save
      flash[:notice] = "Your Data has been submitted"
      redirect_to @data_record
    else
      @document_type = params[:provide_document]
      @data_record.build_author  if @data_record.author.blank?
      @data_record.build_contact if @data_record.contact.blank?
      @data_record.build_catalog if @data_record.catalog.blank?
      render :new
    end
  end

  private

  def initialize_data_record
    @data_record = current_user.data_records.new
    @data_record.documents.build
    @data_record.build_author
    @data_record.build_contact
    @data_record.build_catalog
  end
end
