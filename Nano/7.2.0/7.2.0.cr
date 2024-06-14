class Target < ISM::Software

    def configure
        super

        configureSource(arguments:  "--prefix=/usr      \
                                    --sysconfdir=/etc   \
                                    --enable-utf8       \
                                    --docdir=/usr/share/doc/nano-7.2",
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
                    "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/nano-7.2/nano.html")

        copyFile(   "#{buildDirectoryPath}doc/sample.nanorc",
                    "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/nano-7.2/sample.nanorc")
    end

    def install
        super

        runChmodCommand("0644 /usr/share/doc/nano-7.2/nano.html")
        runChmodCommand("0644 /usr/share/doc/nano-7.2/sample.nanorc")
    end

end
