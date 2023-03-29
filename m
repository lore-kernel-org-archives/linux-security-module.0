Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B888EC74A5B
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Mar 2023 18:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjC2S7X (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 29 Mar 2023 14:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC2S7W (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 Mar 2023 14:59:22 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB17659C
        for <linux-security-module@vger.kernel.org>; Wed, 29 Mar 2023 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680116359; bh=oeFMu7b3kDgXeJ9fyBphMRIOdzdISv9B+XVirna/e8g=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=pz3gEtZk2N81ZLllXadiaCEn8h8slAh3gHKLCzvTay+LFQQG9OdD/rm88ScQn7jIaQbVFCldu32TCzLrWXCpA2PSH/e7uWRAaPGb4qQGZpxdnfFCpvmtbo/4hX2dAJXzqeJ9thk5tgHRN5g7iJeOv2QIg8rtBF+XGtiFx/zLNuDvDuvcQRawLIo+VnMJpmXHqYs+1l4SV8lyuyFS/swHVYp7IE++TXCOYUgmy4GNnjPOJ2CMtnqQfUF43SYi/LjWH77VbCXuCQ32eKPxCxBngaET1mtoE0MeWElJz+MfP60i472krFZUHkq32zQLUYc0kd35Qu4+CU8X7YrCSgU9Ew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680116359; bh=5bngX48L7ND5Oj93nZITwj9eNBpNzHC52AOYMPAjHoH=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=RqV95THwvqhlPKqE8LUaZOPzF2CnE+uDtVviXvC/p7pTHG5dnbsFXuPKjQ+U5lgLtAuZh7i2bjOyBg8JTTyJTNIDpfrZuEj8KocNfrTPmIqbu7QfgXwiMaSC1ifZPt1naSrd7HhLUqSFgUEt4ZSGfq0CYlKDPu6JqWSe4D0w2QX+bRWmilM7DWo5lQb2JdbQFooX5cDw6D1Ly1CpURNG5CQOzYZ6VGpqAxDk2dESzMbc64Dbt0IoZQXQEbKie9cY9Rf7IonrMgVimMs2GRJ4GSchfZzsay1mJlp7GNJJ0cwQihIubIVtqQbnTIaQUqP281tIn8I7BKLW6aaPKB4p5w==
X-YMail-OSG: 8_BNccQVM1ljCqgwbp4_akzsgLniuUYciG4iVObn49EOmZDq1BXFyW99uNhzDZI
 jynKzTsuXNr.Z8VlKBUn1NjTNBAmhAmjKg9gIFbO7zXE1Ud6f_GDpvBwQp2KxmXuivSWJdleS_88
 VyEaEuyGTShPnemeVWZL_w97NkCwcFP0GQj1SORkNeC_PmRmnEL.p8i0as1y5JEjmaQU200IR8zZ
 Wp3LEokM6du90JZYy70C42NFv89jqmJGqxF0Zl0ve2JWtEt4S.HfKy9UffhE11cbtnSY_vZP7ZAu
 ePZfCPd2t1rBa8ubVT5uQg8AKoxpNWZCp8pSVbwrGhhCfT4a.YlYmVXutIWlwsnUQU.DUONwvepR
 9urgKDHCz81JxLhp22bpdb8Hzsit57lbtbZumrW378AnTUjEhn2fmpoas_I4yPdSB9tmYDOsSQaj
 6KCtDnNHULuKKs3C20ijKcGLzbA03OanpKYBQNApva4N7uMmxDAXXU9tb97MQd.thSnrvlC_NOmH
 IbNijmafHhbRMsg2Laknjrz7ncbMTtxsiDRNh.SxiA51guMuSwGkiuwc0inJCdWa91q2Xw6Y4Oco
 aWqTzqyubAnJNZyqcnqAroKo2gZZqikCoxBhHkjRu00W9oTtX0d4tEJumG3ukBsf.ZLA6de8Nirc
 HE4c2Y12T3ZqJQXDCOZQVd9xgsgC8Zy9.wm4uFnrBzDm8t.wOiKZs12UPhyKAUMJR1IcLsAcbh8k
 bj61Ktg9ohslLutAIAIKlsL_KFVjkrXls1Ck2AtxonPWGY1N.EwCXD5wAcgjN5ADkGI6qOMGUs7V
 miR22HzsmhF1CiLkc_iR68VZnjgsJ44KPb1FoxAMKtdgIDhs0XOU.qmV5UljaNClUUKPXThFqNCG
 a4Su2aBu1SlET7T.gaBJwyLnDo1rG0mKSgfz9z9s8KEJkkYPtn73OAsvwwFetprD6o8ZpnMyFrm9
 JhwRJ3xl6JKQ72Itp_s7KZDPtwxgCXrNpv6QQ0HykAz0Ks63DARvNdY3n_8g.SYT8nGRRmnpHlzG
 b0fK1V.wOECbf_Ewly2n8TpjyXcy0n1BrHu4AjpUGXHasKrpJYgcr0TCYfeX5za9qJyjlpz5P1HM
 f3H1Qze5HkHDjJ7LjmdkKp0ohyIra3IPsWtnfUxZIPEkyr3B.rOZoUHsInDddC4ZJ54goK2Uptxb
 B4OCmUqK6oq_fJtfl8ctt2_rF5TXJ2_IsGJo7e1RQseMzMHe1H6BskciGbLSNziVCz8yFQRYxLAg
 cQR5AjmH9KnZmBy8EP8pl_.IhpjaMZP3kzjwHVyQt6eRMVmQU7.USmc_cgKImepU1CziJHRKFuvt
 u9GA9mwonQPOm07Ub66zWtVpwogwW5CY9XqCzKEIBLVT7WUPqYUlAZ9z3YGkQIJxg.cRYYFWIh_8
 PnOPiHW7hOrR8GmKmjAzXilVzbYLdPaMeIAVJ.oiePAMPN2XdJuTZjDwVsqkHekbjGMB_i9j.BMJ
 VVqkXD1B5P.DklpEADEIus8SU0bZg9bR0LYbtRHA5ItbbbCCAgzB1bsnBn_YfaV_i8hGw.SG26W6
 8AQDUmh_bvEqFzjwaYq_i3aqGa_E6ku4JcPs.s8nw7wJEq9K9u8Do1Uu22PZr2mD0gDoXsDlDetM
 I.oNKFlos4AIg7HmOpvlbjM3P_uxyyANTd8UqGf8Ayq8wEN3iFgrVwcEbGBXhUK1R5R9S2_HNfH2
 7mKecrHRxoHdn5vUbw.VRG.HTj00NiNAJ0xNCkMh9o6TPEr03.4Q7H54kP1dYDBupeOjDfGjszWX
 AHaDr_ohRAwNxyjgQoFKGsawki_xmiL80mn2NyhvONiETQDx..AmgJqdDi9zHmmX.LX62B8jDArr
 p54U74EYWMgtky4jy.lGQEPOpJd1j46qcqXI3RZ2jQPlAcBzQxJE4B6Wq6lTyUO8g60ZsXvgc5TE
 LSwokhcBOyiPW7JIUkRe8Fx5gY9Wil_VM2z8Xu6q6pwPays.F.D1bHIUZ7seHwjB3lqvPnkcVfWC
 r.0i.F9zixy8VPS35t4ldr55Az5AoPO4LSmLnHO4s8P.50veWrwXke2dQxbaqvwiKLfHrRM8QeUU
 Tg4FCjoFzqhT0LtuXjqjWM1otxBGl2f2Qs3Y2lZ_XrnlWumWSsrWeUYMaSZqPedrj7js8aF2oiPc
 lgnoi6GMFuj7yMo8nntZKl7RMWwjDaMF7GnQf_j9_bV2mshBETHz44Zqe34Ua0HApaqGwzBkNrSP
 gmKXEXxxfFpEvpuMb
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 46594e67-67ce-4159-a3c9-8e9139b5d02a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 29 Mar 2023 18:59:19 +0000
Received: by hermes--production-bf1-777648578f-286lr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f180f0c54ebbf84baabd1599b9c7b800;
          Wed, 29 Mar 2023 18:59:15 +0000 (UTC)
Message-ID: <d3b983f7-58c4-6d98-1ce7-fdb482572c8f@schaufler-ca.com>
Date:   Wed, 29 Mar 2023 11:59:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     LSM List <linux-security-module@vger.kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Smack: Improve mount process memory use
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <d3b983f7-58c4-6d98-1ce7-fdb482572c8f.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The existing mount processing code in Smack makes many unnecessary
copies of Smack labels. Because Smack labels never go away once
imported it is safe to use pointers to them rather than copies.
Replace the use of copies of label names to pointers to the global
label list entries.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 62 +++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 24ade96e17b3..027f6e2a3a27 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -550,23 +550,22 @@ static int smack_sb_alloc_security(struct super_block *sb)
 }
 
 struct smack_mnt_opts {
-	const char *fsdefault, *fsfloor, *fshat, *fsroot, *fstransmute;
+	const char *fsdefault;
+	const char *fsfloor;
+	const char *fshat;
+	const char *fsroot;
+	const char *fstransmute;
 };
 
 static void smack_free_mnt_opts(void *mnt_opts)
 {
-	struct smack_mnt_opts *opts = mnt_opts;
-	kfree(opts->fsdefault);
-	kfree(opts->fsfloor);
-	kfree(opts->fshat);
-	kfree(opts->fsroot);
-	kfree(opts->fstransmute);
-	kfree(opts);
+	kfree(mnt_opts);
 }
 
 static int smack_add_opt(int token, const char *s, void **mnt_opts)
 {
 	struct smack_mnt_opts *opts = *mnt_opts;
+	struct smack_known *skp;
 
 	if (!opts) {
 		opts = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
@@ -577,31 +576,35 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
 	if (!s)
 		return -ENOMEM;
 
+	skp = smk_import_entry(s, 0);
+	if (IS_ERR(skp))
+		return PTR_ERR(skp);
+
 	switch (token) {
 	case Opt_fsdefault:
 		if (opts->fsdefault)
 			goto out_opt_err;
-		opts->fsdefault = s;
+		opts->fsdefault = skp->smk_known;
 		break;
 	case Opt_fsfloor:
 		if (opts->fsfloor)
 			goto out_opt_err;
-		opts->fsfloor = s;
+		opts->fsfloor = skp->smk_known;
 		break;
 	case Opt_fshat:
 		if (opts->fshat)
 			goto out_opt_err;
-		opts->fshat = s;
+		opts->fshat = skp->smk_known;
 		break;
 	case Opt_fsroot:
 		if (opts->fsroot)
 			goto out_opt_err;
-		opts->fsroot = s;
+		opts->fsroot = skp->smk_known;
 		break;
 	case Opt_fstransmute:
 		if (opts->fstransmute)
 			goto out_opt_err;
-		opts->fstransmute = s;
+		opts->fstransmute = skp->smk_known;
 		break;
 	}
 	return 0;
@@ -629,33 +632,14 @@ static int smack_fs_context_dup(struct fs_context *fc,
 	fc->security = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
 	if (!fc->security)
 		return -ENOMEM;
+
 	dst = fc->security;
+	dst->fsdefault = src->fsdefault;
+	dst->fsfloor = src->fsfloor;
+	dst->fshat = src->fshat;
+	dst->fsroot = src->fsroot;
+	dst->fstransmute = src->fstransmute;
 
-	if (src->fsdefault) {
-		dst->fsdefault = kstrdup(src->fsdefault, GFP_KERNEL);
-		if (!dst->fsdefault)
-			return -ENOMEM;
-	}
-	if (src->fsfloor) {
-		dst->fsfloor = kstrdup(src->fsfloor, GFP_KERNEL);
-		if (!dst->fsfloor)
-			return -ENOMEM;
-	}
-	if (src->fshat) {
-		dst->fshat = kstrdup(src->fshat, GFP_KERNEL);
-		if (!dst->fshat)
-			return -ENOMEM;
-	}
-	if (src->fsroot) {
-		dst->fsroot = kstrdup(src->fsroot, GFP_KERNEL);
-		if (!dst->fsroot)
-			return -ENOMEM;
-	}
-	if (src->fstransmute) {
-		dst->fstransmute = kstrdup(src->fstransmute, GFP_KERNEL);
-		if (!dst->fstransmute)
-			return -ENOMEM;
-	}
 	return 0;
 }
 
@@ -712,8 +696,8 @@ static int smack_sb_eat_lsm_opts(char *options, void **mnt_opts)
 		if (token != Opt_error) {
 			arg = kmemdup_nul(arg, from + len - arg, GFP_KERNEL);
 			rc = smack_add_opt(token, arg, mnt_opts);
+			kfree(arg);
 			if (unlikely(rc)) {
-				kfree(arg);
 				if (*mnt_opts)
 					smack_free_mnt_opts(*mnt_opts);
 				*mnt_opts = NULL;

