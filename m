From: hch@lst.de (Christoph Hellwig)
Date: Wed, 14 Jun 2017 09:03:25 +0200
Subject: [PATCH 3/4] ima: use existing read file operation method to
	calculate file hash
In-Reply-To: <1497366449.21594.422.camel@linux.vnet.ibm.com>
References: <1497031364-19949-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1497031364-19949-4-git-send-email-zohar@linux.vnet.ibm.com>
	<20170613064658.GB31372@lst.de>
	<1497363465.21594.395.camel@linux.vnet.ibm.com>
	<20170613142208.GA23872@lst.de>
	<1497366449.21594.422.camel@linux.vnet.ibm.com>
Message-ID: <20170614070325.GA9757@lst.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jun 13, 2017 at 11:07:29AM -0400, Mimi Zohar wrote:
> The bigger problem is that files that were previously measured, might
> now not be measured, without any indication in the audit logs or the
> IMA measurement list.

And that's exactly what I've been preaching for a long time - you
need to decide on what your requirements for IMA are and check
for them when enabling it, not just have things sort of work
or not at runtime.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
