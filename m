From: paul@paul-moore.com (Paul Moore)
Date: Fri, 31 Aug 2018 12:07:18 -0400
Subject: WARNING in apparmor_secid_to_secctx
In-Reply-To: <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov>
References: <000000000000c178e305749daba4@google.com>
	<CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
	<37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov>
Message-ID: <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Aug 31, 2018 at 12:01 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 08/29/2018 10:21 PM, Dmitry Vyukov wrote:
> > On Wed, Aug 29, 2018 at 7:17 PM, syzbot
> > <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com> wrote:
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
> >> git tree:       net-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1536d296400000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >>
> >> Unfortunately, I don't have any reproducer for this crash yet.
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+21016130b0580a9de3b5 at syzkaller.appspotmail.com
> >
> > Hi John, Tyler,
> >
> > I've switched syzbot from selinux to apparmor as we discussed on lss:
> > https://github.com/google/syzkaller/commit/2c6cb254ae6c06f61e3aba21bb89ffb05b5db946
>
> Sorry, does this mean that you are no longer testing selinux via syzbot?
>   That seems unfortunate.  SELinux is default-enabled and used in
> Fedora, RHEL and all derivatives (e.g. CentOS), and mandatory in Android
> (and seemingly getting some use in ChromeOS now as well, at least for
> the Android container and possibly wider), so it seems unwise to drop it
> from your testing altogether.  I was under the impression that you were
> just going to add apparmor to your testing matrix, not drop selinux
> altogether.

It is also important to note that testing with SELinux enabled but no
policy loaded is not going to be very helpful (last we talked that is
what syzbot is/was doing).  While syzbot did uncover some issues
relating to the enabled-no-policy case, those are much less
interesting and less relevant than the loaded-policy case.

-- 
paul moore
www.paul-moore.com
