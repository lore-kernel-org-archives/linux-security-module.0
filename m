From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Tue, 2 Jan 2018 07:57:35 -0700
Subject: [PATCH v8 1/2] tpm_tis: Move ilb_base_addr to tpm_tis_data
In-Reply-To: <5FFFAD06ADE1CA4381B3F0F7C6AF582898A05E@ORSMSX109.amr.corp.intel.com>
References: <1514865944-95086-1-git-send-email-azhar.shaikh@intel.com>
	<1514865944-95086-2-git-send-email-azhar.shaikh@intel.com>
	<20180102044044.GA29208@ziepe.ca>
	<5FFFAD06ADE1CA4381B3F0F7C6AF582898A03C@ORSMSX109.amr.corp.intel.com>
	<5FFFAD06ADE1CA4381B3F0F7C6AF582898A05E@ORSMSX109.amr.corp.intel.com>
Message-ID: <20180102145735.GB29208@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jan 02, 2018 at 05:31:30AM +0000, Shaikh, Azhar wrote:
> >>On Mon, Jan 01, 2018 at 08:05:43PM -0800, Azhar Shaikh wrote:
> >>
> >>> -	return tpm_chip_register(chip);
> >>> +	rc = tpm_chip_register(chip);
> >>> +	if (rc && is_bsw())
> >>> +		iounmap(priv->ilb_base_addr);
> >>> +
> >>> +	return rc;
> >>>  out_err:
> >>>  	tpm_tis_remove(chip);
> >>> +	if (is_bsw())
> >>> +		iounmap(priv->ilb_base_addr);
> >>> +
> >>>  	return rc;
> >>>  }
> >>
> >>I thought you were resending this to fix the above, why is is it still wonky?
> >>
> >
> >Oh! I fixed it in the second patch ("tpm: Keep CLKRUN enabled throughout
> >the duration of transmit_cmd()"). Should have fixed in this patch instead. My
> >bad, didn't see it was introduced in this patch. I thought it was part of second
> >patch. Will fix this.
> >
> 
> On checking, the ops->clk_enable is not still introduced yet. It is introduced in the second patch. The cleanup is done in the next patch.
> So do you want me to still fix this here?

Try hard to not edit your own patches in your series. No reason why
iounmap cannot be put into tpm_tis_remove in the first place

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
