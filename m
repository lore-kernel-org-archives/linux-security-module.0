From: ebiggers3@gmail.com (Eric Biggers)
Date: Mon, 25 Jun 2018 10:14:26 -0700
Subject: [PATCH] dh key: fix rounding up KDF output length
In-Reply-To: <17595.1528472278@warthog.procyon.org.uk>
References: <20180607191201.97080-1-ebiggers3@gmail.com>
	<0000000000009c221d056e0cf53a@google.com>
	<17595.1528472278@warthog.procyon.org.uk>
Message-ID: <20180625171426.GA180889@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi David,

On Fri, Jun 08, 2018 at 04:37:58PM +0100, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > Commit 383203eff718 ("dh key: get rid of stack allocated array") changed
> > kdf_ctr() to assume that the length of key material to derive is a
> > multiple of the digest size.  The length was supposed to be rounded up
> > accordingly.  However, the round_up() macro was used which only gives
> > the correct result on power-of-2 arguments, whereas not all hash
> > algorithms have power-of-2 digest sizes.  In some cases this resulted in
> > a write past the end of the 'outbuf' buffer.
> > 
> > Fix it by switching to roundup(), which works for non-power-of-2 inputs.
> 
> Applied.

Applied to where?  When are you planning to send this to Linus?  Note that this
was a regression from v4.17 to v4.18-rc1.

Thanks,

- Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
