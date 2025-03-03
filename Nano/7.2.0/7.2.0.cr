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
    end

end
