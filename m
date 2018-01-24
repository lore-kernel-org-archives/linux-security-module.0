From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Wed, 24 Jan 2018 21:29:19 +0000
Subject: [PATCH 3/3] tpm: add longer timeouts for creation commands.
In-Reply-To: <20180123131203.bdhlqdqabhtwnipi@linux.intel.com>
References: <20180123112731.3687-1-tomas.winkler@intel.com>
	<20180123112731.3687-3-tomas.winkler@intel.com>
	<20180123131203.bdhlqdqabhtwnipi@linux.intel.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94203937@hasmsx108.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen at linux.intel.com]
> Sent: Tuesday, January 23, 2018 15:12
> To: Winkler, Tomas <tomas.winkler@intel.com>
> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>; Usyskin,
> Alexander <alexander.usyskin@intel.com>; tpmdd-
> devel at lists.sourceforge.net; linux-integrity at vger.kernel.org; linux-security-
> module at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 3/3] tpm: add longer timeouts for creation commands.
> 
> On Tue, Jan 23, 2018 at 01:27:31PM +0200, Tomas Winkler wrote:
> > TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve
> > generation of crypto keys which can be a computationally intensive task.
> > The timeout is set to 3min.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> From where are these numbers are derived from?

An Intel SW architect.
 
> 
> Can you send 1/3 and 2/3 as a separate patch set with a cover letter (with
> explanation) and this as a separate patch? This is unrelated to first two
> changes albeit might make sense.

Will do, though the patches were born to  address the initialization issues we've encountered.
Thanks
Tomas

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
