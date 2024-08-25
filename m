Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6EA1DFFB
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724612753; cv=none; b=nv6CzDtViG/mcK9sipvzOwYaG8aa5SaaJrM0NciMo3P//fsBLOYuBBE6Gq8ev17FKg68N9wiu+RUHiSDqAAGIr7ciOU/a3KLPmvaGXtipLKrFEGdsLyJPJoH8/soKVHrymlCnK4svLMUgzKHbkQonnkCtggRZhkDYi579KFKH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724612753; c=relaxed/simple;
	bh=tFikoX5kFjOVUKDmXz39rDjXI8MMzz/5Cjm8rtX8YBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvYsHTgdbxtu2ji6py6Tv2f1xGbWkxRdpbdRyrPTmkdNjTfcuedgTFXFrn+BD22iTOMF6aU+Zlzj81Ewx4iY9khE9n6/H0FCOgTNeqeYr6Nfyc20AaR7YKFvj/wf0RTRSbP0lboxtL6wjknD2KiwX/psQ2bElhdI88yMpdfmVzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BgZnpuGu; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BgZnpuGu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612751; bh=7qkMoIPtgFrqJj5arTkxiMGou5Km+ArtnRYl0mFg/y8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=BgZnpuGu4AG4vI2NUJZJcK4jQTMPRb0V2VjcXe1FG16YWCBzHXlBghHk1K5yJf0Z46Jf9MMKGLlurGXxAfqiUj31/JWJxllGvSe+L9SRagA2Zy4INPLjz9Xa5SfsNde0Yd5PTmRRzXOCOfyZz6VirxxO6kUEZJp3ncpl/2/k0YFuUOGAtlfmErZgz/IhbkVErnWrzt1poVQFMDUhrdmBgeGZ6vL0T2vdxhUjk881CxGRYenvdUifHCVsn27mqrLPwDu/DmOlkSFHaEQBhJAuXL3LKbZbdK4XBMDLJPgbWxKLDQGYJCkkyKYPfBmI5iO/82YWsgM+tCnv5sA45TxjBA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612751; bh=8zYEx4OpCuImSrcyXperuvhVDNcPmCPf2xl1R8TdqbE=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=g6TyH6Fizz2CSDZwda6Oh+Z5LcrwJpaZVST3ggWNROTRvl5gdwHiiW/WM2NZh1wIaveY5UYjlOpBdeL+HgoXvfFbiOjWRO2re1FJe53xDCINQyFCEhIwO1W2eWiIEXqHzINasTMRW7hkrL9cCO4JHeKgJ/v2N2tan2QrsO5GLwSW6nRiwTr90sG565rOrJUgB2NCO8KUHpsd37pljyyF+kH09oI7UznLS7NH0qTc7GmSdzm2rBLcRX90ZXRZXDtaJv/Da3LDLyg3qTnjdvZRwFy98WSnLRKtcLg48A9zqYtDyCPtDjGmUaVOkE+U5gXTNuXys8E/KzAsOYNKy8397Q==
