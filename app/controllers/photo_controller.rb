class PhotoController < ApplicationController
  def index
    @agents = Agent.all
    @photo = Photo.all
  end

  def search
    @photo = nil
    if params[:bias].blank?
      @photo = Photo.all
    else @photo = Photo.where(:bia_id => params[:bias])
    end
    respond_to do |format|
      format.turbo_stream { render turbo_stream: [turbo_stream.update('view', partial: 'search', locals: { photo: @photo })]
      }
      format.json { head :no_content }
    end
  end

  def upload
    if request.post?
      unless params[:bias_id].blank? && params[:photo]
        upl = params[:photo]
        path = Rails.root.join('app','assets','images','uploads', upl.original_filename)
        File.open(path, 'wb') do |file|
          file.write(upl.read)
        end
        Photo.create :path=>'uploads/'+upl.original_filename, :bia_id=>params[:bias_id], :user_id=>current_user.id, :likes=>0
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [turbo_stream.update('photo_alert',
                                                      '<div class="p-4 mb-4 text-sm text-green-700 bg-green-100 rounded-lg dark:bg-green-200 dark:text-green-800" role="alert">Photo added</div>')
            ]
          end
        end
      end
    else
      @agents = Agent.all
    end
  end

  def bias
    if request.post? && !params[:bias_name].blank? && !params[:agency_id].blank?
      unless Bia.find_by(:name=>params[:bias_name], :agent_id=>params[:agency_id]).nil?
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [turbo_stream.replace('bias_alert', '<div class="p-4 mb-4 text-sm text-blue-700 bg-blue-100 rounded-lg dark:bg-blue-200 dark:text-blue-800" role="alert">Not save</div>')
            ]
          end
        end
      end
      b = Bia.new :name => params[:bias_name], :agent_id => params[:agency_id]
      if b.save
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [turbo_stream.update('bias_alert',
                                                      '<div class="p-4 mb-4 text-sm text-green-700 bg-green-100 rounded-lg dark:bg-green-200 dark:text-green-800" role="alert">Bias added</div>'),
                                  turbo_stream.update('bias_id',
                                                      Agent.all.inject('') { |html, ag| html + "<optgroup label='#{ag.name}'>" +
                                                        Bia.find_by_agency(ag.id).inject('') { |tmp, bi| tmp + "<option id='#{bi.id}'>#{bi.name}</option>" }+"</optgroup>" })
            ]
          end
        end
      else respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [turbo_stream.replace('bias_alert', '<div class="p-4 mb-4 text-sm text-blue-700 bg-blue-100 rounded-lg dark:bg-blue-200 dark:text-blue-800" role="alert">Not save</div>')
          ]
        end
      end
      end
    end
  end

  def agency
    if request.post? && !params[:agency_name].blank?
      a = Agent.new :name => params[:agency_name]
      if a.save
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [turbo_stream.update('agency_alert',
                                                       '<div class="p-4 mb-4 text-sm text-green-700 bg-green-100 rounded-lg dark:bg-green-200 dark:text-green-800" role="alert">Agency added</div>'),
                                  turbo_stream.update('agency_id',
                                                      Agent.all.inject('') { |html, ag| html + "<option value='#{ag.id}'>#{ag.name}</option>" })
            ]
          end
        end
      else respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [turbo_stream.replace('agency_alert', '<div class="p-4 mb-4 text-sm text-blue-700 bg-blue-100 rounded-lg dark:bg-blue-200 dark:text-blue-800" role="alert">Not save</div>')
          ]
        end
      end
      end
    end
  end

  def like
    photo = Photo.find(params[:id])
    unless photo.nil?
      photo.likes = photo.likes + 1
      if photo.save
        respond_to do |format|
          format.turbo_stream { render turbo_stream: [turbo_stream.update('like-' + photo.id.to_s, html: photo.likes)]
          }
          format.json { head :no_content }
        end
      end
    end
  end
end
