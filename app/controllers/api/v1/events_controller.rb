module Api
  module V1
    class EventsController < Api::V1::ApiController
      include RespondXlsx
      before_action :set_animal
      def index
        @events = @animal.events.page(params[:page]).per(params[:row])
        render partial: 'index.json.jbuilder'
      end

      def show
        @event = @animal.events.find(params[:id])
      end

      def create
        authorize @animal
        event = @animal.events.build(event_params)
        if event.save
          render json: event.as_json(only: [:id]), status: :created
        else
          render json: { error: event.errors.as_json }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @animal
        @event = @animal.events.find(params[:id])
        @event.destroy
        head :no_content
      end

      def search
        @events = @animal.events.search(search_params).page(params[:page]).per(params[:row])
        render partial: 'index.json.jbuilder'
      end

      def export_events
        @events = @animal.events
        respond_excel("eventos_#{@animal.name}", 'excel_events', '/api/v1/events')
        render json: { url: @url }
      end

      private

      def set_animal
        @animal = Animal.find(params[:animal_id])
      end

      def event_params
        params.require(:event).permit(:name, :description, :date)
      end

      def search_params
        params.permit(:text)
      end
    end
  end
end
