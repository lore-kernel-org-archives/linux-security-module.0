From: zyan@redhat.com (Yan, Zheng)
Date: Wed, 27 Jun 2018 09:46:36 +0800
Subject: [PATCH 1/3] selinux: make dentry_init_security() return security
	module name
In-Reply-To: <610fd9e5-4095-d7f0-e5bd-c208e9e77046@schaufler-ca.com>
References: <20180626084306.27511-1-zyan@redhat.com>
	<610fd9e5-4095-d7f0-e5bd-c208e9e77046@schaufler-ca.com>
Message-ID: <4A6464BB-649D-42F2-91D9-22976487CB5A@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



> On Jun 27, 2018, at 00:21, Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> On 6/26/2018 1:43 AM, Yan, Zheng wrote:
>> This is preparation for CephFS security label. CephFS's implementation uses
>> dentry_init_security() to get security context before inode is created,
>> then sends open/mkdir/mknod request to MDS, together with security xattr
>> "security.<security module name>"
> 
> There is no requirement that a security module use
> "security.<security module name>" to name it's attributes.
> Smack, for example, uses "security.SMACK64?.

This does not conflict with this patch. If smack implements dentry_init_security(), if can return whatever it likes.

> Further, Smack uses multiple attributes; "security.SMACK64TRANSMUTE",
> "security.SMACK64MMAP", "security.SMACK64EXEC" as well as
> "security.SMACK64?.
> 
> Also, when (if) we get full module stacking in place you
> will need to handle the possibility that there may be more
> than one security module providing security xattrs.
> 

We can introduce another type of ?dentry_init_security?, which return a xattr array. 

All cephfs wants is a function to get security xattrs before inode is created. It does not matter if the function return one xattr or multiple xattrs.

Regards
Yan, Zheng




>> 
>> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
>> ---
>> fs/nfs/nfs4proc.c         | 3 ++-
>> include/linux/lsm_hooks.h | 4 ++--
>> include/linux/security.h  | 9 +++++----
>> security/security.c       | 7 ++++---
>> security/selinux/hooks.c  | 8 ++++++--
>> 5 files changed, 19 insertions(+), 12 deletions(-)
>> 
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index 6dd146885da9..d18a5fb7aec3 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -122,7 +122,8 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>> 		return NULL;
>> 
>> 	err = security_dentry_init_security(dentry, sattr->ia_mode,
>> -				&dentry->d_name, (void **)&label->label, &label->len);
>> +				&dentry->d_name,  NULL,
>> +				(void **)&label->label, &label->len);
>> 	if (err == 0)
>> 		return label;
>> 
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 8f1131c8dd54..e176c2032bdc 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -1476,8 +1476,8 @@ union security_list_options {
>> 					unsigned long *set_kern_flags);
>> 	int (*sb_parse_opts_str)(char *options, struct security_mnt_opts *opts);
>> 	int (*dentry_init_security)(struct dentry *dentry, int mode,
>> -					const struct qstr *name, void **ctx,
>> -					u32 *ctxlen);
>> +					const struct qstr *name, const char **label,
>> +					void **ctx, u32 *ctxlen);
>> 	int (*dentry_create_files_as)(struct dentry *dentry, int mode,
>> 					struct qstr *name,
>> 					const struct cred *old,
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 63030c85ee19..df2d73998c64 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -246,8 +246,9 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
>> 				unsigned long *set_kern_flags);
>> int security_sb_parse_opts_str(char *options, struct security_mnt_opts *opts);
>> int security_dentry_init_security(struct dentry *dentry, int mode,
>> -					const struct qstr *name, void **ctx,
>> -					u32 *ctxlen);
>> +					const struct qstr *name,
>> +					const char **label,
>> +					void **ctx, u32 *ctxlen);
>> int security_dentry_create_files_as(struct dentry *dentry, int mode,
>> 					struct qstr *name,
>> 					const struct cred *old,
>> @@ -609,8 +610,8 @@ static inline void security_inode_free(struct inode *inode)
>> static inline int security_dentry_init_security(struct dentry *dentry,
>> 						 int mode,
>> 						 const struct qstr *name,
>> -						 void **ctx,
>> -						 u32 *ctxlen)
>> +						 const char **label,
>> +						 void **ctx, u32 *ctxlen)
>> {
>> 	return -EOPNOTSUPP;
>> }
>> diff --git a/security/security.c b/security/security.c
>> index 68f46d849abe..69818d46aa28 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -450,11 +450,12 @@ void security_inode_free(struct inode *inode)
>> }
>> 
>> int security_dentry_init_security(struct dentry *dentry, int mode,
>> -					const struct qstr *name, void **ctx,
>> -					u32 *ctxlen)
>> +					const struct qstr *name,
>> +					const char **label,
>> +					void **ctx, u32 *ctxlen)
>> {
>> 	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
>> -				name, ctx, ctxlen);
>> +				name, label, ctx, ctxlen);
>> }
>> EXPORT_SYMBOL(security_dentry_init_security);
>> 
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 2b5ee5fbd652..eca3879d9357 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -2985,8 +2985,9 @@ static void selinux_inode_free_security(struct inode *inode)
>> }
>> 
>> static int selinux_dentry_init_security(struct dentry *dentry, int mode,
>> -					const struct qstr *name, void **ctx,
>> -					u32 *ctxlen)
>> +					const struct qstr *name,
>> +					const char **label,
>> +					void **ctx, u32 *ctxlen)
>> {
>> 	u32 newsid;
>> 	int rc;
>> @@ -2998,6 +2999,9 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
>> 	if (rc)
>> 		return rc;
>> 
>> +	if (label)
>> +		*label = XATTR_SELINUX_SUFFIX;
>> +
>> 	return security_sid_to_context(&selinux_state, newsid, (char **)ctx,
>> 				       ctxlen);
>> }
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
