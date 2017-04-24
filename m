From: dhowells@redhat.com (David Howells)
Date: Mon, 24 Apr 2017 15:14:35 +0100
Subject: [PATCH 2/5] KEYS: user_defined: sanitize key payloads
In-Reply-To: <20170421183445.GB12755@gmail.com>
References: <20170421183445.GB12755@gmail.com>
	<20170421083037.12746-3-ebiggers3@gmail.com>
	<20170421083037.12746-1-ebiggers3@gmail.com>
	<20091.1492783037@warthog.procyon.org.uk>
Message-ID: <28138.1493043275@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> > Add kzfree_rcu()?
> > 
> > David
> 
> We could, but it's not trivial because the way kfree_rcu() works is to store
> the offset of the rcu_head as the callback function, then have a special
> case in RCU reclaim that recognizes "function pointers" with value < 4096
> and call kfree() rather than the function. ...

Okay, that sounds reasonable.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
