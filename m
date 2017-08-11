From: hch@lst.de (Christoph Hellwig)
Date: Fri, 11 Aug 2017 19:15:52 +0200
Subject: [PATCH v5 2/4] ima: use fs method to read integrity data
In-Reply-To: <1502471504.3579.116.camel@linux.vnet.ibm.com>
References: <1502408507-4257-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1502408507-4257-3-git-send-email-zohar@linux.vnet.ibm.com>
	<20170811102113.GC11531@lst.de>
	<1502457606.3579.87.camel@linux.vnet.ibm.com>
	<1502471504.3579.116.camel@linux.vnet.ibm.com>
Message-ID: <20170811171552.GA1299@lst.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Aug 11, 2017 at 01:11:44PM -0400, Mimi Zohar wrote:
> After moving the libfs and efivarfs code to separate patches, the
> patch hasn't changed all that much, just additional file systems. ?If
> you don't object, I'll leave you as the author.

Sure - feel free to handle it whichever way you want.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
