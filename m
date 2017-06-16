From: dhowells@redhat.com (David Howells)
Date: Fri, 16 Jun 2017 16:54:30 +0100
Subject: [PATCH 07/27] VFS: Differentiate mount flags (MS_*) from internal
	superblock flags [ver #5]
In-Reply-To: <20170616154959.GA27209@infradead.org>
References: <20170616154959.GA27209@infradead.org>
	<20170616090621.GA13775@infradead.org>
	<149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
	<149745338248.10897.17175227466711674034.stgit@warthog.procyon.org.uk>
	<20170615093927.GG31671@ZenIV.linux.org.uk>
	<9141.1497624810@warthog.procyon.org.uk>
Message-ID: <654.1497628470@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> (1) Add a new SB field that is like s_flags but for the new flags,

Do we really need to do that?  The SB_* flags are conumeric with the MS_*
flags they replace.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
