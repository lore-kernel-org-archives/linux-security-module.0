From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 28 Nov 2017 22:19:03 +0200
Subject: [PATCH v4 2/4] tpm: ignore burstcount to improve tpm_tis send()
	performance
In-Reply-To: <694703AB-68E1-4026-937C-61DBBE08DB4B@paramecium.org>
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
	<20171017203232.2262-3-nayna@linux.vnet.ibm.com>
	<5ef60315f2254b3b8bcc217a572280e5@infineon.com>
	<e98e85a5-fec1-93fb-8daf-d997d5995993@linux.vnet.ibm.com>
	<3ff12c6536de4379aa61cb09ebc9d105@infineon.com>
	<20171123144742.GC8862@swastik>
	<20171126152218.c5fsr7uhs3ipwwha@linux.intel.com>
	<1511714261.4361.13.camel@linux.vnet.ibm.com>
	<694703AB-68E1-4026-937C-61DBBE08DB4B@paramecium.org>
Message-ID: <20171128201903.ndd4j3xw3ubfaa4y@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Nov 27, 2017 at 07:08:51AM +0000, Leendert van Doorn wrote:
> Hmm, this is almost 20 years old code (
> 
> I think the original code did a burst write and didn't check for error
> conditions until the very last byte write. I seem to remember that
> there was some text in the original standard to that effect (this may
> have gone back as far as IBM's ESS spec).
> 
> The current code does check for error conditions after each write
> byte(s) so I don't think there is any reason for this anymore.
> Changing the while condition to count < len and setting burstcnt =
> min_t(int, burstcnt, len - count) and remove the
> tpm_tis_write8/wait_for_tpm_stat/tpm_tis_status clauses after the
> while loop should be sufficient.

Thank you for sharing this!

> 	Leendert

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
