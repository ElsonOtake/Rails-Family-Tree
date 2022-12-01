module Api
  module V1
    # Pairs controller handles couples
    class PairsController < ApplicationController
      before_action :find_pair, except: %i[index]

      # GET /users
      def index
        pairs = Pair.all
        render json: pairs, status: :ok
      end

      # GET /users/:id
      def show
        render json: @pair, status: :ok
      end

      private

      def find_pair
        @pair = Pair.find_by_id!(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Pair not found' }, status: :not_found
      end
    end
  end
end
