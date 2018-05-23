From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 23 May 2018 16:23:18 +0300
Subject: [PATCH] tpm: fix race condition in tpm_common_write()
In-Reply-To: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
References: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
Message-ID: <20180523132318.GE363@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, May 22, 2018 at 10:32:46AM -0700, Tadeusz Struk wrote:
> There is a race condition in tpm_common_write function allowing two
> threads on the same /dev/tpm<N>, or two different applications on
> the same /dev/tpmrm<N> to overwrite eachother requests/responses.
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>

Ouch o_O Do you have a fixes tag for this one?

Thank you.

Reviewed-by: Jarkko Sakkien <jarkko.sakkinen@linux.intel.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
