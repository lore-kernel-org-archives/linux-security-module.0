From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Thu, 31 Aug 2017 12:09:17 -0400
Subject: [Non-DoD Source] [PATCH 05/11] LSM: Infrastructure management
	of the remaining blobs
In-Reply-To: <723289df-08c6-daf3-fbff-bfae76c3a0dc@schaufler-ca.com>
References: <bbf8bc4a-b56d-e800-4231-60058e4a88bc@schaufler-ca.com>
	<723289df-08c6-daf3-fbff-bfae76c3a0dc@schaufler-ca.com>
Message-ID: <1504195757.26651.10.camel@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-08-29 at 13:59 -0700, Casey Schaufler wrote:
> Subject: [PATCH 05/11] LSM: Infrastructure management of the
> remaining blobs
> 
> Move management of the inode, ipc, key, msg_msg, sock and superblock
> security blobs from the security modules to the infrastructure.
> Use of the blob pointers is abstracted in the security modules.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
> ?include/linux/lsm_hooks.h?????????|???8 +
> ?security/security.c???????????????| 259 +++++++++++++++++++++++++++-
> ?security/selinux/hooks.c??????????| 333 ++++++++++++--------------
> ----------
> ?security/selinux/include/objsec.h |??65 +++++++-
> ?security/selinux/netlabel.c???????|??15 +-
> ?security/selinux/selinuxfs.c??????|???4 +-
> ?security/selinux/ss/services.c????|???3 +-
> ?security/smack/smack.h????????????|??61 ++++++-
> ?security/smack/smack_lsm.c????????| 343 +++++++++++-----------------
> ----------
> ?security/smack/smack_netfilter.c??|???8 +-
> ?10 files changed, 599 insertions(+), 500 deletions(-)
> 

<snip>
> @@ -319,6 +341,166 @@ int lsm_task_alloc(struct task_struct *task)
> ?	return 0;
> ?}
> ?
> +/**
> + * lsm_inode_alloc - allocate a composite inode blob
> + * @inode: the inode that needs a blob
> + *
> + * Allocate the inode blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +int lsm_inode_alloc(struct inode *inode)
> +{
> +#ifdef CONFIG_SECURITY_LSM_DEBUG
> +	if (inode->i_security)
> +		pr_info("%s: Inbound inode blob is not NULL.\n",
> __func__);
> +#endif
> +	if (blob_sizes.lbs_inode == 0)
> +		return 0;
> +
> +	inode->i_security = kzalloc(blob_sizes.lbs_inode,
> GFP_KERNEL);
> +	if (inode->i_security == NULL)
> +		return -ENOMEM;
> +	return 0;
> +}

NAK. See commit 7cae7e26f245151b9ccad868bf2edf8c8048d307 for why we
moved to using our own cache for inode security blobs in SELinux; we
don't want to regress here.  Also, you need to use GFP_NOFS here, see
commit a02fe13297af26c13d004b1d44f391c077094ea0.

<snip>
> @@ -570,14 +758,39 @@ EXPORT_SYMBOL(security_sb_parse_opts_str);
> ?
> ?int security_inode_alloc(struct inode *inode)
> ?{
> -	inode->i_security = NULL;
> +	int rc = lsm_inode_alloc(inode);
> +
> +	if (rc)
> +		return rc;
> ?	return call_int_hook(inode_alloc_security, 0, inode);
> ?}
> ?
> +static void inode_free_by_rcu(struct rcu_head *head)
> +{
> +	/*
> +	?* The rcu head is at the start of the inode blob
> +	?*/
> +	kfree(head);
> +}
> +
> ?void security_inode_free(struct inode *inode)
> ?{
> ?	integrity_inode_free(inode);
> ?	call_void_hook(inode_free_security, inode);
> +	/*
> +	?* The inode may still be referenced in a path walk and
> +	?* a call to security_inode_permission() can be made
> +	?* after inode_free_security() is called. Ideally, the VFS
> +	?* wouldn't do this, but fixing that is a much harder
> +	?* job. For now, simply free the i_security via RCU, and
> +	?* leave the current inode->i_security pointer intact.
> +	?* The inode will be freed after the RCU grace period too.
> +	?*/
> +	if (inode->i_security != NULL) {
> +		call_rcu((struct rcu_head *)inode->i_security,
> +				inode_free_by_rcu);
> +		inode->i_security = NULL;

You can't clear inode->i_security here; see the comment above that you
copied from the original SELinux code.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
