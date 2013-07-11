class Chef::Recipe
  # An exception to raise when neither git or hg is provided as a
  #   provider/resource for SCM
  NoProviderForRepositoryType = Class.new(RuntimeError)

  # @param [Hash] params the parameters to iterate over when running the SCM
  #   resources/providers
  # @raise [NoProviderForRepositoryType] if params[:type] isn't git or hg
  # @return [void]
  def sync_repository(params = Hash[[:path, :type, :repository, :reference, :key].zip(*nil)])
    case params[:type].to_s
    when 'hg', 'mercurial'
      mercurial params[:path] do
        repository params[:repository]
        reference params[:reference]
        key params[:key] if params[:key]
        action :sync
      end
    when 'git'
      git params[:path] do
        repository params[:repository]
        reference params[:reference]
        action :sync
      end
    else
      raise NoProviderForRepositoryType, "You gave the hash: #{params}. Which didn't provide a valid value for :type."
    end
  end
end
