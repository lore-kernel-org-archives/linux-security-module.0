From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 06 Jul 2017 07:55:20 -0400
Subject: [PATCH v2 05/10] tmpfs: define integrity_read method
In-Reply-To: <20170628143858.GD2359@lst.de>
References: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1498069110-10009-6-git-send-email-zohar@linux.vnet.ibm.com>
	<20170628143858.GD2359@lst.de>
Message-ID: <1499342120.5500.3.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2017-06-28 at 16:38 +0200, Christoph Hellwig wrote:
> On Wed, Jun 21, 2017 at 02:18:25PM -0400, Mimi Zohar wrote:
> > Define an ->integrity_read file operation method to read data for
> > integrity hash collection.
> 
> should be folded into patch 2.

I was hoping to get some Acks/sign-off's from the individual
filesystem maintainers before squashing them. ?The next version will
be squashed.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
