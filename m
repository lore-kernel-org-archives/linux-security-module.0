Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19435179BD
	for <linux-security-module@vger.kernel.org>; Wed, 11 Dec 2024 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880410; cv=none; b=oPDnc4rDV5hsEV/Dg2JF6HFH29Zc3OBpSdA0UUF8gfolAGDkFXbcR6akgsIY9VsGRyUQiKfcAuJ+SKZrHCq6Cln9ejLNeeu57pA9q4NSDJJua9uamoy4JhbcaC7Q96m4vOdZ37cd7oSOQ0VdNCuSTpyZX5aksbiAipwDPUWsQ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880410; c=relaxed/simple;
	bh=1wyB0Kmvqumi+3PHuP7RXOBQVO9MjLvAn5/qctSyvPo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=K53K6m82D1iYlpJDUaTKYsV8/y33ModR3WIXNqIt2V1udi0y7aVd+dWG8rTYRqldgq2GMm90p4iXk00RT8ptBLNQk4qheFJJ3A3BHxZgLXA366BkdDAljJO4KGd7jkpevGReuuNr1SAjFjRJrePPC6x9SHuBtxjN/Rff+STUSz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=D5kJQl1A; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="D5kJQl1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733880401; bh=PV73fKaPwQhm+7872eu+YF6Yuj0Kp5ow+KLi4JbXh2w=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=D5kJQl1A/VZKOFl7BPINk0sSdSmiaDFgdfHnF2sIMkcOx5U9fuecC6OkLQrWZ18/mTc6qMqGlbEgyjcueH3AtVpaV3uu+IU8hVibM4vvFdukvvtWZZwk8i4bhtVOOtgicMrlb9ZU0LxdXpMrVk0yLMW04kIvq/Js6KcKE8warN7pCZIbEWQZFxqeMIUiTHbK1Tym1MjSwwmJAtZ9vPcESFUHL/LTY0od+TRo48u7I/5Wia2XAbU3fmN17L0luy9/hrMmHwBMzYlPQotYO1CNQgw1mJR1nnHWQprU2/OlfXAqGm4Xu6yP8+alehi4yye3fiaWQuUToLb/NkTAGGYsuA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733880401; bh=fofNSq43kY+8BVcHKbFen9w7ToEhjxCBfBC2K3bUEYY=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=Tj1Hg/3GweqbSop4jTaPxxBeWR+HjYyjOUhwgyU184xZgeG9kAW2MlNnkY983o//Tf99+l9jEkoonXxF2cHjvNmzrL+r58lx7qO7iJ57UZf7XBt0LIVGzx6vsi4PKTaEtJ3qbiXMR7LBgQ+v8R0UjlEBDBogHRBiStiGHF+be5w2I/xOanDvom8I9gEnFiLkrqenCMeHTtxn1+o74m2z4zxkETnKsWYx9q7NFQbtzpEvtkrr8f06rAx90YCCV1qmTcK0FLbXX1eWVllUFkFmf8fJ2KFF5AIrdAnFmtz940JLsgjctN9ZcCk/f3xcUHqP1r7MKvb08h0hNGe4Iak3Sg==
