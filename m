From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 13 Mar 2017 10:34:52 -0600
Subject: [PATCH v2] tpm_crb: request and relinquish locality 0
In-Reply-To: <20170311130216.21419-1-jarkko.sakkinen@linux.intel.com>
References: <20170311130216.21419-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <20170313163452.GD22997@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Mar 11, 2017 at 03:02:14PM +0200, Jarkko Sakkinen wrote:
> Added two new callbacks to struct tpm_class_ops:
> 
> - request_locality
> - relinquish_locality
> 
> These are called before sending and receiving data from the TPM.  We
> update also tpm_tis_core to use these callbacks. Small modification to
> request_locality() is done so that it returns -EBUSY instead of locality
> number when check_locality() fails.

Make sense

I think you may as well do the other two drivers, even though you
can't run them the transformation looks safe enough to me.

> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>  drivers/char/tpm/tpm-interface.c |  9 +++++++++
>  drivers/char/tpm/tpm_crb.c       | 41 +++++++++++++++++++++++++++++++++++++++-
>  drivers/char/tpm/tpm_tis_core.c  | 12 ++++--------
>  include/linux/tpm.h              |  3 ++-
>  4 files changed, 55 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index e38c792..9c56581 100644
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -407,6 +407,12 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  	if (chip->dev.parent)
>  		pm_runtime_get_sync(chip->dev.parent);
>  
> +	if (chip->ops->request_locality)  {
> +		rc = chip->ops->request_locality(chip, 0);
> +		if (rc)
> +			goto out;

If request_locality fails we probably shouldn't call
relinquish_locality on the unwind path..

I think you should also put a relinquish_locality inside tpm_remove ?

> +	int (*request_locality)(struct tpm_chip *chip, int loc);
> +	void (*relinquish_locality)(struct tpm_chip *chip, int loc,
> bool force);

Let us document what force is supposed to do...

I'm not sure why we have it?

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
