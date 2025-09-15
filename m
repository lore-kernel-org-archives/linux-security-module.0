Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E2521FF44
	for <linux-security-module@vger.kernel.org>; Mon, 15 Sep 2025 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953176; cv=none; b=HCgJPOvvd3f/XianTGeQLpZ4LgXjg6C1E/Vqy2PZrt1uBv4L/Vkm8PyWKCS/fYV8Z+U6bibFecl5vTIJoORel/PGBBudDeD9YyXy6/blyF7ofPnne6nHc7wAPkAmvJoKyNL/E7yShVH33gjEcfxzNSz2TKRrl9wHVlCW4jmTN88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953176; c=relaxed/simple;
	bh=ZP10hKGbpqvLB9g+5dRmzcAB9ESMnLwIGOelsHpPdTE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=u/PgNYIIgtIQkpsv7/OjMfsfvrMHPchmkhFyvh69KgSNeBlMWGu4YRU2V39pTWMj7TpBX32iSMCDKEkhf0u5H7v7smKwSZlCQnE8QStbIwJ+t9KtOkWZUK+59agps1xxmx7fYXgvO+9hCEs6Nt5e5LvUR/ibYqNxd3zKpRHiDa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=r6Bco3J1; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="r6Bco3J1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757953173; bh=jU1qMWyXk2xtR2oy3+kdkpkeDxPh/dN3Szhc69LWe1M=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=r6Bco3J10NEvewkgzaqWZRKchvDUVky3sY/SqmP7WLKm1qCns9iBLXe9lKQueQQSfY3VNIfj989+YNMP//WKrLS2qacgMC9EHbmO0SC4Z7QkGhSfUwu1f9HiCdA0DRjzEQAmQ7u/VTXXcEHN+6kagUSttkbjsOUKRAGGPJMV2b5BZnIEbY69avppJFdGSJHJR30nz5QQPsN5FxkZHz+XXQ+KdW41q1FPFkmeatnKKm24wZ/iyQd/ujGYIdZRSdcA/FgukLekLeh3mXVV8eu4ctfLiAGL/c+M9AahWDFZw7ReiTnBD1AFNpikK6H2MsiiMQjOfRGUVOckw/se1ZXdnQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757953173; bh=KYQ8sp79Du/2DL1r0JmzbgA1nWObT2llfqKoLi/fh8c=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=EfSNZhw+S9ZOkEKv1jGHfAS558ezjZkRVFg4MS58luV3OrpTyx4fluvVIiZg3s2S8iHS28R+6tG1dU6PfBaRzj3fFnAqTVs/9fsYO+Gcvuic1/HSTbaBnuM+MF93fLY7sNc36g/0R+d0lgo6StLANQ6dZ+QSKWnElHH6m5sjDawd9HflieOv/7AGzli5C94VJaoHj9p6WwilN6450llkYtH0LKlC1ZjiEbUw1QYjliFb6Nm6hhpqzkWjZCM4nhuh90yhqqJQBMRpP3L9a5WeCi13PAt+AQ02knxcveGxRLwhmRVLqF0T+66ah9FGdS7B0qYSvlwS5QnglnhidNeg8g==
