Return-Path: <SRS0=OCSC=24=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365CCC33C8C
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jan 2020 13:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45502081E
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jan 2020 13:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKiso4fJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgAGNcK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:32:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28199 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728171AbgAGNcK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Jan 2020 08:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578403926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TPW+L/6CTxQQd0tcSpnmfHd+Oc89oGj9Oyz8BHyXw4=;
        b=aKiso4fJxwwx3LzW7J1o6uc1i9uoJ05w2XwBzGtVyJzIDZmx/YLD9+pOp8oZ2iqZ95bHbJ
        jMjDv0o5xEfcWLQWsP02jFTdE2ecaaQPF7KUYmEt17OiteMFDdlake1bh5dV0MIhsyQW7j
        Ikv+M0RALfgDSJ34VNoZg/mVm6k3/Xo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-5hOZsiuCNEqhXz96MfH9zA-1; Tue, 07 Jan 2020 08:32:04 -0500
Received: by mail-wr1-f69.google.com with SMTP id z15so885188wrw.0
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jan 2020 05:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NThNQIyGC7lxATvQzw927ctg+bT4CrbGBjSVXk1Dh9Y=;
        b=MdWsF7j7+0QsEkgqOiTybmhB76VfZhsofwn6RUaHiVpAZH0qHpWZU9Rj7HBKAXD+jg
         3HDm75ozYN1OBLGIc0w5BCVF5u+TkEXZ6ex1qcWTlaIXAKlS+CVblIUAecQE6W73m77e
         X7Muc32wI2B6IkoUUegaTl14hl2oL0F/NdsMaGgafnU2N9VWLlJGHL+qAzWw48GxT+vW
         MWk0Adre13w3ViIlCXVjgRJMyBgynqFkjHdTQtNLrB8l0cUOY2DnnBT5d73K0+yrIBmw
         Y1MmdEiV3fthBhHBCeuwq5Dl708Dk7Qsq0GhUqPnXbAoGnP27MHwnU75u5Iw3HtKEEua
         7AgQ==
X-Gm-Message-State: APjAAAXig3M61uXsnn04wmOHmDkTBfD4brUBWjMifyeTylaw2ApzOXvS
        1AGSVj4fA+c0XYvVf/0JnVtc7wrdtxTWqrRVPJzwgyFWT7IM8LaoCOewy+dDHBfHgW5D3/IKJiA
        JHbPwybGgh8Wzx1vDS8wYevd4/sThPLJ90IWk
X-Received: by 2002:a1c:f407:: with SMTP id z7mr38520035wma.72.1578403921604;
        Tue, 07 Jan 2020 05:32:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqwPQ/7iWzMfKr7H5F96yNP+TX4ovzy5oUgN7+J5vIRc4APh+2GfCjia6pApmkB5cg+FQ1z1Gg==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr38519890wma.72.1578403920013;
        Tue, 07 Jan 2020 05:32:00 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f207sm29097127wme.9.2020.01.07.05.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:31:59 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 2/2] security,selinux: get rid of security_delete_hooks()
Date:   Tue,  7 Jan 2020 14:31:54 +0100
Message-Id: <20200107133154.588958-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107133154.588958-1-omosnace@redhat.com>
References: <20200107133154.588958-1-omosnace@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 5hOZsiuCNEqhXz96MfH9zA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The only user is SELinux, which is hereby converted to check the
disabled flag in each hook instead of removing the hooks from the list.

The __lsm_ro_after_init macro is now removed and replaced with
__ro_after_init directly.

