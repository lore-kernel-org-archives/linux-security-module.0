From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 23 Jan 2018 15:12:03 +0200
Subject: [PATCH 3/3] tpm: add longer timeouts for creation commands.
In-Reply-To: <20180123112731.3687-3-tomas.winkler@intel.com>
References: <20180123112731.3687-1-tomas.winkler@intel.com>
	<20180123112731.3687-3-tomas.winkler@intel.com>
Message-ID: <20180123131203.bdhlqdqabhtwnipi@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jan 23, 2018 at 01:27:31PM +0200, Tomas Winkler wrote:
> TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve generation
> of crypto keys which can be a computationally intensive task.
> The timeout is set to 3min.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

>From where are these numbers are derived from?

Can you send 1/3 and 2/3 as a separate patch set with a cover
letter (with explanation) and this as a separate patch? This
is unrelated to first two changes albeit might make sense.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
