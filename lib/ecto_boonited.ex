defmodule EctoBoonited.Repo do
  use Ecto.Repo, otp_app: :ecto_boonited
end

defmodule EctoBoonited.Model do
  defmacro __using__(_) do
    quote do
      use Ecto.Model
      @primary_key {:id, :string, autogenerate: false}
      @foreign_key_type :string
    end
  end
end

defmodule EctoBoonited.User do

  use EctoBoonited.Model

  schema "user" do
    field :created, Ecto.DateTime
    field :updated, Ecto.DateTime
  end
end


defmodule EctoBoonited.App do
  use Application

  import Ecto.Query
  alias EctoBoonited.User
  alias EctoBoonited.Repo

  def start(_type, _args) do
    import Supervisor.Spec
    tree = [worker(EctoBoonited.Repo, [])]
    opts = [name: EctoBoonited.Sup, strategy: :one_for_one]
    Supervisor.start_link(tree, opts)
  end

  def keyword_query do
    query = from w in User,
    select: w
    Repo.all(query)
  end
end
