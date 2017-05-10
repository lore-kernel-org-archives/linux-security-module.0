From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 10 May 2017 15:26:35 -0700
Subject: [PATCH v3] LSM: Enable multiple calls to security_add_hooks() for
	the same LSM
In-Reply-To: <20170510204848.1555-1-mic@digikod.net>
References: <20170510204848.1555-1-mic@digikod.net>
Message-ID: <dff4cd49-bf3e-ddcc-003d-1c624c2c8d7e@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 5/10/2017 1:48 PM, Micka?l Sala?n wrote:
> The commit d69dece5f5b6 ("LSM: Add /sys/kernel/security/lsm") extend
> security_add_hooks() with a new parameter to register the LSM name,
> which may be useful to make the list of currently loaded LSM available
> to userspace. However, there is no clean way for an LSM to split its
> hook declarations into multiple files, which may reduce the mess with
> all the included files (needed for LSM hook argument types) and make the
> source code easier to review and maintain.
>
> This change allows an LSM to register multiple times its hook while
> keeping a consistent list of LSM names as described in
> Documentation/security/LSM.txt . The list reflects the order in which
> checks are made. This patch only check for the last registered LSM. If
> an LSM register multiple times its hooks, interleaved with other LSM
> registrations (which should not happen), its name will still appear in
> the same order that the hooks are called, hence multiple times.
>
> To sum up, "capability,selinux,foo,foo" will be replaced with
> "capability,selinux,foo", however "capability,foo,selinux,foo" will
> remain as is.
>
> Signed-off-by: Micka?l Sala?n <mic@digikod.net>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>
 

> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: James Morris <james.l.morris@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Link: https://lkml.kernel.org/r/ccad825b-7a58-e499-e51b-bd7c98581afe at schaufler-ca.com
> ---
>  security/security.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/security/security.c b/security/security.c
> index 549bddcc2116..54b1e395978a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -25,6 +25,7 @@
>  #include <linux/mount.h>
>  #include <linux/personality.h>
>  #include <linux/backing-dev.h>
> +#include <linux/string.h>
>  #include <net/flow.h>
>  
>  #define MAX_LSM_EVM_XATTR	2
> @@ -86,6 +87,21 @@ static int __init choose_lsm(char *str)
>  }
>  __setup("security=", choose_lsm);
>  
> +static bool match_last_lsm(const char *list, const char *lsm)
> +{
> +	const char *last;
> +
> +	if (WARN_ON(!list || !lsm))
> +		return false;
> +	last = strrchr(list, ',');
> +	if (last)
> +		/* Pass the comma, strcmp() will check for '\0' */
> +		last++;
> +	else
> +		last = list;
> +	return !strcmp(last, lsm);
> +}
> +
>  static int lsm_append(char *new, char **result)
>  {
>  	char *cp;
> @@ -93,6 +109,9 @@ static int lsm_append(char *new, char **result)
>  	if (*result == NULL) {
>  		*result = kstrdup(new, GFP_KERNEL);
>  	} else {
> +		/* Check if it is the last registered name */
> +		if (match_last_lsm(*result, new))
> +			return 0;
>  		cp = kasprintf(GFP_KERNEL, "%s,%s", *result, new);
>  		if (cp == NULL)
>  			return -ENOMEM;

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
