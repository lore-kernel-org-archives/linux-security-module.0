Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D732F90E0
	for <linux-security-module@vger.kernel.org>; Mon, 22 Dec 2025 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766427155; cv=none; b=P4oc4b/TY8W93A5O5XunA5kgqYoa/jpYWZhAQUwXSIxgofceJuPjyGb3oFEVVnSO+hLekrNTuqtFoGdsAp72ur8zZ8UhXghU386F8m/6PWF79C/VTJa3zKCdypyftsbx9MArGSF40wkMpJ40+WibfEP1uNgEX/vLUr3y2ikfbLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766427155; c=relaxed/simple;
	bh=nQuEA/zzF5VDBlZks6GqQrp9z8QLh/cOjF0IcHBHiuU=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type:
	 References; b=rauVsP+gNppTZepyH9yRvzB02EtL5b551xCtJhN6uRSvILZVXIRU+hv9GpMXEqCKN1Eem9tPGt4VHgSgE1c2yF9jDEkegk0WPxyQrQc6OTqNDxVJpPtL2bPkYO42xVZdOybZdglZbMQdUDAQUVZbzcWqIAMllp+LkAyB60Rvz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=YVnS3yeV; arc=none smtp.client-ip=66.163.184.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YVnS3yeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1766427146; bh=tfNMnzo3J/EqslUiXs726LiAydwn6MiiLbbIc+EEzpM=; h=Date:To:From:Cc:Subject:References:From:Subject:Reply-To; b=YVnS3yeVyTH9u5RPbOvNxvVEeIjDoCK2DQO5rDxDh09XrCXw/8iXwdTWDZgQpryqw+O8gdZcPOsk+bMJP2zmSf+uiZVeUKxTKm/ELaCovApyxxmNqW8R0SPv4IjieIbspp5Q1ITpQKSFmtEx7BgrsKZOHL8xXruXPmtFCLGu03T9f8yGytrCaXbYYDwPH8j8v/vWNTyuDK4zbA12c5ENlOJTZ2fAXJ0MIAcPIIZ1I7NaVlLUUAqGynHKgAtOSTgg8YViwHhmJB+5Dr1gUzaKpkmXxBxh68Mo9Opsim/7ZThC7p/Uytc1RzGWu9c4Ez7n57weXs0TlpbDw8K8iqiTUw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1766427146; bh=FJMWSWfhkxCOAudY5azevwbVHqUvzeBxaGVhJXxa/GS=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=EqtOX/UnZZEf9+sEH0eEkwtSQjfe3riS/yW6d31XS3T3eZ+OZSmHbbVE3jvT+ybiSxmcCFa+/+xnq1Cxykf6BAj7HK1yFB5nEXlOywFDtVPKmJPKwxy78t0EMBgv6Hfk8TZTtSMpD/RXWYfhfsu21/13M6StbmDcE6IggDAJgn2QutMOR4X5Tpb2lZ94o+IW9VDS4SsNrNeEUpAAvL85JdeMWPhSFry+eh7576Ek8InpJOTjJ+N5w2DL66nvVvOclm9AtOZgjkZ3g31A4pQ+lmFVcPilAEG0CulLvl92oGuUJplrGSxxt1sj2BSbyqI7nnmQ7dJYK7p2Raz3Iy5a4A==
