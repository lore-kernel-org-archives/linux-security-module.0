From: hch@lst.de (Christoph Hellwig)
Date: Sun, 4 Jun 2017 07:47:47 +0200
Subject: [PATCH] security/ima: use fs method to read integrity data
In-Reply-To: <alpine.LRH.2.20.1705110959020.15627@namei.org>
References: <20170510064507.1764-1-hch@lst.de>
	<20170510064507.1764-2-hch@lst.de>
	<alpine.LRH.2.20.1705110959020.15627@namei.org>
Message-ID: <20170604054747.GA31064@lst.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, May 11, 2017 at 09:59:51AM +1000, James Morris wrote:
> On Wed, 10 May 2017, Christoph Hellwig wrote:
> 
> > Add a new ->integrity_read file operation to read data for
> > integrity hash collection.  This is defined to be equivalent
> > to ->read_iter, except that it will be called with the i_rwsem
> > held exclusively.  Also the presence of ->integrity_read indicates
> > that the file system can support IMA.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Fixes an IMA+XFS deadlock I've been seeing.

Are you going to pick this up?  Any feedback from the folks on the
LSM list on what additional file systems need to be wired up?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
