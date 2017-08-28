From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Mon, 28 Aug 2017 05:13:01 +0100
Subject: [PATCH v6 4/6] ima: use fs method to read integrity data
In-Reply-To: <1502808237-2035-5-git-send-email-zohar@linux.vnet.ibm.com>
References: <1502808237-2035-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1502808237-2035-5-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <20170828041301.GA21125@ZenIV.linux.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Aug 15, 2017 at 10:43:55AM -0400, Mimi Zohar wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Add a new ->integrity_read file operation to read data for integrity
> hash collection.  This is defined to be equivalent to ->read_iter,
> except that it will be called with the i_rwsem held exclusively.

Hmm...  I'm really tempted to add default_integrity_read() that would
just call ->read_iter(), with boilerplate part becoming
	.integrity_read = default_integrity_read

Note that all stuff accessed in it would be fresh in caches, so
it's not as if we had serious overhead there.  And we are going
to be reading from file, anyway...

I agree that it should be an opt-in from filesystem; default is still
"don't know how to read, sod off".  It's just that telling at the
glance whether it's supposed to be a simple case or something tricky
is needed would be simpler that way and it might turn out to be
more robust that way...
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
