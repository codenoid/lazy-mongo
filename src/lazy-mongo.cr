require "qt5"
require "mongo"

# Create the application first
qApp = Qt::Application.new

# We'll use a normal widget as window
window = Qt::Widget.new
window.window_title = "Lazy Mongo - Manage Any Data From Row TextEdit"

# We need to give it a layout
layout = Qt::VBoxLayout.new
window.layout = layout

# Create a input and a button, and push it into the layout
execute = Qt::PushButton.new "EXECUTE"
select_file = Qt::PushButton.new "Choose file"

mongo_url = Qt::LineEdit.new "mongodb://127.0.0.1:27017"
data = Qt::TextEdit.new
file = Qt::FileDialog.new

data.accept_rich_text = true
data.undo_redo_enabled = true

layout << mongo_url << select_file << data << execute

select_file.on_pressed do
  file_url = Qt::FileDialog.get_open_file_url

  unless file_url.empty?
    file_content = File.read file_url.to_local_file
    data.text = file_content
  end
end

execute.on_pressed do # This is how you connect to the `pressed` signal
  unless data.to_plain_text.empty?
    database_name = mongo_url.text.split("/")[-2]
    collection_name = mongo_url.text.split("/")[-1]
    puts database_name
    puts data.text_cursor.selected_text
  end
end

# We're ready for showtime
window.show
window.resize(640, 560)

# And now, start it!
Qt::Application.exec
