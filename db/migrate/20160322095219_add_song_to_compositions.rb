class AddSongToCompositions < ActiveRecord::Migration
  def change
    add_attachment :compositions, :song
  end
end
