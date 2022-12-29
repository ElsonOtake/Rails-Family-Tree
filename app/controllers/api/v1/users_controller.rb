module Api
  module V1
    # User controller handles interaction with table leafs
    class UsersController < ApplicationController
      before_action :find_user, except: %i[index]

      # GET /users
      def index
        users = Leaf.all
        render json: users, status: :ok
      end

      # GET /users/:id
      def show
        @user.parents = find_parents
        @user.children = find_children
        @user.partner = find_partner
        @user.siblings = find_siblings
        render json: @user.serializable_hash(include: %i[parents children partner siblings]), status: :ok
      end

      private

      def find_user
        @user = Leaf.find_by_id!(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
      end

      def find_parents
        branch = Branch.select(:pair_id).where('leaf_id = ?', params[:id])
        p1 = Pair.select(:leaf1_id).where(id: branch)
        p2 = Pair.select(:leaf2_id).where(id: branch)
        Leaf.select(:id, :name, :gender).where(id: p1).or(Leaf.where(id: p2)).order(gender: :desc)
      end

      def find_children
        pair = Pair.where('leaf1_id = ?', params[:id]).or(Pair.where('leaf2_id = ?', params[:id]))
        branches = Branch.where(pair_id: pair).select(:leaf_id)
        Leaf.select(:id, :name, :gender).where(id: branches).order(:birth)
      end

      def find_partner
        p1 = Pair.select(:leaf1_id).where('leaf2_id = ?', params[:id])
        p2 = Pair.select(:leaf2_id).where('leaf1_id = ?', params[:id])
        Leaf.select(:id, :name, :gender).where(id: p1).or(Leaf.where(id: p2))
      end

      def find_siblings
        parents = Branch.where('leaf_id = ?', params[:id])[0].pair_id
        siblings = Branch.select(:leaf_id).where('pair_id = ?', parents).where.not('leaf_id = ?', params[:id])
        Leaf.select(:id, :name, :gender).where(id: siblings).order(:birth)
      end
    end
  end
end
