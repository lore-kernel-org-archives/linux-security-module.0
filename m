From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Sun, 26 Nov 2017 17:22:18 +0200
Subject: [PATCH v4 2/4] tpm: ignore burstcount to improve tpm_tis send()
	performance
In-Reply-To: <20171123144742.GC8862@swastik>
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
	<20171017203232.2262-3-nayna@linux.vnet.ibm.com>
	<5ef60315f2254b3b8bcc217a572280e5@infineon.com>
	<e98e85a5-fec1-93fb-8daf-d997d5995993@linux.vnet.ibm.com>
	<3ff12c6536de4379aa61cb09ebc9d105@infineon.com>
	<20171123144742.GC8862@swastik>
Message-ID: <20171126152218.c5fsr7uhs3ipwwha@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Nov 23, 2017 at 08:17:42PM +0530, Nayna Jain wrote:
> Yeah, you are right, the first version of this patch sent all the
> bytes together, but after hearing ddwg inputs, i.e. "The last byte was
> introduced for error checking purposes (history).", I reverted back to
> original to be safe.

What does that mean ie error checking purposes?

> It seems that the last byte was sent from the beginning (27084ef
> [PATCH] tpm: driver for next generation TPM chips,), does anyone
> remember the reason ?

Sent from the beginning?

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
