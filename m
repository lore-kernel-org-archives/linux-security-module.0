From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 06 Mar 2018 13:19:54 +0200
Subject: [PATCH 2/6] tpm: factor out tpm 1.2 duration calculation to
	tpm1-cmd.c
In-Reply-To: <20180305202017.24008-3-tomas.winkler@intel.com>
References: <20180305202017.24008-1-tomas.winkler@intel.com>
	<20180305202017.24008-3-tomas.winkler@intel.com>
Message-ID: <1520335194.7549.7.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-03-05 at 22:20 +0200, Tomas Winkler wrote:
> Factor out tpm1.2 commands calculation into tpm1-cmd.c file.
> and change the prefix from tpm_ to tpm1_.
> No functional change is done here.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

This a good idea but can you go on and move all TPM 1.x stuff to
this new file while you are doing it?

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
