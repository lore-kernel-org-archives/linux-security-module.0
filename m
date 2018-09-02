From: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com (syzbot)
Date: Sat, 01 Sep 2018 22:46:01 -0700
Subject: WARNING in apparmor_secid_to_secctx
In-Reply-To: <CACT4Y+Y-wWVPYU0auia=u+XM9AS+JTxf1n8JfGLF-KTCBvNGvw@mail.gmail.com>
Message-ID: <0000000000009c848f0574dcf06c@google.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+21016130b0580a9de3b5 at syzkaller.appspotmail.com

Tested on:

commit:         22dad84baabf apparmor: fix apparmor_secid_to_secctx incorr..
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor.git/4.18-syzbot-secid
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7c5a36688323465
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Note: testing is done by a robot and is best-effort only.
