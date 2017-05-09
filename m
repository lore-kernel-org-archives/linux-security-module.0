From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 9 May 2017 09:13:08 -0600
Subject: [PATCH] tpm: fix byte order related arithmetic inconsistency in
	tpm_getcap()
In-Reply-To: <20170509141353.klo7lilef4qiqfoc@intel.com>
References: <20170507175002.9558-1-jarkko.sakkinen@linux.intel.com>
	<20170509141353.klo7lilef4qiqfoc@intel.com>
Message-ID: <20170509151308.GA13586@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, May 09, 2017 at 05:13:53PM +0300, Jarkko Sakkinen wrote:
> On Sun, May 07, 2017 at 08:50:02PM +0300, Jarkko Sakkinen wrote:
> > You should not do arithmetic with __be32 or __le32 types because
> > sometimes it results incorrect results. Calculations must be done only
> > with integers that are in in the CPU byte order. This commit migrates
> > tpm_getcap() to struct tpm_buf in order to sort out these issues.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Now this should work as Robertos patches move byte order conversion
> > where it should be. Sadly I'm out of reach to my Dell E6400 laptop
> > that I use for TPM 1.2 testing.
> >  drivers/char/tpm/tpm-interface.c | 30 ++++++++++++++++--------------
> >  drivers/char/tpm/tpm.h           | 13 -------------
> >  2 files changed, 16 insertions(+), 27 deletions(-)
> 
> I've now tested this with TPM 1.2. Any complains?

Seems reasonable, but which linke had the problematic arithmetic?

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
