From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 10 May 2017 17:00:47 -0400
Subject: [PATCH] security/ima: use fs method to read integrity data
In-Reply-To: <20170510132359.GA22549@lst.de>
References: <20170510064507.1764-1-hch@lst.de>
	<20170510064507.1764-2-hch@lst.de>
	<a552827e-922d-0b28-2919-90c780a8a414@plexistor.com>
	<20170510132359.GA22549@lst.de>
Message-ID: <1494450047.3006.28.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2017-05-10 at 15:24 +0200, Christoph Hellwig wrote:
> On Wed, May 10, 2017 at 03:20:41PM +0300, Boaz Harrosh wrote:
> > Would you not want to call ->read_iter() in the NULL case
> > and have all FSs supported as today?
> 
> As IMA has particular requirements on the fs (e.g. that it can
> read with i_rwsem held as seen in this patch, or useful i_version
> which only the file systems converted in this patch do), having
> an explicit opt-in seems much safer.  This optional method is
> a very easy way to provide this opt-in behavior.

Without i_version support the file is measured/appraised once. ?With
i_version support it will be re-measured/appraised. As a file system
is mounted/remounted, some sort of message should be emitted
indicating whether i_version is supported. ?That does not imply that
there is no value in measuring/appraising the file only once.

With this patch, the "opt-in" behavior, is only for measurement, not
appraisal. ?For appraisal, it still enforces file hash/signature
verification, as it should, based on policy.

Christoph, could we call ->read_iter() in the NULL case as Boaz
suggested?

thanks!

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
