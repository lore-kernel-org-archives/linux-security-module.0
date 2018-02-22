From: dhowells@redhat.com (David Howells)
Date: Thu, 22 Feb 2018 23:42:15 +0000
Subject: [PATCH 6/6] KEYS: Use individual pages in big_key for crypto
	buffers
In-Reply-To: <151931646922.27713.5363631712174136041.stgit@warthog.procyon.org.uk>
References: <151931646922.27713.5363631712174136041.stgit@warthog.procyon.org.uk>
	<151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
Message-ID: <29838.1519342935@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> +		l = min(len, PAGE_SIZE);

Sigh.  This needs to be a min_t().

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
