From: ukernel@gmail.com (Yan, Zheng)
Date: Fri, 7 Sep 2018 16:31:21 +0800
Subject: [PATCH 1/3] selinux: make dentry_init_security() return security
	module name
In-Reply-To: <70879e33-73cd-7185-06a4-cd3147b6a53f@schaufler-ca.com>
References: <20180626084306.27511-1-zyan@redhat.com>
	<356ec32809a222f457b4e04333bb695c32d49680.camel@kernel.org>
	<70879e33-73cd-7185-06a4-cd3147b6a53f@schaufler-ca.com>
Message-ID: <CAAM7YA=baUU1dMpPZMOMrGHJ2hguLNP2tFuHHjVqVjh37eA7kA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Sep 6, 2018 at 11:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 9/6/2018 8:08 AM, Jeff Layton wrote:
> > On Tue, 2018-06-26 at 16:43 +0800, Yan, Zheng wrote:
> >> This is preparation for CephFS security label. CephFS's implementation uses
> >> dentry_init_security() to get security context before inode is created,
> >> then sends open/mkdir/mknod request to MDS, together with security xattr
> >> "security.<security module name>"
>
> Please excuse my late entry into this review.
>
> First, *Do not prefix general LSM interface work with "selinux:"*
> You should only use that prefix when you're dealing with the
> internals of SELinux. Use "LSM:" if you are changing LSM interfaces.
> If you are changing security.h or lsm_hooks.h you are almost
> certainly changing LSM interfaces.
>
> Because you prefixed this work with "selinux:" I pretty much
> ignored it. Please don't do that again.
>
> Why aren't you using security_inode_getsecctx, like kernfs and nfs?
>

Sorry, I don't understand why you mention security_inode_getsecctx().
The selinux_dentry_init_security is called for new inode, I don't how
security_inode_getsecctx() can help.

Regards
Yan, Zheng



>
> >>
> >> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> >> ---
> >>  fs/nfs/nfs4proc.c         | 3 ++-
> >>  include/linux/lsm_hooks.h | 4 ++--
> >>  include/linux/security.h  | 9 +++++----
> >>  security/security.c       | 7 ++++---
> >>  security/selinux/hooks.c  | 8 ++++++--
> >>  5 files changed, 19 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> >> index 6dd146885da9..d18a5fb7aec3 100644
> >> --- a/fs/nfs/nfs4proc.c
> >> +++ b/fs/nfs/nfs4proc.c
> >> @@ -122,7 +122,8 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
> >>              return NULL;
> >>
> >>      err = security_dentry_init_security(dentry, sattr->ia_mode,
> >> -                            &dentry->d_name, (void **)&label->label, &label->len);
> >> +                            &dentry->d_name,  NULL,
> >> +                            (void **)&label->label, &label->len);
> >>      if (err == 0)
> >>              return label;
> >>
> >> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> >> index 8f1131c8dd54..e176c2032bdc 100644
> >> --- a/include/linux/lsm_hooks.h
> >> +++ b/include/linux/lsm_hooks.h
> >> @@ -1476,8 +1476,8 @@ union security_list_options {
> >>                                      unsigned long *set_kern_flags);
> >>      int (*sb_parse_opts_str)(char *options, struct security_mnt_opts *opts);
> >>      int (*dentry_init_security)(struct dentry *dentry, int mode,
> >> -                                    const struct qstr *name, void **ctx,
> >> -                                    u32 *ctxlen);
> >> +                                    const struct qstr *name, const char **label,
> >> +                                    void **ctx, u32 *ctxlen);
> >>      int (*dentry_create_files_as)(struct dentry *dentry, int mode,
> >>                                      struct qstr *name,
> >>                                      const struct cred *old,
> >> diff --git a/include/linux/security.h b/include/linux/security.h
> >> index 63030c85ee19..df2d73998c64 100644
> >> --- a/include/linux/security.h
> >> +++ b/include/linux/security.h
> >> @@ -246,8 +246,9 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
> >>                              unsigned long *set_kern_flags);
> >>  int security_sb_parse_opts_str(char *options, struct security_mnt_opts *opts);
> >>  int security_dentry_init_security(struct dentry *dentry, int mode,
> >> -                                    const struct qstr *name, void **ctx,
> >> -                                    u32 *ctxlen);
> >> +                                    const struct qstr *name,
> >> +                                    const char **label,
> >> +                                    void **ctx, u32 *ctxlen);
> >>  int security_dentry_create_files_as(struct dentry *dentry, int mode,
> >>                                      struct qstr *name,
> >>                                      const struct cred *old,
> >> @@ -609,8 +610,8 @@ static inline void security_inode_free(struct inode *inode)
> >>  static inline int security_dentry_init_security(struct dentry *dentry,
> >>                                               int mode,
> >>                                               const struct qstr *name,
> >> -                                             void **ctx,
> >> -                                             u32 *ctxlen)
> >> +                                             const char **label,
> >> +                                             void **ctx, u32 *ctxlen)
> >>  {
> >>      return -EOPNOTSUPP;
> >>  }
> >> diff --git a/security/security.c b/security/security.c
> >> index 68f46d849abe..69818d46aa28 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -450,11 +450,12 @@ void security_inode_free(struct inode *inode)
> >>  }
> >>
> >>  int security_dentry_init_security(struct dentry *dentry, int mode,
> >> -                                    const struct qstr *name, void **ctx,
> >> -                                    u32 *ctxlen)
> >> +                                    const struct qstr *name,
> >> +                                    const char **label,
> >> +                                    void **ctx, u32 *ctxlen)
> >>  {
> >>      return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
> >> -                            name, ctx, ctxlen);
> >> +                            name, label, ctx, ctxlen);
> >>  }
> >>  EXPORT_SYMBOL(security_dentry_init_security);
> >>
> >> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >> index 2b5ee5fbd652..eca3879d9357 100644
> >> --- a/security/selinux/hooks.c
> >> +++ b/security/selinux/hooks.c
> >> @@ -2985,8 +2985,9 @@ static void selinux_inode_free_security(struct inode *inode)
> >>  }
> >>
> >>  static int selinux_dentry_init_security(struct dentry *dentry, int mode,
> >> -                                    const struct qstr *name, void **ctx,
> >> -                                    u32 *ctxlen)
> >> +                                    const struct qstr *name,
> >> +                                    const char **label,
> >> +                                    void **ctx, u32 *ctxlen)
> >>  {
> >>      u32 newsid;
> >>      int rc;
> >> @@ -2998,6 +2999,9 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
> >>      if (rc)
> >>              return rc;
> >>
> >> +    if (label)
> >> +            *label = XATTR_SELINUX_SUFFIX;
> >> +
> > nit: I'd probably call this "name" since that's what it's called in
> > selinux_inode_init_security. "label" has a different connotation in this
> > context.
> >
> >>      return security_sid_to_context(&selinux_state, newsid, (char **)ctx,
> >>                                     ctxlen);
> >>  }
> > Patch looks reasonable to me though.
> >
> > Acked-by: Jeff Layton <jlayton@kernel.org>
> >
> >
>
