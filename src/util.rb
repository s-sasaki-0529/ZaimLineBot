class Util

  EVENT_JSON_PATH = '/tmp/line_zime/event.json'
  LOG_FILE_PATH   = 'logs'

  #
  # URLとクエリストリング用のパラメータを指定してフルURIを生成する
  #
  def self.url_with_query_string(url, params = nil)
    return url unless params
    url += '?'
    url += params.map { |k, v| "#{k}=#{v}" }.join('&')
    return url
  end

  #
  # /tmpに置いてあるファイルを開く
  #
  def self.load_event_json(parse: false)
    Util.write_log(File.open(EVENT_JSON_PATH).read)
    event_json = File.open(EVENT_JSON_PATH).read
    parse ? JSON.parse(event_json) : event_json
  end

  #
  # /tmpに置いてあるファイルを元にメッセージを取得する
  #
  def self.get_event_message
    json = self.load_event_json(parse: true)
    json['events'][0]['message']['text']
  end

  #
  # ログをファイルに出力する
  #
  def self.write_log(text)
    log = "【#{Time.now}】 #{text}"
    File.open(LOG_FILE_PATH, 'a') do |f|
      f.puts log
    end
  end
end