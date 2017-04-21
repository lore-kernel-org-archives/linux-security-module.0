From: ebiggers3@gmail.com (Eric Biggers)
Date: Fri, 21 Apr 2017 11:34:45 -0700
Subject: [PATCH 2/5] KEYS: user_defined: sanitize key payloads
In-Reply-To: <20091.1492783037@warthog.procyon.org.uk>
References: <20170421083037.12746-3-ebiggers3@gmail.com>
	<20170421083037.12746-1-ebiggers3@gmail.com>
	<20091.1492783037@warthog.procyon.org.uk>
Message-ID: <20170421183445.GB12755@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Apr 21, 2017 at 02:57:17PM +0100, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > -		kfree_rcu(zap, rcu);
> > +		call_rcu(&zap->rcu, user_free_payload_rcu);
> 
> Add kzfree_rcu()?
> 
> David

We could, but it's not trivial because the way kfree_rcu() works is to store the
offset of the rcu_head as the callback function, then have a special case in RCU
reclaim that recognizes "function pointers" with value < 4096 and call kfree()
rather than the function.  To support kzfree_rcu() we'd need to reserve another
4096 bytes of the address space (maybe at the end?), then check for the special
kzfree value on every RCU reclaim.  Or equivalently it could be a flag.  It's
possible, but it may be best to just use a custom callback for now.  Then if it
can be shown later that there are a lot of users who would like a
"kzfree_rcu()", it can be added.

- Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
