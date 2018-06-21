From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 21 Jun 2018 19:19:58 +0300
Subject: [PATCH v6] tpm: separate cmd_ready/go_idle from runtime_pm
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D94EA09@hasmsx108.ger.corp.intel.com>
References: <20180607212040.30989-1-tomas.winkler@intel.com>
	<20180618180406.GA20697@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B9D94EA09@hasmsx108.ger.corp.intel.com>
Message-ID: <20180621161958.GA11859@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jun 18, 2018 at 07:24:39PM +0000, Winkler, Tomas wrote:
> > 
> > On Fri, Jun 08, 2018 at 12:20:40AM +0300, Tomas Winkler wrote:
> > > We cannot use go_idle cmd_ready commands via runtime_pm handles as
> > > with the introduction of localities this is no longer an optional
> > > feature, while runtime pm can be not enabled.
> > > Though cmd_ready/go_idle provides a power saving, it's also a part of
> > > TPM2 protocol and should be called explicitly.
> > > This patch exposes cmd_read/go_idle via tpm class ops and removes
> > > runtime pm support as it is not used by any driver.
> > >
> > > A new tpm transmit flag is added TPM_TRANSMIT_NESTED, which implies
> > > TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW. Both are needed
> > to resolve
> > > tpm spaces and locality request recursive calls to tpm_transmit().
> > >
> > > New wrappers are added tpm_cmd_ready() and tpm_go_idle() to
> > streamline
> > > tpm_try_transmit code.
> > >
> > > tpm_crb no longer needs own power saving functions and can drop using
> > > tpm_pm_suspend/resume.
> > >
> > > This patch cannot be really separated from the locality fix.
> > > Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after
> > > granting locality)
> > >
> > >
> > > Cc: stable at vger.kernel.org
> > > Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after
> > > granting locality)
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > ---
> > > V2-3:resent
> > > V4: 1. Use tpm_pm_suspend/resume in tpm_crb
> > >     2. Drop cmd_ready/go_idle around tpm_chip_register, as there is no
> > >        usage counter like in runtime_pm.
> > > V5: 1. add tpm_cmd_ready and tpm_go_idle wrappers.
> > >     2. Abuse TPM_TRANSMIT_UNLOCKED flag to resolve tpm space
> > >        recursion.
> > > V6: 1. Add new flags TPM_TRANSMIT_NESTED which implies
> > >        TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW, as not all
> > >        unlocked flows are recursive i.e. tpm2_unseal_trusted.
> > >
> > >  drivers/char/tpm/tpm-interface.c  |  51 +++++++++++++++----
> > >  drivers/char/tpm/tpm.h            |  13 ++++-
> > >  drivers/char/tpm/tpm2-space.c     |  12 ++---
> > >  drivers/char/tpm/tpm_crb.c        | 101 ++++++++++----------------------------
> > >  drivers/char/tpm/tpm_vtpm_proxy.c |   2 +-
> > >  include/linux/tpm.h               |   2 +
> > >  6 files changed, 88 insertions(+), 93 deletions(-)
> > >
> > > diff --git a/drivers/char/tpm/tpm-interface.c
> > > b/drivers/char/tpm/tpm-interface.c
> > > index e32f6e85dc6d..1abd8261651b 100644
> > > --- a/drivers/char/tpm/tpm-interface.c
> > > +++ b/drivers/char/tpm/tpm-interface.c
> > > @@ -29,7 +29,6 @@
> > >  #include <linux/mutex.h>
> > >  #include <linux/spinlock.h>
> > >  #include <linux/freezer.h>
> > > -#include <linux/pm_runtime.h>
> > >  #include <linux/tpm_eventlog.h>
> > >
> > >  #include "tpm.h"
> > > @@ -369,10 +368,13 @@ static int tpm_validate_command(struct
> > tpm_chip *chip,
> > >  	return -EINVAL;
> > >  }
> > >
> > > -static int tpm_request_locality(struct tpm_chip *chip)
> > > +static int tpm_request_locality(struct tpm_chip *chip, unsigned int
> > > +flags)
> > >  {
> > >  	int rc;
> > >
> > > +	if (flags & __TPM_TRANSMIT_RAW)
> > > +		return 0;
> > > +
> > >  	if (!chip->ops->request_locality)
> > >  		return 0;
> > >
> > > @@ -385,10 +387,13 @@ static int tpm_request_locality(struct tpm_chip
> > *chip)
> > >  	return 0;
> > >  }
> > >
> > > -static void tpm_relinquish_locality(struct tpm_chip *chip)
> > > +static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned
> > > +int flags)
> > >  {
> > >  	int rc;
> > >
> > > +	if (flags & __TPM_TRANSMIT_RAW)
> > > +		return;
> > > +
> > >  	if (!chip->ops->relinquish_locality)
> > >  		return;
> > >
> > > @@ -399,6 +404,28 @@ static void tpm_relinquish_locality(struct
> > tpm_chip *chip)
> > >  	chip->locality = -1;
> > >  }
> > >
> > > +static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags) {
> > > +	if (flags & __TPM_TRANSMIT_RAW)
> > > +		return 0;
> > > +
> > > +	if (!chip->ops->cmd_ready)
> > > +		return 0;
> > > +
> > > +	return chip->ops->cmd_ready(chip);
> > > +}
> > > +
> > > +static int tpm_go_idle(struct tpm_chip *chip, unsigned int flags) {
> > > +	if (flags & __TPM_TRANSMIT_RAW)
> > > +		return 0;
> > > +
> > > +	if (!chip->ops->go_idle)
> > > +		return 0;
> > > +
> > > +	return chip->ops->go_idle(chip);
> > > +}
> > > +
> > >  static ssize_t tpm_try_transmit(struct tpm_chip *chip,
> > >  				struct tpm_space *space,
> > >  				u8 *buf, size_t bufsiz,
> > > @@ -449,14 +476,15 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> > *chip,
> > >  	/* Store the decision as chip->locality will be changed. */
> > >  	need_locality = chip->locality == -1;
> > >
> > > -	if (!(flags & TPM_TRANSMIT_RAW) && need_locality) {
> > > -		rc = tpm_request_locality(chip);
> > > +	if (need_locality) {
> > > +		rc = tpm_request_locality(chip, flags);
> > >  		if (rc < 0)
> > >  			goto out_no_locality;
> > >  	}
> > >
> > > -	if (chip->dev.parent)
> > > -		pm_runtime_get_sync(chip->dev.parent);
> > > +	rc = tpm_cmd_ready(chip, flags);
> > > +	if (rc)
> > > +		goto out;
> > >
> > >  	rc = tpm2_prepare_space(chip, space, ordinal, buf);
> > >  	if (rc)
> > > @@ -516,13 +544,16 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> > *chip,
> > >  	}
> > >
> > >  	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
> > > +	if (rc)
> > > +		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
> > >
> > >  out:
> > > -	if (chip->dev.parent)
> > > -		pm_runtime_put_sync(chip->dev.parent);
> > > +	rc = tpm_go_idle(chip, flags);
> > > +	if (rc)
> > > +		goto out;
> > >
> > >  	if (need_locality)
> > > -		tpm_relinquish_locality(chip);
> > > +		tpm_relinquish_locality(chip, flags);
> > >
> > >  out_no_locality:
> > >  	if (chip->ops->clk_enable != NULL)
> > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h index
> > > 4426649e431c..beb0a763016c 100644
> > > --- a/drivers/char/tpm/tpm.h
> > > +++ b/drivers/char/tpm/tpm.h
> > > @@ -511,9 +511,18 @@ extern const struct file_operations tpm_fops;
> > > extern const struct file_operations tpmrm_fops;  extern struct idr
> > > dev_nums_idr;
> > >
> > > +/**
> > > + * enum tpm_transmit_flags
> > > + *
> > > + * @TPM_TRANSMIT_UNLOCKED: used to lock sequence of tpm_transmit
> > calls.
> > > + * @__TPM_TRANSMIT_RAW: prevent recursive calls into setup steps
> > > + *                    (go idle, locality,..). Don't use directly.
> > > + * @TPM_TRANSMIT_NESTED: Use from nested tpm_transmit calls  */
> > >  enum tpm_transmit_flags {
> > > -	TPM_TRANSMIT_UNLOCKED	= BIT(0),
> > > -	TPM_TRANSMIT_RAW	= BIT(1),
> > > +	TPM_TRANSMIT_UNLOCKED   = BIT(0),
> > > +	__TPM_TRANSMIT_RAW      = BIT(1),
> > 
> > NAK for the naming convention.
> 
> What do you suggest
> Tomas

Just keeping the same name.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
