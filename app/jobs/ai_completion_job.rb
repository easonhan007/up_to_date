class AiCompletionJob < ApplicationJob
  queue_as :default

  def perform(post, openai_key, openapi_base_url, prompt)
    post.rewrite_title(openai_key, openapi_base_url, prompt)
  end
end
