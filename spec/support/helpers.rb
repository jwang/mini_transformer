module Spec
  module Helpers    
    attr_reader :out, :err, :exitstatus

    def lib
      File.expand_path('../../../lib', __FILE__)
    end

    def mini_transform(cmd, options = {})
      #p "mini transforming"
      expect_err  = options.delete(:expect_err)
      exitstatus = options.delete(:exitstatus)
      #options["no-color"] = true unless options.key?("no-color") || cmd.to_s[0..3] == "exec"

      mini_transform = File.expand_path('../../../bin/mini_transform', __FILE__)

      #requires = options.delete(:requires) || []
      #requires << File.expand_path('../fakeweb/'+options.delete(:fakeweb)+'.rb', __FILE__) if options.key?(:fakeweb)
      #requires << File.expand_path('../artifice/'+options.delete(:artifice)+'.rb', __FILE__) if options.key?(:artifice)
      #requires_str = requires.map{|r| "-r#{r}"}.join(" ")

      #env = (options.delete(:env) || {}).map{|k,v| "#{k}='#{v}' "}.join
      args = options.map do |k,v|
        v == true ? " --#{k}" : " --#{k} #{v}" if v
      end.join

      cmd = "#{Gem.ruby} -I#{lib} #{mini_transform} #{cmd}#{args}"
      #p "cmd: #{cmd}"
      if exitstatus
        sys_status(cmd)
      else
        sys_exec(cmd, expect_err){|i| yield i if block_given? }
      end
    end
    
    def sys_status(cmd)
      @err = nil
      @out = %x{#{cmd}}.strip
      @exitstatus = $?.exitstatus
    end
    
    def sys_exec(cmd, expect_err = false)
      Open3.popen3(cmd.to_s) do |stdin, stdout, stderr|
        @in_p, @out_p, @err_p = stdin, stdout, stderr

        yield @in_p if block_given?
        @in_p.close
        @out = @out_p.read_available_bytes.strip unless @out_p.closed?
        @err = @err_p.read_available_bytes.strip unless @err_p.closed?
      end

      puts @err unless expect_err || @err.empty? || !$show_err
      @out
    end
    
  end
end
