From: tytso@mit.edu (Theodore Y. Ts'o)
Date: Fri, 10 Aug 2018 12:14:00 -0400
Subject: BUG: Mount ignores mount options
In-Reply-To: <28045.1533916438@warthog.procyon.org.uk>
References: <20180810153902.GH21087@thunk.org> <87d0uqpba5.fsf@xmission.com>
	<153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<22361.1533913891@warthog.procyon.org.uk>
	<28045.1533916438@warthog.procyon.org.uk>
Message-ID: <20180810161400.GA627@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Aug 10, 2018 at 04:53:58PM +0100, David Howells wrote:
> Theodore Y. Ts'o <tytso@mit.edu> wrote:
> 
> > Even *with* file system support, there's no way today for the VFS to
> > keep track of whether a pathname resolution came through one
> > mountpoint or another, so I can't do something like this:
> 
> Ummm...  Isn't that encoded in the vfsmount pointer in struct path?

Well, yes, and we do use this as a hack to make read-only bind mounts
work.  But that's done as a special case, and it's for permissions
checking only.

The big problem is that there is single dentry cache object regardless
of which mount point was used to access it.  So that makes it
impossible to support case folding as a mount-pointism.

> 
> However, the case folding stuff - is that a superblockism of a mountpointism?

It's a superblock-ism.  As far as I know the *only* thing that we can
support as a mount-pointism is the ro flag, and that's handled as a
special case, and only if the original superblock was mounted
read/write.  ey That was my point; aside from the ro flag, we can't
support any other mount options as a per-mount point thing, so the
only thing we can do is to fail the mount if there are conflicting
mount options.  And I'm not really sure it helps the container use
case, since the whole point is they want their "guest" to be able to
blithely run "mount /dev/sda1 -o noxattr /mnt" and not worry about the
fact that in some other container, someone had run "mount /dev/sda1 -o
xattr /mnt".  But having the second mount fail because of conflicting
mount option breaks the illusion that containers are functionally as
rich as VM's.

So before you put in lots of work to support rejecting the attmpted
mount if the mount options conflict, are we sure people will actually
find this to be useful?  Because it's not only fsopen() work for you,
but each file system is going to have to implement new functions to
answer the question "are these mount options conflicting or not?".
Are we sure it's worth the effort?

					- Ted
