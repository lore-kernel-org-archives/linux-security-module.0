From: jlayton@redhat.com (jlayton at redhat.com)
Date: Tue, 11 Jul 2017 21:17:32 -0400
Subject: [PATCH v2] integrity: track mtime in addition to i_version for
	assessment
In-Reply-To: <1499688612.6034.111.camel@linux.vnet.ibm.com>
References: <20170707140530.30452-1-jlayton@kernel.org>
	<1499446642.4967.3.camel@poochiereds.net>
	<1499448249.3130.143.camel@linux.vnet.ibm.com>
	<1499449777.4852.3.camel@redhat.com>
	<1499457558.3130.173.camel@linux.vnet.ibm.com>
	<1499459718.4852.8.camel@redhat.com>
	<1499688612.6034.111.camel@linux.vnet.ibm.com>
Message-ID: <1499822252.26839.5.camel@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-07-10 at 08:10 -0400, Mimi Zohar wrote:
> On Fri, 2017-07-07 at 16:35 -0400, Jeff Layton wrote:
> > On Fri, 2017-07-07 at 15:59 -0400, Mimi Zohar wrote:
> > > On Fri, 2017-07-07 at 13:49 -0400, Jeff Layton wrote:
> > > > On Fri, 2017-07-07 at 13:24 -0400, Mimi Zohar wrote:
> > > > > On Fri, 2017-07-07 at 12:57 -0400, Jeff Layton wrote:
> > > > > > On Fri, 2017-07-07 at 10:05 -0400, Jeff Layton wrote:
> > > > > > > From: Jeff Layton <jlayton@redhat.com>
> > > > > > > 
> > > > > > > The IMA assessment code tries to use the i_version
> > > > > > > counter to detect
> > > > > > > when changes to a file have occurred. Many filesystems
> > > > > > > don't increment
> > > > > > > it properly (or at all) so detecting changes with that is
> > > > > > > not always
> > > > > > > reliable.
> > > > > > > 
> > > > > > > That check should be gated on IS_I_VERSION, as you can't
> > > > > > > rely on the
> > > > > > > i_version field changing unless that returns true.
> > > > > > > 
> > > > > > > Have the code also track and check the mtime for the
> > > > > > > file. If the
> > > > > > > IS_I_VERSION returns false, then use it to detect whether
> > > > > > > the file's
> > > > > > > contents might have changed.
> > > > > > > 
> > > > > > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > > > > > > ---
> > > > > > >  security/integrity/ima/ima_api.c  |  4 +++-
> > > > > > >  security/integrity/ima/ima_main.c | 32
> > > > > > > ++++++++++++++++++++++++--------
> > > > > > >  security/integrity/integrity.h    |  1 +
> > > > > > >  3 files changed, 28 insertions(+), 9 deletions(-)
> > > > > > > 
> > > > > > > v2: switch to storing/checking mtime instead of ctime
> > > > > > > 
> > > > > > 
> > > > > > To be clear here, I don't have a large interest in IMA, but
> > > > > > I am looking
> > > > > > at making changes to how the i_version counter is handled.
> > > > > > IMA's use of
> > > > > > it is problematic for some of those changes (and somewhat
> > > > > > sketchy).
> > > > > > 
> > > > > > I think you either want something like the patch below, or
> > > > > > you need to
> > > > > > somehow ensure that you're not doing any of this on a
> > > > > > superblock that
> > > > > > doesn't have MS_I_VERSION set on it.
> > > > > > 
> > > > > > I'm not that familiar with IMA in general though, so it's
> > > > > > possible I'm
> > > > > > missing something. Is that already being done somehow?
> > > > > 
> > > > > Before reverting to using mtime, which wasn't fine grained
> > > > > enough at
> > > > > the time, it would be helpful to first understand the type of
> > > > > changes
> > > > > and the reasons for the changes you're looking to make to
> > > > > i_version.
> > > > 
> > > > Sure, I posted a patchset back in December, actually:
> > > > 
> > > >     [RFC PATCH v1 00/30] fs: inode->i_version rework and
> > > > optimization
> > > 
> > > Thanks you.
> > > 
> > > > The basic idea is to improve performance on filesystems that
> > > > implement
> > > > the i_version counter by allowing them to optimize away
> > > > metadata updates
> > > > that are due solely to i_version counter change when no one is
> > > > actually
> > > > using it. This will also pave the way to allow us to more
> > > > reasonably
> > > > provide an i_version counter on network filesystems and the
> > > > like that
> > > > might have weaker consistency guarantees than a local fs.
> > > > Your point about mtime not being granular enough is valid
> > > > however. It's
> > > > certainly possible for extra writes to race in during the jiffy
> > > > or so
> > > > window that represents the mtime resolution. It's just that
> > > > that is
> > > > still more granular than you'll get on a filesystem that never
> > > > actually
> > > > increments the i_version counter on a write.
> > > > >  After all, i_version has been working all this time (~2009).
> > > > > 
> > > > 
> > > > The i_version counter works just fine on filesystems that
> > > > implement it
> > > > properly. That's a very short list: xfs, btrfs, and ext4 for
> > > > local
> > > > filesystems. NFS and AFS would also likely be fine here, though
> > > > they
> > > > don't set MS_I_VERSION.
> > > > The rest though do not support it consistently and IMA should
> > > > not be
> > > > relying on it on them. This is why the kernel nfs server only
> > > > relies on
> > > > the i_version field when IS_I_VERSION returns true.
> > > > 
> > > > I'll ask again -- is IMA somehow limited only being used only
> > > > on that
> > > > subset of filesystems? My guess from a glance at the
> > > > integrity_read
> > > > patchset is that it is not.
> > > 
> > > Our main use case scenario is verifying the integrity of files,
> > > updating the file hash for mutable files, and maintaining a
> > > measurement list, including re-measurement of files that have
> > > changed,
> > > on local file systems.  Without being in the file write path (or
> > > more
> > > precisely __fput), there are no guarantees of file change
> > > notification.
> > > 
> > > For file systems which do not support i_version, we are limited
> > > to an
> > > initial file integrity verification and measurement.
> > 
> > How is your typical user to know whether to expect this guarantee
> > from
> > the filesystem?
> 
> IMA can be configured in a number of different ways.  There are three
> main aspects - prevention (IMA-appraisal), detection (IMA-
> measurement), and forensics/analytics/remediation (IMA-audit).  A lot
> depends on the environment (eg. embedded, laptop, server, cloud) and
> what is being protected.
> 
> For example, the large majority of files in the Trusted Computing
> Base(TCB) are immutable files and should be signed.  File hashes only
> need to be re-calculated and stored as extended attributes for
> mutable
> files.
> 
> A "typical user" would first want all immutable files to come with a
> file signature, or would need to sign them locally.  Files that are
> modified locally (eg. scripts, configuration files) should be re-
> signed.  Only then would a "typical user" be concerned with files
> that
> change - the mutable files.  With EVM configured, these file hashes
> would be protected from offline modification.  
> 
> A "typical user" should also enable IMA-measurement and IMA-audit,
> just in case something happens...
> 
> Last year, my colleagues Stefan Berger and Mehmet Kayaalp gave a talk
> at LPC titled "File signatures needed!".  I'm looking forward to
> hearing Matthew Garrett's talk at the Open Source Summit titled
> "Signing Linux Executables for Fun and Security".
> 

