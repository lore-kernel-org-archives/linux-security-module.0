From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 21 Dec 2017 15:44:53 -0600
Subject: [PATCH] userns: honour no_new_privs for cap_bset during user ns
	creation/switch
In-Reply-To: <20171221210605.181720-1-zenczykowski@gmail.com> ("Maciej
	\=\?utf-8\?Q\?\=C5\=BBenczykowski\=22's\?\= message of "Thu,
	21 Dec 2017 13:06:05 -0800")
References: <20171221210605.181720-1-zenczykowski@gmail.com>
Message-ID: <87wp1foiwa.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Maciej ?enczykowski <zenczykowski@gmail.com> writes:

> From: Maciej ?enczykowski <maze@google.com>
>
> This allows locking down user namespaces tighter,
> and it could even be considered a security fix.

No.  This makes no logical sense.

A task that enters a user namespace loses all capabilities to everything
outside of the user namespace.  Capabilities inside a user namespace are
only valid for objects created inside that user namespace.

So limiting capabilities inside a user namespace when the capability
bounding set is already fully honored by not giving the processes any of
those capabilities makes no logical sense.

If the concern is kernel attack surface versus logical permissions we
can look at ways to reduce the attack surface but that needs to be fully
discussed in the change log.

> Signed-off-by: Maciej ?enczykowski <maze@google.com>
> ---
>  kernel/user_namespace.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 246d4d4ce5c7..2354f7ade78a 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -50,11 +50,12 @@ static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
>  	 * anything as the capabilities are bound to the new user namespace.
>  	 */
>  	cred->securebits = SECUREBITS_DEFAULT;
> +	cred->cap_bset = task_no_new_privs(current) ? current_cred()->cap_bset
> +						    : CAP_FULL_SET;
>  	cred->cap_inheritable = CAP_EMPTY_SET;
> -	cred->cap_permitted = CAP_FULL_SET;
> -	cred->cap_effective = CAP_FULL_SET;
> +	cred->cap_permitted = cred->cap_bset;
> +	cred->cap_effective = cred->cap_bset;
>  	cred->cap_ambient = CAP_EMPTY_SET;
> -	cred->cap_bset = CAP_FULL_SET;
>  #ifdef CONFIG_KEYS
>  	key_put(cred->request_key_auth);
>  	cred->request_key_auth = NULL;
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
