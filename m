From: jmorris@namei.org (James Morris)
Date: Fri, 15 Sep 2017 06:21:28 +1000 (AEST)
Subject: [PATCH 2/2] integrity: replace call to integrity_read_file with
	kernel version
In-Reply-To: <1505270734-4280-2-git-send-email-zohar@linux.vnet.ibm.com>
References: <1505270734-4280-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1505270734-4280-2-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.21.1709150617350.4414@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 12 Sep 2017, Mimi Zohar wrote:

> From: Christoph Hellwig <hch@lst.de>
> 
> The CONFIG_IMA_LOAD_X509 and CONFIG_EVM_LOAD_X509 options permit
> loading x509 signed certificates onto the trusted keyrings without
> verifying the x509 certificate file's signature.
> 
> This patch replaces the call to the integrity_read_file() specific
> function with the common kernel_read_file_from_path() function.
> To avoid verifying the file signature, this patch defines
> READING_X509_CERTFICATE.

So, to be clear, this patch solves the XFS deadlock using a different 
approach (to the now reverted integrity_read approach), which Christoph 
also says is more correct generally.  Correct?

What testing has this had?

Should this go in with the rest of the security changes now or wait until 
either -rc or the next merge window?


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
