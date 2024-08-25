Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A698C07
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724612561; cv=none; b=s1guMcHht6lmoE2Nux1w+iiRJ9TUTzrBrkPFC6gsPS9G1Nc4ALKuArggZCbzvad4RGnQ19l+GpCyhR0InTo7yrcGOGYQmA6yBOrcABta9PLIgYrRq4lEMLnsxYKz774R4EuzfD02ntvXwEWtxblFUh6HGpZaIDTIaWnAXGiZRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724612561; c=relaxed/simple;
	bh=9lz7Q4lfBcv8FOmmLMF7MG/JQ2alqql4oDj0tG8KuwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YG3oPHX3bHAcBl2xBsb1sypnfdsNEp0fG8TMJNIKI8RjkXZLEiYEeLHcHFnxmC8EppQdhQAxtL+96Sv5DH2XYHAK3lfvF2MMEnu5dN9ReuOjZgia8bsL42+Ok7CVed9oqttlsCemzFMtLU1QieTWFKJnxjl0YNXo3miDikWwh88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=e9lXxKgZ; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="e9lXxKgZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612553; bh=Qo8RS7tfulktRq4Jy9rhDoTvdOZ4eieDVbkNVBsAa9I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=e9lXxKgZb9JZGSiHvSd4Eg6KS+qRVP2jAFD4E4oW+lMqMNZoSYzbdcSDhuwfVtOiEsdZqDVHTVODUzwfqnn5s2SwqwC2LEm3RUkKA+rSilJ5Sdqizu/6Qk9DVdeZrspQDqJezLxlPVUFpx87khWrrlTc4pszmd6b/jdG1eeQ9FNX30IoLhydt3DSGMdgIvDZ9eJemTcnqCKb02VkeffG/Svmhsx+3tuaY7oObzbXA8pqD5lCUVGiqV6AhJbOeQQIl38Eo11UmFCgcctunXXzBMmJzQ1qCpsi6JFw5K3j8es2tUVOIQE59gLtegaMx7GgEdObQ4zDU0Vt0rKySDW1aw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612553; bh=nt8a0yYmRANq0fd72V/Sm1mzd19DMN9LUYRubXh/5oK=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=f++kNQwK9gNdVJHeuSkN9yxfjgvTrHxZwfDJhpkqSQhTpMc1d6nDmpU7ywsAItqArOrEd8pMGTdYIJ1oVdsdHmH/wetLLdJpaGWQ9fikL9NwmDyNq5HRMwzdEWsoYnMqZh080x0wMQOMpZH8/ZRkjmToj2qV/5vxbSQdFeEbvvxv5xfVEMcVc43dgD2LmeZjiDWJmErgTopS/Tgy3pl3E4QvEoia160TDImHrmVndZR4xxw4uZRMb3YYXyxjo3WTWdeP9F4gGctK4Z6Jc1urwLLk0cygFZuvf53fNvaG9zUajMZLtTl726WgSMT/Tit2oJD5DIJG7D1bP/FPpqcjrw==
