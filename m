From: ebiggers3@gmail.com (Eric Biggers)
Date: Tue, 9 May 2017 14:45:26 -0700
Subject: [PATCH] key: Convert big_key payload.data to struct
In-Reply-To: <13867.1494314658@warthog.procyon.org.uk>
References: <20170508221943.GA46762@gmail.com> <20170508214324.GA124468@beast>
	<10235.1494280856@warthog.procyon.org.uk>
	<13867.1494314658@warthog.procyon.org.uk>
Message-ID: <20170509214526.GB87747@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, May 09, 2017 at 08:24:18AM +0100, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > It probably would be easier to kmalloc() this struct and store a pointer to
> > it in key->payload.data[0]
> 
> Yeah, but it's a waste of resources if you don't have to do it.
> 
> David

Yes, but it seems very much like a micro-optimization, which isn't helpful when
the code contains undefined behavior and is creating problems.  This is the
*big* key type, after all; shouldn't the amount of data in the key normally be
large enough to make a kmalloc() of 24 bytes insignificant?

And besides, I expect that most users don't even use the big_keys feature.  If
we actually want to avoid wasting resources that aren't used, we shouldn't
allocate the crypto_rng and crypto_skcipher until someone tries to create a
big_key.  (Currently they're allocated unconditionally in big_key_init().)

- Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
