class Target < ISM::Software

    def configure
        super

        configureSource(arguments:  "--prefix=/usr      \
                                    --sysconfdir=/etc   \
                                    --enable-utf8       \
                                    --docdir=/usr/share/doc/#{versionName}",
                        path:       buildDirectoryPath)
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)

        copyFile(   "#{buildDirectoryPath}doc/nano.html",
                    "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/#{versionName}/nano.html")

        copyFile(   "#{buildDirectoryPath}doc/sample.nanorc",
                    "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/#{versionName}/sample.nanorc")
    end

    def install
        super

        runChmodCommand("0644 /usr/share/doc/#{versionName}/nano.html")
        runChmodCommand("0644 /usr/share/doc/#{versionName}/sample.nanorc")
    end

end
