From: john.johansen@canonical.com (John Johansen)
Date: Thu, 23 Aug 2018 11:21:41 -0700
Subject: [PATCH] apparmor: remove unused label
In-Reply-To: <20180823140917.3060915-1-arnd@arndb.de>
References: <20180823140917.3060915-1-arnd@arndb.de>
Message-ID: <090d76e5-25ef-349c-3160-3f74c9196b38@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 08/23/2018 07:09 AM, Arnd Bergmann wrote:

thank you for the patch, but a fix for this issue was pushed to apparmor-next yesterday


> After the corresponding 'goto' was removed, we get a warning
> for the 'fail' label:
> 
> security/apparmor/policy_unpack.c: In function 'unpack_dfa':
> security/apparmor/policy_unpack.c:426:1: error: label 'fail' defined but not used [-Werror=unused-label]
> 
> Fixes: fb5841091f28 ("apparmor: remove no-op permission check in policy_unpack")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  security/apparmor/policy_unpack.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index 3647b5834ace..96d8cf68ce65 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -423,7 +423,6 @@ static struct aa_dfa *unpack_dfa(struct aa_ext *e)
>  
>  	return dfa;
>  
> -fail:
>  	aa_put_dfa(dfa);
>  	return ERR_PTR(-EPROTO);
>  }
> 
