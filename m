From: john.johansen@canonical.com (John Johansen)
Date: Sat, 1 Sep 2018 02:18:23 -0700
Subject: WARNING in apparmor_secid_to_secctx
In-Reply-To: <000000000000c178e305749daba4@google.com>
References: <000000000000c178e305749daba4@google.com>
Message-ID: <45dda774-fd57-3e60-fb67-ad855f2360c9@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 08/29/2018 07:17 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:??? 817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
> git tree:?????? net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1536d296400000
> kernel config:? https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
> dashboard link: https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
> compiler:?????? gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+21016130b0580a9de3b5 at syzkaller.appspotmail.com
> 

<< snip >>

Patch sent directly to syzbot for testing