This fixes a race condition in SELinux runtime disable, which was
introduced with the switch to hook lists in b1d9e6b0646d ("LSM: Switch
to lists of hooks").

Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_hooks.h    |  31 --
 security/Kconfig             |   5 -
 security/apparmor/lsm.c      |   6 +-
 security/commoncap.c         |   2 +-
 security/loadpin/loadpin.c   |   2 +-
 security/lockdown/lockdown.c |   2 +-
 security/security.c          |   5 +-
 security/selinux/Kconfig     |   6 -
 security/selinux/hooks.c     | 742 ++++++++++++++++++++++++++++++-----
 security/smack/smack_lsm.c   |   4 +-
 security/tomoyo/tomoyo.c     |   6 +-
 security/yama/yama_lsm.c     |   2 +-
 12 files changed, 654 insertions(+), 159 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 20d8cf194fb7..5064060ce910 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -27,7 +27,6 @@
=20
 #include <linux/security.h>
 #include <linux/init.h>
-#include <linux/rculist.h>
=20
 /**
  * union security_list_options - Linux Security Module hook function list
@@ -2145,36 +2144,6 @@ extern struct lsm_info __start_early_lsm_info[], __e=
nd_early_lsm_info[];
 =09=09__used __section(.early_lsm_info.init)=09=09=09\
 =09=09__aligned(sizeof(unsigned long))
=20
-#ifdef CONFIG_SECURITY_SELINUX_DISABLE
-/*
- * Assuring the safety of deleting a security module is up to
- * the security module involved. This may entail ordering the
- * module's hook list in a particular way, refusing to disable
- * the module once a policy is loaded or any number of other
- * actions better imagined than described.
- *
- * The name of the configuration option reflects the only module
- * that currently uses the mechanism. Any developer who thinks
- * disabling their module is a good idea needs to be at least as
- * careful as the SELinux team.
- */
-static inline void security_delete_hooks(struct security_hook_list *hooks,
-=09=09=09=09=09=09int count)
-{
-=09int i;
-
-=09for (i =3D 0; i < count; i++)
-=09=09hlist_del_rcu(&hooks[i].list);
-}
-#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
-
-/* Currently required to handle SELinux runtime hook disable. */
-#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
-#define __lsm_ro_after_init
-#else
-#define __lsm_ro_after_init=09__ro_after_init
-#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
-
 extern int lsm_inode_alloc(struct inode *inode);
=20
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/Kconfig b/security/Kconfig
index 2a1a2d396228..456764990a13 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -32,11 +32,6 @@ config SECURITY
=20
 =09  If you are unsure how to answer this question, answer N.
=20
-config SECURITY_WRITABLE_HOOKS
-=09depends on SECURITY
-=09bool
-=09default n
-
 config SECURITYFS
 =09bool "Enable the securityfs filesystem"
 =09help
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index b621ad74f54a..cd83812a440f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1158,13 +1158,13 @@ static int apparmor_inet_conn_request(struct sock *=
sk, struct sk_buff *skb,
 /*
  * The cred blob is a pointer to, not an instance of, an aa_task_ctx.
  */
-struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init =3D {
+struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init =3D {
 =09.lbs_cred =3D sizeof(struct aa_task_ctx *),
 =09.lbs_file =3D sizeof(struct aa_file_ctx),
 =09.lbs_task =3D sizeof(struct aa_task_ctx),
 };
=20
-static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init =3D =
{
+static struct security_hook_list apparmor_hooks[] __ro_after_init =3D {
 =09LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 =09LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
 =09LSM_HOOK_INIT(capget, apparmor_capget),
@@ -1368,7 +1368,7 @@ static const struct kernel_param_ops param_ops_aaintb=
ool =3D {
 =09.get =3D param_get_aaintbool
 };
 /* Boot time disable flag */
-static int apparmor_enabled __lsm_ro_after_init =3D 1;
+static int apparmor_enabled __ro_after_init =3D 1;
 module_param_named(enabled, apparmor_enabled, aaintbool, 0444);
=20
 static int __init apparmor_enabled_setup(char *str)
diff --git a/security/commoncap.c b/security/commoncap.c
index f4ee0ae106b2..1471d9a5a9bc 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1339,7 +1339,7 @@ int cap_mmap_file(struct file *file, unsigned long re=
qprot,
=20
 #ifdef CONFIG_SECURITY
=20
-static struct security_hook_list capability_hooks[] __lsm_ro_after_init =
=3D {
+static struct security_hook_list capability_hooks[] __ro_after_init =3D {
 =09LSM_HOOK_INIT(capable, cap_capable),
 =09LSM_HOOK_INIT(settime, cap_settime),
 =09LSM_HOOK_INIT(ptrace_access_check, cap_ptrace_access_check),
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index ee5cb944f4ad..9bbc08bee2c0 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -180,7 +180,7 @@ static int loadpin_load_data(enum kernel_load_data_id i=
d)
 =09return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
 }
=20
-static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init =3D {
+static struct security_hook_list loadpin_hooks[] __ro_after_init =3D {
 =09LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 =09LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
 =09LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 5a952617a0eb..8071d0f542c8 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -71,7 +71,7 @@ static int lockdown_is_locked_down(enum lockdown_reason w=
hat)
 =09return 0;
 }
=20
-static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init =3D =
{
+static struct security_hook_list lockdown_hooks[] __ro_after_init =3D {
 =09LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
 };
=20
diff --git a/security/security.c b/security/security.c
index 2b5473d92416..3138a5d99813 100644
--- a/security/security.c
+++ b/security/security.c
@@ -27,6 +27,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <linux/rculist.h>
 #include <net/flow.h>
=20
 #define MAX_LSM_EVM_XATTR=092
@@ -68,14 +69,14 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIA=
LITY_MAX+1] =3D {
 =09[LOCKDOWN_CONFIDENTIALITY_MAX] =3D "confidentiality",
 };
=20
-struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+struct security_hook_heads security_hook_heads __ro_after_init;
 static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
=20
 static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
=20
 char *lsm_names;
-static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
+static struct lsm_blob_sizes blob_sizes __ro_after_init;
=20
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_order;
diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 996d35d950f7..caa5711478ad 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -26,7 +26,6 @@ config SECURITY_SELINUX_BOOTPARAM
 config SECURITY_SELINUX_DISABLE
 =09bool "NSA SELinux runtime disable"
 =09depends on SECURITY_SELINUX
-=09select SECURITY_WRITABLE_HOOKS
 =09default n
 =09help
 =09  This option enables writing to a selinuxfs node 'disable', which
@@ -37,11 +36,6 @@ config SECURITY_SELINUX_DISABLE
 =09  portability across platforms where boot parameters are difficult
 =09  to employ.
=20
-=09  NOTE: selecting this option will disable the '__ro_after_init'
-=09  kernel hardening feature for security hooks.   Please consider
-=09  using the selinux=3D0 boot parameter instead of enabling this
-=09  option.
-
 =09  If you are unsure how to answer this question, answer N.
=20
 config SECURITY_SELINUX_DEVELOP
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 47ad4db925cf..9ac2b6b69ff9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -650,13 +650,15 @@ static int selinux_set_mnt_opts(struct super_block *s=
b,
 {
 =09const struct cred *cred =3D current_cred();
 =09struct superblock_security_struct *sbsec =3D sb->s_security;
-=09struct dentry *root =3D sbsec->sb->s_root;
 =09struct selinux_mnt_opts *opts =3D mnt_opts;
 =09struct inode_security_struct *root_isec;
 =09u32 fscontext_sid =3D 0, context_sid =3D 0, rootcontext_sid =3D 0;
 =09u32 defcontext_sid =3D 0;
 =09int rc =3D 0;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09mutex_lock(&sbsec->lock);
=20
 =09if (!selinux_initialized(&selinux_state)) {
@@ -693,7 +695,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 =09    && !opts)
 =09=09goto out;
=20
-=09root_isec =3D backing_inode_security_novalidate(root);
+=09root_isec =3D backing_inode_security_novalidate(sbsec->sb->s_root);
=20
 =09/*
 =09 * parse the mount options, check if they are valid sids.
@@ -919,10 +921,14 @@ static int selinux_sb_clone_mnt_opts(const struct sup=
er_block *oldsb,
 =09int rc =3D 0;
 =09const struct superblock_security_struct *oldsbsec =3D oldsb->s_security=
;
 =09struct superblock_security_struct *newsbsec =3D newsb->s_security;
+=09int set_fscontext, set_context, set_rootcontext;
+
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
=20
-=09int set_fscontext =3D=09(oldsbsec->flags & FSCONTEXT_MNT);
-=09int set_context =3D=09(oldsbsec->flags & CONTEXT_MNT);
-=09int set_rootcontext =3D=09(oldsbsec->flags & ROOTCONTEXT_MNT);
+=09set_fscontext =3D=09=09(oldsbsec->flags & FSCONTEXT_MNT);
+=09set_context =3D=09=09(oldsbsec->flags & CONTEXT_MNT);
+=09set_rootcontext =3D=09(oldsbsec->flags & ROOTCONTEXT_MNT);
=20
 =09/*
 =09 * if the parent was able to be mounted it clearly had no special lsm
@@ -1041,6 +1047,9 @@ static int selinux_add_mnt_opt(const char *option, co=
nst char *val, int len,
 =09int token =3D Opt_error;
 =09int rc, i;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09for (i =3D 0; i < ARRAY_SIZE(tokens); i++) {
 =09=09if (strcmp(option, tokens[i].name) =3D=3D 0) {
 =09=09=09token =3D tokens[i].opt;
@@ -1100,6 +1109,9 @@ static int selinux_sb_show_options(struct seq_file *m=
, struct super_block *sb)
 =09struct superblock_security_struct *sbsec =3D sb->s_security;
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (!(sbsec->flags & SE_SBINITIALIZED))
 =09=09return 0;
=20
@@ -2044,22 +2056,27 @@ static inline u32 open_file_to_av(struct file *file=
)
=20
 static int selinux_binder_set_context_mgr(struct task_struct *mgr)
 {
-=09u32 mysid =3D current_sid();
-=09u32 mgrsid =3D task_sid(mgr);
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
=20
 =09return avc_has_perm(&selinux_state,
-=09=09=09    mysid, mgrsid, SECCLASS_BINDER,
+=09=09=09    current_sid(), task_sid(mgr), SECCLASS_BINDER,
 =09=09=09    BINDER__SET_CONTEXT_MGR, NULL);
 }
=20
 static int selinux_binder_transaction(struct task_struct *from,
 =09=09=09=09      struct task_struct *to)
 {
-=09u32 mysid =3D current_sid();
-=09u32 fromsid =3D task_sid(from);
-=09u32 tosid =3D task_sid(to);
+=09u32 mysid, fromsid, tosid;
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
+=09mysid =3D current_sid();
+=09fromsid =3D task_sid(from);
+=09tosid =3D task_sid(to);
+
 =09if (mysid !=3D fromsid) {
 =09=09rc =3D avc_has_perm(&selinux_state,
 =09=09=09=09  mysid, fromsid, SECCLASS_BINDER,
@@ -2076,11 +2093,12 @@ static int selinux_binder_transaction(struct task_s=
truct *from,
 static int selinux_binder_transfer_binder(struct task_struct *from,
 =09=09=09=09=09  struct task_struct *to)
 {
-=09u32 fromsid =3D task_sid(from);
-=09u32 tosid =3D task_sid(to);
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
=20
 =09return avc_has_perm(&selinux_state,
-=09=09=09    fromsid, tosid, SECCLASS_BINDER, BINDER__TRANSFER,
+=09=09=09    task_sid(from), task_sid(to),
+=09=09=09    SECCLASS_BINDER, BINDER__TRANSFER,
 =09=09=09    NULL);
 }
=20
@@ -2088,13 +2106,18 @@ static int selinux_binder_transfer_file(struct task=
_struct *from,
 =09=09=09=09=09struct task_struct *to,
 =09=09=09=09=09struct file *file)
 {
-=09u32 sid =3D task_sid(to);
+=09u32 sid;
 =09struct file_security_struct *fsec =3D selinux_file(file);
 =09struct dentry *dentry =3D file->f_path.dentry;
 =09struct inode_security_struct *isec;
 =09struct common_audit_data ad;
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
+=09sid =3D task_sid(to);
+
 =09ad.type =3D LSM_AUDIT_DATA_PATH;
 =09ad.u.path =3D file->f_path;
=20
@@ -2126,19 +2149,26 @@ static int selinux_binder_transfer_file(struct task=
_struct *from,
 static int selinux_ptrace_access_check(struct task_struct *child,
 =09=09=09=09     unsigned int mode)
 {
-=09u32 sid =3D current_sid();
-=09u32 csid =3D task_sid(child);
+=09u16 cls =3D SECCLASS_PROCESS;
+=09u32 perm =3D PROCESS__PTRACE;
=20
-=09if (mode & PTRACE_MODE_READ)
-=09=09return avc_has_perm(&selinux_state,
-=09=09=09=09    sid, csid, SECCLASS_FILE, FILE__READ, NULL);
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
+=09if (mode & PTRACE_MODE_READ) {
+=09=09cls =3D SECCLASS_FILE;
+=09=09perm =3D FILE__READ;
+=09}
=20
 =09return avc_has_perm(&selinux_state,
-=09=09=09    sid, csid, SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
+=09=09=09    current_sid(), task_sid(child), cls, perm, NULL);
 }
=20
 static int selinux_ptrace_traceme(struct task_struct *parent)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return avc_has_perm(&selinux_state,
 =09=09=09    task_sid(parent), current_sid(), SECCLASS_PROCESS,
 =09=09=09    PROCESS__PTRACE, NULL);
@@ -2147,6 +2177,9 @@ static int selinux_ptrace_traceme(struct task_struct =
*parent)
 static int selinux_capget(struct task_struct *target, kernel_cap_t *effect=
ive,
 =09=09=09  kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return avc_has_perm(&selinux_state,
 =09=09=09    current_sid(), task_sid(target), SECCLASS_PROCESS,
 =09=09=09    PROCESS__GETCAP, NULL);
@@ -2157,6 +2190,9 @@ static int selinux_capset(struct cred *new, const str=
uct cred *old,
 =09=09=09  const kernel_cap_t *inheritable,
 =09=09=09  const kernel_cap_t *permitted)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return avc_has_perm(&selinux_state,
 =09=09=09    cred_sid(old), cred_sid(new), SECCLASS_PROCESS,
 =09=09=09    PROCESS__SETCAP, NULL);
@@ -2175,6 +2211,9 @@ static int selinux_capset(struct cred *new, const str=
uct cred *old,
 static int selinux_capable(const struct cred *cred, struct user_namespace =
*ns,
 =09=09=09   int cap, unsigned int opts)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return cred_has_capability(cred, cap, opts, ns =3D=3D &init_user_ns);
 }
=20
@@ -2186,6 +2225,9 @@ static int selinux_quotactl(int cmds, int type, int i=
d, struct super_block *sb)
 =09if (!sb)
 =09=09return 0;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09switch (cmds) {
 =09case Q_SYNC:
 =09case Q_QUOTAON:
@@ -2210,11 +2252,17 @@ static int selinux_quota_on(struct dentry *dentry)
 {
 =09const struct cred *cred =3D current_cred();
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return dentry_has_perm(cred, dentry, FILE__QUOTAON);
 }
=20
 static int selinux_syslog(int type)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09switch (type) {
 =09case SYSLOG_ACTION_READ_ALL:=09/* Read last kernel messages */
 =09case SYSLOG_ACTION_SIZE_BUFFER:=09/* Return size of the log buffer */
@@ -2248,6 +2296,9 @@ static int selinux_vm_enough_memory(struct mm_struct =
*mm, long pages)
 {
 =09int rc, cap_sys_admin =3D 0;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09rc =3D cred_has_capability(current_cred(), CAP_SYS_ADMIN,
 =09=09=09=09 CAP_OPT_NOAUDIT, true);
 =09if (rc =3D=3D 0)
@@ -2335,6 +2386,9 @@ static int selinux_bprm_set_creds(struct linux_binprm=
 *bprm)
 =09struct inode *inode =3D file_inode(bprm->file);
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09/* SELinux context only depends on initial program or script and not
 =09 * the script interpreter */
 =09if (bprm->called_set_creds)
@@ -2505,6 +2559,9 @@ static void selinux_bprm_committing_creds(struct linu=
x_binprm *bprm)
 =09struct rlimit *rlim, *initrlim;
 =09int rc, i;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09new_tsec =3D selinux_cred(bprm->cred);
 =09if (new_tsec->sid =3D=3D new_tsec->osid)
 =09=09return;
@@ -2552,6 +2609,9 @@ static void selinux_bprm_committed_creds(struct linux=
_binprm *bprm)
 =09u32 osid, sid;
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09osid =3D tsec->osid;
 =09sid =3D tsec->sid;
=20
@@ -2592,11 +2652,17 @@ static void selinux_bprm_committed_creds(struct lin=
ux_binprm *bprm)
=20
 static int selinux_sb_alloc_security(struct super_block *sb)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return superblock_alloc_security(sb);
 }
=20
 static void selinux_sb_free_security(struct super_block *sb)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09superblock_free_security(sb);
 }
=20
@@ -2622,6 +2688,9 @@ static int selinux_sb_eat_lsm_opts(char *options, voi=
d **mnt_opts)
 =09bool first =3D true;
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09while (1) {
 =09=09int len =3D opt_len(from);
 =09=09int token;
@@ -2682,6 +2751,9 @@ static int selinux_sb_remount(struct super_block *sb,=
 void *mnt_opts)
 =09u32 sid;
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (!(sbsec->flags & SE_SBINITIALIZED))
 =09=09return 0;
=20
@@ -2732,6 +2804,9 @@ static int selinux_sb_kern_mount(struct super_block *=
sb)
 =09const struct cred *cred =3D current_cred();
 =09struct common_audit_data ad;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09ad.type =3D LSM_AUDIT_DATA_DENTRY;
 =09ad.u.dentry =3D sb->s_root;
 =09return superblock_has_perm(cred, sb, FILESYSTEM__MOUNT, &ad);
@@ -2742,6 +2817,9 @@ static int selinux_sb_statfs(struct dentry *dentry)
 =09const struct cred *cred =3D current_cred();
 =09struct common_audit_data ad;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09ad.type =3D LSM_AUDIT_DATA_DENTRY;
 =09ad.u.dentry =3D dentry->d_sb->s_root;
 =09return superblock_has_perm(cred, dentry->d_sb, FILESYSTEM__GETATTR, &ad=
);
@@ -2755,6 +2833,9 @@ static int selinux_mount(const char *dev_name,
 {
 =09const struct cred *cred =3D current_cred();
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (flags & MS_REMOUNT)
 =09=09return superblock_has_perm(cred, path->dentry->d_sb,
 =09=09=09=09=09   FILESYSTEM__REMOUNT, NULL);
@@ -2766,6 +2847,9 @@ static int selinux_umount(struct vfsmount *mnt, int f=
lags)
 {
 =09const struct cred *cred =3D current_cred();
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return superblock_has_perm(cred, mnt->mnt_sb,
 =09=09=09=09   FILESYSTEM__UNMOUNT, NULL);
 }
@@ -2776,6 +2860,9 @@ static int selinux_fs_context_dup(struct fs_context *=
fc,
 =09const struct selinux_mnt_opts *src =3D src_fc->security;
 =09struct selinux_mnt_opts *opts;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (!src)
 =09=09return 0;
=20
@@ -2828,6 +2915,9 @@ static int selinux_fs_context_parse_param(struct fs_c=
ontext *fc,
 =09struct fs_parse_result result;
 =09int opt, rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09opt =3D fs_parse(fc, &selinux_fs_parameters, param, &result);
 =09if (opt < 0)
 =09=09return opt;
@@ -2844,11 +2934,17 @@ static int selinux_fs_context_parse_param(struct fs=
_context *fc,
=20
 static int selinux_inode_alloc_security(struct inode *inode)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return inode_alloc_security(inode);
 }
=20
 static void selinux_inode_free_security(struct inode *inode)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09inode_free_security(inode);
 }
=20
@@ -2859,6 +2955,9 @@ static int selinux_dentry_init_security(struct dentry=
 *dentry, int mode,
 =09u32 newsid;
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09rc =3D selinux_determine_inode_label(selinux_cred(current_cred()),
 =09=09=09=09=09   d_inode(dentry->d_parent), name,
 =09=09=09=09=09   inode_mode_to_security_class(mode),
@@ -2879,6 +2978,9 @@ static int selinux_dentry_create_files_as(struct dent=
ry *dentry, int mode,
 =09int rc;
 =09struct task_security_struct *tsec;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09rc =3D selinux_determine_inode_label(selinux_cred(old),
 =09=09=09=09=09   d_inode(dentry->d_parent), name,
 =09=09=09=09=09   inode_mode_to_security_class(mode),
@@ -2902,6 +3004,9 @@ static int selinux_inode_init_security(struct inode *=
inode, struct inode *dir,
 =09int rc;
 =09char *context;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09sbsec =3D dir->i_sb->s_security;
=20
 =09newsid =3D tsec->create_sid;
@@ -2941,50 +3046,75 @@ static int selinux_inode_init_security(struct inode=
 *inode, struct inode *dir,
=20
 static int selinux_inode_create(struct inode *dir, struct dentry *dentry, =
umode_t mode)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return may_create(dir, dentry, SECCLASS_FILE);
 }
=20
 static int selinux_inode_link(struct dentry *old_dentry, struct inode *dir=
, struct dentry *new_dentry)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return may_link(dir, old_dentry, MAY_LINK);
 }
=20
 static int selinux_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return may_link(dir, dentry, MAY_UNLINK);
 }
=20
 static int selinux_inode_symlink(struct inode *dir, struct dentry *dentry,=
 const char *name)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return may_create(dir, dentry, SECCLASS_LNK_FILE);
 }
=20
 static int selinux_inode_mkdir(struct inode *dir, struct dentry *dentry, u=
mode_t mask)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return may_create(dir, dentry, SECCLASS_DIR);
 }
=20
 static int selinux_inode_rmdir(struct inode *dir, struct dentry *dentry)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return may_link(dir, dentry, MAY_RMDIR);
 }
=20
 static int selinux_inode_mknod(struct inode *dir, struct dentry *dentry, u=
mode_t mode, dev_t dev)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return may_create(dir, dentry, inode_mode_to_security_class(mode));
 }
=20
 static int selinux_inode_rename(struct inode *old_inode, struct dentry *ol=
d_dentry,
 =09=09=09=09struct inode *new_inode, struct dentry *new_dentry)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return may_rename(old_inode, old_dentry, new_inode, new_dentry);
 }
=20
 static int selinux_inode_readlink(struct dentry *dentry)
 {
-=09const struct cred *cred =3D current_cred();
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
=20
-=09return dentry_has_perm(cred, dentry, FILE__READ);
+=09return dentry_has_perm(current_cred(), dentry, FILE__READ);
 }
=20
 static int selinux_inode_follow_link(struct dentry *dentry, struct inode *=
inode,
@@ -2995,6 +3125,9 @@ static int selinux_inode_follow_link(struct dentry *d=
entry, struct inode *inode,
 =09struct inode_security_struct *isec;
 =09u32 sid;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09validate_creds(cred);
=20
 =09ad.type =3D LSM_AUDIT_DATA_DENTRY;
@@ -3040,6 +3173,9 @@ static int selinux_inode_permission(struct inode *ino=
de, int mask)
 =09int rc, rc2;
 =09u32 audited, denied;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09from_access =3D mask & MAY_ACCESS;
 =09mask &=3D (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
=20
@@ -3086,6 +3222,9 @@ static int selinux_inode_setattr(struct dentry *dentr=
y, struct iattr *iattr)
 =09unsigned int ia_valid =3D iattr->ia_valid;
 =09__u32 av =3D FILE__WRITE;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09/* ATTR_FORCE is just used for ATTR_KILL_S[UG]ID. */
 =09if (ia_valid & ATTR_FORCE) {
 =09=09ia_valid &=3D ~(ATTR_KILL_SUID | ATTR_KILL_SGID | ATTR_MODE |
@@ -3109,6 +3248,9 @@ static int selinux_inode_setattr(struct dentry *dentr=
y, struct iattr *iattr)
=20
 static int selinux_inode_getattr(const struct path *path)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return path_has_perm(current_cred(), path, FILE__GETATTR);
 }
=20
@@ -3131,9 +3273,12 @@ static int selinux_inode_setxattr(struct dentry *den=
try, const char *name,
 =09struct inode_security_struct *isec;
 =09struct superblock_security_struct *sbsec;
 =09struct common_audit_data ad;
-=09u32 newsid, sid =3D current_sid();
+=09u32 newsid, sid;
 =09int rc =3D 0;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (strcmp(name, XATTR_NAME_SELINUX)) {
 =09=09rc =3D cap_inode_setxattr(dentry, name, value, size, flags);
 =09=09if (rc)
@@ -3154,6 +3299,8 @@ static int selinux_inode_setxattr(struct dentry *dent=
ry, const char *name,
 =09if (!inode_owner_or_capable(inode))
 =09=09return -EPERM;
=20
+=09sid =3D current_sid();
+
 =09ad.type =3D LSM_AUDIT_DATA_DENTRY;
 =09ad.u.dentry =3D dentry;
=20
@@ -3225,6 +3372,9 @@ static void selinux_inode_post_setxattr(struct dentry=
 *dentry, const char *name,
 =09u32 newsid;
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09if (strcmp(name, XATTR_NAME_SELINUX)) {
 =09=09/* Not an attribute we recognize, so nothing to do. */
 =09=09return;
@@ -3260,20 +3410,25 @@ static void selinux_inode_post_setxattr(struct dent=
ry *dentry, const char *name,
=20
 static int selinux_inode_getxattr(struct dentry *dentry, const char *name)
 {
-=09const struct cred *cred =3D current_cred();
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
=20
-=09return dentry_has_perm(cred, dentry, FILE__GETATTR);
+=09return dentry_has_perm(current_cred(), dentry, FILE__GETATTR);
 }
=20
 static int selinux_inode_listxattr(struct dentry *dentry)
 {
-=09const struct cred *cred =3D current_cred();
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
=20
-=09return dentry_has_perm(cred, dentry, FILE__GETATTR);
+=09return dentry_has_perm(current_cred(), dentry, FILE__GETATTR);
 }
=20
 static int selinux_inode_removexattr(struct dentry *dentry, const char *na=
me)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (strcmp(name, XATTR_NAME_SELINUX)) {
 =09=09int rc =3D cap_inode_removexattr(dentry, name);
 =09=09if (rc)
@@ -3297,6 +3452,9 @@ static int selinux_path_notify(const struct path *pat=
h, u64 mask,
=20
 =09struct common_audit_data ad;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09ad.type =3D LSM_AUDIT_DATA_PATH;
 =09ad.u.path =3D *path;
=20
@@ -3345,6 +3503,9 @@ static int selinux_inode_getsecurity(struct inode *in=
ode, const char *name, void
 =09char *context =3D NULL;
 =09struct inode_security_struct *isec;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return -EOPNOTSUPP;
+
 =09if (strcmp(name, XATTR_SELINUX_SUFFIX))
 =09=09return -EOPNOTSUPP;
=20
@@ -3385,6 +3546,9 @@ static int selinux_inode_setsecurity(struct inode *in=
ode, const char *name,
 =09u32 newsid;
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return -EOPNOTSUPP;
+
 =09if (strcmp(name, XATTR_SELINUX_SUFFIX))
 =09=09return -EOPNOTSUPP;
=20
@@ -3410,6 +3574,10 @@ static int selinux_inode_setsecurity(struct inode *i=
node, const char *name,
 static int selinux_inode_listsecurity(struct inode *inode, char *buffer, s=
ize_t buffer_size)
 {
 =09const int len =3D sizeof(XATTR_NAME_SELINUX);
+
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (buffer && len <=3D buffer_size)
 =09=09memcpy(buffer, XATTR_NAME_SELINUX, len);
 =09return len;
@@ -3417,16 +3585,24 @@ static int selinux_inode_listsecurity(struct inode =
*inode, char *buffer, size_t
=20
 static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
 {
-=09struct inode_security_struct *isec =3D inode_security_novalidate(inode)=
;
+=09struct inode_security_struct *isec;
+
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
+=09isec =3D inode_security_novalidate(inode);
 =09*secid =3D isec->sid;
 }
=20
 static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 {
-=09u32 sid;
+=09struct inode_security_struct *isec;
 =09struct task_security_struct *tsec;
 =09struct cred *new_creds =3D *new;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (new_creds =3D=3D NULL) {
 =09=09new_creds =3D prepare_creds();
 =09=09if (!new_creds)
@@ -3435,14 +3611,17 @@ static int selinux_inode_copy_up(struct dentry *src=
, struct cred **new)
=20
 =09tsec =3D selinux_cred(new_creds);
 =09/* Get label from overlay inode and set it in create_sid */
-=09selinux_inode_getsecid(d_inode(src), &sid);
-=09tsec->create_sid =3D sid;
+=09isec =3D inode_security_novalidate(d_inode(src));
+=09tsec->create_sid =3D isec->sid;
 =09*new =3D new_creds;
 =09return 0;
 }
=20
 static int selinux_inode_copy_up_xattr(const char *name)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return -EOPNOTSUPP;
+
 =09/* The copy_up hook above sets the initial context on an inode, but we
 =09 * don't then want to overwrite it by blindly copying all the lower
 =09 * xattrs up.  Instead, we have to filter out SELinux-related xattrs.
@@ -3466,6 +3645,9 @@ static int selinux_kernfs_init_security(struct kernfs=
_node *kn_dir,
 =09int rc;
 =09char *context;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09rc =3D kernfs_xattr_get(kn_dir, XATTR_NAME_SELINUX, NULL, 0);
 =09if (rc =3D=3D -ENODATA)
 =09=09return 0;
@@ -3537,14 +3719,16 @@ static int selinux_file_permission(struct file *fil=
e, int mask)
 =09struct inode *inode =3D file_inode(file);
 =09struct file_security_struct *fsec =3D selinux_file(file);
 =09struct inode_security_struct *isec;
-=09u32 sid =3D current_sid();
+
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
=20
 =09if (!mask)
 =09=09/* No permission to check.  Existence test. */
 =09=09return 0;
=20
 =09isec =3D inode_security(inode);
-=09if (sid =3D=3D fsec->sid && fsec->isid =3D=3D isec->sid &&
+=09if (current_sid() =3D=3D fsec->sid && fsec->isid =3D=3D isec->sid &&
 =09    fsec->pseqno =3D=3D avc_policy_seqno(&selinux_state))
 =09=09/* No change since file_open check. */
 =09=09return 0;
@@ -3554,6 +3738,9 @@ static int selinux_file_permission(struct file *file,=
 int mask)
=20
 static int selinux_file_alloc_security(struct file *file)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return file_alloc_security(file);
 }
=20
@@ -3606,6 +3793,9 @@ static int selinux_file_ioctl(struct file *file, unsi=
gned int cmd,
 =09const struct cred *cred =3D current_cred();
 =09int error =3D 0;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09switch (cmd) {
 =09case FIONREAD:
 =09/* fall through */
@@ -3692,6 +3882,9 @@ static int selinux_mmap_addr(unsigned long addr)
 {
 =09int rc =3D 0;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (addr < CONFIG_LSM_MMAP_MIN_ADDR) {
 =09=09u32 sid =3D current_sid();
 =09=09rc =3D avc_has_perm(&selinux_state,
@@ -3708,6 +3901,9 @@ static int selinux_mmap_file(struct file *file, unsig=
ned long reqprot,
 =09struct common_audit_data ad;
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (file) {
 =09=09ad.type =3D LSM_AUDIT_DATA_FILE;
 =09=09ad.u.file =3D file;
@@ -3729,7 +3925,12 @@ static int selinux_file_mprotect(struct vm_area_stru=
ct *vma,
 =09=09=09=09 unsigned long prot)
 {
 =09const struct cred *cred =3D current_cred();
-=09u32 sid =3D cred_sid(cred);
+=09u32 sid;
+
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
+=09sid =3D cred_sid(cred);
=20
 =09if (selinux_state.checkreqprot)
 =09=09prot =3D reqprot;
@@ -3768,9 +3969,10 @@ static int selinux_file_mprotect(struct vm_area_stru=
ct *vma,
=20
 static int selinux_file_lock(struct file *file, unsigned int cmd)
 {
-=09const struct cred *cred =3D current_cred();
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
=20
-=09return file_has_perm(cred, file, FILE__LOCK);
+=09return file_has_perm(current_cred(), file, FILE__LOCK);
 }
=20
 static int selinux_file_fcntl(struct file *file, unsigned int cmd,
@@ -3779,6 +3981,9 @@ static int selinux_file_fcntl(struct file *file, unsi=
gned int cmd,
 =09const struct cred *cred =3D current_cred();
 =09int err =3D 0;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09switch (cmd) {
 =09case F_SETFL:
 =09=09if ((file->f_flags & O_APPEND) && !(arg & O_APPEND)) {
@@ -3817,6 +4022,9 @@ static void selinux_file_set_fowner(struct file *file=
)
 {
 =09struct file_security_struct *fsec;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09fsec =3D selinux_file(file);
 =09fsec->fown_sid =3D current_sid();
 }
@@ -3825,10 +4033,12 @@ static int selinux_file_send_sigiotask(struct task_=
struct *tsk,
 =09=09=09=09       struct fown_struct *fown, int signum)
 {
 =09struct file *file;
-=09u32 sid =3D task_sid(tsk);
 =09u32 perm;
 =09struct file_security_struct *fsec;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09/* struct fown_struct is never outside the context of a struct file */
 =09file =3D container_of(fown, struct file, f_owner);
=20
@@ -3840,15 +4050,16 @@ static int selinux_file_send_sigiotask(struct task_=
struct *tsk,
 =09=09perm =3D signal_to_av(signum);
=20
 =09return avc_has_perm(&selinux_state,
-=09=09=09    fsec->fown_sid, sid,
+=09=09=09    fsec->fown_sid, task_sid(tsk),
 =09=09=09    SECCLASS_PROCESS, perm, NULL);
 }
=20
 static int selinux_file_receive(struct file *file)
 {
-=09const struct cred *cred =3D current_cred();
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
=20
-=09return file_has_perm(cred, file, file_to_av(file));
+=09return file_has_perm(current_cred(), file, file_to_av(file));
 }
=20
 static int selinux_file_open(struct file *file)
@@ -3856,6 +4067,9 @@ static int selinux_file_open(struct file *file)
 =09struct file_security_struct *fsec;
 =09struct inode_security_struct *isec;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09fsec =3D selinux_file(file);
 =09isec =3D inode_security(file_inode(file));
 =09/*
@@ -3883,7 +4097,12 @@ static int selinux_file_open(struct file *file)
 static int selinux_task_alloc(struct task_struct *task,
 =09=09=09      unsigned long clone_flags)
 {
-=09u32 sid =3D current_sid();
+=09u32 sid;
+
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
+=09sid =3D current_sid();
=20
 =09return avc_has_perm(&selinux_state,
 =09=09=09    sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
@@ -3898,6 +4117,9 @@ static int selinux_cred_prepare(struct cred *new, con=
st struct cred *old,
 =09const struct task_security_struct *old_tsec =3D selinux_cred(old);
 =09struct task_security_struct *tsec =3D selinux_cred(new);
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09*tsec =3D *old_tsec;
 =09return 0;
 }
@@ -3910,11 +4132,17 @@ static void selinux_cred_transfer(struct cred *new,=
 const struct cred *old)
 =09const struct task_security_struct *old_tsec =3D selinux_cred(old);
 =09struct task_security_struct *tsec =3D selinux_cred(new);
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09*tsec =3D *old_tsec;
 }
=20
 static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09*secid =3D cred_sid(c);
 }
=20
@@ -3925,11 +4153,13 @@ static void selinux_cred_getsecid(const struct cred=
 *c, u32 *secid)
 static int selinux_kernel_act_as(struct cred *new, u32 secid)
 {
 =09struct task_security_struct *tsec =3D selinux_cred(new);
-=09u32 sid =3D current_sid();
 =09int ret;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09ret =3D avc_has_perm(&selinux_state,
-=09=09=09   sid, secid,
+=09=09=09   current_sid(), secid,
 =09=09=09   SECCLASS_KERNEL_SERVICE,
 =09=09=09   KERNEL_SERVICE__USE_AS_OVERRIDE,
 =09=09=09   NULL);
@@ -3950,11 +4180,13 @@ static int selinux_kernel_create_files_as(struct cr=
ed *new, struct inode *inode)
 {
 =09struct inode_security_struct *isec =3D inode_security(inode);
 =09struct task_security_struct *tsec =3D selinux_cred(new);
-=09u32 sid =3D current_sid();
 =09int ret;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09ret =3D avc_has_perm(&selinux_state,
-=09=09=09   sid, isec->sid,
+=09=09=09   current_sid(), isec->sid,
 =09=09=09   SECCLASS_KERNEL_SERVICE,
 =09=09=09   KERNEL_SERVICE__CREATE_FILES_AS,
 =09=09=09   NULL);
@@ -3968,6 +4200,9 @@ static int selinux_kernel_module_request(char *kmod_n=
ame)
 {
 =09struct common_audit_data ad;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09ad.type =3D LSM_AUDIT_DATA_KMOD;
 =09ad.u.kmod_name =3D kmod_name;
=20
@@ -4012,35 +4247,37 @@ static int selinux_kernel_module_from_file(struct f=
ile *file)
 static int selinux_kernel_read_file(struct file *file,
 =09=09=09=09    enum kernel_read_file_id id)
 {
-=09int rc =3D 0;
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
=20
 =09switch (id) {
 =09case READING_MODULE:
-=09=09rc =3D selinux_kernel_module_from_file(file);
-=09=09break;
+=09=09return selinux_kernel_module_from_file(file);
 =09default:
 =09=09break;
 =09}
-
-=09return rc;
+=09return 0;
 }
=20
 static int selinux_kernel_load_data(enum kernel_load_data_id id)
 {
-=09int rc =3D 0;
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
=20
 =09switch (id) {
 =09case LOADING_MODULE:
-=09=09rc =3D selinux_kernel_module_from_file(NULL);
+=09=09return selinux_kernel_module_from_file(NULL);
 =09default:
 =09=09break;
 =09}
-
-=09return rc;
+=09return 0;
 }
=20
 static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return avc_has_perm(&selinux_state,
 =09=09=09    current_sid(), task_sid(p), SECCLASS_PROCESS,
 =09=09=09    PROCESS__SETPGID, NULL);
@@ -4048,6 +4285,9 @@ static int selinux_task_setpgid(struct task_struct *p=
, pid_t pgid)
=20
 static int selinux_task_getpgid(struct task_struct *p)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return avc_has_perm(&selinux_state,
 =09=09=09    current_sid(), task_sid(p), SECCLASS_PROCESS,
 =09=09=09    PROCESS__GETPGID, NULL);
@@ -4055,6 +4295,9 @@ static int selinux_task_getpgid(struct task_struct *p=
)
=20
 static int selinux_task_getsid(struct task_struct *p)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return avc_has_perm(&selinux_state,
 =09=09=09    current_sid(), task_sid(p), SECCLASS_PROCESS,
 =09=09=09    PROCESS__GETSESSION, NULL);
@@ -4062,11 +4305,17 @@ static int selinux_task_getsid(struct task_struct *=
p)
=20
 static void selinux_task_getsecid(struct task_struct *p, u32 *secid)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09*secid =3D task_sid(p);
 }
=20
 static int selinux_task_setnice(struct task_struct *p, int nice)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return avc_has_perm(&selinux_state,
 =09=09=09    current_sid(), task_sid(p), SECCLASS_PROCESS,
 =09=09=09    PROCESS__SETSCHED, NULL);
@@ -4074,6 +4323,9 @@ static int selinux_task_setnice(struct task_struct *p=
, int nice)
=20
 static int selinux_task_setioprio(struct task_struct *p, int ioprio)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return avc_has_perm(&selinux_state,
 =09=09=09    current_sid(), task_sid(p), SECCLASS_PROCESS,
 =09=09=09    PROCESS__SETSCHED, NULL);
@@ -4081,6 +4333,9 @@ static int selinux_task_setioprio(struct task_struct =
*p, int ioprio)
=20
 static int selinux_task_getioprio(struct task_struct *p)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return avc_has_perm(&selinux_state,
 =09=09=09    current_sid(), task_sid(p), SECCLASS_PROCESS,
 =09=09=09    PROCESS__GETSCHED, NULL);
@@ -4091,6 +4346,9 @@ static int selinux_task_prlimit(const struct cred *cr=
ed, const struct cred *tcre
 {
 =09u32 av =3D 0;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (!flags)
 =09=09return 0;
 =09if (flags & LSM_PRLIMIT_WRITE)
@@ -4107,6 +4365,9 @@ static int selinux_task_setrlimit(struct task_struct =
*p, unsigned int resource,
 {
 =09struct rlimit *old_rlim =3D p->signal->rlim + resource;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09/* Control the ability to change the hard limit (whether
 =09   lowering or raising it), so that the hard limit can
 =09   later be used as a safe reset point for the soft limit
@@ -4121,6 +4382,9 @@ static int selinux_task_setrlimit(struct task_struct =
*p, unsigned int resource,
=20
 static int selinux_task_setscheduler(struct task_struct *p)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return avc_has_perm(&selinux_state,
 =09=09=09    current_sid(), task_sid(p), SECCLASS_PROCESS,
 =09=09=09    PROCESS__SETSCHED, NULL);
@@ -4128,6 +4392,9 @@ static int selinux_task_setscheduler(struct task_stru=
ct *p)
=20
 static int selinux_task_getscheduler(struct task_struct *p)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return avc_has_perm(&selinux_state,
 =09=09=09    current_sid(), task_sid(p), SECCLASS_PROCESS,
 =09=09=09    PROCESS__GETSCHED, NULL);
@@ -4135,6 +4402,9 @@ static int selinux_task_getscheduler(struct task_stru=
ct *p)
=20
 static int selinux_task_movememory(struct task_struct *p)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return avc_has_perm(&selinux_state,
 =09=09=09    current_sid(), task_sid(p), SECCLASS_PROCESS,
 =09=09=09    PROCESS__SETSCHED, NULL);
@@ -4146,6 +4416,9 @@ static int selinux_task_kill(struct task_struct *p, s=
truct kernel_siginfo *info,
 =09u32 secid;
 =09u32 perm;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (!sig)
 =09=09perm =3D PROCESS__SIGNULL; /* null signal; existence test */
 =09else
@@ -4162,11 +4435,13 @@ static void selinux_task_to_inode(struct task_struc=
t *p,
 =09=09=09=09  struct inode *inode)
 {
 =09struct inode_security_struct *isec =3D selinux_inode(inode);
-=09u32 sid =3D task_sid(p);
+
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
=20
 =09spin_lock(&isec->lock);
 =09isec->sclass =3D inode_mode_to_security_class(inode->i_mode);
-=09isec->sid =3D sid;
+=09isec->sid =3D task_sid(p);
 =09isec->initialized =3D LABEL_INITIALIZED;
 =09spin_unlock(&isec->lock);
 }
@@ -4506,6 +4781,9 @@ static int selinux_socket_create(int family, int type=
,
 =09if (kern)
 =09=09return 0;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09secclass =3D socket_type_to_security_class(family, type, protocol);
 =09rc =3D socket_sockcreate_sid(tsec, secclass, &newsid);
 =09if (rc)
@@ -4525,6 +4803,9 @@ static int selinux_socket_post_create(struct socket *=
sock, int family,
 =09u32 sid =3D SECINITSID_KERNEL;
 =09int err =3D 0;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (!kern) {
 =09=09err =3D socket_sockcreate_sid(tsec, sclass, &sid);
 =09=09if (err)
@@ -4555,6 +4836,9 @@ static int selinux_socket_socketpair(struct socket *s=
ocka,
 =09struct sk_security_struct *sksec_a =3D socka->sk->sk_security;
 =09struct sk_security_struct *sksec_b =3D sockb->sk->sk_security;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09sksec_a->peer_sid =3D sksec_b->sid;
 =09sksec_b->peer_sid =3D sksec_a->sid;
=20
@@ -4572,6 +4856,9 @@ static int selinux_socket_bind(struct socket *sock, s=
truct sockaddr *address, in
 =09u16 family;
 =09int err;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09err =3D sock_has_perm(sk, SOCKET__BIND);
 =09if (err)
 =09=09goto out;
@@ -4796,6 +5083,9 @@ static int selinux_socket_connect(struct socket *sock=
,
 =09int err;
 =09struct sock *sk =3D sock->sk;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09err =3D selinux_socket_connect_helper(sock, address, addrlen);
 =09if (err)
 =09=09return err;
@@ -4805,6 +5095,9 @@ static int selinux_socket_connect(struct socket *sock=
,
=20
 static int selinux_socket_listen(struct socket *sock, int backlog)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return sock_has_perm(sock->sk, SOCKET__LISTEN);
 }
=20
@@ -4816,6 +5109,9 @@ static int selinux_socket_accept(struct socket *sock,=
 struct socket *newsock)
 =09u16 sclass;
 =09u32 sid;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09err =3D sock_has_perm(sock->sk, SOCKET__ACCEPT);
 =09if (err)
 =09=09return err;
@@ -4837,22 +5133,34 @@ static int selinux_socket_accept(struct socket *soc=
k, struct socket *newsock)
 static int selinux_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 =09=09=09=09  int size)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return sock_has_perm(sock->sk, SOCKET__WRITE);
 }
=20
 static int selinux_socket_recvmsg(struct socket *sock, struct msghdr *msg,
 =09=09=09=09  int size, int flags)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return sock_has_perm(sock->sk, SOCKET__READ);
 }
=20
 static int selinux_socket_getsockname(struct socket *sock)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return sock_has_perm(sock->sk, SOCKET__GETATTR);
 }
=20
 static int selinux_socket_getpeername(struct socket *sock)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return sock_has_perm(sock->sk, SOCKET__GETATTR);
 }
=20
@@ -4860,6 +5168,9 @@ static int selinux_socket_setsockopt(struct socket *s=
ock, int level, int optname
 {
 =09int err;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09err =3D sock_has_perm(sock->sk, SOCKET__SETOPT);
 =09if (err)
 =09=09return err;
@@ -4870,11 +5181,17 @@ static int selinux_socket_setsockopt(struct socket =
*sock, int level, int optname
 static int selinux_socket_getsockopt(struct socket *sock, int level,
 =09=09=09=09     int optname)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return sock_has_perm(sock->sk, SOCKET__GETOPT);
 }
=20
 static int selinux_socket_shutdown(struct socket *sock, int how)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return sock_has_perm(sock->sk, SOCKET__SHUTDOWN);
 }
=20
@@ -4889,6 +5206,9 @@ static int selinux_socket_unix_stream_connect(struct =
sock *sock,
 =09struct lsm_network_audit net =3D {0,};
 =09int err;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09ad.type =3D LSM_AUDIT_DATA_NET;
 =09ad.u.net =3D &net;
 =09ad.u.net->sk =3D other;
@@ -4921,6 +5241,9 @@ static int selinux_socket_unix_may_send(struct socket=
 *sock,
 =09struct common_audit_data ad;
 =09struct lsm_network_audit net =3D {0,};
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09ad.type =3D LSM_AUDIT_DATA_NET;
 =09ad.u.net =3D &net;
 =09ad.u.net->sk =3D other->sk;
@@ -4994,13 +5317,15 @@ static int selinux_socket_sock_rcv_skb(struct sock =
*sk, struct sk_buff *skb)
 =09int err;
 =09struct sk_security_struct *sksec =3D sk->sk_security;
 =09u16 family =3D sk->sk_family;
-=09u32 sk_sid =3D sksec->sid;
 =09struct common_audit_data ad;
 =09struct lsm_network_audit net =3D {0,};
 =09char *addrp;
 =09u8 secmark_active;
 =09u8 peerlbl_active;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (family !=3D PF_INET && family !=3D PF_INET6)
 =09=09return 0;
=20
@@ -5041,7 +5366,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *s=
k, struct sk_buff *skb)
 =09=09=09return err;
 =09=09}
 =09=09err =3D avc_has_perm(&selinux_state,
-=09=09=09=09   sk_sid, peer_sid, SECCLASS_PEER,
+=09=09=09=09   sksec->sid, peer_sid, SECCLASS_PEER,
 =09=09=09=09   PEER__RECV, &ad);
 =09=09if (err) {
 =09=09=09selinux_netlbl_err(skb, family, err, 0);
@@ -5051,7 +5376,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *s=
k, struct sk_buff *skb)
=20
 =09if (secmark_active) {
 =09=09err =3D avc_has_perm(&selinux_state,
-=09=09=09=09   sk_sid, skb->secmark, SECCLASS_PACKET,
+=09=09=09=09   sksec->sid, skb->secmark, SECCLASS_PACKET,
 =09=09=09=09   PACKET__RECV, &ad);
 =09=09if (err)
 =09=09=09return err;
@@ -5069,6 +5394,9 @@ static int selinux_socket_getpeersec_stream(struct so=
cket *sock, char __user *op
 =09struct sk_security_struct *sksec =3D sock->sk->sk_security;
 =09u32 peer_sid =3D SECSID_NULL;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (sksec->sclass =3D=3D SECCLASS_UNIX_STREAM_SOCKET ||
 =09    sksec->sclass =3D=3D SECCLASS_TCP_SOCKET ||
 =09    sksec->sclass =3D=3D SECCLASS_SCTP_SOCKET)
@@ -5102,6 +5430,9 @@ static int selinux_socket_getpeersec_dgram(struct soc=
ket *sock, struct sk_buff *
 =09u16 family;
 =09struct inode_security_struct *isec;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (skb && skb->protocol =3D=3D htons(ETH_P_IP))
 =09=09family =3D PF_INET;
 =09else if (skb && skb->protocol =3D=3D htons(ETH_P_IPV6))
@@ -5128,6 +5459,9 @@ static int selinux_sk_alloc_security(struct sock *sk,=
 int family, gfp_t priority
 {
 =09struct sk_security_struct *sksec;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09sksec =3D kzalloc(sizeof(*sksec), priority);
 =09if (!sksec)
 =09=09return -ENOMEM;
@@ -5145,6 +5479,9 @@ static void selinux_sk_free_security(struct sock *sk)
 {
 =09struct sk_security_struct *sksec =3D sk->sk_security;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09sk->sk_security =3D NULL;
 =09selinux_netlbl_sk_security_free(sksec);
 =09kfree(sksec);
@@ -5155,6 +5492,9 @@ static void selinux_sk_clone_security(const struct so=
ck *sk, struct sock *newsk)
 =09struct sk_security_struct *sksec =3D sk->sk_security;
 =09struct sk_security_struct *newsksec =3D newsk->sk_security;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09newsksec->sid =3D sksec->sid;
 =09newsksec->peer_sid =3D sksec->peer_sid;
 =09newsksec->sclass =3D sksec->sclass;
@@ -5164,6 +5504,9 @@ static void selinux_sk_clone_security(const struct so=
ck *sk, struct sock *newsk)
=20
 static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09if (!sk)
 =09=09*secid =3D SECINITSID_ANY_SOCKET;
 =09else {
@@ -5175,10 +5518,14 @@ static void selinux_sk_getsecid(struct sock *sk, u3=
2 *secid)
=20
 static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 {
-=09struct inode_security_struct *isec =3D
-=09=09inode_security_novalidate(SOCK_INODE(parent));
+=09struct inode_security_struct *isec;
 =09struct sk_security_struct *sksec =3D sk->sk_security;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
+=09isec =3D inode_security_novalidate(SOCK_INODE(parent));
+
 =09if (sk->sk_family =3D=3D PF_INET || sk->sk_family =3D=3D PF_INET6 ||
 =09    sk->sk_family =3D=3D PF_UNIX)
 =09=09isec->sid =3D sksec->sid;
@@ -5200,6 +5547,9 @@ static int selinux_sctp_assoc_request(struct sctp_end=
point *ep,
 =09u32 conn_sid;
 =09int err =3D 0;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (!selinux_policycap_extsockclass())
 =09=09return 0;
=20
@@ -5270,6 +5620,9 @@ static int selinux_sctp_bind_connect(struct sock *sk,=
 int optname,
 =09struct sockaddr *addr;
 =09struct socket *sock;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (!selinux_policycap_extsockclass())
 =09=09return 0;
=20
@@ -5346,6 +5699,9 @@ static void selinux_sctp_sk_clone(struct sctp_endpoin=
t *ep, struct sock *sk,
 =09struct sk_security_struct *sksec =3D sk->sk_security;
 =09struct sk_security_struct *newsksec =3D newsk->sk_security;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09/* If policy does not support SECCLASS_SCTP_SOCKET then call
 =09 * the non-sctp clone version.
 =09 */
@@ -5367,6 +5723,9 @@ static int selinux_inet_conn_request(struct sock *sk,=
 struct sk_buff *skb,
 =09u32 connsid;
 =09u32 peersid;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09err =3D selinux_skb_peerlbl_sid(skb, family, &peersid);
 =09if (err)
 =09=09return err;
@@ -5384,6 +5743,9 @@ static void selinux_inet_csk_clone(struct sock *newsk=
,
 {
 =09struct sk_security_struct *newsksec =3D newsk->sk_security;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09newsksec->sid =3D req->secid;
 =09newsksec->peer_sid =3D req->peer_secid;
 =09/* NOTE: Ideally, we should also get the isec->sid for the
@@ -5401,6 +5763,9 @@ static void selinux_inet_conn_established(struct sock=
 *sk, struct sk_buff *skb)
 =09u16 family =3D sk->sk_family;
 =09struct sk_security_struct *sksec =3D sk->sk_security;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09/* handle mapped IPv4 packets arriving via IPv6 sockets */
 =09if (family =3D=3D PF_INET6 && skb->protocol =3D=3D htons(ETH_P_IP))
 =09=09family =3D PF_INET;
@@ -5413,6 +5778,9 @@ static int selinux_secmark_relabel_packet(u32 sid)
 =09const struct task_security_struct *__tsec;
 =09u32 tsid;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09__tsec =3D selinux_cred(current_cred());
 =09tsid =3D __tsec->sid;
=20
@@ -5423,17 +5791,26 @@ static int selinux_secmark_relabel_packet(u32 sid)
=20
 static void selinux_secmark_refcount_inc(void)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09atomic_inc(&selinux_secmark_refcount);
 }
=20
 static void selinux_secmark_refcount_dec(void)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09atomic_dec(&selinux_secmark_refcount);
 }
=20
 static void selinux_req_classify_flow(const struct request_sock *req,
 =09=09=09=09      struct flowi *fl)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09fl->flowi_secid =3D req->secid;
 }
=20
@@ -5441,6 +5818,9 @@ static int selinux_tun_dev_alloc_security(void **secu=
rity)
 {
 =09struct tun_security_struct *tunsec;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09tunsec =3D kzalloc(sizeof(*tunsec), GFP_KERNEL);
 =09if (!tunsec)
 =09=09return -ENOMEM;
@@ -5452,12 +5832,20 @@ static int selinux_tun_dev_alloc_security(void **se=
curity)
=20
 static void selinux_tun_dev_free_security(void *security)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09kfree(security);
 }
=20
 static int selinux_tun_dev_create(void)
 {
-=09u32 sid =3D current_sid();
+=09u32 sid;
+
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
+=09sid =3D current_sid();
=20
 =09/* we aren't taking into account the "sockcreate" SID since the socket
 =09 * that is being created here is not a socket in the traditional sense,
@@ -5475,6 +5863,9 @@ static int selinux_tun_dev_attach_queue(void *securit=
y)
 {
 =09struct tun_security_struct *tunsec =3D security;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return avc_has_perm(&selinux_state,
 =09=09=09    current_sid(), tunsec->sid, SECCLASS_TUN_SOCKET,
 =09=09=09    TUN_SOCKET__ATTACH_QUEUE, NULL);
@@ -5485,6 +5876,9 @@ static int selinux_tun_dev_attach(struct sock *sk, vo=
id *security)
 =09struct tun_security_struct *tunsec =3D security;
 =09struct sk_security_struct *sksec =3D sk->sk_security;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09/* we don't currently perform any NetLabel based labeling here and it
 =09 * isn't clear that we would want to do so anyway; while we could apply
 =09 * labeling without the support of the TUN user the resulting labeled
@@ -5501,8 +5895,13 @@ static int selinux_tun_dev_attach(struct sock *sk, v=
oid *security)
 static int selinux_tun_dev_open(void *security)
 {
 =09struct tun_security_struct *tunsec =3D security;
-=09u32 sid =3D current_sid();
 =09int err;
+=09u32 sid;
+
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
+=09sid =3D current_sid();
=20
 =09err =3D avc_has_perm(&selinux_state,
 =09=09=09   sid, tunsec->sid, SECCLASS_TUN_SOCKET,
@@ -5885,6 +6284,9 @@ static unsigned int selinux_ipv6_postroute(void *priv=
,
=20
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return selinux_nlmsg_perm(sk, skb);
 }
=20
@@ -5922,6 +6324,9 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_per=
ms,
=20
 static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return msg_msg_alloc_security(msg);
 }
=20
@@ -5930,9 +6335,11 @@ static int selinux_msg_queue_alloc_security(struct k=
ern_ipc_perm *msq)
 {
 =09struct ipc_security_struct *isec;
 =09struct common_audit_data ad;
-=09u32 sid =3D current_sid();
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09isec =3D selinux_ipc(msq);
 =09ipc_init_security(isec, SECCLASS_MSGQ);
=20
@@ -5940,7 +6347,7 @@ static int selinux_msg_queue_alloc_security(struct ke=
rn_ipc_perm *msq)
 =09ad.u.ipc_id =3D msq->key;
=20
 =09rc =3D avc_has_perm(&selinux_state,
-=09=09=09  sid, isec->sid, SECCLASS_MSGQ,
+=09=09=09  current_sid(), isec->sid, SECCLASS_MSGQ,
 =09=09=09  MSGQ__CREATE, &ad);
 =09return rc;
 }
@@ -5949,7 +6356,9 @@ static int selinux_msg_queue_associate(struct kern_ip=
c_perm *msq, int msqflg)
 {
 =09struct ipc_security_struct *isec;
 =09struct common_audit_data ad;
-=09u32 sid =3D current_sid();
+
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
=20
 =09isec =3D selinux_ipc(msq);
=20
@@ -5957,7 +6366,7 @@ static int selinux_msg_queue_associate(struct kern_ip=
c_perm *msq, int msqflg)
 =09ad.u.ipc_id =3D msq->key;
=20
 =09return avc_has_perm(&selinux_state,
-=09=09=09    sid, isec->sid, SECCLASS_MSGQ,
+=09=09=09    current_sid(), isec->sid, SECCLASS_MSGQ,
 =09=09=09    MSGQ__ASSOCIATE, &ad);
 }
=20
@@ -5966,6 +6375,9 @@ static int selinux_msg_queue_msgctl(struct kern_ipc_p=
erm *msq, int cmd)
 =09int err;
 =09int perms;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09switch (cmd) {
 =09case IPC_INFO:
 =09case MSG_INFO:
@@ -5997,9 +6409,14 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_=
perm *msq, struct msg_msg *m
 =09struct ipc_security_struct *isec;
 =09struct msg_security_struct *msec;
 =09struct common_audit_data ad;
-=09u32 sid =3D current_sid();
+=09u32 sid;
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
+=09sid =3D current_sid();
+
 =09isec =3D selinux_ipc(msq);
 =09msec =3D selinux_msg_msg(msg);
=20
@@ -6045,9 +6462,14 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_=
perm *msq, struct msg_msg *m
 =09struct ipc_security_struct *isec;
 =09struct msg_security_struct *msec;
 =09struct common_audit_data ad;
-=09u32 sid =3D task_sid(target);
+=09u32 sid;
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
+=09sid =3D task_sid(target);
+
 =09isec =3D selinux_ipc(msq);
 =09msec =3D selinux_msg_msg(msg);
=20
@@ -6069,9 +6491,11 @@ static int selinux_shm_alloc_security(struct kern_ip=
c_perm *shp)
 {
 =09struct ipc_security_struct *isec;
 =09struct common_audit_data ad;
-=09u32 sid =3D current_sid();
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09isec =3D selinux_ipc(shp);
 =09ipc_init_security(isec, SECCLASS_SHM);
=20
@@ -6079,8 +6503,8 @@ static int selinux_shm_alloc_security(struct kern_ipc=
_perm *shp)
 =09ad.u.ipc_id =3D shp->key;
=20
 =09rc =3D avc_has_perm(&selinux_state,
-=09=09=09  sid, isec->sid, SECCLASS_SHM,
-=09=09=09  SHM__CREATE, &ad);
+=09=09=09  current_sid(), isec->sid,
+=09=09=09  SECCLASS_SHM, SHM__CREATE, &ad);
 =09return rc;
 }
=20
@@ -6088,7 +6512,9 @@ static int selinux_shm_associate(struct kern_ipc_perm=
 *shp, int shmflg)
 {
 =09struct ipc_security_struct *isec;
 =09struct common_audit_data ad;
-=09u32 sid =3D current_sid();
+
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
=20
 =09isec =3D selinux_ipc(shp);
=20
@@ -6096,8 +6522,8 @@ static int selinux_shm_associate(struct kern_ipc_perm=
 *shp, int shmflg)
 =09ad.u.ipc_id =3D shp->key;
=20
 =09return avc_has_perm(&selinux_state,
-=09=09=09    sid, isec->sid, SECCLASS_SHM,
-=09=09=09    SHM__ASSOCIATE, &ad);
+=09=09=09    current_sid(), isec->sid,
+=09=09=09    SECCLASS_SHM, SHM__ASSOCIATE, &ad);
 }
=20
 /* Note, at this point, shp is locked down */
@@ -6106,6 +6532,9 @@ static int selinux_shm_shmctl(struct kern_ipc_perm *s=
hp, int cmd)
 =09int perms;
 =09int err;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09switch (cmd) {
 =09case IPC_INFO:
 =09case SHM_INFO:
@@ -6141,6 +6570,9 @@ static int selinux_shm_shmat(struct kern_ipc_perm *sh=
p,
 {
 =09u32 perms;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (shmflg & SHM_RDONLY)
 =09=09perms =3D SHM__READ;
 =09else
@@ -6154,9 +6586,11 @@ static int selinux_sem_alloc_security(struct kern_ip=
c_perm *sma)
 {
 =09struct ipc_security_struct *isec;
 =09struct common_audit_data ad;
-=09u32 sid =3D current_sid();
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09isec =3D selinux_ipc(sma);
 =09ipc_init_security(isec, SECCLASS_SEM);
=20
@@ -6164,8 +6598,8 @@ static int selinux_sem_alloc_security(struct kern_ipc=
_perm *sma)
 =09ad.u.ipc_id =3D sma->key;
=20
 =09rc =3D avc_has_perm(&selinux_state,
-=09=09=09  sid, isec->sid, SECCLASS_SEM,
-=09=09=09  SEM__CREATE, &ad);
+=09=09=09  current_sid(), isec->sid,
+=09=09=09  SECCLASS_SEM, SEM__CREATE, &ad);
 =09return rc;
 }
=20
@@ -6173,7 +6607,9 @@ static int selinux_sem_associate(struct kern_ipc_perm=
 *sma, int semflg)
 {
 =09struct ipc_security_struct *isec;
 =09struct common_audit_data ad;
-=09u32 sid =3D current_sid();
+
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
=20
 =09isec =3D selinux_ipc(sma);
=20
@@ -6181,8 +6617,8 @@ static int selinux_sem_associate(struct kern_ipc_perm=
 *sma, int semflg)
 =09ad.u.ipc_id =3D sma->key;
=20
 =09return avc_has_perm(&selinux_state,
-=09=09=09    sid, isec->sid, SECCLASS_SEM,
-=09=09=09    SEM__ASSOCIATE, &ad);
+=09=09=09    current_sid(), isec->sid,
+=09=09=09    SECCLASS_SEM, SEM__ASSOCIATE, &ad);
 }
=20
 /* Note, at this point, sma is locked down */
@@ -6191,6 +6627,9 @@ static int selinux_sem_semctl(struct kern_ipc_perm *s=
ma, int cmd)
 =09int err;
 =09u32 perms;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09switch (cmd) {
 =09case IPC_INFO:
 =09case SEM_INFO:
@@ -6235,6 +6674,9 @@ static int selinux_sem_semop(struct kern_ipc_perm *sm=
a,
 {
 =09u32 perms;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (alter)
 =09=09perms =3D SEM__READ | SEM__WRITE;
 =09else
@@ -6247,7 +6689,9 @@ static int selinux_ipc_permission(struct kern_ipc_per=
m *ipcp, short flag)
 {
 =09u32 av =3D 0;
=20
-=09av =3D 0;
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (flag & S_IRUGO)
 =09=09av |=3D IPC__UNIX_READ;
 =09if (flag & S_IWUGO)
@@ -6261,12 +6705,17 @@ static int selinux_ipc_permission(struct kern_ipc_p=
erm *ipcp, short flag)
=20
 static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 {
-=09struct ipc_security_struct *isec =3D selinux_ipc(ipcp);
-=09*secid =3D isec->sid;
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
+=09*secid =3D selinux_ipc(ipcp)->sid;
 }
=20
 static void selinux_d_instantiate(struct dentry *dentry, struct inode *ino=
de)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09if (inode)
 =09=09inode_doinit_with_dentry(inode, dentry);
 }
@@ -6279,6 +6728,9 @@ static int selinux_getprocattr(struct task_struct *p,
 =09int error;
 =09unsigned len;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return -EINVAL;
+
 =09rcu_read_lock();
 =09__tsec =3D selinux_cred(__task_cred(p));
=20
@@ -6325,10 +6777,15 @@ static int selinux_setprocattr(const char *name, vo=
id *value, size_t size)
 {
 =09struct task_security_struct *tsec;
 =09struct cred *new;
-=09u32 mysid =3D current_sid(), sid =3D 0, ptsid;
+=09u32 mysid, sid =3D 0, ptsid;
 =09int error;
 =09char *str =3D value;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return -EINVAL;
+
+=09mysid =3D current_sid();
+
 =09/*
 =09 * Basic control over ability to set these attributes at all.
 =09 */
@@ -6466,17 +6923,26 @@ abort_change:
=20
 static int selinux_ismaclabel(const char *name)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return (strcmp(name, XATTR_SELINUX_SUFFIX) =3D=3D 0);
 }
=20
 static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return -EOPNOTSUPP;
+
 =09return security_sid_to_context(&selinux_state, secid,
 =09=09=09=09       secdata, seclen);
 }
=20
 static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *s=
ecid)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return security_context_to_sid(&selinux_state, secdata, seclen,
 =09=09=09=09       secid, GFP_KERNEL);
 }
@@ -6490,6 +6956,9 @@ static void selinux_inode_invalidate_secctx(struct in=
ode *inode)
 {
 =09struct inode_security_struct *isec =3D selinux_inode(inode);
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09spin_lock(&isec->lock);
 =09isec->initialized =3D LABEL_INVALID;
 =09spin_unlock(&isec->lock);
@@ -6511,6 +6980,9 @@ static int selinux_inode_notifysecctx(struct inode *i=
node, void *ctx, u32 ctxlen
  */
 static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 c=
txlen)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 0=
);
 }
=20
@@ -6532,6 +7004,9 @@ static int selinux_key_alloc(struct key *k, const str=
uct cred *cred,
 =09const struct task_security_struct *tsec;
 =09struct key_security_struct *ksec;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09ksec =3D kzalloc(sizeof(struct key_security_struct), GFP_KERNEL);
 =09if (!ksec)
 =09=09return -ENOMEM;
@@ -6550,6 +7025,9 @@ static void selinux_key_free(struct key *k)
 {
 =09struct key_security_struct *ksec =3D k->security;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09k->security =3D NULL;
 =09kfree(ksec);
 }
@@ -6568,6 +7046,9 @@ static int selinux_key_permission(key_ref_t key_ref,
 =09if (perm =3D=3D 0)
 =09=09return 0;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09sid =3D cred_sid(cred);
=20
 =09key =3D key_ref_to_ptr(key_ref);
@@ -6584,6 +7065,9 @@ static int selinux_key_getsecurity(struct key *key, c=
har **_buffer)
 =09unsigned len;
 =09int rc;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09rc =3D security_sid_to_context(&selinux_state, ksec->sid,
 =09=09=09=09     &context, &len);
 =09if (!rc)
@@ -6602,6 +7086,9 @@ static int selinux_ib_pkey_access(void *ib_sec, u64 s=
ubnet_prefix, u16 pkey_val)
 =09struct ib_security_struct *sec =3D ib_sec;
 =09struct lsm_ibpkey_audit ibpkey;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09err =3D sel_ib_pkey_sid(subnet_prefix, pkey_val, &sid);
 =09if (err)
 =09=09return err;
@@ -6625,6 +7112,9 @@ static int selinux_ib_endport_manage_subnet(void *ib_=
sec, const char *dev_name,
 =09struct ib_security_struct *sec =3D ib_sec;
 =09struct lsm_ibendport_audit ibendport;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09err =3D security_ib_endport_sid(&selinux_state, dev_name, port_num,
 =09=09=09=09      &sid);
=20
@@ -6645,6 +7135,9 @@ static int selinux_ib_alloc_security(void **ib_sec)
 {
 =09struct ib_security_struct *sec;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09sec =3D kzalloc(sizeof(*sec), GFP_KERNEL);
 =09if (!sec)
 =09=09return -ENOMEM;
@@ -6656,6 +7149,9 @@ static int selinux_ib_alloc_security(void **ib_sec)
=20
 static void selinux_ib_free_security(void *ib_sec)
 {
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09kfree(ib_sec);
 }
 #endif
@@ -6667,6 +7163,9 @@ static int selinux_bpf(int cmd, union bpf_attr *attr,
 =09u32 sid =3D current_sid();
 =09int ret;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09switch (cmd) {
 =09case BPF_MAP_CREATE:
 =09=09ret =3D avc_has_perm(&selinux_state,
@@ -6734,23 +7233,27 @@ static int bpf_fd_pass(struct file *file, u32 sid)
=20
 static int selinux_bpf_map(struct bpf_map *map, fmode_t fmode)
 {
-=09u32 sid =3D current_sid();
 =09struct bpf_security_struct *bpfsec;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09bpfsec =3D map->security;
 =09return avc_has_perm(&selinux_state,
-=09=09=09    sid, bpfsec->sid, SECCLASS_BPF,
+=09=09=09    current_sid(), bpfsec->sid, SECCLASS_BPF,
 =09=09=09    bpf_map_fmode_to_av(fmode), NULL);
 }
=20
 static int selinux_bpf_prog(struct bpf_prog *prog)
 {
-=09u32 sid =3D current_sid();
 =09struct bpf_security_struct *bpfsec;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09bpfsec =3D prog->aux->security;
 =09return avc_has_perm(&selinux_state,
-=09=09=09    sid, bpfsec->sid, SECCLASS_BPF,
+=09=09=09    current_sid(), bpfsec->sid, SECCLASS_BPF,
 =09=09=09    BPF__PROG_RUN, NULL);
 }
=20
@@ -6758,6 +7261,9 @@ static int selinux_bpf_map_alloc(struct bpf_map *map)
 {
 =09struct bpf_security_struct *bpfsec;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
 =09if (!bpfsec)
 =09=09return -ENOMEM;
@@ -6772,6 +7278,9 @@ static void selinux_bpf_map_free(struct bpf_map *map)
 {
 =09struct bpf_security_struct *bpfsec =3D map->security;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09map->security =3D NULL;
 =09kfree(bpfsec);
 }
@@ -6780,6 +7289,9 @@ static int selinux_bpf_prog_alloc(struct bpf_prog_aux=
 *aux)
 {
 =09struct bpf_security_struct *bpfsec;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
 =09if (!bpfsec)
 =09=09return -ENOMEM;
@@ -6794,6 +7306,9 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux=
 *aux)
 {
 =09struct bpf_security_struct *bpfsec =3D aux->security;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09aux->security =3D NULL;
 =09kfree(bpfsec);
 }
@@ -6802,11 +7317,14 @@ static void selinux_bpf_prog_free(struct bpf_prog_a=
ux *aux)
 static int selinux_lockdown(enum lockdown_reason what)
 {
 =09struct common_audit_data ad;
-=09u32 sid =3D current_sid();
+=09u32 sid;
 =09int invalid_reason =3D (what <=3D LOCKDOWN_NONE) ||
 =09=09=09     (what =3D=3D LOCKDOWN_INTEGRITY_MAX) ||
 =09=09=09     (what >=3D LOCKDOWN_CONFIDENTIALITY_MAX);
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09if (WARN(invalid_reason, "Invalid lockdown reason")) {
 =09=09audit_log(audit_context(),
 =09=09=09  GFP_ATOMIC, AUDIT_SELINUX_ERR,
@@ -6814,6 +7332,8 @@ static int selinux_lockdown(enum lockdown_reason what=
)
 =09=09return -EINVAL;
 =09}
=20
+=09sid =3D current_sid();
+
 =09ad.type =3D LSM_AUDIT_DATA_LOCKDOWN;
 =09ad.u.reason =3D what;
=20
@@ -6827,7 +7347,7 @@ static int selinux_lockdown(enum lockdown_reason what=
)
 =09=09=09=09    LOCKDOWN__CONFIDENTIALITY, &ad);
 }
=20
-struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init =3D {
+struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
 =09.lbs_cred =3D sizeof(struct task_security_struct),
 =09.lbs_file =3D sizeof(struct file_security_struct),
 =09.lbs_inode =3D sizeof(struct inode_security_struct),
@@ -6838,7 +7358,12 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_af=
ter_init =3D {
 #ifdef CONFIG_PERF_EVENTS
 static int selinux_perf_event_open(struct perf_event_attr *attr, int type)
 {
-=09u32 requested, sid =3D current_sid();
+=09u32 requested, sid;
+
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
+=09sid =3D current_sid();
=20
 =09if (type =3D=3D PERF_SECURITY_OPEN)
 =09=09requested =3D PERF_EVENT__OPEN;
@@ -6859,6 +7384,9 @@ static int selinux_perf_event_alloc(struct perf_event=
 *event)
 {
 =09struct perf_event_security_struct *perfsec;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
 =09perfsec =3D kzalloc(sizeof(*perfsec), GFP_KERNEL);
 =09if (!perfsec)
 =09=09return -ENOMEM;
@@ -6873,6 +7401,9 @@ static void selinux_perf_event_free(struct perf_event=
 *event)
 {
 =09struct perf_event_security_struct *perfsec =3D event->security;
=20
+=09if (selinux_disabled(&selinux_state))
+=09=09return;
+
 =09event->security =3D NULL;
 =09kfree(perfsec);
 }
@@ -6880,23 +7411,27 @@ static void selinux_perf_event_free(struct perf_eve=
nt *event)
 static int selinux_perf_event_read(struct perf_event *event)
 {
 =09struct perf_event_security_struct *perfsec =3D event->security;
-=09u32 sid =3D current_sid();
=20
-=09return avc_has_perm(&selinux_state, sid, perfsec->sid,
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
+=09return avc_has_perm(&selinux_state, current_sid(), perfsec->sid,
 =09=09=09    SECCLASS_PERF_EVENT, PERF_EVENT__READ, NULL);
 }
=20
 static int selinux_perf_event_write(struct perf_event *event)
 {
 =09struct perf_event_security_struct *perfsec =3D event->security;
-=09u32 sid =3D current_sid();
=20
-=09return avc_has_perm(&selinux_state, sid, perfsec->sid,
+=09if (selinux_disabled(&selinux_state))
+=09=09return 0;
+
+=09return avc_has_perm(&selinux_state, current_sid(), perfsec->sid,
 =09=09=09    SECCLASS_PERF_EVENT, PERF_EVENT__WRITE, NULL);
 }
 #endif
=20
-static struct security_hook_list selinux_hooks[] __lsm_ro_after_init =3D {
+static struct security_hook_list selinux_hooks[] __ro_after_init =3D {
 =09LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 =09LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
 =09LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
@@ -7315,18 +7850,19 @@ int selinux_disable(struct selinux_state *state)
 =09=09return -EINVAL;
 =09}
=20
+=09/*
+=09 * Unregister netfilter hooks (must be done before
+=09 * selinux_mark_disabled()).
+=09 */
+=09selinux_nf_ip_exit();
+
 =09selinux_mark_disabled(state);
=20
 =09pr_info("SELinux:  Disabled at runtime.\n");
=20
-=09security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
-
 =09/* Try to destroy the avc node cache */
 =09avc_disable();
=20
-=09/* Unregister netfilter hooks. */
-=09selinux_nf_ip_exit();
-
 =09/* Unregister selinuxfs. */
 =09exit_sel_fs();
=20
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ecea41ce919b..de50c69846e0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4583,7 +4583,7 @@ static int smack_dentry_create_files_as(struct dentry=
 *dentry, int mode,
 =09return 0;
 }
=20
-struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init =3D {
+struct lsm_blob_sizes smack_blob_sizes __ro_after_init =3D {
 =09.lbs_cred =3D sizeof(struct task_smack),
 =09.lbs_file =3D sizeof(struct smack_known *),
 =09.lbs_inode =3D sizeof(struct inode_smack),
@@ -4591,7 +4591,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after=
_init =3D {
 =09.lbs_msg_msg =3D sizeof(struct smack_known *),
 };
=20
-static struct security_hook_list smack_hooks[] __lsm_ro_after_init =3D {
+static struct security_hook_list smack_hooks[] __ro_after_init =3D {
 =09LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 =09LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
 =09LSM_HOOK_INIT(syslog, smack_syslog),
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 716c92ec941a..9dcdef99d431 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -486,7 +486,7 @@ static int tomoyo_socket_sendmsg(struct socket *sock, s=
truct msghdr *msg,
 =09return tomoyo_socket_sendmsg_permission(sock, msg, size);
 }
=20
-struct lsm_blob_sizes tomoyo_blob_sizes __lsm_ro_after_init =3D {
+struct lsm_blob_sizes tomoyo_blob_sizes __ro_after_init =3D {
 =09.lbs_task =3D sizeof(struct tomoyo_task),
 };
=20
@@ -533,7 +533,7 @@ static void tomoyo_task_free(struct task_struct *task)
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
  */
-static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init =3D {
+static struct security_hook_list tomoyo_hooks[] __ro_after_init =3D {
 =09LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
 =09LSM_HOOK_INIT(bprm_committed_creds, tomoyo_bprm_committed_creds),
 =09LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
@@ -569,7 +569,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_r=
o_after_init =3D {
 /* Lock for GC. */
 DEFINE_SRCU(tomoyo_ss);
=20
-int tomoyo_enabled __lsm_ro_after_init =3D 1;
+int tomoyo_enabled __ro_after_init =3D 1;
=20
 /**
  * tomoyo_init - Register TOMOYO Linux as a LSM module.
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 94dc346370b1..c47d4e09bfb4 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -421,7 +421,7 @@ static int yama_ptrace_traceme(struct task_struct *pare=
nt)
 =09return rc;
 }
=20
-static struct security_hook_list yama_hooks[] __lsm_ro_after_init =3D {
+static struct security_hook_list yama_hooks[] __ro_after_init =3D {
 =09LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 =09LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
 =09LSM_HOOK_INIT(task_prctl, yama_task_prctl),
--=20
2.24.1