X-YMail-OSG: cBn1UjgVM1kwixQsu4gAa1ONx6CtDRAdbnrbra0etnVXT_Yaj77OgO7ytohEjhs
 61sNWAOpH25ZcfnwtWwPJr5uA9q6oDtdKVIWcs6JDzn.iI.IZgWgmSTLLjzr9fKLQk6ITUvFohs6
 p_42BMBdg.kCsvj.b8fQbOgakPZdJTUcaSz8ScM1xAnIfkyMWJhIlkXYFoTcZTLIOo4f8t3Kiyom
 spBjXlVw5ZIv439VR2RVnvVhpCssI2UjQ3Fp686x9GLWT1n566mUpPpJwL5NFqUdBAleuP75Ps11
 i9SDFXIFxN3uFObDSUvsw805lv3H9s7bygQ2XAsj8JdLQT3gs6rIECjnEU4BYj907B_lykLKUk2d
 lGwjgxKO42eq9sOysUftMtTBV2rGiqUybFNA6SdnEGeDPZqbPXy3RtN.QLhQq635qgruIpV.APzg
 .KQlozVgmrOdDUxeDFalr7IBUHJFOOh11ABm_Gt_FIdzRbRjoKwguM8Dw7AW1yg5S_D4_OQeOUy7
 8zRv777cCpccOz7Xm4y0FmXKNanOxXWSMNRWAB5o2FFB6IX6BgMFpaesUShXALxTUZt75EQp.mHW
 nG1ljH2gNtlOQv27y9Hf6WqSjDfWkIqik4_WfX0u.odB_p3KG8Dvdofe8zThYqmpaz6UPbUbvxU0
 DVj_JcbqK_oMsi6xREDOKyjbEgsuGLqqieHjRnViI002TJmV4qup2xpDTHmvnpvZhujD1bWth2dd
 rTaRYzwsTXF4LNx727IbwwevKX6VMr6ulPM6jLb65Qm8KAsxxzy8cFy41ubIGVBXBOaT0IDBBWJP
 Hg5zg5DqWqp7yjg1yXZgTdoWPHO5ux1hca.5tCfLNFbKxxhv2RWuGZxmWFWZPgme4Wm6i.FJZI22
 gHg0zGSdVMU0g9uoPbkF.A3a6mecFvQpDy2lczWH0FvlYaHnpB7peeTrdcJyAF1zeKwFIJqSroHq
 G_sO4aqUB4B7dvI2cHhPtit8uL3KLxlS3GlcLF_2UlUCXlEhWB7_e1Bs.hIPuflB74hvlKIsbDel
 O0DJtR3V2d0g6xbGAI5Dpr1fjTU9eqHeFUsfKPkkUVf5_h6cPWFEm5.421ZkzLSvfxKLlqmEp.eI
 AF95rxBwmSAZCmrSyCHrYGiky7k0d0rdT6lczQe07sOCJAMswV__qoq4CDuVloqz_a08A36vDYG9
 NDJ68bvUbhukrk94QWH_RTvXY8PrUzgJpiy16Z9v26nBjKtGqqgoO2o30jBH7sEjgLqAxavvnLoo
 YCE0BCIZrL82M2U2eg04b4dWM4LbMKD4zcU4_EzJMIswT5A.NiyXPMusXEwiie8hGsSdMZCj.x1g
 KQRMX0ULF_YEZECPz4MPiH_cJIwQJwlPp5GDklO0D7aXAYjzXbfwBy7wX4FJdgusjNigi17dS28c
 k9QKO.6EmjKiZZC2FazF0VgF402aJfmoQYJArTOCBeHX7P1rLdaFyPw8puHoESYVAgSdHEqoJIrw
 XEkVQwrx7fZs4q1gozkD4Tx6TKhWNtjUMYzZ.Jhrcg2q6d0_VmccaCF246KOQxJaFRKR56JidHRH
 uu67HL0xvrVpf9rtDhxxSn4BOyCDOE6vRffnXi_yQDNJG55VxIfsGuEGNfu_D8go.Ml7NP0_lbDv
 2Y_.42_RQXCazqhFR4GAwPLsTcMkaF6G3utnRegkrZzi4zwHKsTwg_YV4d24umwqKV4vp8Ft0cZn
 pE5chI.3MC1qAr0Ay3a5tFruv525wf1smY07galE766DlYh6y03P08nUHusb9cGXb4XELi9V__p9
 PyQgpHlKNTN2HJVamXIy8rp1mRIoUBZ6bvlgpMtNJhfVukYo5y55fd8pic2qHSBEQdwxUHSXvTRS
 pYxkav.GlolJ8lDfrim9J2KFfgHGNJE2OXB98vUh4rm193PNxa0Ua2JOGmNAl.t8z42Xjt6iQOB1
 U_O3hAz69skvkAvzX7KBbKbnuWtojx4x9FfVAWmepDR2gj3FdW9o36y9AMdx2hLzrltXuFK.UFcV
 esD_3eH5su2KGfT0h_ly29uK8ajlNznQlvm1mZsMeFOWKmC0G97NmutVc002GLaQzw5aAg.XhhCE
 7FIAQ5ooIdOY0Z78.3yK6sRt.mST0uHv5z7VGqohUMBB4.rhKL8xpilPXfMGAsgXgTsGHDgP8vP7
 ha3LGnyHAl6VijV7TMEdEGCnKeYAL.RWSgxWjcAOvOi7BB0vh93TN_NneSArAhzug_9seHiy4S1a
 9FZjFKuzRxV1Z.rq2hLhfw2AOXhcsS_JjPmJSyYVAK9dq1_isy4UkBGNW8PaU8abPNCBGH.q0iBT
 AFMlKscKtQB3tUnqZMoj2euxCx9jFuYAfWQo-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c11662c1-0971-443b-b78c-0f1d3aae9aef
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Sun, 25 Aug 2024 19:02:33 +0000
Received: by hermes--production-gq1-5d95dc458-24x88 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9a60282a87ef6e0dec5cdda503c29ed7;
          Sun, 25 Aug 2024 19:02:31 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH 03/13] LSM: Add lsmblob_to_secctx hook
