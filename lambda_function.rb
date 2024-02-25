require "json"

def handler(event:, context:)
  {
    statusCode: 200,
    body: {
      event_type: event.class,
      event: event,
      context_type: context.class,
      context: context.inspect
    }
  }
end
