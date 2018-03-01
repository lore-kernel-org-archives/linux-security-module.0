From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 1 Mar 2018 11:22:45 +0200
Subject: [PATCH 2/3] tpm: reduce poll sleep time between send() and
	recv() in tpm_transmit()
In-Reply-To: <20180228191828.20056-2-nayna@linux.vnet.ibm.com>
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
	<20180228191828.20056-2-nayna@linux.vnet.ibm.com>
Message-ID: <20180301092222.GC29420@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Feb 28, 2018 at 02:18:27PM -0500, Nayna Jain wrote:
> In tpm_transmit, after send(), the code checks for status in a loop

Maybe cutting hairs now but please just use the actual function name
instead of send(). Just makes the commit log more useful asset.

> -		tpm_msleep(TPM_TIMEOUT);
> +		tpm_msleep(TPM_TIMEOUT_POLL);

What about just calling schedule()?

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
