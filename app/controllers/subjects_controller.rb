class SubjectsController < ApplicationController
  
  layout "admin"

  before_action :confirm_logged_in

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new
  end

  def create
    # Instantiate a new obj using form parameters
    @subject = Subject.new(subject_params)
    # Save the object
    if @subject.save
    # If save succeeds, redirect to the index action
      flash[:notice] = "Subject created successfully."
      redirect_to(:action => 'index')
    else
    # If save fails, redisplay the form so the user can fix the problem
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    # Find an existing obj using form parameters
    flash[:notice] = "Subject updated successfully."
    @subject = Subject.find(params[:id])
    # Update the object
    if @subject.update_attributes(subject_params)
    # If update succeeds, redirect to the index action
      redirect_to(:action => 'show', :id => @subject.id)
    else
    # If update fails, redisplay the form so the user can fix the problem
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' destroyed successfully."
    redirect_to(:action => 'index')
  end

  private

    def subject_params
      # same as using "params[:subject]", except that it:
      # - raises an error if :subject is not present
      # - allows listed attributes to be mass-assigned
      params.require(:subject).permit(:name, :position, :visible, :created_at)
    end
end
