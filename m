From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Sun, 25 Feb 2018 14:43:42 +0000
Subject: [PATCH 1/2 v4] tpm: cmd_ready command can be issued only after
	granting locality
In-Reply-To: <20180225134045.dmv3chkm4lbmqnzv@linux.intel.com>
References: <20180224154316.26607-1-tomas.winkler@intel.com>
	<20180225094045.4zkqbrt5yi3ao562@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B94228C1A@hasmsx108.ger.corp.intel.com>
	<20180225134045.dmv3chkm4lbmqnzv@linux.intel.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94228E62@hasmsx108.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> 
> On Sun, Feb 25, 2018 at 10:37:08AM +0000, Winkler, Tomas wrote:
> > >
> > > On Sat, Feb 24, 2018 at 05:43:16PM +0200, Tomas Winkler wrote:
> > > > The correct sequence is to first request locality and only after
> > > > that perform cmd_ready handshake, otherwise the hardware will drop
> > > > the subsequent message as from the device point of view the
> > > > cmd_ready handshake wasn't performed. Symmetrically locality has
> > > > to be relinquished only after going idle handshake has completed,
> > > > this requires that go_idle has to poll for the completion and as
> > > > well locality relinquish has to poll for completion so it is not
> > > > overridden in back to back commands flow.
> > > >
> > > > The issue is only visible on devices that support multiple localities.
> > > >
> > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > ---
> > > > V2: poll for locality relinquish completion
> > > > V3: 1. Print error message upon locality relinquish failure
> > > >     2. Don't override rc code on error path with locality
> > > > relinquish
> > > > V4: 3. Don't capture locality relinquish error code in rc, just print
> > > > 	the error message.
> > > >
> > > >        return value.
> > > >  drivers/char/tpm/tpm-interface.c |  20 +++++---
> > > >  drivers/char/tpm/tpm_crb.c       | 108 +++++++++++++++++++++++++++-
> -----
> > > ------
> > > >  drivers/char/tpm/tpm_tis_core.c  |   4 +-
> > > >  include/linux/tpm.h              |   2 +-
> > > >  4 files changed, 93 insertions(+), 41 deletions(-)
> > > >
> > > > diff --git a/drivers/char/tpm/tpm-interface.c
> > > > b/drivers/char/tpm/tpm-interface.c
> > > > index 9e80a953d693..4d74bacca5a1 100644
> > > > --- a/drivers/char/tpm/tpm-interface.c
> > > > +++ b/drivers/char/tpm/tpm-interface.c
> > > > @@ -422,8 +422,6 @@ ssize_t tpm_transmit(struct tpm_chip *chip,
> > > > struct
> > > tpm_space *space,
> > > >  	if (!(flags & TPM_TRANSMIT_UNLOCKED))
> > > >  		mutex_lock(&chip->tpm_mutex);
> > > >
> > > > -	if (chip->dev.parent)
> > > > -		pm_runtime_get_sync(chip->dev.parent);
> > > >
> > > >  	if (chip->ops->clk_enable != NULL)
> > > >  		chip->ops->clk_enable(chip, true); @@ -439,6 +437,9 @@
> ssize_t
> > > > tpm_transmit(struct tpm_chip *chip, struct
> > > tpm_space *space,
> > > >  		chip->locality = rc;
> > > >  	}
> > > >
> > > > +	if (chip->dev.parent)
> > > > +		pm_runtime_get_sync(chip->dev.parent);
> > > > +
> > > >  	rc = tpm2_prepare_space(chip, space, ordinal, buf);
> > > >  	if (rc)
> > > >  		goto out;
> > > > @@ -499,17 +500,24 @@ ssize_t tpm_transmit(struct tpm_chip *chip,
> > > struct tpm_space *space,
> > > >  	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
> > > >
> > > >  out:
> > > > +	if (chip->dev.parent)
> > > > +		pm_runtime_put_sync(chip->dev.parent);
> > > > +
> > > >  	if (need_locality && chip->ops->relinquish_locality) {
> > > > -		chip->ops->relinquish_locality(chip, chip->locality);
> > > > +		/* this coud be on error path, don't override error code */
> > > > +		int l_rc = chip->ops->relinquish_locality(chip,
> > > > +chip->locality);
> > >
> > > Declaration should be in the beginning of the function.
> >
> > No, it shouldn't. I cannot find any reference to this statement, I've already
> explained my reasoning in a previous mail.
> >
> > >
> > > > +
> > > > +		if (l_rc) {
> > > > +			dev_err(&chip->dev, "%s: relinquish_locality: error
> > > %d\n",
> > > > +				__func__, l_rc);
> > > > +		}
> > >
> > > In kernel coding style, this should be w/o curly braces.
> >
> > Yep, missed that, will resubmit
> >
> >
> > > I can fix these cosmetic issues
> > >
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > >
> > > Doesn't this need
> > >
> > > Fixes: 877c57d0d0ca ("tpm_crb: request and relinquish locality 0")
> > > And shouldn't this also have
> > >
> > > Cc: stable at vger.kernel.org
> > >
> > > ?
> > Good points
> > Thanks
> > Tomas
> 
> Tomas, I updated v4 myself and pushed it to master/next. Please tell me if
> there is anything wrong and I will fix it.
> 
Please, take my fix v5. I didn't agree to moving l_rc out its scope. 
Thanks
Tomas

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
