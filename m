From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 5 Jun 2018 22:35:57 +0300
Subject: [PATCH v4 1/4] tpm: migrate tpm2_shutdown() to use struct tpm_buf
In-Reply-To: <20180527091452.azwuh5u7rjyy7z6h@cantor>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
	<20180326121406.14548-2-jarkko.sakkinen@linux.intel.com>
	<20180518223032.ihszdef5wesj5nie@cantor>
	<20180523125655.GB363@linux.intel.com>
	<20180527091452.azwuh5u7rjyy7z6h@cantor>
Message-ID: <20180605193557.GA27994@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, May 27, 2018 at 02:14:52AM -0700, Jerry Snitselaar wrote:
> On Wed May 23 18, Jarkko Sakkinen wrote:
> > On Fri, May 18, 2018 at 03:30:32PM -0700, Jerry Snitselaar wrote:
> > > On Mon Mar 26 18, Jarkko Sakkinen wrote:
> > > > In order to make struct tpm_buf the first class object for constructing TPM
> > > > commands, migrate tpm2_shutdown() to use it. In addition, removed the klog
> > > > entry when tpm_transmit_cmd() fails because tpm_tansmit_cmd() already
> > > > prints an error message.
> > > >
> > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > 
> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > 
> > Thanky you Jerry. I'll do one more round for this only to update kdoc.
> > It does not involve code changes so are you OK if you I keep your
> > reviewed-by despite this update?
> > 
> > /Jarkko
> 
> Sure

I pushed this commit to my master branch. The only changes are:

1. Update to kdoc.
2. Removed change to tpm2_flush_context_cmd() (should not be part
   of the commit).

 Did not make sense to cycle it through ML anymore.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
