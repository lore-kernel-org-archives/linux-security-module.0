From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 16 Jun 2017 02:06:21 -0700
Subject: [PATCH 07/27] VFS: Differentiate mount flags (MS_*) from
	internal superblock flags [ver #5]
In-Reply-To: <20170615093927.GG31671@ZenIV.linux.org.uk>
References: <149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
	<149745338248.10897.17175227466711674034.stgit@warthog.procyon.org.uk>
	<20170615093927.GG31671@ZenIV.linux.org.uk>
Message-ID: <20170616090621.GA13775@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

FYI, this patch didn't seem to make it through to the list, probably
because it was too large.

It might be good to just introduce the internal flags field first,
populate it with the translated flags, then switch users over to
it, and last but not least remove the old flags field and the MS_*
values that were only used internally.

Also if would be good to sort this out in a separate series without
all the mount context stuff.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
