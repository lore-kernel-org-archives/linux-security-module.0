From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Wed, 21 Jun 2017 07:04:53 -0400
Subject: [PATCH v2] tpm: consolidate the TPM startup code
In-Reply-To: <20170621073134.7436-1-jarkko.sakkinen@linux.intel.com>
References: <20170621073134.7436-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <1ff1a552-15a9-d8a6-3bcd-3c0f9ff6d71e@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 06/21/2017 03:31 AM, Jarkko Sakkinen wrote:
> Consolidated all the "manual" TPM startup code to a single function
> in order to make code flows a bit cleaner and migrate to tpm_buf.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Tested-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


FYI:
swtpm chardev --vtpm-proxy  --tpmstate dir=/tmp --log level=1 --tpm2
swtpm chardev --vtpm-proxy  --tpmstate dir=/tmp --log level=1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
