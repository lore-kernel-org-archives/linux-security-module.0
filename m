From: why2jjj.linux@gmail.com (J Freyensee)
Date: Tue, 8 May 2018 09:34:03 -0700
Subject: [PATCH v3 1/2] tpm: reduce poll sleep time in tpm_transmit()
In-Reply-To: <20180507160733.8817-2-nayna@linux.vnet.ibm.com>
References: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
	<20180507160733.8817-2-nayna@linux.vnet.ibm.com>
Message-ID: <becb898c-b778-d104-5781-899599f536d4@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


>   		do {
> -			tpm_msleep(TPM_POLL_SLEEP);
> +			tpm_msleep(TPM_TIMEOUT_POLL);
>
I'm just curious why it was decided to still use tpm_msleep() here 
instead of usleep_range() which was used in the 2nd patch.

Otherwise,

Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
