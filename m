From: dhowells@redhat.com (David Howells)
Date: Wed, 01 Aug 2018 23:53:17 +0100
Subject: [PATCH 08/33] vfs: Add LSM hooks for the new mount API [ver #11]
In-Reply-To: <alpine.LRH.2.21.1808020650230.13125@namei.org>
References: <alpine.LRH.2.21.1808020650230.13125@namei.org>
	<153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<153313709864.13253.2279983851744713211.stgit@warthog.procyon.org.uk>
Message-ID: <19305.1533163997@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> >  (2) A hook to snoop source specifications.  
> 
> 
> What are source specifications?

"/dev/sda1" or "my.nfs.server:/foo/bar".

Actually, this hook is now gone.  Source specification is done by way of a
parameter with key of "source" and this can be specified multiple times if the
filesystem supports it (bcachefs for example).

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
