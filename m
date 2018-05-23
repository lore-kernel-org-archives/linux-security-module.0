From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 23 May 2018 15:56:55 +0300
Subject: [PATCH v4 1/4] tpm: migrate tpm2_shutdown() to use struct tpm_buf
In-Reply-To: <20180518223032.ihszdef5wesj5nie@cantor>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
	<20180326121406.14548-2-jarkko.sakkinen@linux.intel.com>
	<20180518223032.ihszdef5wesj5nie@cantor>
Message-ID: <20180523125655.GB363@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, May 18, 2018 at 03:30:32PM -0700, Jerry Snitselaar wrote:
> On Mon Mar 26 18, Jarkko Sakkinen wrote:
> > In order to make struct tpm_buf the first class object for constructing TPM
> > commands, migrate tpm2_shutdown() to use it. In addition, removed the klog
> > entry when tpm_transmit_cmd() fails because tpm_tansmit_cmd() already
> > prints an error message.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanky you Jerry. I'll do one more round for this only to update kdoc.
It does not involve code changes so are you OK if you I keep your
reviewed-by despite this update?

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
