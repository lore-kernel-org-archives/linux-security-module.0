From: ebiggers3@gmail.com (Eric Biggers)
Date: Sun, 4 Jun 2017 20:34:12 -0700
Subject: security/keys: add CONFIG_KEYS_COMPAT to Kconfig
In-Reply-To: <30959.1496477082@warthog.procyon.org.uk>
References: <20170603024358.GA565@zzz>
	<1486674698-67190-1-git-send-email-bilal.amarni@gmail.com>
	<20170329192002.GA29310@gmail.com>
	<30959.1496477082@warthog.procyon.org.uk>
Message-ID: <20170605033412.GA6277@zzz>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Jun 03, 2017 at 09:04:42AM +0100, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > This patch is in the "keys-fixes" branch now, but it doesn't remove KEYS_COMPAT
> > from arch/arm64/Kconfig.  David, can you fix it?  Thanks!
> 
> Done.  See below.
> 
> David
> ---

Looks good now, thanks.  (Except that as I mentioned before, I don't think we
need the KEYS_COMPAT option at all, but that can be another patch.)

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
