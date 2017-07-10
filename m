From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 10 Jul 2017 08:10:12 -0400
Subject: [PATCH v2] integrity: track mtime in addition to i_version for
	assessment
In-Reply-To: <1499459718.4852.8.camel@redhat.com>
References: <20170707140530.30452-1-jlayton@kernel.org>
	<1499446642.4967.3.camel@poochiereds.net>
	<1499448249.3130.143.camel@linux.vnet.ibm.com>
	<1499449777.4852.3.camel@redhat.com>
	<1499457558.3130.173.camel@linux.vnet.ibm.com>
	<1499459718.4852.8.camel@redhat.com>
Message-ID: <1499688612.6034.111.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-07-07 at 16:35 -0400, Jeff Layton wrote:
> On Fri, 2017-07-07 at 15:59 -0400, Mimi Zohar wrote:
> > On Fri, 2017-07-07 at 13:49 -0400, Jeff Layton wrote:
> > > On Fri, 2017-07-07 at 13:24 -0400, Mimi Zohar wrote:
> > > > On Fri, 2017-07-07 at 12:57 -0400, Jeff Layton wrote:
> > > > > On Fri, 2017-07-07 at 10:05 -0400, Jeff Layton wrote:
> > > > > > From: Jeff Layton <jlayton@redhat.com>
> > > > > > 
> > > > > > The IMA assessment code tries to use the i_version counter to detect
> > > > > > when changes to a file have occurred. Many filesystems don't increment
> > > > > > it properly (or at all) so detecting changes with that is not always
> > > > > > reliable.
> > > > > > 
> > > > > > That check should be gated on IS_I_VERSION, as you can't rely on the
> > > > > > i_version field changing unless that returns true.
> > > > > > 
> > > > > > Have the code also track and check the mtime for the file. If the
> > > > > > IS_I_VERSION returns false, then use it to detect whether the file's
> > > > > > contents might have changed.
> > > > > > 
> > > > > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > > > > > ---
> > > > > >  security/integrity/ima/ima_api.c  |  4 +++-
> > > > > >  security/integrity/ima/ima_main.c | 32 ++++++++++++++++++++++++--------
> > > > > >  security/integrity/integrity.h    |  1 +
> > > > > >  3 files changed, 28 insertions(+), 9 deletions(-)
> > > > > > 
> > > > > > v2: switch to storing/checking mtime instead of ctime
> > > > > > 
> > > > > 
> > > > > To be clear here, I don't have a large interest in IMA, but I am looking
> > > > > at making changes to how the i_version counter is handled. IMA's use of
> > > > > it is problematic for some of those changes (and somewhat sketchy).
> > > > > 
> > > > > I think you either want something like the patch below, or you need to
> > > > > somehow ensure that you're not doing any of this on a superblock that
> > > > > doesn't have MS_I_VERSION set on it.
> > > > > 
> > > > > I'm not that familiar with IMA in general though, so it's possible I'm
> > > > > missing something. Is that already being done somehow?
> > > > 
> > > > Before reverting to using mtime, which wasn't fine grained enough at
> > > > the time, it would be helpful to first understand the type of changes
> > > > and the reasons for the changes you're looking to make to i_version.
> > > 
> > > Sure, I posted a patchset back in December, actually:
> > > 
> > >     [RFC PATCH v1 00/30] fs: inode->i_version rework and optimization
> > 
> > Thanks you.
> > 
> > > The basic idea is to improve performance on filesystems that implement
> > > the i_version counter by allowing them to optimize away metadata updates
> > > that are due solely to i_version counter change when no one is actually
> > > using it. This will also pave the way to allow us to more reasonably
> > > provide an i_version counter on network filesystems and the like that
> > > might have weaker consistency guarantees than a local fs.
> > > Your point about mtime not being granular enough is valid however. It's
> > > certainly possible for extra writes to race in during the jiffy or so
> > > window that represents the mtime resolution. It's just that that is
> > > still more granular than you'll get on a filesystem that never actually
> > > increments the i_version counter on a write.
> > > >  After all, i_version has been working all this time (~2009).
> > > > 
> > > 
> > > The i_version counter works just fine on filesystems that implement it
> > > properly. That's a very short list: xfs, btrfs, and ext4 for local
> > > filesystems. NFS and AFS would also likely be fine here, though they
> > > don't set MS_I_VERSION.
> > > The rest though do not support it consistently and IMA should not be
> > > relying on it on them. This is why the kernel nfs server only relies on
> > > the i_version field when IS_I_VERSION returns true.
> > > 
> > > I'll ask again -- is IMA somehow limited only being used only on that
> > > subset of filesystems? My guess from a glance at the integrity_read
> > > patchset is that it is not.
> > 
> > Our main use case scenario is verifying the integrity of files,
> > updating the file hash for mutable files, and maintaining a
> > measurement list, including re-measurement of files that have changed,
> > on local file systems.  Without being in the file write path (or more
> > precisely __fput), there are no guarantees of file change
> > notification.
> > 
> > For file systems which do not support i_version, we are limited to an
> > initial file integrity verification and measurement.
> 
> How is your typical user to know whether to expect this guarantee from
> the filesystem?

IMA can be configured in a number of different ways. ?There are three
main aspects - prevention (IMA-appraisal), detection (IMA-
measurement), and forensics/analytics/remediation (IMA-audit). ?A lot
depends on the environment (eg. embedded, laptop, server, cloud) and
what is being protected.

For example, the large majority of files in the Trusted Computing
Base(TCB) are immutable files and should be signed.??File hashes only
need to be re-calculated and stored as extended attributes for mutable
files.

A "typical user" would first want all immutable files to come with a
file signature, or would need to sign them locally. ?Files that are
modified locally (eg. scripts, configuration files) should be re-
signed. ?Only then would a "typical user" be concerned with files that
change - the mutable files. ?With EVM configured, these file hashes
would be protected from offline modification. ?

A "typical user" should also enable IMA-measurement and IMA-audit,
just in case something happens...

Last year, my colleagues Stefan Berger and Mehmet Kayaalp gave a talk
at LPC titled "File signatures needed!". ?I'm looking forward to
hearing Matthew Garrett's talk at the Open Source Summit titled
"Signing Linux Executables for Fun and Security".

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
