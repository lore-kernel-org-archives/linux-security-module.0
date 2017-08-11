From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 11 Aug 2017 13:11:44 -0400
Subject: [PATCH v5 2/4] ima: use fs method to read integrity data
In-Reply-To: <1502457606.3579.87.camel@linux.vnet.ibm.com>
References: <1502408507-4257-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1502408507-4257-3-git-send-email-zohar@linux.vnet.ibm.com>
	<20170811102113.GC11531@lst.de>
	<1502457606.3579.87.camel@linux.vnet.ibm.com>
Message-ID: <1502471504.3579.116.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-08-11 at 09:20 -0400, Mimi Zohar wrote:
> On Fri, 2017-08-11 at 12:21 +0200, Christoph Hellwig wrote:
> > On Thu, Aug 10, 2017 at 07:41:45PM -0400, Mimi Zohar wrote:
> > > From: Christoph Hellwig <hch@lst.de>
> > > 
> > > Add a new ->integrity_read file operation to read data for integrity
> > > hash collection.  This is defined to be equivalent to ->read_iter,
> > > except that it will be called with the i_rwsem held exclusively.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Btw, most of this is yours now, feel free to take over the authorship
> > with a little credit to me for the initial patch if you want.
> 
> Thank you so much for the initial design and patch!

After moving the libfs and efivarfs code to separate patches, the
patch hasn't changed all that much, just additional file systems. ?If
you don't object, I'll leave you as the author.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
