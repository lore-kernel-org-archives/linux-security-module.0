From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 22 Jun 2017 12:02:56 +0200
Subject: [PATCH v2] tpm: consolidate the TPM startup code
In-Reply-To: <1ff1a552-15a9-d8a6-3bcd-3c0f9ff6d71e@linux.vnet.ibm.com>
References: <20170621073134.7436-1-jarkko.sakkinen@linux.intel.com>
	<1ff1a552-15a9-d8a6-3bcd-3c0f9ff6d71e@linux.vnet.ibm.com>
Message-ID: <20170622100256.ehlcwkjp4iduxkbm@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jun 21, 2017 at 07:04:53AM -0400, Stefan Berger wrote:
> On 06/21/2017 03:31 AM, Jarkko Sakkinen wrote:
> > Consolidated all the "manual" TPM startup code to a single function
> > in order to make code flows a bit cleaner and migrate to tpm_buf.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Tested-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> 
> 
> FYI:
> swtpm chardev --vtpm-proxy  --tpmstate dir=/tmp --log level=1 --tpm2
> swtpm chardev --vtpm-proxy  --tpmstate dir=/tmp --log level=1

Thank you! I will also add your Tested-by to

- https://patchwork.kernel.org/patch/9799059/
- https://patchwork.kernel.org/patch/9799057/

I'm in the process of enhancing my BuildRoot enviroment with libtpms and
swtpm packages. My first target is TPM 1.2 test environment by using
tpm_vtpm_proxy driver.

http://git.infradead.org/users/jjs/buildroot-tpmdd.git

Should be easy as you have nicely autooled projects :-)

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
