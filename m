From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 25 May 2017 09:44:16 -0700
Subject: [PATCH] tpm, tpm_infineon: remove useless snprintf() calls
In-Reply-To: <trinity-b171219a-5a85-4fd0-9bc7-f5ecde2598f4-1495690145148@3capp-gmx-bs66>
References: <20170524212916.9106-1-jarkko.sakkinen@linux.intel.com>
	<20170524215259.xkaqrnhcb44jpyd5@intel.com>
	<trinity-b171219a-5a85-4fd0-9bc7-f5ecde2598f4-1495690145148@3capp-gmx-bs66>
Message-ID: <20170525164416.5dn7l3eu4tkudypn@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, May 25, 2017 at 07:29:05AM +0200, Peter Huewe wrote:
> > The memory copy from rodata to stack is useless.
> >
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> After review, yes that should work.
> Reviewed-by: Peter Huewe <peterhuewe@gmx.de>

Yes, the string gets stored to rodata section where it is copied to
stack :-)

Thanx!

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
