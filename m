From: dhowells@redhat.com (David Howells)
Date: Fri, 16 Jun 2017 15:53:30 +0100
Subject: [PATCH 07/27] VFS: Differentiate mount flags (MS_*) from internal
	superblock flags [ver #5]
In-Reply-To: <20170616090621.GA13775@infradead.org>
References: <20170616090621.GA13775@infradead.org>
	<149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
	<149745338248.10897.17175227466711674034.stgit@warthog.procyon.org.uk>
	<20170615093927.GG31671@ZenIV.linux.org.uk>
Message-ID: <9141.1497624810@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> It might be good to just introduce the internal flags field first,

Internal flags field?  Did you mean Al's suggested sb_readonly() wrapper?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