X-YMail-OSG: WdlPDz4VM1lqMVFYjGdbKwcbDzGP8Px2W7tijvajt_j7V.tewJ_N4qzJL7bMW62
 2OOJP3ZCn.3iYAHJOKSNjOTDg6TbJMnQujHPwRlJg65Sdmg5o_fNrOGKJuQWC4DWNFZn.mrmM0OK
 7khn44EVIIX7tX7ETqAyQamDfDw86H7zveLF2w5mVVyI2uZ0Yz12PmisKNVtVsuf.qErTjlaVnVm
 y7gSqJCRk9IM5Z_W3SKoajqwxAd8A.HzB8VieIbXScInFcAsT9Xn32gnl0Z2X5Y7ihNHDfpDU3aU
 1BdcZkSqENG0cXfkk6mfaYEQ_5xFjUNMIrK9wgOdxLaJTaiOdX97H5S1bNHVtLdmqdF4n6PMLzr.
 m7vuQIEVNdzV5wM4UzOGlRkXgZjFteFv_2oYB2wTxaxoCoF06Jd3mTE1xqsiEq34yGHJjasSey4o
 Cy7ojqEc49i72q2UhfOWkkC2qj3TFr3_CLC3.0MA3zdHVCOvWifAofjUt010IeRuophZmezhQ46k
 ou1YchhuRDfWDU0.8Ha4KuBKD9prpJsVJMvyjKLRB.nN.k1LgJnw.AngSFiRB_ovdRlez9dENHhv
 aafJ1xgC6zPde7Bnx6XsyO.H2.b1.I4wxmOCX8mUfBKbaB2z5jJppkbyXtshnW_wq.SI1DZL5AP_
 XPRBmuqObytjlct0KiTRbuwKzsSTCCeMqPRB7wi2q1enH55F1EC1u1yAgbEO43Gcu2wGqTALBPKo
 _PmC0k0bOmx6IAXoBzxpSag56sNN0IRvofyoTdgyv3IWcp87qz5qAg03oIYg0xv5xbU3EusSQJjC
 K_BkLmXN9Lc1.wOM6ZIh5a5MOV7TC.Nmz69kh1KdinUi5bBZ1JnmmahMU206rM.QdLOce4fzSXr7
 9ewEW_oeqeorYvmEe_xQ2Y8DPKeWPOpD2uwswT8UxiJKE77Wjs3X9Phom5NuorQsWqsXRSFDHGWJ
 75.IzPuPn_nrAxI3GEgfD2ljx92OQfD2M3p5Z3y3XHTm_ywm_Hblzx_npzSY56DV4lLBeWpYscd0
 dwZQxlvNgen0sQgHvv3dQ.I3NiOaS80b_ZElR2ASCCTXhT.JtL..EmOYFacjUirlS8LbCI2rE305
 rmT09etIVvlBT5a_.UfYAuYpVI7qJ4xWfyAgSwf.nGBBnfzhrK3fQEq6S5ZCkq4b6bg50FxQoRHz
 AD6dTuq4bgV_Ov50k37U584kd0MK8jYBayMUBDsnZtT8.akoAvam0WJ9xYANHWr4dSp9M2gCH1D6
 XrMnh2tcMag1xxsDbYoq1UosSlfoKK7Sh_ImxcOye_YUQIDwKcoOxnhut8Y.AFjTQ2XE2iL4Sd_N
 K48U7yb4oiI58dRO8QflPz8btqGSmHBtaK6Zx5Per5Hd6YFA_vVHzF6Ae5wlpi21NS47qEiufH9J
 edXr.1Oye4htR2vL_fMiXodBFMzxngfutBI58O3otwoVVSE818bRxREUkAqhRc5SKzbtcWCJa.5D
 7DN5TlHavxsWJHWlqvHh91ccq0H.ZS4A7SpYOJ047NMPSWoXhqcFnJvuCSO2MRhciAGU_ux2GMh3
 SVGOb4nwNbpZn61wJzko27gPV.5s0MFkb1fp3SJxxHG_q7ullSkW1_keNHEXx0_xLRH8UTRE0ze6
 fe5G6WSwBnGvvNrNsWuAdkBbr3z5QqHHzsJFQ__2zM9KZUywievrUkjT272i89WuHQvj3vNj3Orx
 O7XVAtonnyp3IW0rI8U9u.b3icxclqqDAEzLNbXz1kfwOTuhujnRZkvxO3JIrf4ms.KbARxSDeRE
 OcNbns6TbGjSnZDZriY1FEJEh9XexYT1E5dR09fhLeFt9uGm5Wom4hBoMrlqTpQ0zaHhK2No_1K2
 hQFoCCj7cjdWAW5G3GwbwPw3O_wCVeP_1YxjzY8Ym6NzV1FMpIIuKsEG3ovXJazoIzUZetrYCXZ7
 RDqOgMDoBqJWEnW7UbDjUiB4MfEgLPHeRQUAxL29zk0zYeYG_U1OEDOpShmcW9J089DbCRUeb5EZ
 WkR.L3hGfdY6_UcmOJVJEc._aT59KcpUgyqvICYdc8iEOaNRow8pa68bUSz5A56dhfW8J2wC5dI_
 l8GcZdx.76LbmNepQFjQ9zRkYqCsj13vqCp5RSwAqJ6h_YmURHDZbVt0Xh3ccNbjk99_a17T2IEm
 _Yxb72eisxnipanN6AexiB1y01vgXlXFnopFZptR6jbGScoq0KC0Ur8q.wRbwQDjd9l7cFgblOV1
 Ix8TZmLTNY5GwrvIMbDIifKLR0WvoLITc69H6_mf8o238YaZSnVJnu7gYwoTq8Y7Yn3V4G0RlOE9
 9dop97spW8OwS88l0JnXzBg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 278ff861-4a0e-4196-9e06-64036015fcdf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 11 Dec 2024 01:26:41 +0000
