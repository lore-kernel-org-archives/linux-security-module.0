Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC473C416A
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216505; cv=none; b=b5MCHO1VEDC6Pa6zgWb43iJ4N7nu6iXxNyxx4lUme66BCjNJCVN3Kqg6Xugi5e+hsQUpJZ5kSkzn6tcTifRkIVwum4/qFhbH7Qh8chq4MA8bu+m4wV+E1ZLOGu70KU/mFSeRvhHM3ryX2+hi0tERcDeRAs+EaBj75sEgnNrdN1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216505; c=relaxed/simple;
	bh=l5xZJq7SJIQbEKIdMk/8CyU82z95S13RHM4M5HNEOB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOFNLxLhi+nTTfzYk7UmMlKWlIq5tqswXs9lshF6OdydwMazVR9ZR6lLL1nfFmX8pz1osascGDqZp+XNwOud7qy0fqyV4gd00h5jPbAi7pQCvCK+MME1sDoWpW7IF6mWDKaJJ6ZDm/yMjwoUjwbY/Jqmz5ggdXODereMPZRR3Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gwKr4gx0; arc=none smtp.client-ip=66.163.186.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gwKr4gx0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1788216503; bh=spL1TCRGv1nTSaQv5qslf2f6hMhi+lllz41KcBPUl+Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=gwKr4gx0kZUkhiAECAksALYR3v5Gl8hnVQk6ngs1EaQjdHLX8TfAMgklnEesZzo1TJ8DIjex4/U4p6XQIXA7Yd+XZJlsB5OyD6ErXI9IW7lekou9HVkgYeWu8p3oyyKJYqgXFq7cNw6e+ij+p4dzIJo3oe65YEVPb+SG+5YAjYb9kUGD+nG4+wx+H5nFZk1XFCzNsqjWwtTGk5l1AkVZLn11rWRk8oEjcNd/yME82Yp5uLjdYRz9If5y/jLSa1aRMa9qKGsEhxH2NrY/J0gzB7XE+jCB/01f9r0E4vww167vOw/1o4G4gZfANMH69gK8cyLcNShKqvc4Iob2x0cogw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1788216503; bh=Z/1fWiYsmMDNeAaVEXeCJ6ld2SoFUtLqEH+tmJKulLC=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Fky0wm30AuY3MCwp3UYzYozajrPE+cSLMyOVwkJ9UI7B+KEp8JBEtKnI/8NJImbKGB0qUyYEzbkUHWu6wR1ws1K1ZXz+XLzyl5/Jy0wcZQBqBMaOXG0JxLnZ6jeGtoxMaJaoHbSzzOpz1HTtwsSH/RQVQt5C9Ym0dOL0ZC8jYyhhvVi5G1WuWspAJZ5Ve8/DCXLENFsanQm+N76+KVs76wSifWCdBwuN0d28Xe6liu92Rjhc70qaB5kH3/MqTphMTwtqhd1pDIB5/KbvDq/1t2gttes6WLDfUq3z15LqDwbuON5r1OdvGGK7WB9y8m+JSYpvntcfMKGn9TAL+KRpGQ==
