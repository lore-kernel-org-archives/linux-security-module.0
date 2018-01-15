From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 15 Jan 2018 09:19:14 -0800
Subject: [PATCH] ima: define new policy condition based on the filesystem
	name
In-Reply-To: <1516034407.6607.26.camel@linux.vnet.ibm.com>
References: <1516033236.6607.6.camel@linux.vnet.ibm.com>
	<20180115162726.GB15686@infradead.org>
	<1516034407.6607.26.camel@linux.vnet.ibm.com>
Message-ID: <20180115171914.GB28088@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jan 15, 2018 at 11:40:07AM -0500, Mimi Zohar wrote:
> rootfs IS different than other filesystems, as other filesystems
> uniquely identify the underlying filesystem type. ?rootfs can be a
> ramfs or tmpfs filesystem. ?Only tmpfs supports xattrs.

Tons of filesystems only have xattrs optionally.  Check for goddamn
xattrs if that is the requirement and not a name that has absolutely
zero meaning for functionality.  That is the whole point!
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
