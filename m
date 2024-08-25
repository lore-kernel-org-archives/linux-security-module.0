Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A0A28DC1
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724612653; cv=none; b=DNbn/LCYiLS4AlpLc9I/GwMlIuWZdLb4X0+Ew7k98bRudVndBdgwLqYLqxzxIfDX5FYgqiQoleNYCRQPz2nRJ8f978TCs+Q+E1UtTeGv5ckvCQIDY/b+Bn7IKj8ezd1Y8ES4NFAQ+7A4HemShkUR+Z2xK77Eh4QTPpKlQdNl2sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724612653; c=relaxed/simple;
	bh=nisAlOqrbSB1p/Vv7LMd2fNCpuWwRrGJ71NJb4sjikc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UN1artUZQwZZfMAs0t4SP3iU1DQTzvASXZt3kGT7UVmZOPCt37QHXwtIYLDL0YKCtIZ6W2fY67mMOO19NYv0qrb5HVEcjI4vfZlqz+V0cSvvgpYT3Vrk3JU6BZIjioVDQZpb+5jiqPGEsnUpSqTal27AA8Q3Ody0lTJcZ/VCjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tAVu2yjU; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tAVu2yjU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612651; bh=NlnwdP3mIK//o8Be0+fD1f34cp8awF0dOr1PdMaucwc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tAVu2yjUjWiRQE4CdIaVZQkWxXt5e5QqVw6qwKpcFgVhAGRtgF+3Rl5Npb4htCYbvFXi+P2ysJEI59AIw3bpBaWejidvXfUZXVcGjjoRMj7HKjyPtIcTakR9E/7GNuHBnjPgO9oZG7nGX7fS5JEUylrxpD/M5yd5/uHEr9V+fyPR2Xml02VaDiTWeFJ2VlJqntRWC+MzhXmK5c77vBpMJh/e+wc6eMvXrIIVv407uyN3PjWMWN+b9bAlaw60qMK54Bm0NoSSf0iWpU5twa8y6TUFSRrWLzuYtTDBO2GEUVJyHenHI9ctczsb7z8xtbXvcXIsr49RbyWyxbs3qlNUqw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612651; bh=3EB5yf0mVCE012aBk1XEJJzqCFIBgKE1Zl4yd0hHCRa=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Kjc24T326gxDqJfq/Tm/McSTSfr3gF6aSlUFujBVF335yBAnZQtOPMqicWeQhafJW96SQ2xzYihRd2uAovvEitTi4iScQE+tbUCgEMGliLD8qi+mafpYTDEUkUlrN9BUC5Fgyf1mTDbGne8ohgiWs+T+X2vawiNUOkk5+1t2oTipE9gXeTO4wSoaIIRMDqATkY9jNVoa26NcT5w9lpBXfpz4VSDVYnz9MFGg9xfEZgm1aUQ/5HAe76dCGzMcx1l6z5yvRJQ+xis1McQgmbXsWi/mgPU+DtTAzTeZz8Vw7DzcSvIejIitzQJzFF/W8kjXcZgNLG9xzO/zXzbyouZnmw==
