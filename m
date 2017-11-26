From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Sun, 26 Nov 2017 11:37:41 -0500
Subject: [PATCH v4 2/4] tpm: ignore burstcount to improve tpm_tis send()
	performance
In-Reply-To: <20171126152218.c5fsr7uhs3ipwwha@linux.intel.com>
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
	<20171017203232.2262-3-nayna@linux.vnet.ibm.com>
	<5ef60315f2254b3b8bcc217a572280e5@infineon.com>
	<e98e85a5-fec1-93fb-8daf-d997d5995993@linux.vnet.ibm.com>
	<3ff12c6536de4379aa61cb09ebc9d105@infineon.com>
	<20171123144742.GC8862@swastik>
	<20171126152218.c5fsr7uhs3ipwwha@linux.intel.com>
Message-ID: <1511714261.4361.13.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

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


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
