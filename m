From: Alexander.Steffen@infineon.com (Alexander.Steffen at infineon.com)
Date: Wed, 22 Nov 2017 06:52:03 +0000
Subject: [PATCH v4 2/4] tpm: ignore burstcount to improve tpm_tis send()
	performance
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
	<20171017203232.2262-3-nayna@linux.vnet.ibm.com>
	<5ef60315f2254b3b8bcc217a572280e5@infineon.com>
	<e98e85a5-fec1-93fb-8daf-d997d5995993@linux.vnet.ibm.com>  
Message-ID: <3ff12c6536de4379aa61cb09ebc9d105@infineon.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> > > On 10/20/2017 08:12 PM, Alexander.Steffen at infineon.com wrote:
> > > >> The TPM burstcount status indicates the number of bytes that can
> > > >> be sent to the TPM without causing bus wait states.  Effectively,
> > > >> it is the number of empty bytes in the command FIFO.
> > > >>
> > > >> This patch optimizes the tpm_tis_send_data() function by checking
> > > >> the burstcount only once. And if the burstcount is valid, it writes
> > > >> all the bytes at once, permitting wait state.
> > > >>
> > > >> After this change, performance on a TPM 1.2 with an 8 byte
> > > >> burstcount for 1000 extends improved from ~41sec to ~14sec.
> > > >>
> > > >> Suggested-by: Ken Goldman<kgold@linux.vnet.ibm.com>  in
> > > >> conjunction with the TPM Device Driver work group.
> > > >> Signed-off-by: Nayna Jain<nayna@linux.vnet.ibm.com>
> > > >> Acked-by: Mimi Zohar<zohar@linux.vnet.ibm.com>
> > > >> ---
> > > >>   drivers/char/tpm/tpm_tis_core.c | 42 +++++++++++++++--------------
> --
> > --
> > > ----
> > > >> ----
> > > >>   1 file changed, 15 insertions(+), 27 deletions(-)
> > > >>
> > > >> diff --git a/drivers/char/tpm/tpm_tis_core.c
> > > >> b/drivers/char/tpm/tpm_tis_core.c
> > > >> index b33126a35694..993328ae988c 100644
> > > >> --- a/drivers/char/tpm/tpm_tis_core.c
> > > >> +++ b/drivers/char/tpm/tpm_tis_core.c
> > > >> @@ -316,7 +316,6 @@ static int tpm_tis_send_data(struct tpm_chip
> > > *chip,
> > > >> u8 *buf, size_t len)
> > > >>   {
> > > >>   	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> > > >>   	int rc, status, burstcnt;
> > > >> -	size_t count = 0;
> > > >>   	bool itpm = priv->flags & TPM_TIS_ITPM_WORKAROUND;
> > > >>
> > > >>   	status = tpm_tis_status(chip);
> > > >> @@ -330,35 +329,24 @@ static int tpm_tis_send_data(struct
> tpm_chip
> > > *chip,
> > > >> u8 *buf, size_t len)
> > > >>   		}
> > > >>   	}
> > > >>
> > > >> -	while (count < len - 1) {
> > > >> -		burstcnt = get_burstcount(chip);
> > > >> -		if (burstcnt < 0) {
> > > >> -			dev_err(&chip->dev, "Unable to read
> burstcount\n");
> > > >> -			rc = burstcnt;
> > > >> -			goto out_err;
> > > >> -		}
> > > >> -		burstcnt = min_t(int, burstcnt, len - count - 1);
> > > >> -		rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv-
> > > >>> locality),
> > > >> -					 burstcnt, buf + count);
> > > >> -		if (rc < 0)
> > > >> -			goto out_err;
> > > >> -
> > > >> -		count += burstcnt;
> > > >> -
> > > >> -		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip-
> > > >>> timeout_c,
> > > >> -					&priv->int_queue, false) < 0) {
> > > >> -			rc = -ETIME;
> > > >> -			goto out_err;
> > > >> -		}
> > > >> -		status = tpm_tis_status(chip);
> > > >> -		if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0)
> {
> > > >> -			rc = -EIO;
> > > >> -			goto out_err;
> > > >> -		}
> > > >> +	/*
> > > >> +	 * Get the initial burstcount to ensure TPM is ready to
> > > >> +	 * accept data.
> > > >> +	 */
> > > >> +	burstcnt = get_burstcount(chip);
> > > >> +	if (burstcnt < 0) {
> > > >> +		dev_err(&chip->dev, "Unable to read burstcount\n");
> > > >> +		rc = burstcnt;
> > > >> +		goto out_err;
> > > >>   	}
> > > >>
> > > >> +	rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv-
> >locality),
> > > >> +			len - 1, buf);
> > > >> +	if (rc < 0)
> > > >> +		goto out_err;
> > > >> +
> > > >>   	/* write last byte */
> > > >> -	rc = tpm_tis_write8(priv, TPM_DATA_FIFO(priv->locality),
> > > >> buf[count]);
> > > >> +	rc = tpm_tis_write8(priv, TPM_DATA_FIFO(priv->locality),
> buf[len-
> > > >> 1]);
> > > >>   	if (rc < 0)
> > > >>   		goto out_err;
> > > >>
> > > >> --
> > > >> 2.13.3
> > > > This seems to fail reliably with my SPI TPM 2.0. I get EIO when trying to
> > > send large amounts of data, e.g. with TPM2_Hash, and subsequent tests
> > > seem to take an unusual amount of time. More analysis probably has to
> > wait
> > > until November, since I am going to be in Prague next week.
> > >
> > > Thanks Alex for testing these.. Did you get the chance to do any further
> > > analysis ?
> >
> > I am working on that now. Ken's suggestion seems reasonable, so I am
> going
> > to test whether correctly waiting for the flags to change fixes the problem.
> If
> > it does, I'll send the patches.
> 
> Sorry for the delay, I had to take care of some device tree changes in v4.14
> that broke my ARM test machines.
> 
> I've implemented some patches that fix the issue that Ken pointed out and
> rebased your patch 2/4 ("ignore burstcount") on top. While doing this I
> noticed that your original patch does not, as the commit message says, write
> all the bytes at once, but still unnecessarily splits all commands into at least
> two transfers (as did the original code). I've fixed this as well in my patches,
> so that all bytes are indeed sent in a single call, without special handling for
> the last byte. This should speed up things further, especially for small
> commands and drivers like tpm_tis_spi, where writing a single byte
> translates into additional SPI transfers.
> 
> Unfortunately, even with those changes the problem persists. But I've got
> more detailed logs now and will try to understand and hopefully fix the issue.
> I'll follow up with more details and/or patches once I know more.

Okay, so the problem seems to be that at some point the TPM starts inserting wait states for the FIFO access. The driver tries to handle this, but fails since even the 50 retries that are currently used do not seem to be enough. Adding small (millisecond) delays between the attempts did not help so far.

Is there any limit in the specification for how many wait states the TPM may generate or for how long it may do so? I could not find anything, but we need to use something there to prevent a faulty TPM from blocking the kernel forever.

Alexander
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
