From: jmorris@namei.org (James Morris)
Date: Wed, 16 Aug 2017 19:52:17 +1000 (AEST)
Subject: [PATCH v6 0/6] define new fs integrity_read method
In-Reply-To: <20170816063410.GB16531@lst.de>
References: <1502808237-2035-1-git-send-email-zohar@linux.vnet.ibm.com>
	<alpine.LRH.2.20.1708161240220.30541@namei.org>
	<20170816063410.GB16531@lst.de>
Message-ID: <alpine.LRH.2.20.1708161951210.13272@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 16 Aug 2017, Christoph Hellwig wrote:

> On Wed, Aug 16, 2017 at 12:43:58PM +1000, James Morris wrote:
> > On Tue, 15 Aug 2017, Mimi Zohar wrote:
> > 
> > > To resolve this locking problem, this patch set introduces a new
> > > ->integrity_read file operation method.  Until all filesystems
> > > define the new ->integrity_read method, files that were previously
> > > measured might not be currently measured and files that were
> > > previously appraised might fail to be appraised properly.
> > 
> > Are there any such filesystems in mainline which are not getting an 
> > integrity_read method in this patchset?
> 
> There are a few, mostly because we're pretty sure the previous integrity
> code did the wrong thing for them - e.g. ocfs2 and gfs2 where locking
> vs operations on other cluster nodes was missing, or NFS where in addition
> to the above deadlocks were 100% reprodicible with current code.

Should we do a warn_once for these filesystems when IMA is used?


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
