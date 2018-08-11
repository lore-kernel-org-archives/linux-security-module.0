From: dhowells@redhat.com (David Howells)
Date: Sat, 11 Aug 2018 08:29:46 +0100
Subject: BUG: Mount ignores mount options
In-Reply-To: <87pnyphf8i.fsf@xmission.com>
References: <87pnyphf8i.fsf@xmission.com> <87d0uqpba5.fsf@xmission.com>
	<153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<22361.1533913891@warthog.procyon.org.uk>
Message-ID: <30365.1533972586@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com> wrote:

> > Yes, I agree it would be nice to have, but it *doesn't* really need
> > supporting right this minute, since what I have now oughtn't to break the
> > current behaviour.
> 
> I am really reluctant to endorse anything that propagates the issues of
> the current interface in the new mount interface.

Do realise that your problem cannot be solved through fsopen() until every
filesystem is converted to the new fs_context-based sget() since the flag has
to make it from the VFS through the filesystem to sget().

I'm reluctant to add this flag till that point until that time unless we error
out if the flag is set against a legacy filesystem.

David