X-YMail-OSG: HXOQxoUVM1lJzmrHCRevUuZh7Y.0X7nOAc6M0guvEU7tq2gMspNDvBj0RUkIgNr
 d43wp7kDZqlcGfsQVJbVytv1UelZ1XlM7tsysILZrR8yn8qba.7RLG0bq8i.Hffv.gsZJG5awZ6K
 fu0Ja_mzR1H0R0XUqAK3PctWw8JGcaUGkrVxOHZX.fKnB_Iv7vUj3l26.DexTLDntwe3hHl7YyNt
 Mw60MDkhAJH6ZdTKXM7xV2z88R_M961fux8gNZeX0l7bQsK6xZdySV9Y58N9XhjTmUjZ2YJgEAgM
 cOH0VovA8Dy28tFY3aD5KPCB0e_OQG12iMDEDHNtjOHd9XPLabkc1lgHhU2X4H8RSKU4pfQTmRIN
 Qz9KRHy9NXIEK1Pz8_QucvK0g9iyZyoEAvCxx9hE4HtNuH2JV7.U6SuM8u8UhHeQoLuyZkyAOTCz
 _F_A.r0_3Jkz1c75.xXjQj5Qfw5DIkGSZ2Pgmu.9gg4iHhydfjNINtDqzvqJrYGtuIfCtlpaoCTM
 VMAbdbup9VAvWj6LB4dyxVgkjqbqRrHgOph.S_uJWWRB9OjPWk13HobPu6zaRm8UnCYrlJS2UcST
 jZa7icb1GeatjF22KdA7nU4FZ.Xqf4EykARmBsPS2.cC_qUjFllf14bVRmgUWvYWODvXD4Zntw7a
 jXnP2No4lsRoC5rm9nRtL4aWkd1q2ysHadF4SfmltYK1M4KFBhkcc2jPxc5HphzKz3c8BvzR.C0f
 db5hHGpxKvYkjq9KrR4uk42qvd0vcN2M37fuLesxITRtDNSZXUyATDZGwGSLqZxXJhVg8dyhXh82
 1W5h5bUlNSYEMElTe.989NnyMxDXsvl54Gf40ugLXnSXxK_QMvkgDy.D86s0i49K4GtiLHCkTEp9
 W1p2rwn4V.3.yrlwmwr_BPZ7rbTwIMJ9JTCq5IpgfIwsJrii2ymdDSN10SzuB6h0jWDg.pUAXrFR
 m0gU40K50WbElfaCH0Hp0DDRUyRBQSHhggifi0oIT.XbJ31vN7l_YdwsHNhvfzi4unCEZO1b2yJ3
 PYKD8v33Vg5Y5OqTvix2k5elPYn15XXbe2BP6GN4KVem7uZUUSNTYA1LvD1rhlk6WzNLXeChAiXq
 9lS56XBSyKjzbZNlhXSXbGfmYRqhcWo6xi5Hs7LPDOsPu2A0BS9PoN0va9NJ9Dy4PJxRoSgJsmWB
 RaZUWg5OnrbcxVL6e_sBhvuVm5CxkdDQtu66Bhg5wn4u5CqVaarnSvXyfGAixZsb.9o25GMYPKMU
 BT94tD9eOAiQjdnOQHBswxl6yVX6xtVdNRxaA8UtAfLTfh2tfAZZ8QI1_lJBOMv8euUfq6UK_vsN
 v6W_FJ7.s.R.wtCerA6shot5p_yGgerCm7_PiJWwl_rMbH4JBPNflLKl.07vFTBdbyvIpNxKupkw
 Dgsyh6EQMbrA80pD_W0FI7AagLVeiLUqV8xVRdhoS98Mk_zOcs9Ci6X1dZ78iFRcGqti3N9Aml75
 .5PVA_poKK4lE_TofV.silajjlnkfRV2tF3Wxi_dIcT1jZoOQNbXsxJhznWvN3rlvkVSs.WjtDwh
 RkzNXvPojpmqCdIPjPbgq5t1ZaG2om5z3g8rRpKl9srSwrewelEkhNSTt2Ohq.KwVsImJI8HNhO6
 VJvVEq1zEfpZk716UYciDSVAYHXC4id_awNN5F6QugBt7pQijCQkfyxzfWq.LJ63t.wVskF31vkn
 GW5N2jTLOsJcAP8oPFig66qhbvu4dpAfvfv8ueV56_2_9GDq9AHgsBVWf8e_VxL3phqkEWl8Lv35
 Br_2eOTqROFx2QF3PV7OShoz.1m03zHbQifuTS6LvYjgnQIandc1MWiaOazzrcjCsV928SP4oOdW
 xYFG8cX9_h63l_3L8Cux.RtP5UG9gLNE7p1tmiXdlHZeFuhKo5gDvV3VhgELTU6.Z2v21_Z8b2HN
 Tnx_h7n4StNkyCrnh4lTIlGzSgvJu9owZ9qMQUCVlGdDlPXAnEiEMW_qduq7VAmfcQ_Qb0xi1Cjp
 rbBFX0g9zQjbp3GEOgRXH.0kyBS_sA.Rtod1tGq0JTsHDQ1N6iPATQEpSZ4nBhqOWseJW6sitPsz
 Rszi7hanqfMRf4cSQ.xNkTcSUJfXVt5UHs3Cwh6WnxHFPUmo2ldp1nsZtUqpaZ.kDVzAi3Dzybn6
 CteCSzVTB5YtaNdwUhPiPv3kJP.roDHe_q3J14OG._3oYjSSor.mr5JtbSAMFfS31dL9W8jKYIUA
 AVaWK2rvLyfpUvLVYQxoHhSMvVmq_xPsMgEosZiZ0OKL2aOJ4dQOxullRjEpmuxp2ASEkuaMZIuj
 VFIfd80C5
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e70f04d5-5d47-4610-ae4d-790a3212c07f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 15 Sep 2025 16:19:33 +0000
Received: by hermes--production-gq1-7bfc77444d-9lfjn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID eae22218690b93e8de41960c9ff07b13;
          Mon, 15 Sep 2025 15:49:09 +0000 (UTC)
