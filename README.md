# Ruby SQLite Todo Web App

A beautiful web-based todo app built with Ruby 3.4.7, Sinatra, and SQLite.

## Setup

1. Ensure Ruby 3.4.7 (see `.ruby-version`).
2. Install gems:
   ```bash
   bundle install
   ```

## Running the Web App

Start the web server:
```bash
ruby app.rb
```

Then open your browser and visit:
```
http://localhost:4567
```

The app will automatically create the SQLite database at `data/app.sqlite3` on first run.

## Features

- ✅ Add new tasks
- ✅ Mark tasks as complete/incomplete
- ✅ Delete tasks
- ✅ Beautiful, modern UI
- ✅ Responsive design

SQLite database lives at `data/app.sqlite3` and is created on first run.
