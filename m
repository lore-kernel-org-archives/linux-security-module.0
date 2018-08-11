From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Sat, 11 Aug 2018 17:51:24 +0100
Subject: BUG: Mount ignores mount options
In-Reply-To: <9B6E2781-484B-4C42-95F5-F900EA36CEA5@amacapital.net>
References: <87pnyphf8i.fsf@xmission.com> <87d0uqpba5.fsf@xmission.com>
	<153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<22361.1533913891@warthog.procyon.org.uk>
	<30365.1533972586@warthog.procyon.org.uk>
	<9B6E2781-484B-4C42-95F5-F900EA36CEA5@amacapital.net>
Message-ID: <20180811165123.GH6515@ZenIV.linux.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Aug 11, 2018 at 09:31:29AM -0700, Andy Lutomirski wrote:

> I don?t see why we need all this fancy ?do the options match? stuff.  For the handful of filesystems (like NFS) that do something intelligent when multiple non-bind mount requests against the same underlying storage happen,  we can keep that behavior in the new API. For other filesystems that don?t have this feature, we should simply fail the request.

> IOW I see so compelling reason to call sget() at all from the new API.  The only sort-of-legit use case I can think of is mounting more than one btrfs subvolume. But even that should probably not be done by asking the kernel to separately instantiate the filesystem.


May I politely suggest the esteemed participants of that conversation
to RTFS?  Yes, I know that it's less fun that talking about your
rather vague ideas of how the things (surely) work, but it just might
avoid the feats of idiocy like the above.

Andy, I don't know how to put it more plainly: read the fucking source.
Even grep would do.  The same NFS you've granted (among the "handful"
of filesystems) an exception, *DOES* *CALL* *THE* *FUCKING* sget().

Yes, really.  And in some obscure[1] cases (including the one mentioned
upthread) it does reuse a pre-existing superblock.  For a very good
reason.

[1] such as, oh, mounting two filesystems from the same server with
default options - who would've ever thought of doing something so
perverted?
