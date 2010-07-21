class PartsController < ApplicationController
  
  def create
    puts "thing: #{params.inspect}"
    # @todo validation on dups, invalid/no name, etc
    gadget_id = params[:gadget_id]
    name = params[:part_name]
    part = Part.new(:name => name, :gadget_id => gadget_id)
    part.save!
    redirect_to "/gadgets/#{gadget_id}/detail"
  end
  
  def new
    fetch_gadget
    @gadget_name = @gadget.name
    @gadget_id = params[:gadget_id]
    @show_new_part = true
    render '/gadgets/detail', :layout => 'application'
  end

  protected
  def fetch_gadget
    @gadget_id = params[:gadget_id]
    @gadget = Gadget.find(params[:gadget_id])
  end
end
