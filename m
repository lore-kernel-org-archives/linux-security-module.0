From: hch@lst.de (Christoph Hellwig)
Date: Wed, 5 Jul 2017 19:18:57 +0200
Subject: [PATCH v2 10/10] ima: use existing read file operation method
	to calculate file hash
In-Reply-To: <20170705170215.GA14148@srcf.ucam.org>
References: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1498069110-10009-11-git-send-email-zohar@linux.vnet.ibm.com>
	<20170628144111.GI2359@lst.de>
	<1499266209.3059.91.camel@linux.vnet.ibm.com>
	<20170705170215.GA14148@srcf.ucam.org>
Message-ID: <20170705171857.GA5246@lst.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jul 05, 2017 at 06:02:15PM +0100, Matthew Garrett wrote:
> On Wed, Jul 05, 2017 at 10:50:09AM -0400, Mimi Zohar wrote:
> > [Cc'ing linux-ima-users]
> > 
> > On Wed, 2017-06-28 at 16:41 +0200, Christoph Hellwig wrote:
> > > NAK - we'll need an explicit method for the integrity code.
> > > 
> > > And just curious - what filesystem that you care about actually
> > > implements ->read instead of ->read_iter?  We shouldn't be doing that
> > > for real file systems anymore.
> > 
> > Right, pseudo filesystems are using ->read. The existing builtin
> > measurement policies exclude a number of pseudo filesystems, but not
> > efivarfs. ?Unfortunately, we do not know what type of custom policies
> > are currently being used.
> 
> efi variables contain information that may influence userspace behaviour 
> and can also be modified out of band, so I think there's a reasonable 
> argument that they should be measured.

Then efivars should grow a ->integrity_read method.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
