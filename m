From: dhowells@redhat.com (David Howells)
Date: Fri, 10 Aug 2018 16:13:11 +0100
Subject: BUG: Mount ignores mount options
In-Reply-To: <0F2FA70F-8C7E-4D7D-B685-244A76BDB459@amacapital.net>
References: <0F2FA70F-8C7E-4D7D-B685-244A76BDB459@amacapital.net>
	<153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<87d0uqpba5.fsf@xmission.com>
Message-ID: <22558.1533913991@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Andy Lutomirski <luto@amacapital.net> wrote:

> > /dev/loop0 /root/loop0-noacl-noquota-nouser_xattr ext4 rw,relatime,nouser_xattr,noacl 0 0
> > /dev/loop0 /root/loop0-acl-quota-user_xattr ext4 rw,relatime,nouser_xattr,noacl 0 0
> 
> To make sure I understand correctly: the problem is that the second mount
> ignored the options because the device was already mounted, right?
> 
> For the new API, I think the only remotely sane approach is to refuse to
> mount or init or whatever you call it an already mounted bdev. If user code
> genuinely needs to bind-mount an existing mount that is known only by its
> bdev, we can add a specific API just for that.

I'm adding some flags to fsopen() to allow userspace to say whether it wants
no sharing, same parameters-only sharing or anything-goes sharing (as now).

I'm also adding a flag whereby userspace can forbid anyone else from sharing a
new superblock it has just set up.

David
