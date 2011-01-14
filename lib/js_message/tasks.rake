namespace :js_message do
  desc "Install the jquery.js_message.js into your public/javascripts dir"
  task :install do
    gemdir = File.join(File.dirname(__FILE__), "..", "..")
    print "\n  Copying 'jquery.js_message.js' to rails' public/javascripts dir ... "
    FileUtils.cp(
      File.join(gemdir, "js", "jquery.js_message.js"),
      Rails.root.join("public", "javascripts")
    )
    puts "Done."

    puts %q[
  Now just add the following lines into your application's layout files:

  <%= javascript_include_tag "jquery.js_message.js" %>

  Done! Make sure to restart your server before.
    ]
  end
end
