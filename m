From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 6 Feb 2018 22:06:50 +0200
Subject: [PATCH v2] tpm: add longer timeouts for creation commands.
In-Reply-To: <20180128081739.8066-1-tomas.winkler@intel.com>
References: <20180128081739.8066-1-tomas.winkler@intel.com>
Message-ID: <20180206200650.ozcwsv3uks6eyah3@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 28, 2018 at 10:17:39AM +0200, Tomas Winkler wrote:
> TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve generation
> of crypto keys which can be a computationally intensive task.
> The timeout is set to 3min.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

This is still NAK because we need some kind of reference for the new
value. Is that also right value for ARM64/TrustZone based TPMs?

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
