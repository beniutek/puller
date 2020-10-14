require 'puller'

describe Puller do
  let(:owner) { 'owner' }
  let(:repo) { 'repo' }
  let(:url) { "https://api.github.com/repos/#{owner}/#{repo}/pulls" }
  let(:title) { 'title' }
  let(:body) { 'body' }
  let(:head) { 'head' }
  let(:base) { 'base' }
  let(:params) {{
    title: title,
    head: head,
    base: base,
    body: body,
    maintainer_can_modify: true,
  }}
  let(:headers) {{
    "Accept" => "application/vnd.github.v3+json",
  }}
  let(:puller) { described_class.new(owner, repo) }
  let(:ok_response) { 'ok' }

  before do
    allow(RestClient).to receive(:post).and_return(nil)
  end

  describe '#create_pull_request' do
    context 'when params are ok' do
      before do
        allow(RestClient).to receive(:post).with(url, params, headers).and_return(ok_response)
      end

      it 'sends a requests to github api' do
        expect(puller.create_pull_request('title', 'head', 'base', 'body')).to eq(ok_response)
      end
    end

    context 'when one param is nil' do
      it 'raises an error' do
        expect { puller.create_pull_request('title', 'head', nil, 'body') }.to raise_error(Puller::BadParamError)
      end
    end

    context 'when one param is an empty string' do
      it 'raises an error' do
        expect { puller.create_pull_request('title', 'head', '', 'body') }.to raise_error(Puller::BadParamError)
      end
    end
  end
end
