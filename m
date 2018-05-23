From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Wed, 23 May 2018 13:41:15 -0600
Subject: [PATCH] tpm: fix race condition in tpm_common_write()
In-Reply-To: <fb9c3d0c-d6fe-25ee-6452-92ade053c75a@intel.com>
References: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
	<20180523132318.GE363@linux.intel.com>
	<fb9c3d0c-d6fe-25ee-6452-92ade053c75a@intel.com>
Message-ID: <20180523194115.GC8705@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 23, 2018 at 10:57:07AM -0700, Tadeusz Struk wrote:
> On 05/23/2018 06:23 AM, Jarkko Sakkinen wrote:
> > Ouch o_O Do you have a fixes tag for this one?
> > 
> 
> This one is quite tricky.
> The original bug was introduced by abce9ac292e13 (tpm: Propagate error from tpm_transmit to fix a timeout hang)
> and the code back then was in drivers/char/tpm/tpm-interface.c file

No, it has been wrong since before git history started, so just use

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

All the other commits you listed are just moving the bad code around
to new files.

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
