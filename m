From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 05 Feb 2018 12:31:41 -0500
Subject: [PATCH] ima: define new policy condition based on the
	filesystem name
In-Reply-To: <20180115171914.GB28088@infradead.org>
References: <1516033236.6607.6.camel@linux.vnet.ibm.com>
	<20180115162726.GB15686@infradead.org>
	<1516034407.6607.26.camel@linux.vnet.ibm.com>
	<20180115171914.GB28088@infradead.org>
Message-ID: <1517851901.3736.120.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-01-15 at 09:19 -0800, Christoph Hellwig wrote:
> On Mon, Jan 15, 2018 at 11:40:07AM -0500, Mimi Zohar wrote:
> > rootfs IS different than other filesystems, as other filesystems
> > uniquely identify the underlying filesystem type. ?rootfs can be a
> > ramfs or tmpfs filesystem. ?Only tmpfs supports xattrs.
> 
> Tons of filesystems only have xattrs optionally.  Check for goddamn
> xattrs if that is the requirement and not a name that has absolutely
> zero meaning for functionality.  That is the whole point!

I should have said the main reason for defining a rootfs policy rule
is not to differentiate it from ramfs, but the ability to require file
signatures.

Up to now, CPIO did not support xattrs. ?With Taras' proposed CPIO
xattr patch set, the initramfs can now be properly labeled with file
signatures. ?Since only some systems will include file signatures in
the initramfs, we need to be able to differentiate between those that
require file signatures from those that don't.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