Date: Sun, 25 Aug 2024 12:00:38 -0700
Message-ID: <20240825190048.13289-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240825190048.13289-1-casey@schaufler-ca.com>
References: <20240825190048.13289-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new hook security_lsmblob_to_secctx() and its LSM specific
implementations. The LSM specific code will use the lsmblob element
allocated for that module. This allows for the possibility that more
than one module may be called upon to translate a secid to a string,
as can occur in the audit code.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h     |  2 ++
 include/linux/security.h          | 11 +++++++++-
 security/apparmor/include/secid.h |  2 ++
 security/apparmor/lsm.c           |  1 +
 security/apparmor/secid.c         | 36 +++++++++++++++++++++++++++++++
 security/security.c               | 30 ++++++++++++++++++++++++++
 security/selinux/hooks.c          | 16 ++++++++++++--
 security/smack/smack_lsm.c        | 31 +++++++++++++++++++++-----
 8 files changed, 121 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 1d3bdf71109e..3e5f6baa7b9f 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -291,6 +291,8 @@ LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
 LSM_HOOK(int, 0, ismaclabel, const char *name)
 LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdata,
 	 u32 *seclen)
+LSM_HOOK(int, -EOPNOTSUPP, lsmblob_to_secctx, struct lsmblob *blob,
+	 char **secdata, u32 *seclen)
 LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
 LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
diff --git a/include/linux/security.h b/include/linux/security.h
index c0ed2119a622..457fafc32fb0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -520,6 +520,8 @@ int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+			       u32 *seclen);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(char *secdata, u32 seclen);
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1461,7 +1463,14 @@ static inline int security_ismaclabel(const char *name)
 	return 0;
 }
 
-static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static inline int security_secid_to_secctx(u32 secid, char **secdata,
+					   u32 *seclen)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int security_lsmblob_to_secctx(struct lsmblob *blob,
+					     char **secdata, u32 *seclen)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index a912a5d5d04f..816a425e2023 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -26,6 +26,8 @@ extern int apparmor_display_secid_mode;
 
 struct aa_label *aa_secid_to_label(u32 secid);
 int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+			       u32 *seclen);
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void apparmor_release_secctx(char *secdata, u32 seclen);
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 808060f9effb..050d103f5ca5 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1532,6 +1532,7 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 #endif
 
 	LSM_HOOK_INIT(secid_to_secctx, apparmor_secid_to_secctx),
+	LSM_HOOK_INIT(lsmblob_to_secctx, apparmor_lsmblob_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, apparmor_secctx_to_secid),
 	LSM_HOOK_INIT(release_secctx, apparmor_release_secctx),
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 83d3d1e6d9dc..3c389e5810cd 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -90,6 +90,42 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 	return 0;
 }
 
+int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+			       u32 *seclen)
+{
+	/* TODO: cache secctx and ref count so we don't have to recreate */
+	struct aa_label *label;
+	int flags = FLAG_VIEW_SUBNS | FLAG_HIDDEN_UNCONFINED | FLAG_ABS_ROOT;
+	int len;
+
+	AA_BUG(!seclen);
+
+	/* scaffolding */
+	if (!blob->apparmor.label && blob->scaffold.secid)
+		label = aa_secid_to_label(blob->scaffold.secid);
+	else
+		label = blob->apparmor.label;
+
+	if (!label)
+		return -EINVAL;
+
+	if (apparmor_display_secid_mode)
+		flags |= FLAG_SHOW_MODE;
+
+	if (secdata)
+		len = aa_label_asxprint(secdata, root_ns, label,
+					flags, GFP_ATOMIC);
+	else
+		len = aa_label_snxprint(NULL, 0, root_ns, label, flags);
+
+	if (len < 0)
+		return -ENOMEM;
+
+	*seclen = len;
+
+	return 0;
+}
+
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
 	struct aa_label *label;
