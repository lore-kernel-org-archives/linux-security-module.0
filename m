Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA658155342
	for <linux-security-module@vger.kernel.org>; Fri, 20 Dec 2024 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734733394; cv=none; b=Hbx//UeRL2ickg2tM5J/rD+3beY8R4odBil/sfqQ3DQE+SpvJzvheO8vYhNxlVYs82Do/ragVk4mws4hmgsjqB93JowqD0oxCI/u3SMsBAiEL2h2sdSuWY5gR7uSrpruaxRgv2ya5WmYTj76MDUYtIP163qkh/d1pCASkUCLKmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734733394; c=relaxed/simple;
	bh=+pinxooH9YfYNFVQRkfQU0QTzNRpWhJroziKMZaRDcw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type:
	 References; b=tcShwhgB+7Ox0wj3+KQ1G/pSS6OU50+5CNgcu0J04MXYFDXokQFC7CmHXKMAwsqKSCZk5NS/9+/2ueq2Urxg3T3sqV7yGyuojoU9zDPEpWD9NAnGeWfW3vsiow2ttBQZgDpvjlrr0MXVBpYQm6K9sEIru0Yt8agRMljLePetI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=X15CZl3H; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="X15CZl3H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734733386; bh=GrXlJH5FlMn/c5i8Tx9M6gzdkVIzOVqGVuZ4Lixivmg=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=X15CZl3HbzGDaNiyvYfxCLDdRvZVuzz5LgSD0I03esEiO07e2FW2nmLW9LZILrQRILsLjBV53BnldEGQtxk81Smi2UXRVBXZ2LeXVUhoNaRcIlfCo3zCt9WYIuAXP11TvJIEGFANGrg8ALz9qI8KnVxjFM4b051lgFKFrFYNAg2zeH+grmnO5FRL9S2mCaB05z2AGEFSqyqOI+1tNh/yiHymuDI+byNPqQGqCLCTv4s/4PrxDjFShKMDejQmSbFGGHoxq3ymbJ0sg5CQPivpBJzyTbVLaoHmnYJchBRg5bZB+o8OVrs8HTqmMc+G4O5ujnRJNiIJWYa06xj9FAcU/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734733386; bh=Dw4TF3yzaJNyqCcTOEtBIFRK+Whi1KCEv4aVaOYCfj2=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=gBxsgQ6Sycly5Gk6oN/XOa33aOpETPMeNAZ/Kgl3wuN1bINCMKOgBlwHDvdeyFr+keuDJRm4mN6L3f5NjOzmjFSyjf2zesYvFd6wElpMqWgudRBvEBUtGFNrHB7Eq0U/csVK6pQKCu7tREry7+CuNLgBtlIbDG08iT+Gs/1AjG9adIzUOdiQZcNMpv2D/2PUMhmetZzPcdHCuzF3dyteoNy2/KTv/idCJVB8xfDLFKyEbNkfjTz4wE5zoGFqwqLQHSRnfX12oSMADAOWtfbv4XPMV9bpSzbMwY60HWcT7bl1ZgCRoApEUGUlXl0PN1oorD0Am20rm1vCPoSrhXJclA==
