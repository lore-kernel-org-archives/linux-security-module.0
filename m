From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Fri, 17 Mar 2017 22:44:29 +0200
Subject: [tpmdd-devel] [PATCH v3 4/7] tpm: infrastructure for TPM spaces
In-Reply-To: <1aa1c9d32fd446f69551a36c37f0ed16@MUCSE603.infineon.com>
References: <20170303151912.14752-1-jarkko.sakkinen@linux.intel.com>
	<20170303151912.14752-5-jarkko.sakkinen@linux.intel.com>
	<1aa1c9d32fd446f69551a36c37f0ed16@MUCSE603.infineon.com>
Message-ID: <20170317204429.wsoe4r4jne437kyc@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 17, 2017 at 03:41:38PM +0000, Alexander.Steffen at infineon.com wrote:
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> > interface.c
> > index 20b1fe3..db5ffe9 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -376,11 +376,12 @@ static bool tpm_validate_command(struct
> > tpm_chip *chip, const u8 *cmd,
> >   *     0 when the operation is successful.
> >   *     A negative number for system errors (errno).
> >   */
> > -ssize_t tpm_transmit(struct tpm_chip *chip, const u8 *buf, size_t bufsiz,
> > -		     unsigned int flags)
> > +ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
> > +		     u8 *buf, size_t bufsiz, unsigned int flags)
> 
> When adding parameters, please also update the parameter documentation
> at the top of the function. It is missing for the new parameter
> "space" here.

I missed that. I'll update the commits with the proper documentation.

> Alexander

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
