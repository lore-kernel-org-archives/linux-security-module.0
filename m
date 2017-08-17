From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 17 Aug 2017 07:00:17 -0400
Subject: [PATCH v6 1/6] libfs: define simple_read_iter_from_buffer
In-Reply-To: <alpine.LRH.2.20.1708171241420.10905@namei.org>
References: <1502808237-2035-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1502808237-2035-2-git-send-email-zohar@linux.vnet.ibm.com>
	<20170816063508.GA16683@lst.de>
	<1502905386.21278.2.camel@linux.vnet.ibm.com>
	<alpine.LRH.2.20.1708171241420.10905@namei.org>
Message-ID: <1502967617.21278.68.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-08-17 at 12:42 +1000, James Morris wrote:
> On Wed, 16 Aug 2017, Mimi Zohar wrote:
> 
> > On Wed, 2017-08-16 at 08:35 +0200, Christoph Hellwig wrote:
> > > Looks good,
> > > 
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> > Thank you for the reviewed-by's.
> > 
> > Up to now I haven't been removing the Changelog before sending James a
> > pull request.??Adding the dashes in the commit itself, only changes
> > how the patches are applied by others to their local branch, not to
> > what would be upstreamed.??Am I suppose to be removing the changelog
> > before sending a pull request?
> 
> I don't really understand this, but leave the changelog in?

Christoph had commented that the "---" should be before the Changelog,
not afterwards, so that git-am skips them. ?The changelog is needed by
reviewers, but once upstreamed it isn't really needed any more. ?Based
on Christph's response (offline), any information in the changelog
that is still useful, should move into the commit description itself
or code.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