X-YMail-OSG: sxzkUNkVM1lxBgfWOMoQ.flRn5sA5K6PHcuotjHS9YDz1ZweOjM1X56FH7B7sdw
 _mhTcr7oYvuA4OMSf8v8CpLAlde1a8qWNvACN_rixQcOcQwUml7SIkgz2OixSeZ6dBViwXAXAp94
 IBQ5EkQIxkCESoF.DTZTQ5lPUC2yJQvSNYnqaKps7a83lH8HOcBzhyar.riRhzsZMSIaQVolYdk_
 KgxbpvUAcKaoyMif3KPqGauanowOzI8A.cBoUBFcb7uHMuyPiOzzdpj1qY7r9Wg9KDynXrsBVEVh
 6sxztRJNSr2E7yHYRhm1xq.MxAIPwum6oFbariwSyuKOhJvQeqqxKHqRaS0SpVZc02H_sjzqbGQW
 lD4l2pBlAPZz77k_74NPYALy3GSkfYayKpFkDTX6X1h3zA.3o5Eynu_6luHian_heR7RdOSJF4WW
 ubYiY3mC.BF_xl0OeiWrxi2A9bY9G6_dz0CziQxlXozGNVnMc8fRXRogtS9AtINxrZ_uEFHWubAo
 4Yvw7VE4WXUFXFA6Vu9ToyIB2R3MNoYWOATap2EX1l3RpK3ZvT3fNVLq8pUa5oBQEXrOem6hLQyH
 jJhAMeFHThWnkMfza4q2W_fVBeLS7P5dfIGWSBSRJ2.0GPST01a6l8lTDv_oBrCKFzOU_vvt4Jbn
 Zl1PmR8XEU6NzLebTm97Y9_wrdvWhIPO2K5mJzagyWzx0m3td9Atk3mfxreQYKEvv20X2keElDpj
 YudHyI_QbaY.sN9gahZaR.9hGaXs4DW4lBiXF1xPPLNnQp.ie31tQSMoJuxtkqFZATordCj_KJhb
 xnXbCzkgPVaplowzs3l2HGIynfZrIWrcVrBjA7Zvjwd.TkC1Oy1bYD6yZiUEzt0vR4qF4cyP7Ii_
 UdZaGRVAepvExCw986swErHcvFJ1sPIh.S_OZ3Q1h11s6cPQqKucAcH0jBoqp269cBH6gi7_Rtv5
 h0bQYbHXjfS7ck26dEC4ZAMYZnUHbcxjVHH0lEX07N5R4fT5NSCy7UGuGZolBTbU2FE9d7csYvVN
 ViZtB2xFChcnNgnaZK3yAGOLCQ1fOigUs_5qPiQgwBZnb7aI_gwY8WIDR762o6Kaw89I8erph8Fe
 h_FSz_EX0cgfjmiXI6UaXreOwX3zRBd3fjjbEJG4PfJglDFOhdZ2OWS4p6Beh4v5qLrvbJ3urFt_
 kt6JTD5173RZ_I7SjlT857x8USV43ttl7snlPWt8QAYT_Knf0qRnCOgHbcfG29f81_p...grDIjy
 RB_StYiyxUmrepZqDvvDryjhLq7VSE_UY859KYO9p7WF2MrUPHmttw.BQ1itYlnUvletT2VGhsez
 .1qtYu0yp4wL.Wr5TRkMqTaWBWXTkChgJPxG51Dkwt.7mjAecb5.WiX_b7GWtnP32HKRg8rmB4h5
 W_yTsHf9R7G1w9HViHKNJQFUzWZwMjdwKw66YgJ2i9yOmZfmHu7whQ1prk58FnTfx.QG18AD0eEw
 xz0uX9G1hZTjM_XdxnAhr0MVO4XK5elETK541AfhBo.ngi8e2uD8Gh4BE_nWUNRvLOIxUqqb13Kb
 7koQQ0_EgDm_6ynfCslMs_Kfa350yhTH_FqAMpiN5PLq_Ji7Pn0t0F4homs4KK2L.4zDU03fSoo_
 .LuCqpJMLgOsio0JBvKQH.5uzHX1iO9.lBi0MReKU_BBhe_dFdju9fJSZP1JTHlK3Gw9wyOFC1Hv
 CFOIMYEIUx8WiYnGxwv6yotC1pcEmkL3chilqmnKM0XpqhDnlTgFAl3LHrLfSp45SqWZSMNhrW3M
 XGqFYB7HpUBOIrhki8Y76MD5thHEMYAmjlBtxkqspx32VGJLS7GUOlgPk7JuVNiVn47Rw7VK.wRO
 71m_PllEnZByxj7df7rOpQAt_JFQnMwvYoxoj6crke19GDy3fACYEigxoW4XYft3fVjs7GKqLB7m
 VS7QZ3O3NLqtK7b4MLfL2MvZPvPUgMVsZRF8Xm5TXVaSqikM9ah5F6IIPMxORYGnK6Ye1Tm3rxgQ
 PnVNfrdQnA6mtSGEOlVicfSK8UJKT2oPXdLoDLuYVKLR9dt_5TPnjLSPfzPxGhjAOlsXdhseK4PQ
 GSN3fm3CZVm2uJAzccuS0etHHoI2VWMp37uewNU7SgMgn5ISZo76ncqxemggyriKEUYKkQ_eaviz
 bDfnE2HNq3dCDZTOYzh4mc328gjs3rHsNB.F_AAWd2SAw5cXFslxdlVo69B8dsoLahGGYhxUqw8k
 6X6NMP_VoS915P_83ZB2zbFb2GbYHjD30N5PsbD8PnB_2q9IpobY4T9ozfQE26aUAVbK9eWb13PZ
 Jn1Su3ruy23Zpiz_kzBBf.oQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9c858d2f-c178-4013-887d-3c5c2d752bc2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Dec 2024 22:23:06 +0000
Received: by hermes--production-gq1-5dd4b47f46-5qmz7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e507aec9745ea7d4617055aef3f2e491;
          Fri, 20 Dec 2024 22:02:48 +0000 (UTC)
Message-ID: <2ac1afc7-8549-48eb-ac63-daea64c3d80a@schaufler-ca.com>
Date: Fri, 20 Dec 2024 14:02:46 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v2 lsm/dev] net: corrections for security_secid_to_secctx
 returns
To: Paul Moore <paul@paul-moore.com>,
 LSM List <linux-security-module@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>, Karol Przybylski <karprzy7@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2ac1afc7-8549-48eb-ac63-daea64c3d80a.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

security_secid_to_secctx() returns the size of the new context,
whereas previous versions provided that via a pointer parameter.
Correct the type of the value returned in nfqnl_get_sk_secctx()
and the check for error in netlbl_unlhsh_add(). Add an error
check.

Fixes: 2d470c778120 ("lsm: replace context+len with lsm_context")
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/nfnetlink_queue.c   | 12 +++++++-----
 net/netlabel/netlabel_unlabeled.c |  6 +++---
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 5110f29b2f40..5c913987901a 100644
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
@@ -643,7 +643,9 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 
 	if ((queue->flags & NFQA_CFG_F_SECCTX) && entskb->sk) {
 		seclen = nfqnl_get_sk_secctx(entskb, &ctx);
-		if (seclen >= 0)
+		if (seclen < 0)
+			return NULL;
+		if (seclen)
 			size += nla_total_size(seclen);
 	}
 
@@ -782,7 +784,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
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

