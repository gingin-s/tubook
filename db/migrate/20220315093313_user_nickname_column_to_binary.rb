class UserNicknameColumnToBinary < ActiveRecord::Migration[6.0]
  def up
    execute('ALTER TABLE users MODIFY nickname varchar(255) BINARY')
  end

  def down
    execute('ALTER TABLE users MODIFY nickname varchar(255)')
  end
end
