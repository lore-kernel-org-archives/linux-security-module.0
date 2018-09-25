From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 25 Sep 2018 17:28:13 +0300
Subject: [PATCH v4 20/21] tpm1: reimplement tpm1_continue_selftest()
	using tpm_buf
In-Reply-To: <ca7221f592cfcdc312fe1ec72623f118dfa21788.camel@linux.intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
	<20180921135820.20549-21-tomas.winkler@intel.com>
	<5f142a3b-15b8-368b-19e5-5926b20addfd@linux.vnet.ibm.com>
	<ca7221f592cfcdc312fe1ec72623f118dfa21788.camel@linux.intel.com>
Message-ID: <54bbc3719576bf3365aea5992fe49cbc6b02e3b6.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-09-25 at 17:25 +0300, Jarkko Sakkinen wrote:
> On Tue, 2018-09-25 at 15:53 +0530, Nayna Jain wrote:
> > > +
> > > +	rc = tpm_transmit_cmd(chip, NULL, &buf.data, PAGE_SIZE,
> > 
> > I think this needs to buf.data instead of &buf.data
> > 
> > Thanks & Regards,
> >       - Nayna
> 
> You are absolutely right. Thank you.

Had to backtrack what I was doing wrong last time because the commit
has my tested-by and noticed that I did not have this one applied. I
tested this now by doing the change that you suggested and seems to
work.

/Jarkko
