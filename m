From: john.johansen@canonical.com (John Johansen)
Date: Mon, 31 Jul 2017 17:22:29 -0700
Subject: [PATCH] apparmor: Fix logical error in verify_header()
In-Reply-To: <1499543421-5544-1-git-send-email-chris.gekas@gmail.com>
References: <1499543421-5544-1-git-send-email-chris.gekas@gmail.com>
Message-ID: <2ea41bda-6a90-4d11-bb85-e56073b64274@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/08/2017 12:50 PM, Christos Gkekas wrote:
> verify_header() is currently checking whether interface version is less
> than 5 *and* greater than 7, which always evaluates to false. Instead it
> should check whether it is less than 5 *or* greater than 7.
> 
> Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>

sigh, yes. sorry for the delay this ended up in the wrong bucket.

I've pulled it in for the next pull

Acked-by: John Johansen <john.johansen@canonical.com>


> ---
>  security/apparmor/policy_unpack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index c600f4d..f273c61 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -832,7 +832,7 @@ static int verify_header(struct aa_ext *e, int required, const char **ns)
>  	 * if not specified use previous version
>  	 * Mask off everything that is not kernel abi version
>  	 */
> -	if (VERSION_LT(e->version, v5) && VERSION_GT(e->version, v7)) {
> +	if (VERSION_LT(e->version, v5) || VERSION_GT(e->version, v7)) {
>  		audit_iface(NULL, NULL, NULL, "unsupported interface version",
>  			    e, error);
>  		return error;
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
