# frozen_string_literal: true

require "sinatra"
require "webrick"
require "sqlite3"
require "fileutils"

DB_DIR = File.expand_path("data", __dir__)
DB_PATH = File.join(DB_DIR, "app.sqlite3")

FileUtils.mkdir_p(DB_DIR)

def db
  @db ||= begin
    conn = SQLite3::Database.new(DB_PATH)
    conn.results_as_hash = true
    conn.type_translation = true
    conn.execute <<~SQL
      CREATE TABLE IF NOT EXISTS tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        completed BOOLEAN NOT NULL DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      );
    SQL
    conn
  end
end

get "/" do
  @tasks = db.execute("SELECT id, title, completed, created_at FROM tasks ORDER BY id DESC")
  erb :index
end

post "/add" do
  title = params[:title]&.strip
  if title && !title.empty?
    db.execute("INSERT INTO tasks (title) VALUES (?)", [title])
  end
  redirect "/"
end

post "/done/:id" do
  id = params[:id].to_i
  db.execute("UPDATE tasks SET completed = 1 WHERE id = ?", [id])
  redirect "/"
end

post "/undone/:id" do
  id = params[:id].to_i
  db.execute("UPDATE tasks SET completed = 0 WHERE id = ?", [id])
  redirect "/"
end

post "/delete/:id" do
  id = params[:id].to_i
  db.execute("DELETE FROM tasks WHERE id = ?", [id])
  redirect "/"
end