X-YMail-OSG: S87BsjIVM1nCRPhkfZTfGOiZI.C1urD_pLaNLiIBCf3u6Yj1twjgF.ZQQ5jf9K3
 KWBWh3BP5Y_Y_7z2byI8pmAzFFqDtkTFEcJ8dgEOysk79uf5jRVq0X7zdO4BIbvBU18Qpp7ZxT16
 B2d6.QLd69Xwt4FwETKTpCZFb4bsrU8H5lTRSkXcSy5j.lbdNsvf1u.KikecOnuUzbKDCShmvmzR
 6owSpB1Fk2tnxHLnd8va5AHfn3WiCis8lAQfV_LzRJAmIsUdS6epHtXEelQqMo5etCT1l3N7.yIG
 amkr9ortOIcXXoxLJQ_ldcTvOTTHX7P7uQZhXHwdu3ywqY.H1CAv_J8REJe5MqBK.yMJB7tFYFM4
 r9DiSPcWyaQ2keDbsaTUCderbQ7Z1l0Um5qeys5H16LgLFB49F3FrYyNq6Yjvp835LXZx5xJDw2c
 Pfr32irUklzdii2yTmxZYD51Ywv4.ovjlyJpl.5qBc10f3GIjCHqsyMUvA9R.B_1Hj0fbfHzD6.5
 qR2Rm8t_4q12tLwCuppTpqzUxI8Ik0iFltHpf8e1DsRncy0XcmAHEZkKb_CGkd1Xsg_3yuv._wxD
 kFzDXdYZEMe7SKXVJ4t4HF4LqkfR6JMw9CIJXBXYVsoBI0g0feCq1CpVuIhhqM7qWJKQY7fYkK_e
 MyzFLtCz80IRWIJiVFoOhvUuGJ3f1sDe9pKGLb5oMCl0Cckz9j6oqJrsyxMhVYXLYCJgFHktXU19
 PvyXavgLdPZWSFnEB9hOeuIOravsZTGqcoTSIyDpiWk7b13mG7MHCvCGIxwTx_jRfrfaMvz5ZP8i
 h70l3JMZmozrUEq89QWI64hwkXU75OnSV2YJKm.OIRxDQiyaYNekfJJuXDuU.Q3CIxYbO6CxheIE
 oeWA16KHRJjTwPGyyL3CjSBPCMbvLgog5G0efmG4mUltc8fMqsN70wYVDXBvhNVCa2BzLqfQiHcr
 BCnMCopUi4iOcGpqA9kNvG5QVNecODoXNYLm7u8fZDeZoUuFWn._iyJjMGZumC3dSWbHyY0Nf97t
 XFPo2Qu8O2iuDTHFyTxcuvq9T29UxFa0xYGBMXMLBmapSGQWf0FE4urm8dyp2s66NmGDyJzusW1I
 1Hba1_FwhNicDVsdOhtFfmFoqJ3hxYigZVyCAMsNljdZDRE1gskrs3oLFJB5jWhaA05hZxDDCB0h
 .zBMcxqdn0MDdoOPftvQ4DNqroHfamK9aJ6h4TiyvxkN9npwbE7mOrj68hKoT4UTlK2SylUu4PZQ
 oHi6GDkPeLTZZptVT0iS82.lRBznk6ZKcfFJ7aM4VRmKdim41USrzktpG4C3EMBlXJi_fEUTSv8C
 y6w90MFY.QvnrxkmpMLV7YFtujvG5aRbYzW2Suu4woLbxIRPAYRExBO0UkxAi1V0iDjT7LOn7kJ0
 KN1QRCX1szHvho4rpULuVNA0wDbGlnol_UpObq9KqabJbcIIp5_hXmUlDvAEzoH98mBHu5ly9FcO
 ZjXkM1SDACui.KaLv2k5sF5AeJqFfgYYKN2YSsa6xaxpjRGnr0nRlxCgvTPzzhakFv2oK_2f4Tfe
 Jn4XNK74wvH4l7M2lEbjBa2wjmzWNdBBfpUWu2OWsGofh0jdhUt0raRzfI6tOnpfxTvLv2SOYMlJ
 6eA8vLixp00jFtMBSnvPWu2cKLKloiUVdDCVcLuyxg.Lc3bi0kf6S4Eq1LDJtTXXmkY.PtYSd14t
 394Sc0Jm6rBHH0ovEYvbZA3Kt.JlWbThSfOXJah0wqB91QBztrmHdJSEqbgMX_uwjlm.fQZl8z8H
 71WVY9Gte4D4eZ9RyC_06LvaolI7aK1wXTd4B7TXKJwto.Aim5wRYepQB8TC0Gw5.G6rpnesVXAm
 vRqacAek3p74z6jdU8T8tjrtjP9B52UkUWUZqd2oJq32uPQRHN8mssOGea3RtSLMsowTMQNN6zXf
 UtQZhmvtMK9Uxawd.GrxVxATlvigwIu9QKJdvqf9Qv5jucKUoZ8STMOUAkqQvatchelWS8A.Jt98
 IPhjh8Eyd2lZKdN_g5ClSk1uTwbnGb8F_Ewi_YqJnfs2G0vrP7zMjfxyZY0W3ut5fhuJ4Eeo18qJ
 lPNw8dQkHkRzmDysdMo_cf7hTEZ0dSWEyGyQp96mPaYZEFrD.i._pKr7A7xIn236TTeeM3K_CjCC
 L0STLwbI1.trBMaVLF5.Abp_Q9c1oVQohpnP0Y3zJmQaC27IpMuacB0HsdecD9jb1S5ZsfQG5g10
 nxTVftaSDW8Qi6U1lOXYyOsdOUrcS7C0_kjgHWU7E4N1AzBSgJgowifArxB25R5hN_R0vEd7b3Ww
 gKon6CoC7eSUlBxnsHtZh6UdzMNSJ1Kce
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 117f4ca8-956e-48ae-bf73-d643d65f15dc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sun, 25 Aug 2024 19:04:11 +0000
Received: by hermes--production-gq1-5d95dc458-dxlpk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID acda3a00d6062e816b69b20719962769;
          Sun, 25 Aug 2024 19:04:08 +0000 (UTC)
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
Subject: [PATCH 06/13] Audit: Update shutdown LSM data
Date: Sun, 25 Aug 2024 12:00:41 -0700
Message-ID: <20240825190048.13289-7-casey@schaufler-ca.com>
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

The audit process LSM information is changed from a secid audit_sig_sid
to an lsmblob in audit_sig_lsm. Update the users of this data
appropriately. Calls to security_secid_to_secctx() are changed to use
security_lsmblob_to_secctx() instead. security_current_getsecid_subj()
is scaffolded. It will be updated in a subsequent patch.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index e7a62ebbf4d1..9dac776b60a7 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -123,7 +123,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 /* The identity of the user shutting down the audit system. */
 static kuid_t		audit_sig_uid = INVALID_UID;
 static pid_t		audit_sig_pid = -1;
-static u32		audit_sig_sid;
+static struct lsmblob	audit_sig_lsm;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
@@ -1473,20 +1473,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
-		if (audit_sig_sid) {
-			err = security_secid_to_secctx(audit_sig_sid, &ctx, &len);
+		if (lsmblob_is_set(&audit_sig_lsm)) {
+			err = security_lsmblob_to_secctx(&audit_sig_lsm, &ctx,
+							 &len);
 			if (err)
 				return err;
 		}
 		sig_data = kmalloc(struct_size(sig_data, ctx, len), GFP_KERNEL);
 		if (!sig_data) {
-			if (audit_sig_sid)
+			if (lsmblob_is_set(&audit_sig_lsm))
 				security_release_secctx(ctx, len);
 			return -ENOMEM;
 		}
 		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
 		sig_data->pid = audit_sig_pid;
-		if (audit_sig_sid) {
+		if (lsmblob_is_set(&audit_sig_lsm)) {
 			memcpy(sig_data->ctx, ctx, len);
 			security_release_secctx(ctx, len);
 		}
@@ -2404,7 +2405,8 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_current_getsecid_subj(&audit_sig_sid);
+		/* scaffolding */
+		security_current_getsecid_subj(&audit_sig_lsm.scaffold.secid);
 	}
 
 	return audit_signal_info_syscall(t);
-- 
2.41.0

