class Api::V1::UsersController < ApplicationController
  before_action :find_user, except: %i[create index]

  ALLOWED_DATA = %(name gender alive birth death description).freeze

  # GET /users
  def index
    users = Leaf.all
    render json: users, status: :ok
  end

  # GET /users/:id
  def show
    parents = Leaf.find_by_sql("select id, name, gender from leafs where id in
      (select leafs.id from leafs join pairs on leafs.id = leaf1_id or leafs.id = leaf2_id join
      branches on branches.pair_id = pairs.id where branches.leaf_id = #{params[:id]})")
    puts "parents #{parents}"
    puts "@user #{@user}"
    render json: @user, status: :ok
  end

  # POST /users
  def create
    data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
    return render json: { error: 'Empty body. Could not create user.' }, status: :unprocessable_entity if data.empty?

    user = Leaf.new(data)
    if user.save
      render json: user, status: :ok
    else
      render json: { error: 'Could not create user.' }, status: :unprocessable_entity
    end
  end

  # PUT /users/:id
  def update
    data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
    return render json: { error: 'Empty body. Could not update user.' }, status: :unprocessable_entity if data.empty?

    if @user.update(data)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    render json: @user, status: :ok
  end

  private

  def find_user
    @user = Leaf.find_by_id!(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end
end
