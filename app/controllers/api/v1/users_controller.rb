module Api
  module V1
    # User controller handles interaction with table leafs
    class UsersController < ApplicationController
      before_action :find_user, except: %i[create index]

      ALLOWED_DATA = %(name gender alive birth death description).freeze

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

      # POST /users
      def create
        # data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
        # if data.empty?
        #   return render json: { error: 'Empty body. Could not create user.' }, status: :unprocessable_entity
        # end

        # user = Leaf.new(data)
        # if user.save
        #   render json: user, status: :ok
        # else
        #   render json: { error: 'Could not create user.' }, status: :unprocessable_entity
        # end
      end

      # PUT /users/:id
      def update
        # data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
        # if data.empty?
        #   return render json: { error: 'Empty body. Could not update user.' }, status: :unprocessable_entity
        # end

        # if @user.update(data)
        #   render json: @user, status: :ok
        # else
        #   render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        # end
      end

      # DELETE /users/:id
      def destroy
        # @user.destroy
        # render json: @user, status: :ok
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
        Leaf.find_by_sql("select leafs.id, name, gender from leafs join branches on
          branches.leaf_id = leafs.id join pairs on pairs.id = branches.pair_id where pairs.id =
          (select pair_id from branches where leaf_id = #{params[:id]}) and leafs.id <> #{params[:id]}
          order by birth")
      end
    end
  end
end
