From: dhowells@redhat.com (David Howells)
Date: Fri, 10 Aug 2018 16:53:58 +0100
Subject: BUG: Mount ignores mount options
In-Reply-To: <20180810153902.GH21087@thunk.org>
References: <20180810153902.GH21087@thunk.org> <87d0uqpba5.fsf@xmission.com>
	<153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<22361.1533913891@warthog.procyon.org.uk>
Message-ID: <28045.1533916438@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Theodore Y. Ts'o <tytso@mit.edu> wrote:

> Even *with* file system support, there's no way today for the VFS to
> keep track of whether a pathname resolution came through one
> mountpoint or another, so I can't do something like this:

Ummm...  Isn't that encoded in the vfsmount pointer in struct path?

However, the case folding stuff - is that a superblockism of a mountpointism?

> So if the file system has been mounted with one set of mount options,
> and you want to try to mount it with a conflicting set of mount
> options and you don't want it to silently ignore the mount options,
> the *only* thing we can today is to refuse the mount and return an
> error.  

With fsopen() there is the option to have the filesystem and the LSM attempt
to compare the non-key[*] mount options and reject the attempt to share if
they differ in any way.

David


[*] sget lookup keys, that is.
