From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Fri, 10 Aug 2018 16:24:08 +0100
Subject: BUG: Mount ignores mount options
In-Reply-To: <0F2FA70F-8C7E-4D7D-B685-244A76BDB459@amacapital.net>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<87d0uqpba5.fsf@xmission.com>
	<0F2FA70F-8C7E-4D7D-B685-244A76BDB459@amacapital.net>
Message-ID: <20180810152408.GB6515@ZenIV.linux.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Aug 10, 2018 at 07:36:17AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Aug 10, 2018, at 7:05 AM, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > 
> > 
> > There is a serious problem with mount options today that fsopen does not
> > address.  The problem is that mount options are ignored for block based
> > filesystems, and any other type of filesystem that follows the same
> > pattern.
> > 
> 
> > /dev/loop0 /root/loop0-noacl-noquota-nouser_xattr ext4 rw,relatime,nouser_xattr,noacl 0 0
> > /dev/loop0 /root/loop0-acl-quota-user_xattr ext4 rw,relatime,nouser_xattr,noacl 0 0
> 
> To make sure I understand correctly: the problem is that the second mount ignored the options because the device was already mounted, right?
> 
> For the new API, I think the only remotely sane approach is to refuse to mount or init or whatever you call it an already mounted bdev. If user code genuinely needs to bind-mount an existing mount that is known only by its bdev, we can add a specific API just for that.

First of all, that does NOT belong anywhere other than fs itself.
Example: NFS.  Not every attempt to mount something leads to creation
of new fs instance; moreover, whether it will or not can't be predicted
in general.

PS: for pity sake, fix your MUA; 270-character lines are way over the
top.
