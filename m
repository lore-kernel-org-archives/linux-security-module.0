From: Alexander.Steffen@infineon.com (Alexander.Steffen at infineon.com)
Date: Tue, 28 Mar 2017 11:27:53 +0000
Subject: [PATCH] tpm: do handle area size validation only when TPM space
	used
In-Reply-To: <20170328102453.hvyc3a4vmrk3lyzu@intel.com>
References: <20170326210815.21252-1-jarkko.sakkinen@iki.fi>
	<20170328102453.hvyc3a4vmrk3lyzu@intel.com>
Message-ID: <93b2b783656c400ebea13a9eeec48097@MUCSE603.infineon.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Yes, this fixes the issue for me. Thanks.

Alexander

> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen at linux.intel.com]
> Sent: Tuesday, March 28, 2017 12:25 PM
> To: Steffen Alexander (IFAG CCS ESS D SW A)
> Cc: tpmdd-devel at lists.sourceforge.net; linux-security-
> module at vger.kernel.org; Peter Huewe; Marcel Selhorst; Jason Gunthorpe;
> open list
> Subject: Re: [PATCH] tpm: do handle area size validation only when TPM
> space used
> 
> So do you need this or not?
> 
> /Jarkko
> 
> On Mon, Mar 27, 2017 at 12:08:15AM +0300, Jarkko Sakkinen wrote:
> > In order to not cause backwards compatibility issues with
> > /dev/tpm0 disable handle area size validation if tpm_transmit is not
> > called with a TPM space.
> >
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
> > ---
> >  drivers/char/tpm/tpm-interface.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm-interface.c
> > b/drivers/char/tpm/tpm-interface.c
> > index bf0c3fa..158c1db 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -328,7 +328,9 @@ unsigned long tpm_calc_ordinal_duration(struct
> > tpm_chip *chip,  }  EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
> >
> > -static bool tpm_validate_command(struct tpm_chip *chip, const u8
> > *cmd,
> > +static bool tpm_validate_command(struct tpm_chip *chip,
> > +				 struct tpm_space *space,
> > +				 const u8 *cmd,
> >  				 size_t len)
> >  {
> >  	const struct tpm_input_header *header = (const void *)cmd; @@ -
> 340,6
> > +342,9 @@ static bool tpm_validate_command(struct tpm_chip *chip,
> const u8 *cmd,
> >  	if (len < TPM_HEADER_SIZE)
> >  		return false;
> >
> > +	if (!space)
> > +		return true;
> > +
> >  	if (chip->flags & TPM_CHIP_FLAG_TPM2 && chip->nr_commands) {
> >  		cc = be32_to_cpu(header->ordinal);
> >
> > @@ -386,7 +391,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct
> tpm_space *space,
> >  	unsigned long stop;
> >  	bool need_locality;
> >
> > -	if (!tpm_validate_command(chip, buf, bufsiz))
> > +	if (!tpm_validate_command(chip, space, buf, bufsiz))
> >  		return -EINVAL;
> >
> >  	if (bufsiz > TPM_BUFSIZE)
> > --
> > 2.9.3
> >

????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
