From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 24 Oct 2017 12:52:08 -0600
Subject: [PATCH] tpm: remove chip_num parameter from in-kernel API
In-Reply-To: <20171023123817.18559-1-jarkko.sakkinen@linux.intel.com>
References: <20171023123817.18559-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <20171024185208.GD1806@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Oct 23, 2017 at 02:38:14PM +0200, Jarkko Sakkinen wrote:
> The reasoning is simple and obvious. Since every call site passes the
> value TPM_ANY_NUM (0xFFFF) the parameter does not have right to exist.
> Refined the documentation of the corresponding functions.

I like this patch, but how about a slightly different take, make this
change instead:

-struct tpm_chip *tpm_chip_find_get(int chip_num)
+struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip);

Where chip == NULL means the default TPM.

And then at all call sites swap TPM_ANY_NUM to NULL and instead of
flowing an 'int chip_num' to tpm_chip_find_get, flow the 'struct
tpm_chip *' directly.

This gets us much closer to the desired API with about the same amount
of churn as this patch has.

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
