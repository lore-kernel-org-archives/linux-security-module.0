From: ebiggers3@gmail.com (Eric Biggers)
Date: Sun, 29 Oct 2017 09:32:46 -0700
Subject: [PATCH v2] fscrypt: fix dereference of NULL user_key_payload
In-Reply-To: <20171029102305.4ifapjehlrgwsqmu@thunk.org>
References: <20171009194618.67494-1-ebiggers3@gmail.com>
	<20171029102305.4ifapjehlrgwsqmu@thunk.org>
Message-ID: <20171029163246.GA566@zzz.localdomain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Oct 29, 2017 at 06:23:05AM -0400, Theodore Ts'o wrote:
> On Mon, Oct 09, 2017 at 12:46:18PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > When an fscrypt-encrypted file is opened, we request the file's master
> > key from the keyrings service as a logon key, then access its payload.
> > However, a revoked key has a NULL payload, and we failed to check for
> > this.  request_key() *does* skip revoked keys, but there is still a
> > window where the key can be revoked before we acquire its semaphore.
> > 
> > Fix it by checking for a NULL payload, treating it like a key which was
> > already revoked at the time it was requested.
> > 
> > Fixes: 88bd6ccdcdd6 ("ext4 crypto: add encryption key management facilities")
> > Reviewed-by: James Morris <james.l.morris@oracle.com>
> > Cc: <stable@vger.kernel.org>    [v4.1+]
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Applied, thanks.
> 

Hi Ted, you should drop this one, since it's already in mainline; David Howells
ended up taking the original series via the keyrings tree.

Thanks!

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
