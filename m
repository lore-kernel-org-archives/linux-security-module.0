From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Thu, 31 Aug 2017 11:47:09 -0400
Subject: [Non-DoD Source] [PATCH 03/11] LSM: Manage file security blobs
In-Reply-To: <a19965e2-1787-a190-5648-79bb465ebcab@schaufler-ca.com>
References: <bbf8bc4a-b56d-e800-4231-60058e4a88bc@schaufler-ca.com>
	<a19965e2-1787-a190-5648-79bb465ebcab@schaufler-ca.com>
Message-ID: <1504194429.26651.6.camel@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-08-29 at 13:57 -0700, Casey Schaufler wrote:
> Subject: [PATCH 03/11] LSM: Manage file security blobs
> 
> Move the management of file security blobs from the individual
> security modules to the security infrastructure. The security modules
> using file blobs have been updated accordingly. Modules are required
> to identify the space they need at module initialization. In some
> cases a module no longer needs to supply a blob management hook, in
> which case the hook has been removed.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
> ?include/linux/lsm_hooks.h???????????|??1 +
> ?security/apparmor/include/context.h |??5 +++++
> ?security/apparmor/include/file.h????|??2 +-
> ?security/apparmor/lsm.c?????????????| 19 +++++++++--------
> ?security/security.c?????????????????| 32
> +++++++++++++++++++++++++++++
> ?security/selinux/hooks.c????????????| 41 +++++++++----------------
> ------------
> ?security/selinux/include/objsec.h???|??5 +++++
> ?security/smack/smack.h??????????????|??5 +++++
> ?security/smack/smack_lsm.c??????????| 26 ++++++++---------------
> ?9 files changed, 78 insertions(+), 58 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4ecb4ed572cf..0603c57726e4 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1923,6 +1923,7 @@ struct security_hook_list {
> ? */
> ?struct lsm_blob_sizes {
> ?	int	lbs_cred;
> +	int	lbs_file;
> ?};
> ?
> ?/*
> diff --git a/security/apparmor/include/context.h
> b/security/apparmor/include/context.h
> index 301ab3a0dd04..c6e106a533e8 100644
> --- a/security/apparmor/include/context.h
> +++ b/security/apparmor/include/context.h
> @@ -87,6 +87,11 @@ static inline struct aa_label
> *aa_get_newest_cred_label(const struct cred *cred)
> ?	return aa_get_newest_label(aa_cred_raw_label(cred));
> ?}
> ?
> +static inline struct aa_file_ctx *apparmor_file(const struct file
> *file)
> +{
> +	return file->f_security;
> +}
> +
> ?/**
> ? * __aa_task_raw_label - retrieve another task's label
> ? * @task: task to query??(NOT NULL)
> diff --git a/security/apparmor/include/file.h
> b/security/apparmor/include/file.h
> index 001e40073ff9..af87b23700d7 100644
> --- a/security/apparmor/include/file.h
> +++ b/security/apparmor/include/file.h
> @@ -32,7 +32,7 @@ struct path;
> ?				?AA_MAY_CHMOD | AA_MAY_CHOWN |
> AA_MAY_LOCK | \
> ?				?AA_EXEC_MMAP | AA_MAY_LINK)
> ?
> -#define file_ctx(X) ((struct aa_file_ctx *)(X)->f_security)
> +#define file_ctx(X) apparmor_file(X)
> ?
> ?/* struct aa_file_ctx - the AppArmor context the file was opened in
> ? * @lock: lock to update the ctx
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 827df7012fe4..fb317cc94510 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -400,21 +400,21 @@ static int apparmor_file_open(struct file
> *file, const struct cred *cred)
> ?
> ?static int apparmor_file_alloc_security(struct file *file)
> ?{
> -	int error = 0;
> -
> -	/* freed by apparmor_file_free_security */
> +	struct aa_file_ctx *ctx = file_ctx(file);
> ?	struct aa_label *label = begin_current_label_crit_section();
> -	file->f_security = aa_alloc_file_ctx(label, GFP_KERNEL);
> -	if (!file_ctx(file))
> -		error = -ENOMEM;
> -	end_current_label_crit_section(label);
> ?
> -	return error;
> +	spin_lock_init(&ctx->lock);
> +	rcu_assign_pointer(ctx->label, aa_get_label(label));
> +	end_current_label_crit_section(label);
> +	return 0;
> ?}
> ?
> ?static void apparmor_file_free_security(struct file *file)
> ?{
> -	aa_free_file_ctx(file_ctx(file));
> +	struct aa_file_ctx *ctx = file_ctx(file);
> +
> +	if (ctx)
> +		aa_put_label(rcu_access_pointer(ctx->label));
> ?}
> ?
> ?static int common_file_perm(const char *op, struct file *file, u32
> mask)
> @@ -635,6 +635,7 @@ static int apparmor_task_setrlimit(struct
> task_struct *task,
> ?
> ?struct lsm_blob_sizes apparmor_blob_sizes = {
> ?	.lbs_cred = sizeof(struct aa_task_ctx),
> +	.lbs_file = sizeof(struct aa_file_ctx),
> ?};
> ?
> ?static struct security_hook_list apparmor_hooks[]
> __lsm_ro_after_init = {
> diff --git a/security/security.c b/security/security.c
> index 89d43c65630c..b9346db8a2d4 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -91,6 +91,7 @@ int __init security_init(void)
> ?
> ?#ifdef CONFIG_SECURITY_LSM_DEBUG
> ?	pr_info("LSM: cred blob size???????= %d\n",
> blob_sizes.lbs_cred);
> +	pr_info("LSM: file blob size???????= %d\n",
> blob_sizes.lbs_file);
> ?#endif
> ?
> ?	return 0;
> @@ -267,6 +268,30 @@ static void __init lsm_set_size(int *need, int
> *lbs)
> ?void __init security_add_blobs(struct lsm_blob_sizes *needed)
> ?{
> ?	lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
> +	lsm_set_size(&needed->lbs_file, &blob_sizes.lbs_file);
> +}
> +
> +/**
> + * lsm_file_alloc - allocate a composite file blob
> + * @file: the file that needs a blob
> + *
> + * Allocate the file blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +int lsm_file_alloc(struct file *file)
> +{
> +#ifdef CONFIG_SECURITY_LSM_DEBUG
> +	if (file->f_security)
> +		pr_info("%s: Inbound file blob is not NULL.\n",
> __func__);
> +#endif
> +	if (blob_sizes.lbs_file == 0)
> +		return 0;
> +
> +	file->f_security = kzalloc(blob_sizes.lbs_file, GFP_KERNEL);
> +	if (file->f_security == NULL)
> +		return -ENOMEM;
> +	return 0;
> ?}
> ?
> ?/*
> @@ -957,12 +982,19 @@ int security_file_permission(struct file *file,
> int mask)
> ?
> ?int security_file_alloc(struct file *file)
> ?{
> +	int rc = lsm_file_alloc(file);
> +
> +	if (rc)
> +		return rc;
> ?	return call_int_hook(file_alloc_security, 0, file);
> ?}
> ?
> ?void security_file_free(struct file *file)
> ?{
> ?	call_void_hook(file_free_security, file);
> +
> +	kfree(file->f_security);
> +	file->f_security = NULL;
> ?}
> ?
> ?int security_file_ioctl(struct file *file, unsigned int cmd,
> unsigned long arg)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3b2f028f1e86..b7909d710368 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -129,7 +129,6 @@ int selinux_enabled = 1;
> ?#endif
> ?
> ?static struct kmem_cache *sel_inode_cache;
> -static struct kmem_cache *file_security_cache;
> ?
> ?/**
> ? * selinux_secmark_enabled - Check to see if SECMARK is currently
> enabled
> @@ -359,27 +358,15 @@ static void inode_free_security(struct inode
> *inode)
> ?
> ?static int file_alloc_security(struct file *file)
> ?{
> -	struct file_security_struct *fsec;
> +	struct file_security_struct *fsec = selinux_file(file);
> ?	u32 sid = current_sid();
> ?
> -	fsec = kmem_cache_zalloc(file_security_cache, GFP_KERNEL);
> -	if (!fsec)
> -		return -ENOMEM;
> -

NAK. See commit 63205654c0e05e5ffa1c6eef2fbef21dcabd2185 for why this
was changed from a simple kzalloc() to using its own cache; we don't
want to regress in this regard.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
