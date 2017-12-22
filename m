From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Thu, 21 Dec 2017 19:49:06 -0700
Subject: [PATCH v2] tpm: Fix the driver cleanup code
In-Reply-To: <1513898019-164487-1-git-send-email-azhar.shaikh@intel.com>
References: <1513898019-164487-1-git-send-email-azhar.shaikh@intel.com>
Message-ID: <20171222024906.GB23946@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Dec 21, 2017 at 03:13:39PM -0800, Azhar Shaikh wrote:
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
> Changes in v2:
> - Remove TPM_CHIP_FLAG_DO_NOT_CLEAR_OPS flag, instead call
>   tpm_tis_clkrun_enable() directly in tpm_tis_remove()
> - Add comment to tpm_tis_clkrun_enable()

Looks Ok to me

Reviewed-by: Jason Gunthorpe <jgg@ziepe.ca>

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
