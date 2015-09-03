require 'image_suckr'

photos = []

suckr = ImageSuckr::GoogleSuckr.new({:usz => "200"})
iteration = 0

while photos.length < 200 do
  iteration += 1
  picture = suckr.get_image_url
  if picture == nil
    puts "sleeping..."
    sleep(61)
  end
  photos << picture unless photos.any? { |photo| photo == picture }
  puts picture
  puts iteration
  puts photos.length
end

puts photos
