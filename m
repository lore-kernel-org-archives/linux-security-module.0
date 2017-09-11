From: Alexander.Steffen@infineon.com (Alexander.Steffen at infineon.com)
Date: Mon, 11 Sep 2017 10:24:17 +0000
Subject: [PATCH v3] tpm-dev-common: Reject too short writes
In-Reply-To: <20170909125347.y3zgvpnbdywqxi54@linux.intel.com>
References: <20170908152132.8728-1-Alexander.Steffen@infineon.com>
	<20170908213739.k7ifm2isz4dciaaa@linux.intel.com>
	<20170909125347.y3zgvpnbdywqxi54@linux.intel.com>
Message-ID: <cd44dc6b622c4a65ad06bdbc851fe4a0@MUCSE603.infineon.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> On Sat, Sep 09, 2017 at 12:37:39AM +0300, Jarkko Sakkinen wrote:
> > On Fri, Sep 08, 2017 at 05:21:32PM +0200, Alexander Steffen wrote:
> > > tpm_transmit() does not offer an explicit interface to indicate the
> number
> > > of valid bytes in the communication buffer. Instead, it relies on the
> > > commandSize field in the TPM header that is encoded within the buffer.
> > > Therefore, ensure that a) enough data has been written to the buffer, so
> > > that the commandSize field is present and b) the commandSize field does
> not
> > > announce more data than has been written to the buffer.
> > >
> > > This should have been fixed with CVE-2011-1161 long ago, but apparently
> > > a correct version of that patch never made it into the kernel.
> > >
> > > Cc: stable at vger.kernel.org
> > > Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> > > ---
> > > v2:
> > > - Moved all changes to tpm_common_write in a single patch.
> > > v3:
> > > - Access data copied from user space (priv->data_buffer) instead of user
> > >   space data directly (buf).
> > > - Changed return code to EINVAL.
> > >
> > >  drivers/char/tpm/tpm-dev-common.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/char/tpm/tpm-dev-common.c
> b/drivers/char/tpm/tpm-dev-common.c
> > > index 610638a..461bf0b 100644
> > > --- a/drivers/char/tpm/tpm-dev-common.c
> > > +++ b/drivers/char/tpm/tpm-dev-common.c
> > > @@ -110,6 +110,12 @@ ssize_t tpm_common_write(struct file *file,
> const char __user *buf,
> > >  		return -EFAULT;
> > >  	}
> > >
> > > +	if (in_size < 6 ||
> > > +	    in_size < be32_to_cpu(*((__be32 *) (priv->data_buffer + 2)))) {
> > > +		mutex_unlock(&priv->buffer_mutex);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > >  	/* atomic tpm command send and result receive. We only hold the
> ops
> > >  	 * lock during this period so that the tpm can be unregistered even if
> > >  	 * the char dev is held open.
> > > --
> > > 2.7.4
> > >
> >
> > I'm not gonna fight about that "in_size < 6" check. I think it is not
> > needed, I understand your point but still disagree but it is something
> > where I can live with having it.
> >
> > I kind of disagree also with allowing messages longer than the command
> > size but it does not have to be in the scope of this commit and actually
> > should be a separate discussion if we ever going to do something about
> > it.
> >
> > Thanks for the patience!
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >
> > /Jarkko
> 
> Without your fix:
> 
> $ python -m unittest -v tpm2_smoke.SmokeTest.test_too_short_cmd
> test_too_short_cmd (tpm2_smoke.SmokeTest) ... FAIL
> 
> ==========================================================
> ============
> FAIL: test_too_short_cmd (tpm2_smoke.SmokeTest)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File "tpm2_smoke.py", line 157, in test_too_short_cmd
>     self.assertEqual(rejected, True)
> AssertionError: False != True
> 
> ----------------------------------------------------------------------
> Ran 1 test in 2.108s
> 
> FAILED (failures=1)
> 
> The test case expects to get a posix error, which it doesn't get.
> 
> With your fix:
> 
> $ python -m unittest -v tpm2_smoke.SmokeTest.test_too_short_cmd
> test_too_short_cmd (tpm2_smoke.SmokeTest) ... ok
> 
> ----------------------------------------------------------------------
> Ran 1 test in 2.099s
> 
> OK
> 
> So looks good to me.
> 
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Can you test the master branch with SPI TPM? I had to tinker your
> commits a bit because of merge conflicts with Arnd's commit. I'll
> put everything back to next as soon as I hear from you. Thanks
> 
> /Jarkko

tpm_tis_spi in master (3897f7c) is broken, it does not transfer any data. I'll send you a fixed patch for the DMA change.

Alexander
????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
