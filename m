From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 6 Sep 2017 15:57:40 +0300
Subject: [PATCH RESEND v2 0/3] tpm2-cmd: Improve self test execution
In-Reply-To: <20170831171858.13252-1-Alexander.Steffen@infineon.com>
References: <20170831171858.13252-1-Alexander.Steffen@infineon.com>
Message-ID: <20170906125740.2wntnvllembpil7u@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Aug 31, 2017 at 07:18:55PM +0200, Alexander Steffen wrote:
> The self test logic for TPM 2.0 was probably based on the implementation
> for TPM 1.2, but did not correctly take into account some TPM 2.0 specifics.
> This patch series fixes those issues.
> 
> v2:
> - Moved implementation description from comment to commit message.
> 
> Alexander Steffen (3):
>   tpm2-cmd: Trigger only missing self tests
>   tpm2-cmd: Use dynamic delay to wait for self test result
>   tpm2-cmd: React correctly to RC_TESTING from self tests
> 
>  drivers/char/tpm/tpm2-cmd.c | 69 +++++++++++++--------------------------------
>  1 file changed, 20 insertions(+), 49 deletions(-)
> 
> -- 
> 2.7.4
> 

Applied to my master for convenient testing.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
