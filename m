From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 15 Jan 2018 11:40:07 -0500
Subject: [PATCH] ima: define new policy condition based on the
	filesystem name
In-Reply-To: <20180115162726.GB15686@infradead.org>
References: <1516033236.6607.6.camel@linux.vnet.ibm.com>
	<20180115162726.GB15686@infradead.org>
Message-ID: <1516034407.6607.26.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-01-15 at 08:27 -0800, Christoph Hellwig wrote:
> On Mon, Jan 15, 2018 at 11:20:36AM -0500, Mimi Zohar wrote:
> > Some filesystems do not export the filesystem's magic number, as it is
> > considered internal, private data.  In other cases, the policy rule
> > needs to identify a specifically mounted filesystem (eg. rootfs).
> 
> No, it doesn't.  Policies based on a file system type are complete and
> utterly bogus.   rootfs should not be treated any different from other
> file systems.

rootfs IS different than other filesystems, as other filesystems
uniquely identify the underlying filesystem type. ?rootfs can be a
ramfs or tmpfs filesystem. ?Only tmpfs supports xattrs.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
