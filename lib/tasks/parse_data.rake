namespace :parse do
  desc "Parse data from the website and save it to the database"
  task services_data: :environment do

    require 'open-uri'
    require 'nokogiri'

    def difficulty_text
      <<~TEXT
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. At quis risus sed vulputate odio ut enim blandit. Nec tincidunt praesent semper feugiat nibh sed pulvinar proin. Non arcu risus quis varius quam quisque id diam vel. Tellus id interdum velit laoreet. Vel facilisis volutpat est velit egestas dui. Duis convallis convallis tellus id interdum velit laoreet id. Tellus orci ac auctor augue mauris augue neque. Sed arcu non odio euismod lacinia at quis. Id cursus metus aliquam eleifend mi in nulla posuere. Aliquet porttitor lacus luctus accumsan. Ac ut consequat semper viverra. Velit dignissim sodales ut eu sem integer. Suscipit tellus mauris a diam. Suspendisse potenti nullam ac tortor vitae purus faucibus ornare.
        Semper feugiat nibh sed pulvinar proin gravida hendrerit. Nunc mattis enim ut tellus elementum sagittis. Proin sed libero enim sed faucibus turpis in eu mi. Tortor id aliquet lectus proin nibh nisl. Tempor orci eu lobortis elementum nibh tellus molestie. Velit dignissim sodales ut eu sem. Faucibus a pellentesque sit amet porttitor. Eget mauris pharetra et ultrices neque ornare aenean euismod elementum. Elit pellentesque habitant morbi tristique senectus et netus et. Quis eleifend quam adipiscing vitae proin. Lorem ipsum dolor sit amet consectetur. Tempor orci eu lobortis elementum nibh tellus.
        Dolor sit amet consectetur adipiscing elit duis tristique sollicitudin nibh. Est ante in nibh mauris cursus mattis. Sagittis vitae et leo duis. Odio aenean sed adipiscing diam donec adipiscing tristique. Lobortis scelerisque fermentum dui faucibus in ornare quam viverra. Amet justo donec enim diam vulputate ut pharetra sit amet. Sagittis orci a scelerisque purus semper eget. Tortor aliquam nulla facilisi cras fermentum odio eu feugiat. Ultrices tincidunt arcu non sodales neque sodales ut etiam sit. Odio euismod lacinia at quis risus.
        Sodales ut etiam sit amet nisl purus in mollis nunc. Ac turpis egestas maecenas pharetra convallis posuere. Nibh sit amet commodo nulla facilisi nullam vehicula ipsum a. Pharetra sit amet aliquam id diam maecenas ultricies mi. Auctor elit sed vulputate mi sit amet mauris commodo. Metus aliquam eleifend mi in nulla posuere sollicitudin aliquam ultrices. Ac turpis egestas maecenas pharetra convallis posuere morbi leo urna. Id neque aliquam vestibulum morbi blandit cursus risus at. Sed augue lacus viverra vitae congue eu consequat ac felis. Dictum varius duis at consectetur lorem donec.
        Accumsan tortor posuere ac ut consequat semper viverra. Sapien faucibus et molestie ac. Tortor posuere ac ut consequat semper viverra nam libero justo. Mauris pellentesque pulvinar pellentesque habitant. Gravida cum sociis natoque penatibus et. Nisi vitae suscipit tellus mauris. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui. Sit amet risus nullam eget felis eget. Est velit egestas dui id ornare arcu odio. Rhoncus aenean vel elit scelerisque mauris pellentesque. Ut etiam sit amet nisl purus in mollis nunc sed. Tortor pretium viverra suspendisse potenti. Ultrices neque ornare aenean euismod elementum. A scelerisque purus semper eget duis at tellus at urna. Velit sed ullamcorper morbi tincidunt ornare massa eget egestas purus. Enim diam vulputate ut pharetra sit amet aliquam id. Enim tortor at auctor urna nunc id cursus metus. Aliquam sem et tortor consequat id. Risus nec feugiat in fermentum posuere. Sem viverra aliquet eget sit amet.
        Feugiat pretium nibh ipsum consequat nisl vel. Praesent tristique magna sit amet purus gravida quis blandit turpis. Aliquam nulla facilisi cras fermentum odio eu feugiat pretium nibh. Pretium vulputate sapien nec sagittis aliquam malesuada bibendum arcu vitae. In hac habitasse platea dictumst quisque sagittis. Ornare arcu odio ut sem nulla pharetra diam. Id diam maecenas ultricies mi eget mauris pharetra. Mattis pellentesque id nibh tortor id aliquet lectus proin. Gravida quis blandit turpis cursus in hac. Sociis natoque penatibus et magnis. Orci a scelerisque purus semper eget duis at tellus at. Mattis enim ut tellus elementum sagittis vitae et leo. Cursus mattis molestie a iaculis at erat pellentesque. Massa placerat duis ultricies lacus sed turpis. Est placerat in egestas erat imperdiet sed euismod nisi. Sit amet consectetur adipiscing elit pellentesque habitant. Fringilla est ullamcorper eget nulla facilisi etiam dignissim diam.
        At lectus urna duis convallis convallis tellus. Enim sed faucibus turpis in eu mi bibendum neque egestas. Aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque. Pharetra pharetra massa massa ultricies mi. Sapien faucibus et molestie ac feugiat sed lectus vestibulum mattis. In metus vulputate eu scelerisque felis imperdiet proin fermentum. Nullam ac tortor vitae purus faucibus ornare suspendisse. Fames ac turpis egestas maecenas. Molestie nunc non blandit massa enim nec dui nunc mattis. Egestas dui id ornare arcu odio ut. Elit eget gravida cum sociis natoque. Maecenas accumsan lacus vel facilisis volutpat. Urna id volutpat lacus laoreet non curabitur gravida. Egestas dui id ornare arcu odio ut sem nulla. Ullamcorper malesuada proin libero nunc consequat interdum varius sit. Vitae congue eu consequat ac felis donec et odio pellentesque. Quam elementum pulvinar etiam non quam lacus suspendisse faucibus. Viverra suspendisse potenti nullam ac tortor vitae purus faucibus ornare. Sit amet commodo nulla facilisi nullam vehicula ipsum a arcu.
      TEXT
    end

    html = URI.open('https://www.nerdwallet.com/article/small-business/service-business-ideas').read
    doc = Nokogiri::HTML(html)

    current_h2 = nil
    first_h2_processed = false

    doc.traverse do |node|
      h2Header = node.name == 'h2' && node['class'] == '_3P4ktl zeCuXk _28z5Fp _1My7YX'
      h3Header = node.name == 'h3' && node['class'] == '_21EZtY eHXiWO _3_uGsM _28z5Fp _1My7YX'

      if h2Header || h3Header
        unless first_h2_processed
          first_h2_processed = true
          next
        end
        current_h2 = node.text.strip
      end

      if node.name == 'ol' && node.at_css('span') && current_h2
        list_content = node.css('span._28z5Fp._3-to_p').map(&:text)
        list_content.each do |item|
          difficulty = Difficulty.find_or_create_by(title: "Medium")
          difficulty.save!
          service = Service.find_or_create_by(title: item.strip, service_type: current_h2, difficulty: Difficulty.first, description: difficulty_text)
          if service.persisted?
            puts "Service #{service.title} created successfully"
          else
            puts "Failed to create service: #{service.errors.full_messages.join(', ')}"
          end
        end
        current_h2 = nil
      end
    end
  end
