# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '1m', :first_in => 0 do |job|
  send_event('progress_bars', {title: "Progress", progress_items: [{name: "Duluth Permission Slips", progress: 24, critical: 10, warning: 25, localScope:0} , {name: "First Registration", progress: 98, critical:99, warning:0, localScope:0},{name: "Safety Video Watched", progress: 75, critical:100, warning: 66, localScope:0}]})
end
