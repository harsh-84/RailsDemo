class BookmarksController < ApplicationController

  before_action :authenticate_user! 
  require 'will_paginate/array'

  def index
     @bookmark = current_user.bookmarks.paginate(page: params[:page],per_page: 2).order('created_at DESC')
    # @bookmarks = []
    # Bookmark.all.each do |bookmark|
    # @bookmarks.push(current_user.bookmarks)
    # end
    # @bookmark = @bookmarks.paginate(page: params[:page],per_page: 2)
    # @bookmark = current_user.bookmarks
  end

  def create
    @bookmark = current_user.bookmarks.new(feed_id: params[:feed_id])

    
    if @bookmark.save
      flash[:success] =  'Bookmark was successfully created.'
    else
      flash[:error] =  'Bookmark error'
    end
  
    redirect_to feeds_path
  end


 def destroy

   @bookmark = Bookmark.find(params[:id])
    if @bookmark.destroy
     
      redirect_to feeds_path

    end
  end
end
