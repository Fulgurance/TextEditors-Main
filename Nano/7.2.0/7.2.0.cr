class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--sysconfdir=/etc",
                            "--enable-utf8",
                            "--docdir=/usr/share/doc/nano-7.2"],
                            buildDirectoryPath)
    end
    
    def build
        super
        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        copyFile("#{buildDirectoryPath}doc/nano.html","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/nano-7.2/nano.html")
        copyFile("#{buildDirectoryPath}doc/sample.nanorc","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/nano-7.2/sample.nanorc")
    end

    def install
        super

        setPermissions("#{Ism.settings.rootPath}usr/share/doc/nano-7.2/nano.html",0o644)
        setPermissions("#{Ism.settings.rootPath}usr/share/doc/nano-7.2/sample.nanorc",0o644)
    end

end
