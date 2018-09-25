From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 25 Sep 2018 17:25:40 +0300
Subject: [PATCH v4 20/21] tpm1: reimplement tpm1_continue_selftest()
	using tpm_buf
In-Reply-To: <5f142a3b-15b8-368b-19e5-5926b20addfd@linux.vnet.ibm.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
	<20180921135820.20549-21-tomas.winkler@intel.com>
	<5f142a3b-15b8-368b-19e5-5926b20addfd@linux.vnet.ibm.com>
Message-ID: <ca7221f592cfcdc312fe1ec72623f118dfa21788.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-09-25 at 15:53 +0530, Nayna Jain wrote:
> > +
> > +	rc = tpm_transmit_cmd(chip, NULL, &buf.data, PAGE_SIZE,
> 
> I think this needs to buf.data instead of &buf.data
> 
> Thanks & Regards,
>       - Nayna

You are absolutely right. Thank you.

/Jarkko
