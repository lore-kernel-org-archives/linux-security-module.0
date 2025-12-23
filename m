Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CDD289378
	for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766532229; cv=none; b=HiBkJb4btb4ye8bxJ2ze+EsCLToH0RWKExg3Ocwq1QRRRtrK9aadZF43Al3BRHhaLwa052uaaSZrK7HW1RX2kVel1YD2ZSmLj/szOQNMc0CRSJik4GYUvzJMrIZxDrvJwwyLhI27X18vBpzTwtPtoiHSwEjezmm1tXiYMT7ozbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766532229; c=relaxed/simple;
	bh=E7kW4czBFpM5iDTQMmlzk2z5qEaevIlM2cwkwajZ5Os=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SLYlPKPYMbHrb28pqXqrePWpkbXolRDVqAzSerDiy415ZPyl5ZzXm/dEG/FKuYsAb9f75KHZj4wi8NcNVV/rp/ygjyM3zmQQkuhM+dWFlNrueSvfwJgpPTd09z9pvi8GAKoSjPZ71o6L6LocSamnzSekwHhGq/aJKtNEPN3HSrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=uhXi096+; arc=none smtp.client-ip=66.163.184.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uhXi096+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1766532221; bh=aSCRiYN90BmfoldDiDoWUkM3pJMoVpALxYO9yC5O+RA=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=uhXi096+vI+BVt4Q0iRls8d3GGLQvDfPjPxYo97/xY2BDyr8T5xQ/EeZ0CKm3ZkS83rsjNxCQ1P1GJkIFlLFVVi/JZrlTR+XQfu4wdIeZ7D4s3sj5LL7D3j1u2KK1ToDFabAIpfsPLHc6W1fJIKOsruwx4e0IEed/5t9nEkdw8Om4JyKlzl1mGwh7Evm68hatI58JjlhTvgGAK38qhDPJKeYE5c56o5NO8/GpHQVl8Ul2r+o/94opqr/D0k1sKyT8LmI7PwDtfv+TaevJWG1edBZC2l8nMC7hIHhkhILRBauyCsUP0tF5MdymAhpIK82jzv3BA4h5gi2+s3NR7h8VA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1766532221; bh=gEEo+RXp8gPAUdCGudopROIqbKVuHw7mtg2VY1gN2mn=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=Pkl7qrzYaCngz13+6g/JHOjn/TaFMoY855I5ftmZRrDJEeneQdLxXowkSx8U8DKgQqWLpYCZ+9tPPUX3d1v9hSWy1itcmdI01FxgHTlU9koYbV+8LXbKet8TQYWWbD19LsZvyqL1to4kD36DC+5FptArKzPaWo8IbtjRsEoO+Y8kJj9H/B6XLNfNgq3YWUsPZurHE+J9J4MUeW1rwrhZOvwVtJKyQSHaDevHTIANGjCZ9T+5eqONJ5jzaUCB/XZ0jfaBnDvblSgfYpkLDUpqxsZJ3pGqqS6ULCVU4tvmRfHYlUIpbt1dHD3ikTXPysMCX805t/BzMgRHz3ydjEd+yw==