X-YMail-OSG: kEu83nwVM1meRvzYAtL7mQ9bk4phXRYo2SRbyYCb6Z6o08S7icVezlt60Tdo9zD
 1yrPyWQonXcHKKWtx3D6MgRqPo.KFkQGSF5Z.0pXUPP4oZ8rpcsT8vVzeNYmuzEjSQzCbp3j9MMf
 ggvpls2hzUM3F6Og53fNdNeH92OSaWjSkUsvpyt_bg5pChtRpp9gGCVKEFbdOAW.WXagJh88E6YW
 NvicMmEUBRpicE2ALA0kL6.oab04B1nI2TTQOgJfDIk4YA1QFqHFr7kJySlj7Cu2ijEpu8ITPAyQ
 PlulqcaDM4qY6yrlzQOTW8Fasz7aA7RhP_yMAxE5ZPJvz4n4p4VVITfO9M9PIEI7wotBgBpCmVCs
 _N3GEDgHG7YFunj.8AxdizBvkC6WMf162Y2gQoyN8CMhUS8ILAqL5f.2ORkwE162E2TElo4.Bq64
 cwok9PFzMf0jJkQ9KRbw98fwix4fqgcA3ZBd1YPPbxFdVqKcZp_MqcBjdLEC.mfCe0DzKH3ktVNJ
 2G5mtKCGT5dzl.sXaz7JipnwFjChQCiai5tb5ykgxFkvLv3OF3kXzrkGxNnH7_V2FQgxpDY.5DNV
 jfqW.X6FK8duQyZEib4JizD4slr92yDSoFAYZsGYOE0eP4KrWIxij85TkXQF_UK6llmEgz6O8deM
 v13dRhR4S7bms7OATfyvEhfxAjmoc8KC7TgRO45D38cG79YbssBRYgSHNl_v9M6uiDOzF3Zjv0ab
 BBhIb.eZqootFLOpwXt9hi8hz_GKa8wKKpx4qTCN9.sDs5H8UWL.EFQHisKuygwBq5SXlPia0HDF
 4ifFfEfMThU2PYec3U7qZl_aFDIy0Hv8GAIILQoiBw57SVYyY6YVkSHRYexdoRs5Jq26HCfhfC_a
 z0eeMCga6dYpQ730qLj99TigODf09rKJvasw8uj0Pyzl2KAd4WYNFl318p5Jea24pXurzZ._AdLF
 DG.kePspZRDWdmIenNGXXaoWanUAasEolEc0P4_uoPoeX3NegHb9BAfONHf3csMSQej6C2WvC6Bh
 wQ7OvHYd2hqVKPAlcs7tdJ25l2GGG0mbo6VNY.bLHW92NIdKeAnMRvT4ezUxqD1IRCDhZGeBMJEj
 drJimJfpqTIe9.LBoQkOgVIhRGS2aig19IAzo08U5f1ZouEtYnKMZYcR.dPEu.YAJsLJdQ623VH.
 x29IHJpDhsMN93PK_W9F49R5EcA7_VIW.7tCWgio49.kwhX83Umzlulbapf9QrbJFkpAL.o8w2XP
 ZKQ4ylGt_dDO_4y4z3uIaOq5ZeJhwNSumRZm6SY4bzoWZx_W6zxbJssXbsgLVYyd5ETOP0rorSuQ
 Mtqyo.fZENGeahMDb71fbGTt8.I1K0rHOUrfcSxdziNZkG4m7.vjSUaEjumEFfTyP13xZOL8Zn8A
 pvfcvF7Nkip77HWmS5p9PHGdY_3F1DVOhg9nKTtb4duZFgx6RNxqQstdXCCCtrV3RnaufFH9KxuW
 n5C.WGmpj4vTS4IQJqClq5ErFqDMU5pg2M2iQyMPr8QhqHP6_3dGTAwK.cVJk7_AXWHlH.OiJFAY
 Q6tZxnSW9O1OZjlZg0VovwPAr1ixOuvxj6q.99eRq2p5UKK37ZDHs76.W3eouddUIlV5bSt5E.mP
 ij3lpvir_4cxxTLajc7XmfJJOSh8_CUTy3H0ci67wD28tApgTzZiUs0qFGo54LMKtsIXwjnuKDVy
 M4UfEhsN0c24Alu_qsU99MwsohplnbEqy2KZGMvUEiXll1G4euGfeyoXS_PD5M0IQ3nyHbiAt1g3
 sxbKliJa_VG3GdeMqUSEP9Ruv6o.KdK0T6uBd.GYPIiZ9bb7CIgOPpioFyGiPvdTnIbLITMoCLbu
 3EsXCteUMdthnkp2iGpnNe_PNHkfED.LidwsWgMHzTk_ABrKu5qnImj1Y8QJbRr5nR8S_IKzysJU
 k4e_Si4Qn7SRUccKkVqUsqvkXdZclfrGsKb2czXxyhDQiFsXHbAQct37nobDltIaI23WlKBUyon9
 3Wmt12CGVNG3m4.1BHUlEQaN8uyxikHITX47Dwg6Ka2A7mdAGRbXcuvz_r6BPEcjjBdhmYj36Rxx
 hSWWcmkPHFCt7iN9IqvZja6RGQ6RFt_ZOfAaRDfSSWIBrLQPHA6jluP6stEngZGi0CIVEjv6eu7u
 SdhMfhv0E6GGm.hrBiwphs0XjEQq13XQm_UYaW0fyYCM_AB9MIUUXfBXIsKSOalmVtj0qYX5DrLW
 UYKVPHQm.Xv7sK1hD2a2TPJtRzIfcvaT3J5x2
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6c79827b-c26e-4510-9271-79f12b088c53
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Dec 2025 18:12:26 +0000
Received: by hermes--production-gq1-54bf57fc64-dtvpq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e0aff2aafe4e4f8ee4607853f1c4d5bb;
          Mon, 22 Dec 2025 18:02:17 +0000 (UTC)
Message-ID: <15895666-464c-4349-9fb2-f24e10aac8c7@schaufler-ca.com>
Date: Mon, 22 Dec 2025 10:02:14 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, David Howells <dhowells@redhat.com>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Serge Hallyn <serge@hallyn.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Cc: max.kellermann@ionos.com, LSM List
 <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH] Cred: Remove unused set_security_override_from_ctx()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <15895666-464c-4349-9fb2-f24e10aac8c7.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

The function set_security_override_from_ctx() has no in-tree callers
since 6.14. Remove it.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/cred.c | 23 -----------------------
 1 file changed, 23 deletions(-)

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

