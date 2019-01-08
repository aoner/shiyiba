defmodule Sky.Avatar do
  # Include ecto support (requires package arc_ecto installed):
  use Arc.Definition
  use Arc.Ecto.Definition

  # To add a thumbnail version:
  @versions [:original, :thumb]

  # Override the bucket on a per definition basis:
  # def bucket do
  #   :custom_bucket_name
  # end

  # Whitelist file extensions:
  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  end

  # Define a thumbnail transformation:
  def transform(:thumb, _) do
    # {:convert, "-strip -thumbnail 100x100^ -gravity center -extent 100x100"}
    {:convert, "-strip -thumbnail 100x100^ -gravity center -extent 100x100"}
  end

  # Override the persisted filenames:
  def filename(version, _), do: version

  # def filename(version,  {file, _}) do
  #   # # 获取文件扩展名
  #   extname = Path.extname(file.file_name)
  #   # # file_name = Path.basename(file.file_name, extname)
  #   # # extname
  #   # file_name = Path.basename(file.file_name, Path.extname(file.file_name))
  #   "#{version}#{extname}"
  # end

  defp images_dir(user) do
    times = user.inserted_at
    "#{times.year}/#{times.month}/#{times.day}"
  end

  # Override the storage directory:
  def storage_dir(_, { _, scope }) do
    "users/avatars/#{images_dir(scope)}/#{scope.id}"
  end

  # Provide a default URL if there hasn't been a file uploaded
  def default_url() do
    "users/avatars/thumb.png"
  end

  # Specify custom headers for s3 objects
  # Available options are [:cache_control, :content_disposition,
  #    :content_encoding, :content_length, :content_type,
  #    :expect, :expires, :storage_class, :website_redirect_location]
  #
  # def s3_object_headers(version, {file, scope}) do
  #   [content_type: MIME.from_path(file.file_name)]
  # end
end
