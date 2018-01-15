From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 15 Jan 2018 08:27:26 -0800
Subject: [PATCH] ima: define new policy condition based on the filesystem
	name
In-Reply-To: <1516033236.6607.6.camel@linux.vnet.ibm.com>
References: <1516033236.6607.6.camel@linux.vnet.ibm.com>
Message-ID: <20180115162726.GB15686@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jan 15, 2018 at 11:20:36AM -0500, Mimi Zohar wrote:
> Some filesystems do not export the filesystem's magic number, as it is
> considered internal, private data.  In other cases, the policy rule
> needs to identify a specifically mounted filesystem (eg. rootfs).

No, it doesn't.  Policies based on a file system type are complete and
utterly bogus.   rootfs should not be treated any different from other
file systems.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
