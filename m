From: ebiggers3@gmail.com (Eric Biggers)
Date: Fri, 21 Apr 2017 11:24:18 -0700
Subject: [PATCH 3/5] KEYS: encrypted: sanitize all key material
In-Reply-To: <28373.1492785068@warthog.procyon.org.uk>
References: <20170421083037.12746-4-ebiggers3@gmail.com>
	<20170421083037.12746-1-ebiggers3@gmail.com>
	<28373.1492785068@warthog.procyon.org.uk>
Message-ID: <20170421182418.GA12755@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Apr 21, 2017 at 03:31:08PM +0100, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > -	memzero_explicit(epayload->decrypted_data, epayload->decrypted_datalen);
> > -	kfree(key->payload.data[0]);
> > +	kzfree(key->payload.data[0]);
> 
> Should kzfree() be using memzero_explicit() rather than memset()?
> 
> David

It's not actually needed because it's impossible for the compiler to optimize
away the memset().  memzero_explicit() is only needed on stack data.

The reason I still used memzero_explicit() for heap data in a couple of my
patches, even though it's unnecessary, is just that it makes it clearer that
it's being done for sanitization purposes, as opposed to some random memset.

That's not as much of an issue for kzfree(), since it's explicitly for
sanitization purposes already.

As a separate note, something that might make sense at some point would be to
skip the memset in kzfree() if slab poisoning is enabled.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
