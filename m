From: tadeusz.struk@intel.com (Tadeusz Struk)
Date: Mon, 23 Jul 2018 13:53:14 -0700
Subject: [PATCH] tpm: add support for partial reads
In-Reply-To: <20180723201956.GB26824@linux.intel.com>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
	<20180723201956.GB26824@linux.intel.com>
Message-ID: <fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/23/2018 01:19 PM, Jarkko Sakkinen wrote:
> In this case I do not have any major evidence of any major benefit *and*
> the change breaks the ABI.

As I said before - this does not break the ABI.
As for the benefits - it help user space in how they implement the receive
path. Application does not need to provide a 4K buffer for every read even
if the response is, for instance 8 bytes long.
Thanks,
-- 
Tadeusz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
