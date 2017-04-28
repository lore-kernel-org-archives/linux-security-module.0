From: ebiggers3@gmail.com (Eric Biggers)
Date: Fri, 28 Apr 2017 10:57:12 -0700
Subject: [PATCH 1/5] KEYS: sanitize add_key() and keyctl() key payloads
In-Reply-To: <20170421083037.12746-2-ebiggers3@gmail.com>
References: <20170421083037.12746-1-ebiggers3@gmail.com>
	<20170421083037.12746-2-ebiggers3@gmail.com>
Message-ID: <20170428175712.GA14932@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hey David,

On Fri, Apr 21, 2017 at 01:30:33AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Before returning from add_key() or one of the keyctl() commands that
> takes in a key payload, zero the temporary buffer that was allocated to
> hold the key payload copied from userspace.  This may contain sensitive
> key material that should not be kept around in the slab caches.
> 
> This must not be applied before the patch "KEYS: fix dereferencing NULL
> payload with nonzero length".
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Can you make sure that my other patch "KEYS: fix dereferencing NULL payload with
nonzero length" gets applied along with this one?  Otherwise triggering the NULL
pointer dereference (which really needs to be fixed anyway) becomes even more
trivial.  The only reason I didn't check for NULL before doing the memsets is
that the bug was going to have to be fixed anyway, and the fix backported.

- Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
