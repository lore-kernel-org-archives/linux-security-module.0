From: dhowells@redhat.com (David Howells)
Date: Fri, 10 Aug 2018 16:11:31 +0100
Subject: BUG: Mount ignores mount options
In-Reply-To: <87d0uqpba5.fsf@xmission.com>
References: <87d0uqpba5.fsf@xmission.com>
	<153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
Message-ID: <22361.1533913891@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com> wrote:

> There is a serious problem with mount options today that fsopen does not
> address.  The problem is that mount options are ignored for block based
> filesystems, and any other type of filesystem that follows the same
> pattern.

Yes.  Since you *absolutely* *insist* on this being fixed *right* *now* *or*
*else*, I'm working up a set of additional patches to give userspace the
option of whether they want no sharing; sharing, but only with exactly the
same parameters; or to ignore the parameter differences and just accept
sharing of what's already already mounted (ie. the current behaviour).

The second option, however, is not trivial as it needs to compare the fs
contexts, including the LSM parameters.  To make that work, I really need to
remove the old security_mnt_opts stuff - which means I need to port btrfs to
the new context stuff.

We discussed this yesterday, and I proposed a solution, and I'm working on it.

Yes, I agree it would be nice to have, but it *doesn't* really need supporting
right this minute, since what I have now oughtn't to break the current
behaviour.

David
