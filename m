From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Sun, 11 Mar 2018 18:01:18 -0400
Subject: [PATCH 1/2] security: evm: Move evm_hmac and evm_hash from
	evm_main.c to evm_crypto.c
In-Reply-To: <1519769820-20365-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1519769820-20365-1-git-send-email-hernan@vanguardiasur.com.ar>
Message-ID: <1520805678.3547.8.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-02-27 at 19:16 -0300, Hern?n Gonzalez wrote:
> Note: This is compile only tested.
> This variable was not used where it was defined, there was no point in
> declaring it there as extern, thus it got moved and constified saving up 2
> bytes.
> 
> Function                                     old     new   delta
> init_desc                                    273     271      -2
> Total: Before=2112094, After=2112092, chg -0.00%
> 
> Signed-off-by: Hern?n Gonzalez <hernan@vanguardiasur.com.ar>

Thanks, both patches have been applied.

Mimi

> ---
>  security/integrity/evm/evm.h        | 2 --
>  security/integrity/evm/evm_crypto.c | 3 +++
>  security/integrity/evm/evm_main.c   | 2 --
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
> index 0482539..45c4a89 100644
> --- a/security/integrity/evm/evm.h
> +++ b/security/integrity/evm/evm.h
> @@ -31,8 +31,6 @@
>  		       EVM_ALLOW_METADATA_WRITES)
> 
>  extern int evm_initialized;
> -extern char *evm_hmac;
> -extern char *evm_hash;
> 
>  #define EVM_ATTR_FSUUID		0x0001
> 
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index 691f3e0..fdde9cb 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -37,6 +37,9 @@ static DEFINE_MUTEX(mutex);
> 
>  static unsigned long evm_set_key_flags;
> 
> +char * const evm_hmac = "hmac(sha1)";
> +char * const evm_hash = "sha1";
> +
>  /**
>   * evm_set_key() - set EVM HMAC key from the kernel
>   * @key: pointer to a buffer with the key data
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index a8d5028..826926d 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -33,8 +33,6 @@ int evm_initialized;
>  static char *integrity_status_msg[] = {
>  	"pass", "pass_immutable", "fail", "no_label", "no_xattrs", "unknown"
>  };
> -char *evm_hmac = "hmac(sha1)";
> -char *evm_hash = "sha1";
>  int evm_hmac_attrs;
> 
>  char *evm_config_xattrnames[] = {

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
