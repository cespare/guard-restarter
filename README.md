# Guard::Restarter

This is a small guard plugin to run a command (typically a server) and restart it when files change. It
restarts the process by killing it (with SIGINT, followed by SIGKILL if it doesn't die after a bit). It takes
care of ensuring the process (and any children) are gone before bringing it up again.

## Installation

    $ gem install guard-restarter

or add it to your gemfile:

``` ruby
gem "guard-restarter"
```

## Usage

Pretty straightforward:

``` ruby
guard :restarter, :command => "./run_server" do
  watch(/\.*\.[ch]$/)
end
```

You can also pass in the full set of arguments to `Process.spawn` for more control:

``` ruby
guard :restarter, :spawn => [{ "CC" => "gcc" }, "make", :err => "/dev/null"] do
  watch(/\.*\.[ch]$/)
end
```
