From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 14 Aug 2018 23:03:17 -0500
Subject: BUG: Mount ignores mount options
In-Reply-To: <001a1608-d0fa-84c1-9c54-ae36df95fd89@schaufler-ca.com> (Casey
	Schaufler's message of "Sat, 11 Aug 2018 10:47:50 -0700")
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<87d0uqpba5.fsf@xmission.com>
	<20180810151606.GA6515@ZenIV.linux.org.uk>
	<87pnypiufr.fsf@xmission.com> <20180811014619.GA14368@thunk.org>
	<8736vlo6ef.fsf@xmission.com>
	<001a1608-d0fa-84c1-9c54-ae36df95fd89@schaufler-ca.com>
Message-ID: <87d0ukjmyi.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> writes:

> Don't blame the filesystems for behaving as documented.

No.  This behavior is not documented.  At least I certainly don't see a
word about this in any of the man pages.  Where does it say mounting a
filesystem will not honor it's mount options?

It is also rare enough in practice it is something it is reasonable to
expect people to be surprised by.

> The problem is not in the mount mechanism, it's in the way you want to
> abuse it.

I am not asking for this behavior.  I am pointing out this behavior
exists.  I am pointing out this behavior is harmful.  I am asking we
stop doing this harmful thing in the new API where we don't have a
chance of breaking anything.

The place where this has bitten the hardest is someone wrote a script to
do something for Xen in a chroot.  That script involved a chroot that
mounted devpts and in doing so happend to change the options of the main
/dev/pts.  Which resulted in ptys created with /dev/ptmx outside the
chroot with the wrong permissions.  That in turn caused several distros
to retain the ancient suid pt_chown binary from libc that the devpts
filesystem was built to make obsolete.  As the world turned that
pt_chown binary could be confused into chowning the wrong pty if a pty
from a container was used.

The fix was to mount a new instance of devpts every time mount of devpts
is called.  That simplified the code, and allowed pt_chown to be removed
permanently.  The tricky bit was figuring out how keep /dev/ptmx
working.  I wound up testing on every distribution I could think of to
ensure no one would notice the slightly changed behavior of the devpts
filesystem.

The behavior in other filesystems of ignoring the options instead of
changing them on the filesystem isn't quite as bad.  But it still has
the potential for a lot of mischief.

Eric
