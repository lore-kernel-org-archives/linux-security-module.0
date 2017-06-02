From: ebiggers3@gmail.com (Eric Biggers)
Date: Fri, 2 Jun 2017 10:24:17 -0700
Subject: [PATCH 1/5] KEYS: sanitize add_key() and keyctl() key payloads
In-Reply-To: <5744.1496417684@warthog.procyon.org.uk>
References: <20170421083037.12746-2-ebiggers3@gmail.com>
	<20170421083037.12746-1-ebiggers3@gmail.com>
	<5744.1496417684@warthog.procyon.org.uk>
Message-ID: <20170602172417.GA2938@zzz>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jun 02, 2017 at 04:34:44PM +0100, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> >  error2:
> > +	memzero_explicit(payload, plen);
> 
> Isn't that wrong?  payload can be NULL.
> 
> David

If you're talking about memset(NULL, ..., 0) being undefined behavior, it's
completely insane but sure, I guess we should add the NULL check to be safe.  It
would also mean there would be no requirement that "KEYS: fix dereferencing NULL
payload with nonzero length" be applied first so the second paragraph of the
commit message would be removed.  I'll send a v2 of just this patch.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