diff --git a/security/security.c b/security/security.c
index 64a6d6bbd1f4..bb541a3be410 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4192,6 +4192,36 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
+/**
+ * security_lsmblob_to_secctx() - Convert a lsmblob to a secctx
+ * @blob: lsm specific information
+ * @secdata: secctx
+ * @seclen: secctx length
+ *
+ * Convert a @blob entry to security context.  If @secdata is NULL the
+ * length of the result will be returned in @seclen, but no @secdata
+ * will be returned.  This does mean that the length could change between
+ * calls to check the length and the next call which actually allocates
+ * and returns the @secdata.
+ *
+ * Return: Return 0 on success, error on failure.
+ */
+int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+			       u32 *seclen)
+{
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
+		rc = hp->hook.lsmblob_to_secctx(blob, secdata, seclen);
+		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
+			return rc;
+	}
+
+	return LSM_RET_DEFAULT(secid_to_secctx);
+}
+EXPORT_SYMBOL(security_lsmblob_to_secctx);
+
 /**
  * security_secctx_to_secid() - Convert a secctx to a secid
  * @secdata: secctx
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 55c78c318ccd..102489e6d579 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6610,8 +6610,19 @@ static int selinux_ismaclabel(const char *name)
 
 static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	return security_sid_to_context(secid,
-				       secdata, seclen);
+	return security_sid_to_context(secid, secdata, seclen);
+}
+
+static int selinux_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+				     u32 *seclen)
+{
+	u32 secid = blob->selinux.secid;
+
+	/* scaffolding */
+	if (!secid)
+		secid = blob->scaffold.secid;
+
+	return security_sid_to_context(secid, secdata, seclen);
 }
 
 static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
@@ -7388,6 +7399,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
 	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
 	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
+	LSM_HOOK_INIT(lsmblob_to_secctx, selinux_lsmblob_to_secctx),
 	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
 	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
 	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 52d5ef986db8..5d74d8590862 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4787,7 +4787,7 @@ static int smack_audit_rule_known(struct audit_krule *krule)
 static int smack_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 				  void *vrule)
 {
-	struct smack_known *skp;
+	struct smack_known *skp = blob->smack.skp;
 	char *rule = vrule;
 
 	if (unlikely(!rule)) {
@@ -4799,10 +4799,8 @@ static int smack_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 		return 0;
 
 	/* scaffolding */
-	if (!blob->smack.skp && blob->scaffold.secid)
+	if (!skp && blob->scaffold.secid)
 		skp = smack_from_secid(blob->scaffold.secid);
-	else
-		skp = blob->smack.skp;
 
 	/*
 	 * No need to do string comparisons. If a match occurs,
@@ -4833,7 +4831,6 @@ static int smack_ismaclabel(const char *name)
 	return (strcmp(name, XATTR_SMACK_SUFFIX) == 0);
 }
 
-
 /**
  * smack_secid_to_secctx - return the smack label for a secid
  * @secid: incoming integer
@@ -4852,6 +4849,29 @@ static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 	return 0;
 }
 
+/**
+ * smack_lsmblob_to_secctx - return the smack label
+ * @blob: includes incoming Smack data
+ * @secdata: destination
+ * @seclen: how long it is
+ *
+ * Exists for audit code.
+ */
+static int smack_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+				   u32 *seclen)
+{
+	struct smack_known *skp = blob->smack.skp;
+
+	/* scaffolding */
+	if (!skp && blob->scaffold.secid)
+		skp = smack_from_secid(blob->scaffold.secid);
+
+	if (secdata)
+		*secdata = skp->smk_known;
+	*seclen = strlen(skp->smk_known);
+	return 0;
+}
+
 /**
  * smack_secctx_to_secid - return the secid for a smack label
  * @secdata: smack label
@@ -5208,6 +5228,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
 	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
+	LSM_HOOK_INIT(lsmblob_to_secctx, smack_lsmblob_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
 	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
-- 
2.41.0

