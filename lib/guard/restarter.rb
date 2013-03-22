require "guard"
require "guard/guard"
require "guard/watcher"

module Guard
  class Restarter < ::Guard::Guard
    VERSION = "0.0.2"

    def initialize(watchers = [], options = {})
      super
      @pid = nil
      @command = options[:command]
      @spawn = options[:spawn]
      raise "Must provide option :command or :spawn" unless @command || @spawn
    end

    def start()
      start_info
      start_server
    end

    def run_on_changes(paths)
      run_info
      stop_server
      start_server
    end

    def stop() stop_server end

    private

    def start_server
      custom_spawn_args = { chdir: Dir.pwd, pgroup: true }
      if @command
        args = [@command, custom_spawn_args]
      elsif @spawn.last.is_a? Hash
        args = @spawn[0..-2] << @spawn.last.merge(custom_spawn_args)
      else
        args = @spawn << custom_spawn_args
      end
      @pid = spawn(*args)
      Process.detach(@pid)
    end

    def stop_server
      unless @pid && @pid > 0 && server_is_running
        UI.info "Error: server not started."
        return
      end
      UI.info "Stopping server..."
      Process.kill "INT", -@pid
      20.times do
        return unless server_is_running
        sleep 0.05
      end
      UI.info "Killing server forcibly."
      Process.kill "KILL", -@pid
    end

    def server_is_running()
      !!Process.kill(0, @pid) rescue false
    end

    def start_info
      if @command
        UI.info "Running command '#{@command}'..."
      else
        UI.info "Running spawn: #{@spawn.inspect}..."
      end
    end

    def run_info
      if @pid
        UI.info "Process started, pid #{@pid}"
      else
        UI.info "Error starting process."
      end
    end
  end
end
