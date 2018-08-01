From: jmorris@namei.org (James Morris)
Date: Thu, 2 Aug 2018 06:50:54 +1000 (AEST)
Subject: [PATCH 08/33] vfs: Add LSM hooks for the new mount API [ver #11]
In-Reply-To: <153313709864.13253.2279983851744713211.stgit@warthog.procyon.org.uk>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<153313709864.13253.2279983851744713211.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1808020650230.13125@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 1 Aug 2018, David Howells wrote:

>  (2) A hook to snoop source specifications.  


What are source specifications?


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
