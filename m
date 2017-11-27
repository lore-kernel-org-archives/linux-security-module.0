From: leendert@paramecium.org (Leendert van Doorn)
Date: Mon, 27 Nov 2017 07:08:51 +0000
Subject: [PATCH v4 2/4] tpm: ignore burstcount to improve tpm_tis send()
	performance
In-Reply-To: <1511714261.4361.13.camel@linux.vnet.ibm.com>
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
	<20171017203232.2262-3-nayna@linux.vnet.ibm.com>
	<5ef60315f2254b3b8bcc217a572280e5@infineon.com>
	<e98e85a5-fec1-93fb-8daf-d997d5995993@linux.vnet.ibm.com>
	<3ff12c6536de4379aa61cb09ebc9d105@infineon.com>
	<20171123144742.GC8862@swastik>
	<20171126152218.c5fsr7uhs3ipwwha@linux.intel.com>
	<1511714261.4361.13.camel@linux.vnet.ibm.com>
Message-ID: <694703AB-68E1-4026-937C-61DBBE08DB4B@paramecium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hmm, this is almost 20 years old code (

I think the original code did a burst write and didn't check for error conditions until the very last byte write. I seem to remember that there was some text in the original standard to that effect (this may have gone back as far as IBM's ESS spec).

The current code does check for error conditions after each write byte(s) so I don't think there is any reason for this anymore. Changing the while condition to count < len and setting burstcnt = min_t(int, burstcnt, len - count) and remove the tpm_tis_write8/wait_for_tpm_stat/tpm_tis_status clauses after the while loop should be sufficient.

	Leendert

???On 11/26/17, 8:37 AM, "Mimi Zohar" <zohar@linux.vnet.ibm.com> wrote:

    [Cc'ing Dave and Leendeert]
    
    Hi Jarkko,
    
    > > It seems that the last byte was sent from the beginning (27084ef
    > > [PATCH] tpm: driver for next generation TPM chips,), does anyone
    > > remember the reason ?
    > 
    > Sent from the beginning?
    
    I went through the commit logs to see if any of the patch descriptions
    have an explanation for sending the last byte separately. Based on
    commit 27084efee0c3 "[PATCH] tpm: driver for next generation TPM
    chips", it seems it's been there since the beginning.
    
    Dave, Leendert, Do either of you remember the reason for
    tpm_tis_send_data() sending the last byte separately?
    
    thanks,
    
    Mimi
    
    
    

????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