Message-ID: <5e8be941-626a-4d8f-82bf-e08f75152f20@schaufler-ca.com>
Date: Mon, 15 Sep 2025 08:49:07 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LSM List <linux-security-module@vger.kernel.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
 David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 Christian Brauner <brauner@kernel.org>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Smack: Memory leak in smack_fs_context_submount()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <5e8be941-626a-4d8f-82bf-e08f75152f20.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.24425 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

The mount options for Smack should be pointers into the global Smack label
list. smack_fs_context_submount() allocates copies of the labels. These
will never be freed. Change the code to save the pointers instead.

Fixes: d80a8f1b58c2 (vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing)
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index adf1c542d213..4c002e55d4f6 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -630,31 +630,18 @@ static int smack_fs_context_submount(struct fs_context *fc,
 	sbsp = smack_superblock(reference);
 	isp = smack_inode(reference->s_root->d_inode);
 
-	if (sbsp->smk_default) {
-		ctx->fsdefault = kstrdup(sbsp->smk_default->smk_known, GFP_KERNEL);
-		if (!ctx->fsdefault)
-			return -ENOMEM;
-	}
+	if (sbsp->smk_default)
+		ctx->fsdefault = sbsp->smk_default->smk_known;
 
-	if (sbsp->smk_floor) {
-		ctx->fsfloor = kstrdup(sbsp->smk_floor->smk_known, GFP_KERNEL);
-		if (!ctx->fsfloor)
-			return -ENOMEM;
-	}
+	if (sbsp->smk_floor)
+		ctx->fsfloor = sbsp->smk_floor->smk_known;
 
-	if (sbsp->smk_hat) {
-		ctx->fshat = kstrdup(sbsp->smk_hat->smk_known, GFP_KERNEL);
-		if (!ctx->fshat)
-			return -ENOMEM;
-	}
+	if (sbsp->smk_hat)
+		ctx->fshat = sbsp->smk_hat->smk_known;
+
+	if ((isp->smk_flags & SMK_INODE_TRANSMUTE) && sbsp->smk_root)
+		ctx->fstransmute = sbsp->smk_root->smk_known;
 
-	if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
-		if (sbsp->smk_root) {
-			ctx->fstransmute = kstrdup(sbsp->smk_root->smk_known, GFP_KERNEL);
-			if (!ctx->fstransmute)
-				return -ENOMEM;
-		}
-	}
 	return 0;
 }
 

