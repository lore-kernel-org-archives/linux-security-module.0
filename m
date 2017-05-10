From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 May 2017 15:24:00 +0200
Subject: [PATCH] security/ima: use fs method to read integrity data
In-Reply-To: <a552827e-922d-0b28-2919-90c780a8a414@plexistor.com>
References: <20170510064507.1764-1-hch@lst.de>
	<20170510064507.1764-2-hch@lst.de>
	<a552827e-922d-0b28-2919-90c780a8a414@plexistor.com>
Message-ID: <20170510132359.GA22549@lst.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 10, 2017 at 03:20:41PM +0300, Boaz Harrosh wrote:
> Would you not want to call ->read_iter() in the NULL case
> and have all FSs supported as today?

As IMA has particular requirements on the fs (e.g. that it can
read with i_rwsem held as seen in this patch, or useful i_version
which only the file systems converted in this patch do), having
an explicit opt-in seems much safer.  This optional method is
a very easy way to provide this opt-in behavior.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
