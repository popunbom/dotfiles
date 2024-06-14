# [Startup/Shutdown Files](https://zsh.sourceforge.io/Doc/Release/Files.html#Files)

## [シェルの種類]((https://zsh.sourceforge.io/Guide/zshguide02.html#l7))

- ログインシェル: ユーザがログインするときに実行されるシェル
  - `$ zsh --login` または `$ zsh -l` でログインシェルとして起動
- インタラクティブシェル: ターミナル等から対話的にコマンドを入力するときに実行されるシェル
  - `$ zsh [script-file]` でスクリプトを実行するときはインタラクティブシェルではない

## 読み込まれるファイル
```
- $ZDOTDIR/.zshenv
- $ZDOTDIR/.zprofile
- $ZDOTDIR/.zshrc
- $ZDOTDIR/.zlogin
- $ZDOTDIR/.zlogout
- ${TMPPREFIX}* (default is /tmp/zsh*)
- /etc/zshenv
- /etc/zprofile
- /etc/zshrc
- /etc/zlogin
- /etc/zlogout (installation-specific - /etc is the default)
```
- `$ZDOTDIR` はデフォルトで `$HOME` に設定されている
- `/etc` は zsh のインストール時オプションによっては別のディレクトリになる可能性がある


# Notes
- 読み込まれるファイルの順序は `RCS` または `GLOBAL_RCS` オプションによって制御される
  https://zsh.sourceforge.io/Doc/Release/Options.html#Initialisation
  - `RCS`: すべてのスタートアップファイルのロード順を制御する
  - `GLOBAL_RCS`: `/` から始まるファイルパスのスタートアップファイルのロード順を制御する

## 読み込み順序

# 起動時

1. `/etc/zshenv`
    - **`/etc/zshenv` は `RCS` と `GLOBAL_RCS` の設定にかかわらず、常に最初に読み込まれる**
      - どの環境でも常に読み込まれるため、必要最低限の定義であることが推奨される
2. `$ZDOTDIR/.zshenv`
3. `/etc/zprofile` (ログインシェルの場合)
4. `$ZDOTDIR/.zprofile` (ログインシェルの場合)
    - zprofile には zshrc の評価前に実行される必要のある定義を書く
4. `/etc/zshrc` (インタラクティブシェルの場合)
5. `$ZDOTDIR/.zshrc` (インタラクティブシェルの場合)
6. `/etc/zlogin` (ログインシェルの場合)
7. `$ZDOTDIR/.zlogin` (ログインシェルの場合)
    - zlogin には zshrc の評価後に実行される必要のある定義を書く

# 終了時

スクリプトの最終行に到達、あるいは `exit`, `logout` コマンドを実行したときに読み込まれる
- `exec` コマンドにより別プロセスに置き換えられた場合は読み込まれない

1. `$ZDOTDIR/.zlogout` (ログインシェルの場合)
2. `/etc/zlogout` (ログインシェルの場合)
