From: jmorris@namei.org (James Morris)
Date: Thu, 17 Aug 2017 12:42:16 +1000 (AEST)
Subject: [PATCH v6 1/6] libfs: define simple_read_iter_from_buffer
In-Reply-To: <1502905386.21278.2.camel@linux.vnet.ibm.com>
References: <1502808237-2035-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1502808237-2035-2-git-send-email-zohar@linux.vnet.ibm.com>
	<20170816063508.GA16683@lst.de>
	<1502905386.21278.2.camel@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.20.1708171241420.10905@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 16 Aug 2017, Mimi Zohar wrote:

> On Wed, 2017-08-16 at 08:35 +0200, Christoph Hellwig wrote:
> > Looks good,
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Thank you for the reviewed-by's.
> 
> Up to now I haven't been removing the Changelog before sending James a
> pull request.??Adding the dashes in the commit itself, only changes
> how the patches are applied by others to their local branch, not to
> what would be upstreamed.??Am I suppose to be removing the changelog
> before sending a pull request?

I don't really understand this, but leave the changelog in?


-- 
James Morris
<jmorris@namei.org>
