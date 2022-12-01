module Api
  module V1
    # Branches controller handles parents data
    class BranchesController < ApplicationController
      before_action :find_branch, except: %i[index]

      # GET /users
      def index
        branches = Branch.all
        render json: branches, status: :ok
      end

      # GET /users/:id
      def show
        render json: @branch, status: :ok
      end

      private

      def find_branch
        @branch = Branch.find_by_id!(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Branch not found' }, status: :not_found
      end
    end
  end
end