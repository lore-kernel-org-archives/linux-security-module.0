From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 19 Mar 2018 16:42:05 +0200
Subject: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
In-Reply-To: <1521203812.3503.19.camel@linux.vnet.ibm.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
	<20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
	<1520290344.10396.357.camel@linux.vnet.ibm.com>
	<20180316122129.GA2458@linux.intel.com>
	<1521203812.3503.19.camel@linux.vnet.ibm.com>
Message-ID: <20180319144205.GA4619@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 16, 2018 at 08:36:52AM -0400, Mimi Zohar wrote:
> On Fri, 2018-03-16 at 14:21 +0200, Jarkko Sakkinen wrote:
> > On Mon, Mar 05, 2018 at 05:52:24PM -0500, Mimi Zohar wrote:
> > > Hi Jarrko,
> > > 
> > > On Mon, 2018-03-05 at 18:56 +0200, Jarkko Sakkinen wrote:
> > > > In order to make struct tpm_buf the first class object for constructing TPM
> > > > commands, migrate tpm2_probe() to use it.
> > > > 
> > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > 
> > > With this patch, the Pi doesn't find the TPM. ?I'm seeing the
> > > following line in dmesg.
> > > 
> > > [????1.087414] tpm_tis_spi: probe of spi0.0 failed with error 256
> > 
> > Thank you for reporting this Mimi. Does it have TPM1/TPM2?
> 
> The pi has a TPM 2.0 attached to the GPIO. ?James pointed out the
> change in return codes.
> 
> 
> +       if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
>                 chip->flags |= TPM_CHIP_FLAG_TPM2;
> -
> -       return 0;
> +out:
> +       tpm_buf_destroy(&buf);
> +       return rc;
>  }
>  EXPORT_SYMBOL_GPL(tpm2_probe);
> 
> Mimi

Oops, thank you James and Mimi for pointing this out. I'll refine
the patch set.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
