From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Sun, 04 Jun 2017 21:57:21 -0400
Subject: [PATCH] security/ima: use fs method to read integrity data
In-Reply-To: <alpine.LRH.2.20.1706051022330.5970@namei.org>
References: <20170510064507.1764-1-hch@lst.de>
	<20170510064507.1764-2-hch@lst.de>
	<alpine.LRH.2.20.1705110959020.15627@namei.org>
	<20170604054747.GA31064@lst.de>
	<alpine.LRH.2.20.1706051022330.5970@namei.org>
Message-ID: <1496627841.2998.44.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-06-05 at 10:23 +1000, James Morris wrote:
> On Sun, 4 Jun 2017, Christoph Hellwig wrote:
> 
> > On Thu, May 11, 2017 at 09:59:51AM +1000, James Morris wrote:
> > > On Wed, 10 May 2017, Christoph Hellwig wrote:
> > > 
> > > > Add a new ->integrity_read file operation to read data for
> > > > integrity hash collection.  This is defined to be equivalent
> > > > to ->read_iter, except that it will be called with the i_rwsem
> > > > held exclusively.  Also the presence of ->integrity_read indicates
> > > > that the file system can support IMA.
> > > > 
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > 
> > > Fixes an IMA+XFS deadlock I've been seeing.
> > 
> > Are you going to pick this up?  Any feedback from the folks on the
> > LSM list on what additional file systems need to be wired up?
> 
> That would normally come in via Mimi's tree, but I will pick it up if it 
> doesn't.

With just this patch, a number of file measurements and appraisal
verifications are missing. ?I'm hoping to have an initial patch set
ready to be posted later this week.

Sorry for the delay.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
