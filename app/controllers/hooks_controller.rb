require 'faker'
class HooksController < ApplicationController

  def github
    @log = Log.create(body: params)
    respond_to do |format|
      if @log.save
        format.json { render json: { message: 'successfully added user' }, status: :ok }
      else
        format.json { render json: { message: 'You cannot create the user' }, status: :unprocessable_entity }
      end
    end
  end

  def hook_params
    params.require(:payload)
  end
end
