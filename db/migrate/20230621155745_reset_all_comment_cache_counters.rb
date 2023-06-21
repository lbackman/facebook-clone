class ResetAllCommentCacheCounters < ActiveRecord::Migration[7.0]
  def up
    Comment.all.each do |comment|
      Comment.reset_counters(comment.id, :likes)
    end
  end

  def down
    # no rollback needed
  end
end
