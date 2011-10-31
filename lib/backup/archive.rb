# encoding: utf-8

##
# Require the pathname Ruby library when Backup::Archive is loaded
require "pathname"

module Backup
  class Archive
    include Backup::CLI

    ##
    # Stores the name of the archive
    attr_accessor :name

    ##
    # Stores an array of different paths/files to store
    attr_accessor :paths

    ##
    # Stores an array of different paths/files to exclude
    attr_accessor :excludes

    ##
    # Stores the path to the archive directory
    attr_accessor :archive_path

    ##
    # Optional flag to tell Backup::Archive to follow all the symlinks in the @paths variable
    attr_accessor :follow_symlinks

    ##
    # Takes the name of the archive and the configuration block
    def initialize(name, &block)
      @name            = name.to_sym
      @paths           = Array.new
      @excludes        = Array.new
      @follow_symlinks = false

      instance_eval(&block)
    end

    ##
    # Adds new paths to the @paths instance variable array
    def add(path)
      @paths << File.expand_path(path)
    end

    ##
    # Adds new paths to the @excludes instance variable array
    def exclude(path)
      @excludes << File.expand_path(path)
    end

    ##
    # Archives all the provided paths in to a single .tar file
    # and places that .tar file in the folder which later will be packaged
    def perform!
      prepare!

      Logger.message("#{ self.class } started packaging and archiving #{ paths.map { |path| "\"#{path}\""}.join(", ") }.")
      run("#{ utility(:tar) } -c -f '#{ File.join(archive_path, "#{name}.tar") }' #{ paths_to_exclude } #{ paths_to_package }", :ignore_exit_codes => [1])
    end

  private

    ##
    # Prepares the Backup::Archive object before actually
    # performing the archving process
    #
    # If @follow_symlinks is set to true, then Backup::Archive will
    # search through every directory (recursively) for symlinks and append
    # their absolute path to the array of @paths to package.
    def prepare!
      @archive_path = File.join(TMP_PATH, TRIGGER, 'archive')
      mkdir(archive_path)

      if follow_symlinks
        paths.each do |path|
          collect_symlinks(Pathname.new(path)).each do |symlink|
            @paths << symlink.realpath
          end
        end
      end

      @paths.uniq!
    end

    ##
    # Returns a "tar-ready" string of all the specified paths combined
    def paths_to_package
      paths.map do |path|
        "'#{path}'"
      end.join("\s")
    end

    ##
    # Returns a "tar-ready" string of all the specified excludes combined
    def paths_to_exclude
      if excludes.any?
        excludes.map{ |e| "--exclude='#{e}'" }.join(" ")
      end
    end

    ##
    # Collects symlinks in all directories (recursively) for the given path
    def collect_symlinks(pathname)
      return Array.new unless pathname.directory?

      pathname.children.map do |entry|
        symlink = if entry.symlink?
          entry
        end

        directory = if entry.directory?
          collect_symlinks(entry)
        end

        Array.new([symlink, directory])
      end.flatten.compact
    end
  end
end
