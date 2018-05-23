From: tadeusz.struk@intel.com (Tadeusz Struk)
Date: Wed, 23 May 2018 10:57:07 -0700
Subject: [PATCH] tpm: fix race condition in tpm_common_write()
In-Reply-To: <20180523132318.GE363@linux.intel.com>
References: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
	<20180523132318.GE363@linux.intel.com>
Message-ID: <fb9c3d0c-d6fe-25ee-6452-92ade053c75a@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 05/23/2018 06:23 AM, Jarkko Sakkinen wrote:
> Ouch o_O Do you have a fixes tag for this one?
> 

This one is quite tricky.
The original bug was introduced by abce9ac292e13 (tpm: Propagate error from tpm_transmit to fix a timeout hang)
and the code back then was in drivers/char/tpm/tpm-interface.c file

Then there were two other commits that moved the code around:
afdba32e2a9ea (tpm: Pull everything related to /dev/tpmX into tpm-dev.c)
which moved it from drivers/char/tpm/tpm-interface.c into drivers/char/tpm/tpm-dev.c

and last one, ecb38e2f521b0 (tpm: split out tpm-dev.c into tpm-dev.c and tpm-common-dev.c)
which moved it from drivers/char/tpm/tpm-dev.c into tpm-common-dev.c

I have no idea how to tag it. Maybe we can use:
Fixes: ecb38e2f521b0 ("tpm: split out tpm-dev.c into tpm-dev.c and tpm-common-dev.c")

And then it probably needs to be back ported manually all the way back to abce9ac292e13.

Thanks,
-- 
Tadeusz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
