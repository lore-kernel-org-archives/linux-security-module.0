Return-Path: <SRS0=OCSC=24=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2006FC33C9B
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jan 2020 13:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46BC2081E
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jan 2020 13:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeARdueb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgAGNcD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:32:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21334 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728006AbgAGNcD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Jan 2020 08:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578403922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXFSFv9sP2eWEJtqa5bLdWL6gc/v7o86DJq633fzFzU=;
        b=eeARdueb5PciyIMSTpHlG6jkcpo+zVjg8v9H2YjlK+IxceOdaffoIIxJikWux8c3gUbt9W
        o0VOI7wDanekt2BIVX5pr5iNK4LV2MaUZJ6lEUVfSmvR2O0PNGvjepAF6D6UxMHEpIHHMq
        lbTXBkXZxJgMQ8GHU0MD1Xs1HrOpJtc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-oAiWpnT1MEis7N9kZanp-A-1; Tue, 07 Jan 2020 08:32:00 -0500
Received: by mail-wr1-f71.google.com with SMTP id u18so28584649wrn.11
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jan 2020 05:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qyaqqREnkpVhglZ516gFAkxLLNwR7BKT/czon5pgNjM=;
        b=kCrquzppIfEnJNlWQGvHc8sLQ+J71FU6bj0d/HnDjuZz7NY0cBhKZ2GLVBJCnFRARi
         VD1LGj66PUCkWF5SHucBgh9+rFFMRx6fcSlVxv7orgEQC/i7bzFJWUzIfEqRP+GKn7CN
         8LYDU+vf+TCRFo8i4eEBRc2jrkpO6La7Vectt0UlhObRWx6MQohxJaGNbn+VxZfHjWcv
         abY2NLcupOpS3Y5qHZ9Nz+ViA8PNIvzKgl+ZSy3bC43uoxuGeAdbDR2XuAzudkvobY+8
         qp4u14xwRwEyg2dmK1jc+IRlb8pepu9g93TBDDDyxvC+ia4VqbGjdU5UCMwK+d2ZVuKi
         2l+w==
X-Gm-Message-State: APjAAAXcq10P/ihUv3KYjcb+FyLxwkh3i9Sx4dQjlegHEKOcRgl6TJM8
        VilEHbClaVirwwlPJAju2pb9NuL8XKJ3Uz4/564NryEsTxROPSj/hIWuIHm9TBxCSzxLBYbBQ5v
        eOdxS99K042RYb0rZTe9W7p4gG6pnli2xkmeW
X-Received: by 2002:a7b:cbcd:: with SMTP id n13mr39916412wmi.104.1578403918941;
        Tue, 07 Jan 2020 05:31:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqxGDrhx9S7+S433gHy6DUA1BbyIzCh/vT9XirfjS+1A5A9CZ87irnpGvLqV9bd7Rtu3z88nZw==
X-Received: by 2002:a7b:cbcd:: with SMTP id n13mr39916362wmi.104.1578403918528;
        Tue, 07 Jan 2020 05:31:58 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f207sm29097127wme.9.2020.01.07.05.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:31:57 -0800 (PST)
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
Subject: [PATCH 1/2] selinux: treat atomic flags more carefully
Date:   Tue,  7 Jan 2020 14:31:53 +0100
Message-Id: <20200107133154.588958-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107133154.588958-1-omosnace@redhat.com>
References: <20200107133154.588958-1-omosnace@redhat.com>
MIME-Version: 1.0
X-MC-Unique: oAiWpnT1MEis7N9kZanp-A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The disabled/enforcing/initialized flags are all accessed concurrently
by threads so use the appropriate accessors that ensure atomicity and
document that it is expected.

Use smp_load/acquire...() helpers (with memory barriers) for the
initialized flag, since it gates access to the rest of the state
structures.