X-YMail-OSG: ZSn2pXEVM1mK5oBxIu.zt1Bip6WyTcdPQTr0dYfx9G93Bn8wyhp8eFSTaGVVs6H
 9rs1pt7jNa3VQCY3J2yF90yQ4iIoC5VMTiKTVOWq.zn53quPF5UphUH.6GqWSOgZncyfaQRBWK8t
 V8My55uDt8L4wfY3MdIGcTrj2y_ycR1dNJCB4DT5qosr5ErRUy_YNVvO2NNC2w7h9tBJtgkV7K0V
 .LXQeWunRYaNM_Rx55G0yoT7etq94BvutBJ.rNzuzpENO2xEN7L0vYvT71IEATL4wMgG_kFE3KxD
 n6qMGLD.WxWqJtYqb0ufNB2pSwDDoqWZU3oirbutTDv6J5djgNXfrui46mlHtZXDo0FXRf4NLrlF
 HEIbqRtP1O4GXF9Va_knUxYV0489PRWeOIDOV3e2GEOItUy6q3wI40VhmKePsoDL6bT7Scu4DQot
 2mB7lz5us0witW0amWTXf8FMYx1GgbTXqbGfWnBeixyTXymYMOuNQ2szgzU2XigQ6MHfXU4_E3.d
 caIXD9duEOH2jWIkg4CMyPxeJO6nvBQdJLpAf0KmTfF9PxVu.JLPYYFTgTOYb6_cl4jnmad_GwEX
 6jrMS3tPQIIFiKXCA0TiornCKppwtk8UZWi1RjGf_Ay_c4AiDxwfDP9hak7bEZvH1PhIOYqyt_op
 UcM.yULD.k8HysO6OJIh5SzNJSAHjcF.Rpq8GQOPeuKCb5ALrK4xapjMvpIVlpIDkPiOt4PI2In5
 Nlxy.HGysfM0BlxWP.eK5JD9W4cpUICGrmWRQe9RxEfILbZc4r3QNH4UuiPRXfCkYwO1UkKRndcY
 qXDryODbJ5CroPL.Or4kWUP5eTc3JSaou129QkaoviTV.zZI4QMq5fxSxP6ffADnc64VvPlr7vUw
 hRIFzLpQ5J0DE.PnaGazne1qjiHN3Bs9z7kor6PxZL_oTSW4mdbYKoL.WmfMzyPg7fm5d91EOvD4
 64nAKCb1Y6YBI0LRXLrNTSjBP7bp32TzFfRRKr82dVlawr.dV3i5S0iYsims9vtOgt2AmOu5zGbR
 st1eNTBvO_fq1_8K1w4bRx7VF3xM6OJpT3GzKO3422yHOhsVGXxBuRnUQJe8ocDjWNH6jSATCv8F
 5iWya3sAEdeQ0J7liAv3SY8dKBW.W1usmubWTR1K7Ukskv7yJTRjrthMiRHCF4_KRw6BmNKOyebU
 HlkFyp2zO4QGz7nD.ZH9TVlx0k.FcIhcwlwCpKJ6NVi0Wvh0Ypo2YK7ekKlWkb5DJQKs.A7rM8Xx
 UnP6FJkO91v5d08eYyXVNfaWTfq.nyojowcsuAofVl0t2mOcZ5ei4sNK80ur5tQ5HE92VRuoIN7T
 4vYHda4pUbAd9S62JTHsUHdQMmOFcgxey38BOytttJV3sbsZy6dX.EC06CtNrbSiAxqUQX1Zuy02
 TYAvIfSRiXTwNm7_9A217.OQTMbLf1kzGHqxX_LmSOp6I6RD.gkY44XKGqzwGo5UK3evSx0BIBVu
 mz16MjXSnloJ1kx9tkkJobxBTKN6AHf9v9UzRxNkye2PZiFeisQWQGWEFDJxk0ckqyfmIqcytXKy
 qAudyqSIYoZcGucGaoOmLK6fdS4d7AB4NsriqbNaCN4umEHZ33YYxyiQN5cF.u09oN6loG6sXV0X
 ghVAZUl1x2vdUYg2KaRpTVJsU1uNz03yUBuqC709qOjHJaYl_kxr.dzSLzH785xC8nSLF1pFcKzY
 V9XWWZTHeX0JYusu.rHgRPM0QO4EM.KiZomI3lKUsmvNp2uwx_7dLKrKwCHas2GMVugQyhSAed6E
 HmNwQ5tr5xFMYjhKX.GmKbJ2UEkHRwuRh0PDsTV.Wi97swrCp9FXnN4hPz4O3nKYTECF28qN86e_
 aDp.2p8.JBpjDkepv8OEim4p.f4_nAhJFzbspbong7MaM4.NQ6yU.AZO_n4J4aGGsKqsCcb6LUxg
 .eJ12HElu.a9vHNQ3nqDorwExJwedXNsVoincJI.iZ3LwYiyredTRBg4DzOksAFFlEIMM.t.M58x
 zw0g_8Qhhh4o6uVDeECcdti_XhmXf0Tx9MtT51.HEZjP80YaAwM_Fr8QJY4FN57UIaP0u2m6Oygi
 2iazhxrhxO83xRdslfqJU2MAErmfKdF742iF1QbAGSEXHXdm_4hzvaun91co1kRan_22iIKeo13t
 ppSyU_PjmpA76Db5I2FoEwn27lfpyy8ygacD2YCx6NONJfZwRonQKZNZ4bOQueWMDCBOcAR0ro1H
 EA32GCTYwfH63kXc0By5E6uDBUYs1n9pJ2QHSGZX1VBcFW.zS8nWKm0sG61EggB0iOxp2tPvaz5y
 odARCPRimoiSaO3raC.VVF9_y7Q--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a3b693a1-d47f-4dc6-8929-4fb8f8ae304c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 31 Aug 2026 22:48:23 +0000
Received: by hermes--production-gq1-678d9dd684-vr75x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9afda7e456c775b6473ef75f34d3e2be;
          Mon, 31 Aug 2026 22:38:06 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc
Cc: linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	selinux@vger.kernel.org
Subject: [PATCH 5/7] Smack: hooks for secctx_to_lsmprop and update_lsmprop
Date: Mon, 31 Aug 2026 15:37:46 -0700
Message-ID: <20260831223748.4304-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831223748.4304-1-casey@schaufler-ca.com>
References: <20260831223748.4304-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement these hooks.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ff115068c5c0..fcfadd5d9994 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4909,6 +4909,37 @@ static int smack_lsmprop_to_secctx(struct lsm_prop *prop,
 	return smack_to_secctx(prop->smack.skp, cp);
 }
 
+/**
+ * smack_secctx_to_lsmprop - add the smack label to an lsmprop
+ * @secdata: smack label
+ * @seclen: how long label is
+ * @prop: where to put the result
+ *
+ * Exists for audit and networking code.
+ */
+static int smack_secctx_to_lsmprop(const char *secdata, u32 seclen,
+				   struct lsm_prop *prop)
+{
+	prop->smack.skp = smk_find_entry(secdata);
+
+	return 0;
+}
+
+/**
+ * smack_update_lsmprop - set the smack label in an lsmprop
+ * @dest: destination properties
+ * @src: source properties
+ * @lsmid: which LSM is relevant.
+ *
+ * Set the Smack entry in the @dest if appropriate.
+ */
+static void smack_update_lsmprop(struct lsm_prop *dest, struct lsm_prop *src,
+				 int lsmid)
+{
+	if (lsmid == LSM_ID_SMACK || lsmid == LSM_ID_UNDEF)
+		dest->smack.skp = src->smack.skp;
+}
+
 /**
  * smack_secctx_to_secid - return the secid for a smack label
  * @secdata: smack label
@@ -5269,6 +5300,8 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
 	LSM_HOOK_INIT(lsmprop_to_secctx, smack_lsmprop_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
+	LSM_HOOK_INIT(secctx_to_lsmprop, smack_secctx_to_lsmprop),
+	LSM_HOOK_INIT(update_lsmprop, smack_update_lsmprop),
 	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
 	LSM_HOOK_INIT(inode_getsecctx, smack_inode_getsecctx),
-- 
2.54.0