(cc'ing Bruce here too, since he's also done a lot of work with the
i_version counter...)

Thanks, but that doesn't really answer my question. Let me try again:

My main concern is whether IMA is supposed to be a filesystem-agnostic
feature.

Typically, when we accept features into the kernel we like for them to
work in a consistent way across different filesystems. Barring that, we
want to provide some way for userland to ascertain what sort of
semantics it can expect the fs to provide.

For instance, most filesystems support file locking, but some don't.
Those that don't typically return a particular error (-ENOLCK) when
someone attempts to set or query for a lock.

IMA, however does not have any sort of whitelist of supported
filesystems, AFAICT. It also doesn't properly check whether the
i_verison counter is properly supported by the filesystem before
attempting to use it.

If using the mtime is unacceptable due to insufficient granularity,
then it seems logical that relying on an i_version counter that is
never incremented is also bad.

So, my question is: Why is that not a problem here?

To put it another way... In an earlier reply you said:

> For file systems which do not support i_version, we are limited to an
> initial file integrity verification and measurement.

How is userland supposed to know which behavior to expect from the fs?

ext4 only provides a working i_version counter when you mount with "-o
i_version", so it's trivial to tell there. xfs and btrfs also have
functional i_version counter implementations, but there is no such
mount option for them (it's always on there). NFSv4 and AFS can provide
one too (as they're supplied by the server).

Suppose I want to use IMA on something else (say, ubifs). How do I know
whether I'm only going to get "initial file integrity verification and
measurement" or whether it'll be updated after being written?

Now, I happen to know that ubifs does _not_ support the i_version
counter because I can poke through the kernel sources and tell, but how
is Joe Random Linux User to know this?

Does that not matter for some reason? Is there a whitelist of
filesystems being maintained in some userland package?

Sorry if it seems like I'm being dense here, but I really just don't
understand how we can allow this code to be so cavalier about using the
i_version counter without taking steps to ensure that it actually does
a damned thing at all.

Thanks,
-- 
Jeff Layton <jlayton@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
