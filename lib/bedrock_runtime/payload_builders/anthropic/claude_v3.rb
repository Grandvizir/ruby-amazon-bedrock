module RubyAmazonBedrock
  module PayloadBuilders
    module Anthropic
      # ClaudeV2 is a subclass of Base. It provides functionalities specific to the Anthropic
      # Claude 2 model.
      #
      # @see https://us-east-1.console.aws.amazon.com/bedrock/home?region=us-east-1#/providers?model=anthropic.claude-v2
      # for more information about the Anthropic model.
      class ClaudeV3 < Base
        # Returns the model ID for the Anthropic Claude 2 model.
        #
        # @return [String] 'anthropic.claude-v2'
        def model_id
          'anthropic.claude-3-sonnet-20240229-v1:0'
        end
      end
    end
  end
end