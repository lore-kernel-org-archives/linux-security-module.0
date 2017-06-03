From: ebiggers3@gmail.com (Eric Biggers)
Date: Fri, 2 Jun 2017 19:43:58 -0700
Subject: security/keys: add CONFIG_KEYS_COMPAT to Kconfig
In-Reply-To: <20170329192002.GA29310@gmail.com>
References: <1486674698-67190-1-git-send-email-bilal.amarni@gmail.com>
	<20170329192002.GA29310@gmail.com>
Message-ID: <20170603024358.GA565@zzz>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Mar 29, 2017 at 12:20:02PM -0700, Eric Biggers wrote:
> On Thu,  9 Feb 2017 22:11:38 +0100, Bilal Amarni wrote:
> > CONFIG_KEYS_COMPAT is defined in arch-specific Kconfigs and is missing for
> > several 64-bit architectures : arm64, mips, parisc, tile.
> > 
> > At the moment and for those architectures, calling in 32-bit userspace the
> > keyctl syscall would return an ENOSYS error.
> > 
> > This patch moves the CONFIG_KEYS_COMPAT option to security/keys/Kconfig, to
> > make sure the compatibility wrapper is registered by default for any 64-bit
> > architecture as long as it is configured with CONFIG_COMPAT.
> 
> David, where can I find the git branch this patch was applied to?  I don't see
> it anywhere in security-keys or linux-security.
> 
> I recently added KEYS_COMPAT to arm64 (5c2a625937ba); that should be reverted
> after this patch.
> 
> Also, I'd like to submit a follow-on patch that removes KEYS_COMPAT and simply
> uses COMPAT.
> 
> And the parisc architecture doesn't use compat_sys_keyctl() in its compat
> syscall table, so that should be fixed too (though that's not a new bug).
> 
> - Eric

This patch is in the "keys-fixes" branch now, but it doesn't remove KEYS_COMPAT
from arch/arm64/Kconfig.  David, can you fix it?  Thanks!

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
