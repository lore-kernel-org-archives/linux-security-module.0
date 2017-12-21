From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Thu, 21 Dec 2017 13:26:52 -0700
Subject: [PATCH] tpm: Fix the driver cleanup code
In-Reply-To: <1513887422-123222-1-git-send-email-azhar.shaikh@intel.com>
References: <1513887422-123222-1-git-send-email-azhar.shaikh@intel.com>
Message-ID: <20171221202652.GH20015@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Dec 21, 2017 at 12:17:02PM -0800, Azhar Shaikh wrote:
> Commit 3c1701339284353c41 ("tpm: Keep CLKRUN enabled throughout
> the duration of transmit_cmd()") added code which accessed
> chip->ops, even after it was set to NULL in tpm_del_char_device(),
> called from tpm_chip_unregister() in error / driver exit paths.
> So fix this code.
> 
> Fixes: 3c1701339284353c41 ("tpm: Keep CLKRUN enabled throughout
> the duration of transmit_cmd()")
> 
> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
>  drivers/char/tpm/tpm-chip.c     |  5 +++++
>  drivers/char/tpm/tpm.h          |  1 +
>  drivers/char/tpm/tpm_tis.c      |  8 ++------
>  drivers/char/tpm/tpm_tis_core.c | 23 +++++++++++++++--------
>  drivers/char/tpm/tpm_tis_spi.c  |  1 +
>  5 files changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 0a62c19937b6..c88ec9a32a7e 100644
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -346,6 +346,10 @@ static void tpm_del_char_device(struct tpm_chip *chip)
>  	down_write(&chip->ops_sem);
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		tpm2_shutdown(chip, TPM2_SU_CLEAR);
> +	if (chip->flags & TPM_CHIP_FLAG_DO_NOT_CLEAR_OPS) {
> +		up_write(&chip->ops_sem);
> +		return;
> +	}

Yikes, too ugly. Figure something else out.. ops->clk_enable is always
tpm_tis_clkrun_enable at this point, so maybe call it directly in
the removal path in tpm_tis_core?

Jason

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