X-YMail-OSG: Ojk6aFMVM1nAz60ByGm4oMCStqVICSNQ8rtbN8ZTPhoSBE8IqLZvd41uF6ES0f.
 6n2TFAT0HerH1dbgDj01eNCIRzinF.fbQPX65ex.9Kk_aDYbsn5IeDprZqr0FXqDEZ3rmTlq3hOz
 i4fZuM14VRUPYQqLV9e08e0HPypEA9aOoXRPG6ZLd6clxub8NOnjlS8D9XmDFQ0kqR3KfzRP140u
 ioN9l2t_mtqztH.dB.7gP.d5iGof_3h.xbd6ZaWN3rb_uzqgubrZ1lQisaZ943rkwHH3dtUOIdBg
 LsoZqrxNl71oobzdOTsoy5_FDB1pJUqCucECP1y.M2FM8eEI4RkM3AUwu6pR0VIPHjCEyn4UgOlA
 juMDa06DKgVzU5YHNLHrtnscaWkU1S9z3NQP36N8TENI1XcCHRHMVWuVlrOUbdpFbgm9cyXPE7v.
 zGjV52s5PBtgn8LCSqSV9FWeLepeydGisnbQyuOfHGPDtPgplhziBowc566O0j7slO3g.MNgEiFn
 Yfp568vN.DNsVRTqbnxzxSWQCHIu69S0lqL4KojokXRBifuNWq5VJQpplUKsuCvnjxH.TgN.SVyb
 WS14AGApea.pLXeIQ17h5ZLojeK.Ngu9ir4inmU_BP6ZdqsqDAlwLaDaL574yT86SHZlBJVYu27V
 X0IN.Yd0r1k0KKgUl7qMkVeBsTMH0PN5eig_07N_zQimKeVTFWQH6D4deMn3ytSOa110kHFXyRS4
 bvTfHjz.GT7db5NPv5VG5Ojo9c_wbfc9eUPv6j1Eytd6tB3boHJlGy6av3fS2J2iMFSducf1hGa5
 GM80WL9_i4Bo4803H5lkZSE9ddI6rmOhdRvBIzMImqb6NgoC1MggFP9BMUHyxAWHUevgDVHuaxUP
 myNFt8eryx5T6eXZ0gkA44nAu_vWkIyhlELu_.sxozR5hazIae9KK3SOw5nGw1FdhSpRyztFdEQF
 meZtNL5.WtMd0hFyaPOpWZwqe14QZM09pnx4IFiZcHqOo1T9OclrF1IKS0_vXaiVZAbzoyTX_YMI
 g7WEVB_qHo8rovoppBk.8ji9IpjAktR5gx_g2736CjltmkX_YgscLdyDiLs2rLpWON17qQLTjAZl
 uc38FShy.TJjossw_aMZPujpk0Kk_0tHwhVcdemI7YXK4rcP80b2zpHA99UxO2fxNL3Imy9a8t_5
 Z.bx.j1fsUEO2m11yST09yRivcYZvY5CmS.OnTt.1ZzoMOcYeRDRZHpeRgrZyza1b9u4bLeC912R
 zeDPxEVSpnjjt9BkmFEabEIu5c3S3kJPV_ZjJVN6AIYcOj7E5iaRp2_c7YDVtxFTEY._kCAgytrL
 5FEJKg9KJcW9k9vmbadga_omF7RxtMrgRUj5txnGMEFseQX7mIAuypYHec_5FEeJqmzYYQm2Bdu6
 7c7Q0P7JGRNdFdAS_rZ6rA2LIngxGikdqyhQ4yvKU1g307D61aRqzRI1GT6w2cJlKBdn5WohZL5p
 eGZLv5InZL7lKZV6NM6XmM7hNc68Owc6UCGjlHY47Rp_PHY4n98II1QenPwpZfRv4DwTdTm_sAsO
 fHI1gW7CPzwtAArwO.Nx9FpyRcBZROuj0D4cXNicy5D3LJIT9OAhNC7frFLMWCK5T87zJ6J6ne3t
 Le83oq1nfV1QBuG_i0GlzGs6AvGlOMEXtP_TjfKqRzyI.0Dvdvpax_vqbaNb9tMPYPbLE._H3i3j
 qhlg9Wxe.3V42cbnsxtoQjzygqedFaB3C.KHdvrKaAWQ7Bhmxrn2RmzYBg55oIflEZ1YnhJFSa7X
 OpmGz1FKWiJwPMRmKVC_d.8o6beCaHf2DGvMmLwyrEdi1Tex3Lnhd18hm90UDKbBJ2JbHZM3BLZn
 OpX336mbA.gkuF__bJAnAId6UZlyLIwKfOpMFt6njMT9_PLnD22HYBsnVUFEJzjV7Ovng3qAVXi3
 Ggd6YJnnwtodN93RAGUFG76Ma6pFgvH0cU3Dx7jVBR5HCLHO5AmHqhS1rlVG9e73XUDaTrZZDPa2
 5AOXwo5UyyTLJzV944pIeKceqNteVrYXQc3ivBX0sRpbh5urs5oWkfHI7sG_XPcZznSTap8JBmFn
 E1egnUTEGdMhonAA01W8Xr7gxRmVvH2tHMWnN6ha04.zRGRoPsRSeiZaBhoH5MdJpxG8ofnACpgy
 mjDTemFDACEh3AjOnoy8389iqHEdOmK9EAQmcHrGRpBxpAcLpWpL1fN5pWZVMrstPVOoxU_dOSUI
 msqCxdEM21KIWQFD9.Aek2ljoz7fGYcsZd9.tG_xuiPWdtPkDgcqia0OqgNWzK3FK2G7i9OqxJwm
 J7IDQ0FzxAPOmVjA0BWETNXp7h4SKq.6GhlE-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5cf5b26a-ef89-40d4-8053-d788474d741c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sun, 25 Aug 2024 19:05:51 +0000
Received: by hermes--production-gq1-5d95dc458-m8nfd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fa6d7487ce614a4db5b8d88c90575908;
          Sun, 25 Aug 2024 19:05:45 +0000 (UTC)
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
Subject: [PATCH 09/13] Audit: use an lsmblob in audit_names
Date: Sun, 25 Aug 2024 12:00:44 -0700
Message-ID: <20240825190048.13289-10-casey@schaufler-ca.com>
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

Replace the osid field in the audit_names structure with a
lsmblob structure. This accommodates the use of an lsmblob in
security_audit_rule_match() and security_inode_getsecid().

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.h   |  2 +-
 kernel/auditsc.c | 20 +++++---------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index b1f2de4d4f1e..6c664aed8f89 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -82,7 +82,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsmblob		oblob;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index eb1c64a2af31..886564532bbe 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -698,19 +698,15 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
-					/* scaffolding */
-					blob.scaffold.secid = name->osid;
 					result = security_audit_rule_match(
-								&blob,
+								&name->oblob,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						/* scaffolding */
-						blob.scaffold.secid = n->osid;
 						if (security_audit_rule_match(
-								&blob,
+								&n->oblob,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -1562,13 +1558,11 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (n->osid != 0) {
+	if (lsmblob_is_set(&n->oblob)) {
 		char *ctx = NULL;
 		u32 len;
 
-		if (security_secid_to_secctx(
-			n->osid, &ctx, &len)) {
-			audit_log_format(ab, " osid=%u", n->osid);
+		if (security_lsmblob_to_secctx(&n->oblob, &ctx, &len)) {
 			if (call_panic)
 				*call_panic = 2;
 		} else {
@@ -2276,17 +2270,13 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
 			     struct inode *inode, unsigned int flags)
 {
-	struct lsmblob blob;
-
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getlsmblob(inode, &blob);
-	/* scaffolding */
-	name->osid = blob.scaffold.secid;
+	security_inode_getlsmblob(inode, &name->oblob);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
-- 
2.41.0