Received: by hermes--production-gq1-5dd4b47f46-k4d2j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID aee1f1b8cad054045e3de593974b672a;
          Wed, 11 Dec 2024 00:56:18 +0000 (UTC)
Message-ID: <a5ac15fc-440e-4483-825a-2d6f08083af3@schaufler-ca.com>
Date: Tue, 10 Dec 2024 16:56:16 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>,
 LSM List <linux-security-module@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>, Karol Przybylski <karprzy7@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH lsm/dev] net: corrections for security_secid_to_secctx returns
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <a5ac15fc-440e-4483-825a-2d6f08083af3.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

security_secid_to_secctx() returns the size of the new context,
whereas previous versions provided that via a pointer parameter.
Correct the type of the value returned in nfqnl_get_sk_secctx()
and the check for error in netlbl_unlhsh_add().

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/nfnetlink_queue.c   | 8 ++++----
 net/netlabel/netlabel_unlabeled.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 5110f29b2f40..6ae6cdc5fa5b 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -470,9 +470,9 @@ static int nfqnl_put_sk_classid(struct sk_buff *skb, struct sock *sk)
 	return 0;
 }
 
-static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsm_context *ctx)
+static int nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsm_context *ctx)
 {
-	u32 seclen = 0;
+	int seclen = 0;
 #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
 
 	if (!skb || !sk_fullsock(skb->sk))
@@ -568,7 +568,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	const struct nfnl_ct_hook *nfnl_ct;
 	bool csum_verify;
 	struct lsm_context ctx;
-	u32 seclen = 0;
+	int seclen = 0;
 	ktime_t tstamp;
 
 	size = nlmsg_total_size(sizeof(struct nfgenmsg))
@@ -782,7 +782,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	if (nfqnl_put_sk_classid(skb, entskb->sk) < 0)
 		goto nla_put_failure;
 
-	if (seclen && nla_put(skb, NFQA_SECCTX, ctx.len, ctx.context))
+	if (seclen > 0 && nla_put(skb, NFQA_SECCTX, ctx.len, ctx.context))
 		goto nla_put_failure;
 
 	if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index bd7094f225d1..dfda9ea61971 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -437,7 +437,7 @@ int netlbl_unlhsh_add(struct net *net,
 unlhsh_add_return:
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
-		if (security_secid_to_secctx(secid, &ctx) == 0) {
+		if (security_secid_to_secctx(secid, &ctx) >= 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", ctx.context);
 			security_release_secctx(&ctx);
 		}
@@ -490,7 +490,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 					  addr->s_addr, mask->s_addr);
 		dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid, &ctx) == 0) {
+		    security_secid_to_secctx(entry->secid, &ctx) >= 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", ctx.context);
 			security_release_secctx(&ctx);
 		}
@@ -548,7 +548,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 					  addr, mask);
 		dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid, &ctx) == 0) {
+		    security_secid_to_secctx(entry->secid, &ctx) >= 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", ctx.context);
 			security_release_secctx(&ctx);
 		}

