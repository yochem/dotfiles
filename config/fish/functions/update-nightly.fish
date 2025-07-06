function update-nightly
    sudo -v
    set tmpdir (mktemp -d)
    set asset nvim-macos-x86_64

    echo $tmpdir

    pushd $tmpdir

    gh -R neovim/neovim release download nightly -p $asset.tar.gz -p shasum.txt

    xattr -c $asset.tar.gz
    tar xzf $asset.tar.gz

    sudo cp -r $asset/bin/* /usr/local/bin/
    sudo cp -r $asset/lib/* /usr/local/lib/
    sudo cp -r $asset/share/* /usr/local/share/

    popd
end
