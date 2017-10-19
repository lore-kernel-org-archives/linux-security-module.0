From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 19 Oct 2017 17:22:44 +0300
Subject: [PATCH v4 3/4] tpm: reduce tpm polling delay in tpm_tis_core
In-Reply-To: <20171018152447.b6scwbbmulrfzymw@linux.intel.com>
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
	<20171017203232.2262-4-nayna@linux.vnet.ibm.com>
	<20171018152447.b6scwbbmulrfzymw@linux.intel.com>
Message-ID: <20171019142244.7aaqyc3hizzt7n7p@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 18, 2017 at 06:24:47PM +0300, Jarkko Sakkinen wrote:
> On Tue, Oct 17, 2017 at 04:32:31PM -0400, Nayna Jain wrote:
> > The existing wait_for_tpm_stat() polls for the chip status after
> > 5msec sleep. As per TCG ddwg input, it is expected that tpm might
> > return status in few usec. So, reducing the delay in polling to
> > 1msec.
> > Similarly, get_burstcount() function sleeps for 5msec before
> > retrying for next query to burstcount in a loop. If it takes
> > lesser time for TPM to return, this 5msec delay is longer than
> > necessary.
> > 
> > After this change, performance on a TPM 1.2 with an 8 byte
> > burstcount for 1000 extends improved from ~14sec to ~9sec.
> > 
> > Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Tested-by: Jarkko Sakkinen <jarkkko.sakkinen@linux.intel.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
