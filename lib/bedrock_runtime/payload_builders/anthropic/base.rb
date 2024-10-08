# frozen_string_literal: true

module RubyAmazonBedrock
  module PayloadBuilders
    module Anthropic
      # Builds and returns a payload hash suitable for the Anthropic model processing.
      # This method constructs a payload with specific parameters like `model_id`,
      # `content_type`, `accept`, and a `body` that includes various AI-related settings.
      #
      # @return [Hash] The constructed payload containing AI model parameters and settings.
      class Base < RubyAmazonBedrock::PayloadBuilders::Base
        # Constructs and returns a payload hash for text generation requests.
        # This method is designed to prepare a structured payload comprising various
        # parameters that dictate how the input text should be processed by the models.
        #
        # @return [Hash] A structured payload hash containing:
        #   - :model_id [String] Identifies the model ('anthropic.claude-2') to process the request.
        #   - :content_type [String] Defines the content type of the payload ('application/json').
        #   - :accept [String] Specifies the MIME type expected in the response.
        #   - :body [String] A JSON string including the following details:
        #     - :prompt [String] The input text for the model to process.
        #     - :max_tokens_to_sample [Integer] The maximum number of tokens the model should generate.
        #     - :temperature [Float] A parameter influencing the randomness in response generation.
        #     - :top_k [Integer] A parameter specifying the number of highest probability vocabulary tokens to keep for
        # 			top-k sampling.
        #     - :top_p [Float] Controls the diversity of the generated text (nucleus sampling).
        #     - :stop_sequences [Array<String>] An array containing specific sequences that signal the model to stop
        # 			text generation.
        #     - :anthropic_version [String] Specifies the version of the underlying model or API.
        def build
          message_models = %w[anthropic.claude-3-sonnet-20240229-v1:0 anthropic.claude-3-5-sonnet-20240620-v1:0]

          return default_api unless message_models.include? model_id

          message_api
        end

        def default_api
          {
            model_id: model_id,
            content_type: 'application/json',
            accept: '*/*',
            body: {
              prompt: "\n\nHuman: #{@prompt}\n\nAssistant:",
              max_tokens_to_sample: parameters[:max_tokens_to_sample],
              temperature: parameters[:temperature],
              top_k: parameters[:top_k],
              top_p: parameters[:top_p],
              stop_sequences: parameters[:stop_sequences],
              anthropic_version: 'bedrock-2023-05-31'
            }.to_json
          }
        end

        def message_api
          {
            model_id: model_id,
            content_type: 'application/json',
            accept: '*/*',
            body: {
              anthropic_version: "bedrock-2023-05-31",
              max_tokens: parameters[:max_tokens_to_sample],
              temperature: parameters[:temperature],
              top_k: parameters[:top_k],
              top_p: parameters[:top_p],
              stop_sequences: parameters[:stop_sequences],
              messages: [
                {
                  role: "user",
                  content: [
                    {
                      type: "text",
                      text: @prompt.to_s
                    }
                  ]
                }
              ]
            }.to_json
          }
        end

        def model_id
          # noop
        end

        def parameters
          {
            max_tokens_to_sample: @options[:max_tokens] || 200,
            temperature: @options[:temperature] || 0.5,
            top_k: @options[:top_k] || 250,
            top_p: @options[:top_p] || 1,
            stop_sequences: @options[:stop_sequences] || ['\n\nHuman']
          }
        end
      end
    end
  end
end
