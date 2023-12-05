require 'trello'

include Trello

Trello.configure do |config|
  config.developer_public_key = 'ba80afb38be5995391bbd6d83eb50cf6'
  config.member_token = 'ATTA8d26c5fd5e831dff140d1df7f46bc29c9fdb0e5ada2b814cc99152e297dd453c90624275'
end

boards = {
  "my-trello-program" => "6567eb16eed089a7622c880d",
  "my-trello-cadcam" => "6567eb16a86c57d844c6f73e",
  "my-trello-fab" => "6567eb16e07091651f117565",
  "my-trello-electrical" => "6569e9fb4973e4b20811acd1",
}

class MyTrello
  def initialize(widget_id, board_id)
    @widget_id = widget_id
    @board_id = board_id
  end

  def widget_id()
    @widget_id
  end

  def board_id()
    @board_id
  end

  def status_list()
    status = Array.new
    List.find(@board_id).cards.each do |cards|
      status.push({label: cards.name})
    end
    status
  end  
end

@MyTrello = []
boards.each do |widget_id, board_id|
  begin
    @MyTrello.push(MyTrello.new(widget_id, board_id))
  rescue Exception => e
    puts e.to_s
  end
end

SCHEDULER.every '5m', :first_in => 0 do |job|
  @MyTrello.each do |board|
    status = board.status_list()
    send_event(board.widget_id, { :items => status })
  end
end
