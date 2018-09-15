require "qt5"
require "mongo"

class LazyMongo
  def initialize
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

    mongo_url = Qt::LineEdit.new "mongodb://127.0.0.1:27017/dbname/colname"
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
      mongo_path = mongo_url.text.gsub("mongodb://", "")

      database_name = mongo_path.split("/")[-2]
      collection_name = mongo_path.split("/")[-1]

      if database_name.empty? || collection_name.empty? || database_name.includes?(":") || collection_name.includes?(":")
        data.placeholder_text = "Invalid Mongo Url"
      else
        unless data.to_plain_text.empty?
          database = Mongo::Client.new "mongodb://#{mongo_path}"
          separator = data.text_cursor.selected_text
          unless separator.empty?
            raw_data = data.to_plain_text
            raw_data_arr = raw_data.gsub("\r\n", "\n").gsub("\r", "\n").split("\n")

            if raw_data_arr.size > 1
              header = raw_data_arr[0].split(separator)
              raw_data_arr.delete_at(0)
              raw_data_arr.each do |line|
                line = line.split(separator)
                if header.size == line.size
                  document = {} of String => String | Int32 | Int64
                  (header.size).times { |i| document[header[i]] = line[i] }
                  database[database_name][collection_name].insert(document)
                end
              end
            end
          end
        end
      end
    end

    # We're ready for showtime
    window.show
    window.resize(640, 560)

    # And now, start it!
    Qt::Application.exec
  end

  def alert(title : String, message : String)
    qApp = Qt::Application.new

    # We'll use a normal widget as window
    window = Qt::Widget.new
    window.window_title = title

    # We need to give it a layout
    layout = Qt::VBoxLayout.new
    window.layout = layout

    image_label = Qt::Label.new "Invalid Mongo Path"

    layout << image_label

    window.resize(150, 50)
    window.show
    sleep 2.seconds
    window.close
  end
end

LazyMongo.new
