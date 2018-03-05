From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 5 Mar 2018 13:11:07 +0200
Subject: [PATCH 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
In-Reply-To: <5d8921fb-f7e0-5498-99e2-d4d84aa597f3@gmail.com>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
	<20180228195819.22231-4-jarkko.sakkinen@linux.intel.com>
	<5d8921fb-f7e0-5498-99e2-d4d84aa597f3@gmail.com>
Message-ID: <20180305111107.GH25377@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Mar 01, 2018 at 02:10:17PM -0800, J Freyensee wrote:
> .
> .
> .
> I'm new to this area of the kernel, but I'm not getting these lines:
> 
> > +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
> > +	tpm_buf_destroy(&buf);
> >   	if (rc <  0)
> Why is this if() check not directly after the tpm_transmit_cmd() call that
> sets rc?? Is it correct you want to destroy buf regardless of the
> tpm_transmit_cmd() outcome?
> >   		return rc;
> > -
> > -	if (be16_to_cpu(cmd.header.out.tag) == TPM2_ST_NO_SESSIONS)
> > +	out = (struct tpm_output_header *)buf.data;
> 
> So buf has been destroyed, buf.data sill has something valid to assign to
> out?
> > +	if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
> >   		chip->flags |= TPM_CHIP_FLAG_TPM2;
> >   	return 0;
> Thanks,
> Jay

Nope it is a regression in the patch. Thank you :-) tpm_buf_destroy()
can be called if the response data is not needed other than everything
went OK (tpm_transmit_cmd() already digs this info).

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
