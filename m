From: hch@lst.de (Christoph Hellwig)
Date: Thu, 11 May 2017 10:16:59 +0200
Subject: [PATCH] security/ima: use fs method to read integrity data
In-Reply-To: <1494450047.3006.28.camel@linux.vnet.ibm.com>
References: <20170510064507.1764-1-hch@lst.de>
	<20170510064507.1764-2-hch@lst.de>
	<a552827e-922d-0b28-2919-90c780a8a414@plexistor.com>
	<20170510132359.GA22549@lst.de>
	<1494450047.3006.28.camel@linux.vnet.ibm.com>
Message-ID: <20170511081659.GA20214@lst.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 10, 2017 at 05:00:47PM -0400, Mimi Zohar wrote:
> Without i_version support the file is measured/appraised once. ?With
> i_version support it will be re-measured/appraised. As a file system
> is mounted/remounted, some sort of message should be emitted
> indicating whether i_version is supported.

You can check for (sb->s_flags & MS_I_VERSION) to see if it's supported.

> ?That does not imply that
> there is no value in measuring/appraising the file only once.
> 
> With this patch, the "opt-in" behavior, is only for measurement, not
> appraisal. ?For appraisal, it still enforces file hash/signature
> verification, as it should, based on policy.
> 
> Christoph, could we call ->read_iter() in the NULL case as Boaz
> suggested?

No - that way you get deadlocks for every fs that uses i_rwsem in
->read_iter, which is perfectly valid behavior.

We can set ->integrity_read for every file system that's been tested
with IMA, though.  Do you have a list of known-good file systems?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
