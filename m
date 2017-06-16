From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 16 Jun 2017 08:49:59 -0700
Subject: [PATCH 07/27] VFS: Differentiate mount flags (MS_*) from
	internal superblock flags [ver #5]
In-Reply-To: <9141.1497624810@warthog.procyon.org.uk>
References: <20170616090621.GA13775@infradead.org>
	<149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
	<149745338248.10897.17175227466711674034.stgit@warthog.procyon.org.uk>
	<20170615093927.GG31671@ZenIV.linux.org.uk>
	<9141.1497624810@warthog.procyon.org.uk>
Message-ID: <20170616154959.GA27209@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jun 16, 2017 at 03:53:30PM +0100, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > It might be good to just introduce the internal flags field first,
> 
> Internal flags field?  Did you mean Al's suggested sb_readonly() wrapper?

(1) Add a new SB field that is like s_flags but for the new flags,
(2) switch users over to the new field
(3) remove s_flags
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