X-YMail-OSG: z2.CKjAVM1kx8q3GbNoAAIXYy8RQfj7q7aImfpeO7Tbuv5uB_j5DTUTIVERV3Io
 2t3bR2iH_0c1K0zc8DYhr1Z_JTam0eSr9EYAj6C8y0QMAjwZKKagzCJk4ifwQjvD22s.iJQnX_LG
 WsdFZmD0d0zNRD3l6o2HIYg90qxaqQXsF3eoiEtisJmAnUTOYpnNqaGMR9IqqT2AZXqfEkreBcbq
 kxgwkjyK7aZqotcoZ2KPsGZm7l5vUoNFfEnfc273Tt05RxLVBnpQNsY6TQLVlhTX4G442qMkvnw6
 mjPkzUvy7DBht29Wjmq9GPL15IyWvtLOAq8Z.464rP4Vvqig8xGJpneU1Pc0.eAsSSY5AxFOV0fi
 96MtjGvPuzpzQ8KAqJMFS6rrKp0GEhoYKYEflmEzOSze6MHmOJ1QuAUjdRSzH1I.wepJDLgPwebg
 wf4Y0VWcHa4hRbBFAC0pFGvKes0tw4VoMhNXuvflYE.j_L3dT_5Ea2es2vkgCkwK9fzewjGYEMGf
 OcEaS3s602BOQFu2ujGuygHYWRogau.w4wEfX9uBHMS1pwzfu.YPUxoB_Zk8WKzoOYO4YIiNQKTM
 sK0pLgasLVICE_xrImgeVfBp0dgS277S.lkaayBNyQducG2zp8F.Eausa3Obs6U5cU2glNiVF9Sk
 VzRAQ7ZjFfqssrfsoXvFRtA_pzsvvx6_DmTElUJmt5LKw3A8o04E6yhVk8eRtifsve_7C40.xgty
 LA7DWVsRnMlaA5ltKYMf8gYlXP767eDicBt_Pd9QAL14i9c4bIOr9505YkF6waywi2xdy87M1cFl
 XRK9CMuYW.n9g8VtJfeggjqncWrMOaLqn.4nI6BuKFUxk9_I00R6vRGdry8mfsQJ9iXteY8ZH6gA
 HsHemQka_BfEAhgynrc3FkI5cNcUsluOQ_HhxGRJ.GPPYTdxtyTluoEwiBu.cztPIE0nAKz0gLBG
 sg0Tj_sZrGj9FRU2aXEhQuSYfnru.2dsr7vNAShYkxxSOzHwwDGO3p6Hi7EHKq1VKsyGCbVTPwaU
 cYP18rcmmmktdy7chabL4YyTX74G77HA4QEIsamMElAJlasZNpU3PEP2W03A7cmTqGNz5jV2zVBb
 FOU3Mj8zgEv9hj1S4qEFaK5x3Csp3CvygMEVddSiLR9e24qgHaZsEOrv18WTZr9qxUtj.Y29xiMs
 EXLskK9QAFDHx.hExS42PqqvL7bQBIWMDhG_LySh4wjCQ8FY74wxvmtN7x0rVMVOO0eHwgn00MZS
 JVOVLxbRzYO9ejBLllgw8ikDu07YxwPUY12cq.53gpqDc1cSxOr7kJDhdmpVpxSZi8q1_2IMwQ6t
 4LP95ka_eCRPpWNBIJc77_1g9tS8lJn8QnMHjaRfSKzTfCEhoOEuspCDa_fV3qBBnmQKl81hdt79
 Wb.x7zmKwRcNwC7CrxPU8Es9vJKMw_3dNeDVhYn7WnTtPHJxgx0MHKfIyLR3rhOOBVqnxRvvC.h9
 sLd9qOE.hoAoUP4GXEdF7MLLIO.DdQo2iTidL29olPTa8gNmzFnD.sFuvZodOnNuwCJ3PwgkBcWL
 s2mRyilHihxuCawc6m9IuuEY6AcD44.onA35iI9dSSUNZIHIuEixUM21vlk34DgGVHEkuhQxw6i_
 eOC5U8pcOo4H1U8qVXALLGZn__0E7v259UhtWAjpyg2Z32H1p3vODrk65yz3F.29FDBM8mCuTfzu
 x2d6RuoGfbn57pccupNxXb1BJ_Z60ORI4fjvKHEBXus5ntImHmQviR6L1lrkr.2_ZYO0YPoWsKY2
 VmirXmQNRiijgSzx_wnajYlV5uHZtKSZwusQl5tlNcMtqklvr36IdyLqrvFEU0DlkGQ0HtqUs7ZS
 An31buW3NBBnB7U7oD3Hs8qnpWe2dJy.S4oOE9wh0EC5ueqejoQihPf3lG.Hm.hXZ3lLikrKnivG
 zVCt3TBSV4Zix45J90L8247kmQPUb_lTkcmQOcCm63KZcR7eld9uap4kxtBxvhG2ws2mfMq1n0TC
 81v4pwqM7usEKpUw07t7JekURbb6cvJ9mynRuZN4K.VHX3mpleOQt7YQ6LlZpA_n.hXYDQYBglDY
 99vDKrh1HAxAPv0Ui1tdFyhHnZb1_ZAspXJU_QcThApO2I_dau4v1Y.Kyo7ZQg41nV_4ZHoB84pT
 91xjGm8Q7.oa9_AsbPZ39aZn1sOXObsSJ0M.11.Vx1.CedebfOuYAUltBlbnRx35AxbdMKb6TYvy
 VtcjX0nLfq85M1VfiZNk47Gak6cZLyF5rYUha83m7W.0vDXKUryMnrsOypIkwEs55isqi9rkmMYf
 zNdE44cADPK3IMLiDYBxJ4Q--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 336f15ae-6d9d-4a5d-8120-d658529fa36b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 23 Dec 2025 23:23:41 +0000
Received: by hermes--production-gq1-54bf57fc64-ftpn2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9f054a8783b604c9ea23afbafab50eca;
          Tue, 23 Dec 2025 23:13:27 +0000 (UTC)
Message-ID: <c1b06d12-eebe-4b6f-bb47-c17bb0a05cd8@schaufler-ca.com>
Date: Tue, 23 Dec 2025 15:13:25 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v2] Cred: Remove unused set_security_override_from_ctx()
To: Paul Moore <paul@paul-moore.com>, David Howells <dhowells@redhat.com>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Serge Hallyn <serge@hallyn.com>
Cc: max.kellermann@ionos.com, LSM List
 <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <15895666-464c-4349-9fb2-f24e10aac8c7.ref@schaufler-ca.com>
Content-Language: en-US
In-Reply-To: <15895666-464c-4349-9fb2-f24e10aac8c7.ref@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

The function set_security_override_from_ctx() has no in-tree callers
since 6.14. Remove it.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h |  1 -
 kernel/cred.c        | 23 -----------------------
 2 files changed, 24 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 343a140a6ba2..ed1609d78cd7 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -164,7 +164,6 @@ static inline const struct cred *kernel_cred(void)
 	return rcu_dereference_raw(init_task.cred);
 }
 extern int set_security_override(struct cred *, u32);
-extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
 extern void __init cred_init(void);
diff --git a/kernel/cred.c b/kernel/cred.c
index a6f686b30da1..12a7b1ce5131 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -620,29 +620,6 @@ int set_security_override(struct cred *new, u32 secid)
 }
 EXPORT_SYMBOL(set_security_override);
 
-/**
- * set_security_override_from_ctx - Set the security ID in a set of credentials
- * @new: The credentials to alter
- * @secctx: The LSM security context to generate the security ID from.
- *
- * Set the LSM security ID in a set of credentials so that the subjective
- * security is overridden when an alternative set of credentials is used.  The
- * security ID is specified in string form as a security context to be
- * interpreted by the LSM.
- */
-int set_security_override_from_ctx(struct cred *new, const char *secctx)
-{
-	u32 secid;
-	int ret;
-
-	ret = security_secctx_to_secid(secctx, strlen(secctx), &secid);
-	if (ret < 0)
-		return ret;
-
-	return set_security_override(new, secid);
-}
-EXPORT_SYMBOL(set_security_override_from_ctx);
-
 /**
  * set_create_files_as - Set the LSM file create context in a set of credentials
  * @new: The credentials to alter

