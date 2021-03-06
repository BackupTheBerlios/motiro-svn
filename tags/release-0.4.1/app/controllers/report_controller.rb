require 'models/headline'

require 'core/chief_editor'

class ReportController < ApplicationController
  
  layout :determine_layout
  
  def initialize(chief_editor=ChiefEditor.new)
    @chief_editor = chief_editor
  end
  
  def determine_layout
    return 'application' if params[:id] and params[:context] != 'partial'
    return nil
  end
  
  def show
    reporter_name = params[:reporter]
    
    @name = reporter_name

    if params[:id]
      id = params[:id]
      context = params[:context] || 'full'
      begin
        @revision_id = id
        @headline = @chief_editor.headline_with(reporter_name, id)
        @partial = context == 'partial'
        
        render(:action => "#{reporter_name}_detail")
      rescue
        logger.error("Tried to access invalid headline #{id} from #{reporter_name}")
        flash[:notice] = 'The article %s from the %s reporter could not be found' / id / reporter_name.capitalize
        redirect_to(:controller => 'root', :action => 'index')
      end            
    else
      format = params[:format] || 'html_fragment'
      
      @title = @chief_editor.title_for reporter_name
      @headlines = @chief_editor.latest_news_from reporter_name
      render(:action => format)
    end
  end
  
end
