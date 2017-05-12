From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 12 May 2017 17:09:36 -0400
Subject: [PATCH] security/ima: use fs method to read integrity data
In-Reply-To: <20170511081659.GA20214@lst.de>
References: <20170510064507.1764-1-hch@lst.de>
	<20170510064507.1764-2-hch@lst.de>
	<a552827e-922d-0b28-2919-90c780a8a414@plexistor.com>
	<20170510132359.GA22549@lst.de>
	<1494450047.3006.28.camel@linux.vnet.ibm.com>
	<20170511081659.GA20214@lst.de>
Message-ID: <1494623376.4997.28.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-05-11 at 10:16 +0200, Christoph Hellwig wrote:
> On Wed, May 10, 2017 at 05:00:47PM -0400, Mimi Zohar wrote:
> > Without i_version support the file is measured/appraised once. ?With
> > i_version support it will be re-measured/appraised. As a file system
> > is mounted/remounted, some sort of message should be emitted
> > indicating whether i_version is supported.
> 
> You can check for (sb->s_flags & MS_I_VERSION) to see if it's supported.

Yes, I defined a new LSM hook to catch the new mounts, but there are
lots of mounts, even after to limiting it to non-kernel mounts
(MS_KERNMOUNT) and only checking if the MS_I_VERSION is set on
filesystems mounted read-write. ?It would be nice if there was a way
of saying not pseudo filesystems (eg. CGROUP_SUPER_MAGIC,
DEBUGFS_MAGIC, DEVPTS_SUPER_MAGIC, PROC_SUPER_MAGIC, SECURITYFS_MAGIC,
SYSFS_MAGIC, etc).

> 
> > ?That does not imply that
> > there is no value in measuring/appraising the file only once.
> > 
> > With this patch, the "opt-in" behavior, is only for measurement, not
> > appraisal. ?For appraisal, it still enforces file hash/signature
> > verification, as it should, based on policy.
> > 
> > Christoph, could we call ->read_iter() in the NULL case as Boaz
> > suggested?
> 
> No - that way you get deadlocks for every fs that uses i_rwsem in
> ->read_iter, which is perfectly valid behavior.
> 
> We can set ->integrity_read for every file system that's been tested
> with IMA, though.  Do you have a list of known-good file systems?

In addition to the ones you've already defined, we need definitions in
ramfs/file-mmu.c and file-nommu.c, and the corresponding tmpfs, to get
the initial measurements from the initramfs.
?
We know that stacked filesystems have similar locking problems. ?I'm
loop back mounting each filesystem and testing to see if files are
being measured/re-measured properly. ?I haven't finished yet, but
there haven't been any problems so far.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
