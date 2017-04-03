From: dhowells@redhat.com (David Howells)
Date: Mon, 03 Apr 2017 20:20:44 +0100
Subject: [PATCH] KEYS: fix dereferencing NULL payload with nonzero length
In-Reply-To: <20170403175929.GB72831@gmail.com>
References: <20170403175929.GB72831@gmail.com>
	<20170401213428.17097-1-ebiggers3@gmail.com>
	<3451.1491234402@warthog.procyon.org.uk>
Message-ID: <6884.1491247244@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> > > -	if (_payload) {
> > > +	if (plen) {
> > 
> > "if (_payload && plen)" would be better.
> > 
> > David
> 
> No, that doesn't solve the problem.  The problem is that userspace can pass
> in a NULL payload with nonzero length, causing the kernel to dereference a
> NULL pointer for some key types.  For example:

Okay, in that case, I think there should be an else-statement that clears plen
if !_payload.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