Note that the disabled flag is currently not used for anything other
than avoiding double disable, but it will be used for bailing out of
hooks once security_delete_hooks() is removed.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c            | 21 ++++++++--------
 security/selinux/include/security.h | 33 +++++++++++++++++++++++--
 security/selinux/ss/services.c      | 38 ++++++++++++++---------------
 3 files changed, 61 insertions(+), 31 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 659c4a81e897..47ad4db925cf 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -272,7 +272,7 @@ static int __inode_security_revalidate(struct inode *in=
ode,
=20
 =09might_sleep_if(may_sleep);
=20
-=09if (selinux_state.initialized &&
+=09if (selinux_initialized(&selinux_state) &&
 =09    isec->initialized !=3D LABEL_INITIALIZED) {
 =09=09if (!may_sleep)
 =09=09=09return -ECHILD;
@@ -659,7 +659,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
=20
 =09mutex_lock(&sbsec->lock);
=20
-=09if (!selinux_state.initialized) {
+=09if (!selinux_initialized(&selinux_state)) {
 =09=09if (!opts) {
 =09=09=09/* Defer initialization until selinux_complete_init,
 =09=09=09   after the initial policy is loaded and the security
@@ -928,7 +928,7 @@ static int selinux_sb_clone_mnt_opts(const struct super=
_block *oldsb,
 =09 * if the parent was able to be mounted it clearly had no special lsm
 =09 * mount options.  thus we can safely deal with this superblock later
 =09 */
-=09if (!selinux_state.initialized)
+=09if (!selinux_initialized(&selinux_state))
 =09=09return 0;
=20
 =09/*
@@ -1103,7 +1103,7 @@ static int selinux_sb_show_options(struct seq_file *m=
, struct super_block *sb)
 =09if (!(sbsec->flags & SE_SBINITIALIZED))
 =09=09return 0;
=20
-=09if (!selinux_state.initialized)
+=09if (!selinux_initialized(&selinux_state))
 =09=09return 0;
=20
 =09if (sbsec->flags & FSCONTEXT_MNT) {
@@ -2920,7 +2920,8 @@ static int selinux_inode_init_security(struct inode *=
inode, struct inode *dir,
 =09=09isec->initialized =3D LABEL_INITIALIZED;
 =09}
=20
-=09if (!selinux_state.initialized || !(sbsec->flags & SBLABEL_MNT))
+=09if (!selinux_initialized(&selinux_state) ||
+=09    !(sbsec->flags & SBLABEL_MNT))
 =09=09return -EOPNOTSUPP;
=20
 =09if (name)
@@ -3143,7 +3144,7 @@ static int selinux_inode_setxattr(struct dentry *dent=
ry, const char *name,
 =09=09return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
 =09}
=20
-=09if (!selinux_state.initialized)
+=09if (!selinux_initialized(&selinux_state))
 =09=09return (inode_owner_or_capable(inode) ? 0 : -EPERM);
=20
 =09sbsec =3D inode->i_sb->s_security;
@@ -3229,7 +3230,7 @@ static void selinux_inode_post_setxattr(struct dentry=
 *dentry, const char *name,
 =09=09return;
 =09}
=20
-=09if (!selinux_state.initialized) {
+=09if (!selinux_initialized(&selinux_state)) {
 =09=09/* If we haven't even been initialized, then we can't validate
 =09=09 * against a policy, so leave the label as invalid. It may
 =09=09 * resolve to a valid label on the next revalidation try if
@@ -7304,17 +7305,17 @@ static void selinux_nf_ip_exit(void)
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 int selinux_disable(struct selinux_state *state)
 {
-=09if (state->initialized) {
+=09if (selinux_initialized(state)) {
 =09=09/* Not permitted after initial policy load. */
 =09=09return -EINVAL;
 =09}
=20
-=09if (state->disabled) {
+=09if (selinux_disabled(state)) {
 =09=09/* Only do this once. */
 =09=09return -EINVAL;
 =09}
=20
-=09state->disabled =3D 1;
+=09selinux_mark_disabled(state);
=20
 =09pr_info("SELinux:  Disabled at runtime.\n");
=20
diff --git a/security/selinux/include/security.h b/security/selinux/include=
/security.h
index ecdd610e6449..a39f9565d80b 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -117,15 +117,27 @@ void selinux_avc_init(struct selinux_avc **avc);
=20
 extern struct selinux_state selinux_state;
=20
+static inline bool selinux_initialized(const struct selinux_state *state)
+{
+=09/* do a synchronized load to avoid race conditions */
+=09return smp_load_acquire(&state->initialized);
+}
+
+static inline void selinux_mark_initialized(struct selinux_state *state)
+{
+=09/* do a synchronized write to avoid race conditions */
+=09smp_store_release(&state->initialized, true);
+}
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 static inline bool enforcing_enabled(struct selinux_state *state)
 {
-=09return state->enforcing;
+=09return READ_ONCE(state->enforcing);
 }
=20
 static inline void enforcing_set(struct selinux_state *state, bool value)
 {
-=09state->enforcing =3D value;
+=09WRITE_ONCE(state->enforcing, value);
 }
 #else
 static inline bool enforcing_enabled(struct selinux_state *state)
@@ -138,6 +150,23 @@ static inline void enforcing_set(struct selinux_state =
*state, bool value)
 }
 #endif
=20
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+static inline bool selinux_disabled(struct selinux_state *state)
+{
+=09return READ_ONCE(state->disabled);
+}
+
+static inline void selinux_mark_disabled(struct selinux_state *state)
+{
+=09WRITE_ONCE(state->disabled, true);
+}
+#else
+static inline bool selinux_disabled(struct selinux_state *state)
+{
+=09return false;
+}
+#endif
+
 static inline bool selinux_policycap_netpeer(void)
 {
 =09struct selinux_state *state =3D &selinux_state;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.=
c
index 55cf42945cba..0e8b94e8e156 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -767,7 +767,7 @@ static int security_compute_validatetrans(struct selinu=
x_state *state,
 =09int rc =3D 0;
=20
=20
-=09if (!state->initialized)
+=09if (!selinux_initialized(state))
 =09=09return 0;
=20
 =09read_lock(&state->ss->policy_rwlock);
@@ -868,7 +868,7 @@ int security_bounded_transition(struct selinux_state *s=
tate,
 =09int index;
 =09int rc;
=20
-=09if (!state->initialized)
+=09if (!selinux_initialized(state))
 =09=09return 0;
=20
 =09read_lock(&state->ss->policy_rwlock);
@@ -1027,7 +1027,7 @@ void security_compute_xperms_decision(struct selinux_=
state *state,
 =09memset(xpermd->dontaudit->p, 0, sizeof(xpermd->dontaudit->p));
=20
 =09read_lock(&state->ss->policy_rwlock);
-=09if (!state->initialized)
+=09if (!selinux_initialized(state))
 =09=09goto allow;
=20
 =09policydb =3D &state->ss->policydb;
@@ -1112,7 +1112,7 @@ void security_compute_av(struct selinux_state *state,
 =09read_lock(&state->ss->policy_rwlock);
 =09avd_init(state, avd);
 =09xperms->len =3D 0;
-=09if (!state->initialized)
+=09if (!selinux_initialized(state))
 =09=09goto allow;
=20
 =09policydb =3D &state->ss->policydb;
@@ -1166,7 +1166,7 @@ void security_compute_av_user(struct selinux_state *s=
tate,
=20
 =09read_lock(&state->ss->policy_rwlock);
 =09avd_init(state, avd);
-=09if (!state->initialized)
+=09if (!selinux_initialized(state))
 =09=09goto allow;
=20
 =09policydb =3D &state->ss->policydb;
@@ -1286,7 +1286,7 @@ int security_sidtab_hash_stats(struct selinux_state *=
state, char *page)
 {
 =09int rc;
=20
-=09if (!state->initialized) {
+=09if (!selinux_initialized(state)) {
 =09=09pr_err("SELinux: %s:  called before initial load_policy\n",
 =09=09       __func__);
 =09=09return -EINVAL;
@@ -1320,7 +1320,7 @@ static int security_sid_to_context_core(struct selinu=
x_state *state,
 =09=09*scontext =3D NULL;
 =09*scontext_len  =3D 0;
=20
-=09if (!state->initialized) {
+=09if (!selinux_initialized(state)) {
 =09=09if (sid <=3D SECINITSID_NUM) {
 =09=09=09char *scontextp;
=20
@@ -1549,7 +1549,7 @@ static int security_context_to_sid_core(struct selinu=
x_state *state,
 =09if (!scontext2)
 =09=09return -ENOMEM;
=20
-=09if (!state->initialized) {
+=09if (!selinux_initialized(state)) {
 =09=09int i;
=20
 =09=09for (i =3D 1; i < SECINITSID_NUM; i++) {
@@ -1736,7 +1736,7 @@ static int security_compute_sid(struct selinux_state =
*state,
 =09int rc =3D 0;
 =09bool sock;
=20
-=09if (!state->initialized) {
+=09if (!selinux_initialized(state)) {
 =09=09switch (orig_tclass) {
 =09=09case SECCLASS_PROCESS: /* kernel value */
 =09=09=09*out_sid =3D ssid;
@@ -2198,7 +2198,7 @@ int security_load_policy(struct selinux_state *state,=
 void *data, size_t len)
 =09=09goto out;
 =09}
=20
-=09if (!state->initialized) {
+=09if (!selinux_initialized(state)) {
 =09=09rc =3D policydb_read(policydb, fp);
 =09=09if (rc) {
 =09=09=09kfree(newsidtab);
@@ -2223,7 +2223,7 @@ int security_load_policy(struct selinux_state *state,=
 void *data, size_t len)
=20
 =09=09state->ss->sidtab =3D newsidtab;
 =09=09security_load_policycaps(state);
-=09=09state->initialized =3D 1;
+=09=09selinux_mark_initialized(state);
 =09=09seqno =3D ++state->ss->latest_granting;
 =09=09selinux_complete_init();
 =09=09avc_ss_reset(state->avc, seqno);
@@ -2639,7 +2639,7 @@ int security_get_user_sids(struct selinux_state *stat=
e,
 =09*sids =3D NULL;
 =09*nel =3D 0;
=20
-=09if (!state->initialized)
+=09if (!selinux_initialized(state))
 =09=09goto out;
=20
 =09read_lock(&state->ss->policy_rwlock);
@@ -2875,7 +2875,7 @@ int security_get_bools(struct selinux_state *state,
 =09struct policydb *policydb;
 =09int i, rc;
=20
-=09if (!state->initialized) {
+=09if (!selinux_initialized(state)) {
 =09=09*len =3D 0;
 =09=09*names =3D NULL;
 =09=09*values =3D NULL;
@@ -3050,7 +3050,7 @@ int security_sid_mls_copy(struct selinux_state *state=
,
 =09int rc;
=20
 =09rc =3D 0;
-=09if (!state->initialized || !policydb->mls_enabled) {
+=09if (!selinux_initialized(state) || !policydb->mls_enabled) {
 =09=09*new_sid =3D sid;
 =09=09goto out;
 =09}
@@ -3217,7 +3217,7 @@ int security_get_classes(struct selinux_state *state,
 =09struct policydb *policydb =3D &state->ss->policydb;
 =09int rc;
=20
-=09if (!state->initialized) {
+=09if (!selinux_initialized(state)) {
 =09=09*nclasses =3D 0;
 =09=09*classes =3D NULL;
 =09=09return 0;
@@ -3366,7 +3366,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *=
rulestr, void **vrule)
=20
 =09*rule =3D NULL;
=20
-=09if (!state->initialized)
+=09if (!selinux_initialized(state))
 =09=09return -EOPNOTSUPP;
=20
 =09switch (field) {
@@ -3665,7 +3665,7 @@ int security_netlbl_secattr_to_sid(struct selinux_sta=
te *state,
 =09struct context *ctx;
 =09struct context ctx_new;
=20
-=09if (!state->initialized) {
+=09if (!selinux_initialized(state)) {
 =09=09*sid =3D SECSID_NULL;
 =09=09return 0;
 =09}
@@ -3732,7 +3732,7 @@ int security_netlbl_sid_to_secattr(struct selinux_sta=
te *state,
 =09int rc;
 =09struct context *ctx;
=20
-=09if (!state->initialized)
+=09if (!selinux_initialized(state))
 =09=09return 0;
=20
 =09read_lock(&state->ss->policy_rwlock);
@@ -3771,7 +3771,7 @@ int security_read_policy(struct selinux_state *state,
 =09int rc;
 =09struct policy_file fp;
=20
-=09if (!state->initialized)
+=09if (!selinux_initialized(state))
 =09=09return -EINVAL;
=20
 =09*len =3D security_policydb_len(state);
--=20
2.24.1

