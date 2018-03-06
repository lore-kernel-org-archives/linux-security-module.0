From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Tue, 6 Mar 2018 08:44:01 -0700
Subject: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
In-Reply-To: <1520336251.7549.13.camel@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
	<20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
	<1520336251.7549.13.camel@linux.intel.com>
Message-ID: <20180306154401.GB13395@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Mar 06, 2018 at 01:37:31PM +0200, Jarkko Sakkinen wrote:
> On Mon, 2018-03-05 at 18:56 +0200, Jarkko Sakkinen wrote:
> > In order to make struct tpm_buf the first class object for constructing TPM
> > commands, migrate tpm2_probe() to use it.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Jason, is this now OK? I removed the error klog.

Sure the log message is gone - but I haven't been auditing your tpm_buf
work..

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
