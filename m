From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 25 May 2017 16:40:50 -0600
Subject: [PATCH RFC] tpm: migrate pubek_show to struct tpm_buf
In-Reply-To: <20170525222801.mayost6gxcggurjo@intel.com>
References: <20170525211105.843-1-jarkko.sakkinen@linux.intel.com>
	<20170525211613.GA14802@obsidianresearch.com>
	<20170525222801.mayost6gxcggurjo@intel.com>
Message-ID: <20170525224050.GA15715@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, May 25, 2017 at 03:28:01PM -0700, Jarkko Sakkinen wrote:
> On Thu, May 25, 2017 at 03:16:13PM -0600, Jason Gunthorpe wrote:
> > On Thu, May 25, 2017 at 02:11:04PM -0700, Jarkko Sakkinen wrote:
> > >  	struct tpm_chip *chip = to_tpm_chip(dev);
> > > +	char anti_replay[20];
> > >  
> > > -	tpm_cmd.header.in = tpm_readpubek_header;
> > > -	err = tpm_transmit_cmd(chip, NULL, &tpm_cmd, READ_PUBEK_RESULT_SIZE,
> > > +	rc = tpm_buf_init(&tpm_buf, TPM_TAG_RQU_COMMAND, TPM_ORD_READPUBEK);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	/* The checksum is ignored so it doesn't matter what the contents are.
> > > +	 */
> > > +	tpm_buf_append(&tpm_buf, anti_replay, sizeof(anti_replay));
> > 
> > It does matter, we do not want to leak random kernel memory incase it
> > has something sensitive. Zero anti_replay.
> 
> If there was a leak it has existed before this change as tpm_cmd was
> also allocated from stack. And there is not leak because the checksum is
> not printed.

It leaks stack memory to the TPM which is not OK.

> I think better idea would be to move struct tpm_readpubek_params_out
> declaration here and use it to refer different fields. Previously
> this

That would be better..

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
