class CreatePostSubs < ActiveRecord::Migration[6.1]
  def change
    create_table :post_subs do |t|

      t.timestamps
    end
  end
end
