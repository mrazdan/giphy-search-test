require 'spec_helper'

RSpec.describe 'Giphy Search API' do
  BASE_URL = 'https://api.giphy.com/v1/gifs/search'
  API_KEY  = ENV['GIPHY_API_KEY']

  it 'returns results with correct pagination and query' do
    query  = 'fish'
    limit  = 5
    offset = 10

    response = HTTParty.get(BASE_URL, query: {
      api_key: API_KEY,
      q: query,
      limit: limit,
      offset: offset
    })

    expect(response.code).to eq(200)

    body = JSON.parse(response.body)

    expect(body['data'].size).to eq(limit)
    expect(body['pagination']['offset']).to eq(offset)
    expect(body['pagination']['count']).to eq(limit)

    first_slug = body['data'].first['slug']
    expect(first_slug.downcase).to include('fish')
  end
end
