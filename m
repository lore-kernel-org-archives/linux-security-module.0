From: ebiggers3@gmail.com (Eric Biggers)
Date: Mon, 3 Apr 2017 14:30:41 -0700
Subject: [PATCH] KEYS: fix dereferencing NULL payload with nonzero length
In-Reply-To: <6884.1491247244@warthog.procyon.org.uk>
References: <20170403175929.GB72831@gmail.com>
	<20170401213428.17097-1-ebiggers3@gmail.com>
	<3451.1491234402@warthog.procyon.org.uk>
	<6884.1491247244@warthog.procyon.org.uk>
Message-ID: <20170403213041.GA140817@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Apr 03, 2017 at 08:20:44PM +0100, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > > > -	if (_payload) {
> > > > +	if (plen) {
> > > 
> > > "if (_payload && plen)" would be better.
> > > 
> > > David
> > 
> > No, that doesn't solve the problem.  The problem is that userspace can pass
> > in a NULL payload with nonzero length, causing the kernel to dereference a
> > NULL pointer for some key types.  For example:
> 
> Okay, in that case, I think there should be an else-statement that clears plen
> if !_payload.
> 
> David

I think it's preferable to return EFAULT in the case in question.  Most syscalls
work like that, i.e. if you say you have 100 bytes (or any number > 0) at
address NULL you'll get EFAULT.

Also note that anyone doing this before would have been either crashing the
kernel or getting EINVAL.  So starting to return EFAULT would be very unlikely
to break anything.

- Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
