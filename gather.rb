require 'chef/knife'

module Lnxchk
  class Gather < Chef::Knife

    deps do 
      require 'chef/mixin/command'
      require 'chef/search/query'
      require 'chef/knife/search'
      require 'chef/knife/ssh'
      require 'net/ssh/multi'
    end

    banner "knife ssh --gather QUERY COMMAND"

    def run
      query = name_args[0]
      command = name_args[1]

      knife_ssh = Chef::Knife::Ssh.new
      cmd_line = command
      knife_ssh.name_args = [query, cmd_line]
      orig_stdout = $stdout
      $stdout = File.open('./myfile','w')
      knife_ssh.run
      $stdout.close
      $stdout = orig_stdout
      

      mylines = Hash.new()

      file = File.open('./myfile', 'r')
      file.each_line do |line|
        host, data = line.split(" ", 2)
        if mylines.has_key?(host)
          mylines[host] += "\t" + data + "\n"
        else
          mylines[host] = "\t" + data + "\n"
        end
      end

      mylines.each do |host,lines|

        print "#{host}: \n"
        print "#{lines}\n"
        print "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n"
      end
      file.close
      File.delete('./myfile') 

    end # end run
  end # end class
end # end module
        
