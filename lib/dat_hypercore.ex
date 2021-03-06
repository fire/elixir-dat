
defmodule Dat.Hypercore.Placeholder do

  def get_batch(feed, start, _end, {:config, timeout, value_encoding}) do
    []
  end

  def head(feed, {:config, timeout, value_encoding}) do
    {:error, ''}
  end

  def download(feed, {:range, start, _end, linear}) do
    {:error, ['']}
  end

  def undownload(feed, {:range, start, _end, linear}) do
    {:error}
  end

  def signature(feed, {:index}) do
    {:error, 'last_signed_block', 'signature'}
  end

  def verify(feed, signature) do
    {:error, true}
  end

  def root_hashes(feed, index) do
    {:error, [{'roots', 'index', 'size', 'hash'}]}
  end

  # total_number_of_downloaded_blocks_within_range
  def downloaded(feed, start, _end) do
    0
  end

  def has_local(feed, index) do
    true
  end

  def has_local(feed, start, _end) do
    true
  end

  def clear do
  end

  def close do
  end

  def seek do
  end

  def update do
  end

  def set_downloading do
  end

  def set_uploading do
  end

  # create_read_stream

  # create_write_stream

  def is_writable do
  end

  def is_readable do
  end

  def key do
  end

  def discovery_key do
  end

  def length do
  end

  def byte_length do
  end

  def stats do
  end

  def on_peer_add do
  end

  def on_peer_remove do
  end

  def on_peer_open do
  end

  def connected_peers do
  end

  def register_replication_extension do
  end

  def send() do
  end

  def broadcast() do
  end

  def on_ready() do
  end

  def on_error() do
  end

  def on_download() do
  end

  def on_upload() do
  end

  def on_sync() do
  end

  def on_close() do
  end
end

defmodule Dat.Hypercore do
  @moduledoc """
  Documentation for Dat Hypercore.
  """

  def start(_args) do
    # the initial cluster members
    members = Enum.map([:a@localhost, :b@localhost, :c@localhost], fn node -> { :rakv, node } end)
    # an arbitrary cluster name
    clusterName = <<"dat_hypercore">>
    # the config passed to `init/1`, must be a `map`
    config = %{}
    # the machine configuration
    machine = {:module, Dat.Hypercore.Machine, config}
    # ensure ra is started
    Application.ensure_all_started(:ra)
    # start a cluster instance running the `ra_kv` machine
    :ra.start_cluster(clusterName, machine, members)
  end

  ## Client API

  def new(serverid) do
    :ra.process_command(serverid, {:new})
  end

  def get(serverid, key) do
    :ra.process_command(serverid, {:get, key})
  end

  def set(serverid, key, feed = %Dat.Hypercore.Feed{}, index, config = %Dat.Hypercore.Config{}) do
    :ra.process_command(serverid, {:set, key, feed, index, config})
  end

  def append(serverid, key, block) do
    :ra.process_command(serverid, {:append, key, block})
  end
end
