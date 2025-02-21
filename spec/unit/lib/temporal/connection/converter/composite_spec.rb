require 'temporal/connection/converter/payload/bytes'
require 'temporal/connection/converter/payload/json'

describe Temporal::Connection::Converter::Composite do
  let(:bytes_converter) { Temporal::Connection::Converter::Payload::Bytes.new }
  let(:json_converter) { Temporal::Connection::Converter::Payload::JSON.new }

  subject { described_class.new(payload_converters: [bytes_converter, json_converter]) }

  describe 'encoding' do
    it 'tries converters until it finds a match' do
      payloads = [
        Temporalio::Api::Common::V1::Payload.new(
          metadata: { 'encoding' =>  Temporal::Connection::Converter::Payload::Bytes::ENCODING },
          data: 'test'.b
        ),
        Temporalio::Api::Common::V1::Payload.new(
          metadata: { 'encoding' =>  Temporal::Connection::Converter::Payload::JSON::ENCODING },
          data: '"test"'
        ),
      ]

      expect(bytes_converter).to receive(:to_payload).exactly(2).times.and_call_original
      expect(json_converter).to receive(:to_payload).once.and_call_original

      results = [subject.to_payload('test'.b), subject.to_payload('test')]

      expect(results).to eq(payloads)
    end
  end

  describe 'decoding' do
    it 'uses metadata to pick a converter' do
      payloads = [
        Temporalio::Api::Common::V1::Payload.new(
          metadata: { 'encoding' =>  Temporal::Connection::Converter::Payload::Bytes::ENCODING },
          data: 'test'.b
        ),
        Temporalio::Api::Common::V1::Payload.new(
          metadata: { 'encoding' =>  Temporal::Connection::Converter::Payload::JSON::ENCODING },
          data: '"test"'
        ),
      ]

      expect(bytes_converter).to receive(:from_payload).once.and_call_original
      expect(json_converter).to receive(:from_payload).once.and_call_original

      subject.from_payload(payloads[0])
      subject.from_payload(payloads[1])
    end

    it 'raises if there is no converter for an encoding' do
      payload = Temporalio::Api::Common::V1::Payload.new(
        metadata: { 'encoding' => 'fake' }
      )

      expect { subject.from_payload(payload) }.to raise_error(Temporal::Connection::Converter::Composite::ConverterNotFound)
    end
  end
end
