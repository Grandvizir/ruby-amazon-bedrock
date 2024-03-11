# # frozen_string_literal: true
#
# require 'spec_helper'
# require 'bedrock_runtime/payload_builders/anthropic/claude_v2'
#
# RSpec.describe RubyAmazonBedrock::PayloadBuilders::Anthropic::ClaudeV3 do
#   let(:prompt) { 'example_prompt' }
#   let(:options) { {} }
#   let(:body) do
#     {
#       anthropic_version: "bedrock-2023-05-31",
#       max_tokens: 4096,
#       temperature: 0,
#       top_k: 250,
#       top_p: 1,
#       stop_sequences: [
#         '\n\nHuman'
#       ],
#       messages: [
#         {
#           role: "user",
#           content: [
#             {
#               type: "text",
#               text: prompt.to_s
#             }
#           ]
#         }
#       ]
#     }.to_json
#   end
#
#   describe '#build' do
#     it_behaves_like 'a payload builder'
#
#     context 'with custom parameters' do
#       include_context 'anthropic parameters'
#       it_should_behave_like 'a payload builder'
#     end
#   end
# end
