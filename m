From: dhowells@redhat.com (David Howells)
Date: Tue, 04 Apr 2017 20:44:49 +0100
Subject: [PATCH] KEYS: Fix integrity calls to keyring_alloc
In-Reply-To: <20170404183030.6054-1-mathew.j.martineau@linux.intel.com>
References: <20170404183030.6054-1-mathew.j.martineau@linux.intel.com>
Message-ID: <26247.1491335089@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Since I just rebuilt my keys-next branch, it's probably worth you folding in
this patch and repushing so that I can repull.  That way you won't get a
bisection problem if you're using the integrity stuff.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
