From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 24 Oct 2017 16:04:15 +0200
Subject: [tpmdd-devel] [PATCH] tpm: remove chip_num parameter from
	in-kernel API
In-Reply-To: <cbcb78c6-fa36-32d3-891e-96544875d97c@linux.vnet.ibm.com>
References: <20171023123817.18559-1-jarkko.sakkinen@linux.intel.com>
	<cbcb78c6-fa36-32d3-891e-96544875d97c@linux.vnet.ibm.com>
Message-ID: <20171024140415.wx6oyqpktbebjt25@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Oct 23, 2017 at 10:07:31AM -0400, Stefan Berger wrote:
> I think every kernel internal TPM driver API should be called with the
> tpm_chip as a parameter. This is in foresight of namespacing of IMA where we
> want to provide the flexibility of passing a dedicated vTPM to each
> namespace and IMA would use the chip as a parameter to all of these
> functions to talk to the right tpm_vtpm_proxy instance. From that
> perspective this patch goes into the wrong direction.
> 
>    Stefan

The goal of this patch is to kernel code that never gets executed. It
removes a load of completely dead code. It is the only thing that this
commit does. Why do you think this is "going into wrong direction" if it
only removes dead code and refines the documentation up to date?

After the dead code has been removed it makes sense to propose a better
mechanism. Maybe the one that you are speaking about. But you need to
remove the cruft first.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