end

  # namespace :add do
  #   desc "Add data to specialization"
  #   task :specialization_data => :environment do
  #     Specialization.find_or_create_by(title: "Tutor")
  #     Specialization.find_or_create_by(title: "Locksmith")
  #     Specialization.find_or_create_by(title: "Cook")
  #   end
  # end

  namespace :add do
    desc "Add data to specialization"
    task specialization_data: :environment do
      titles = ["Tutor", "Locksmith", "Cook"]
      successes = 0

      titles.each do |title|
        specialization = Specialization.find_or_create_by(title:)
        if specialization.persisted?
          successes += 1
        else
          puts "Failed to add specialization: #{title}"
        end
      end
      if successes == titles.length
        puts "Specializations added successfully"
      else
        puts "Some specializations failed to add"
      end
    end
  end

  namespace :add do
    desc "Add data to urgency"
    task urgency_data: :environment do
      titles = ["Critical", "Urgent", "Normal", "Non-urgent"]
      successes = 0

      titles.each do |title|
        urgency = Urgency.create(title:)

        if urgency.persisted?
          successes += 1
        else
          puts "Failed to add urgency: #{title}"
        end
      end
      if successes == titles.length
        puts "Urgencies added successfully"
      else
        puts "Some urgencies failed to add"
      end
    end
  end

  namespace :add do
    desc "Add data to comment"
    task comment_data: :environment do
      contents = ["Hello1", "Hello2", "Hello3", "Hello4"]
      successes = 0

      contents.each do |content|
        comment = Comment.create(content:)
        if comment.persisted?
          successes += 1
        else
          puts "Failed to add comment: #{content}"
        end
      end

      if successes == contents.length
        puts "Comments added successfully"
      else
        puts "Some comments failed to add"
      end
    end
  end

  namespace :add do
    desc "Add data to status"
    task status_data: :environment do
      titles = ["Done", "In Progress", "Approved", "Not Approved"]
      successes = 0

      titles.each do |title|
        status = Status.create(title:)
        if status.persisted?
          successes += 1
        else
          puts "Failed to add status: #{title}"
        end
      end

      if successes == titles.length
        puts "Statuses added successfully"
      else
        puts "Some statuses failed to add"
      end
    end
  end

# namespace :db do
#   desc "Clear the services table"
#   task clear_services: :environment do
#     Service.destroy_all
#     # puts "Services table has been cleared"
#   end
# end
