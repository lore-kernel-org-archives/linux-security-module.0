From: john.johansen@canonical.com (John Johansen)
Date: Thu, 31 Aug 2017 02:12:15 -0700
Subject: [PATCH 01/11] procfs: add smack subdir to attrs
In-Reply-To: <1edd82f8-3388-eeb2-1dda-69ea4b55bf00@schaufler-ca.com>
References: <bbf8bc4a-b56d-e800-4231-60058e4a88bc@schaufler-ca.com>
	<1edd82f8-3388-eeb2-1dda-69ea4b55bf00@schaufler-ca.com>
Message-ID: <14814745-7254-d9c8-12c0-de762fec7076@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 08/29/2017 01:55 PM, Casey Schaufler wrote:
> Subject: [PATCH 01/11] procfs: add smack subdir to attrs
> 
> Back in 2007 I made what turned out to be a rather serious
> mistake in the implementation of the Smack security module.
> The SELinux module used an interface in /proc to manipulate
> the security context on processes. Rather than use a similar
> interface, I used the same interface. The AppArmor team did
> likewise. Now /proc/.../attr/current will tell you the
> security "context" of the process, but it will be different
> depending on the security module you're using.
> 
> This patch provides a subdirectory in /proc/.../attr for
> Smack. Smack user space can use the "current" file in
> this subdirectory and never have to worry about getting
> SELinux attributes by mistake. Programs that use the
> old interface will continue to work (or fail, as the case
> may be) as before.
> 
> This patch does not include subdirectories for SELinux
> or AppArmor. I do have a patch that provides those, and
> will happily make it available should anyone see value
> in it.
> 
> The original implementation is by Kees Cook.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  Documentation/admin-guide/LSM/index.rst | 13 +++++--
>  fs/proc/base.c                          | 63 ++++++++++++++++++++++++++++-----
>  fs/proc/internal.h                      |  1 +
>  include/linux/security.h                | 15 +++++---
>  security/security.c                     | 30 +++++++++++++---
>  5 files changed, 101 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
> index c980dfe9abf1..9842e21afd4a 100644
> --- a/Documentation/admin-guide/LSM/index.rst
> +++ b/Documentation/admin-guide/LSM/index.rst
> @@ -17,9 +17,8 @@ MAC extensions, other extensions can be built using the LSM to provide
>  specific changes to system operation when these tweaks are not available
>  in the core functionality of Linux itself.
>  
> -Without a specific LSM built into the kernel, the default LSM will be the
> -Linux capabilities system. Most LSMs choose to extend the capabilities
> -system, building their checks on top of the defined capability hooks.
> +The Linux capabilities modules will always be included. This may be
> +followed by any number of "minor" modules and at most one "major" module.
>  For more details on capabilities, see ``capabilities(7)`` in the Linux
>  man-pages project.
>  
> @@ -30,6 +29,14 @@ order in which checks are made. The capability module will always
>  be first, followed by any "minor" modules (e.g. Yama) and then
>  the one "major" module (e.g. SELinux) if there is one configured.
>  
> +Process attributes associated with "major" security modules should
> +be accessed and maintained using the special files in ``/proc/.../attr``.
> +A security module may maintain a module specific subdirectory there,
> +named after the module. ``/proc/.../attr/smack`` is provided by the Smack
> +security module and contains all its special files. The files directly
> +in ``/proc/.../attr`` remain as legacy interfaces for modules that provide
> +subdirectories.
> +
>  .. toctree::
>     :maxdepth: 1
>  

<< snip >>

> -int security_getprocattr(struct task_struct *p, char *name, char **value)
> +int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
> +				char **value)
>  {
> -	return call_int_hook(getprocattr, -EINVAL, p, name, value);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	list_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
> +		if (lsm != NULL && strcmp(lsm, hp->lsm))
> +			continue;
> +		rc = hp->hook.getprocattr(p, name, value);
> +		if (rc != -ENOENT)
> +			return rc;
> +	}
> +	return -EINVAL;
>  }
>  
> -int security_setprocattr(const char *name, void *value, size_t size)
> +int security_setprocattr(const char *lsm, const char *name, void *value,
> +			 size_t size)
>  {
> -	return call_int_hook(setprocattr, -EINVAL, name, value, size);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	list_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
> +		if (lsm != NULL && strcmp(lsm, hp->lsm))
> +			continue;
> +		rc = hp->hook.setprocattr(name, value, size);
> +		if (rc != -ENOENT)
> +			return rc;


why
if (rc != -ENOENT), here and above in getprocattr?

this breaks apparmor, as -ENOENT is returned when trying to set a
label that doesn't exist


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
