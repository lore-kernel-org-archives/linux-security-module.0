From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Mon, 23 Jul 2018 14:13:32 -0700
Subject: [PATCH] tpm: add support for partial reads
In-Reply-To: <fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
	<20180723201956.GB26824@linux.intel.com>
	<fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
Message-ID: <1532380412.4112.22.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-07-23 at 13:53 -0700, Tadeusz Struk wrote:
> On 07/23/2018 01:19 PM, Jarkko Sakkinen wrote:
> > In this case I do not have any major evidence of any major benefit
> > *and* the change breaks the ABI.
> 
> As I said before - this does not break the ABI.

The current patch does, you even provided a use case in your last email
 (it's do command to get sizing followed by do command with correctly
sized buffer).?

However, if you tie it to O_NONBLOCK, it won't because no-one currently
opens the TPM device non blocking so it's an ABI conformant
discriminator of the uses.  Tying to O_NONBLOCK should be simple
because it's in file->f_flags.

James

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
