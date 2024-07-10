Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE1B13C3F2
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647164; cv=none; b=Jik11js4vzgCfjsFuaueRRn0IMNTBci5svg0IXe9FI3p9vBTuhNDAAqDjwfcNsMJEq4bx+6aORjeW/DF7VO6yzxjn2raUbgxPQ0NiFxh7r9mnNXgs6yXmnLHj/HcazcT6ZoEXbRTmrQLOCIcCMDuBtJPzLZkbF7kHDQS9kaFCVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647164; c=relaxed/simple;
	bh=9yBwzgqAHk/G6Au9Sx6ODpCYBVRbysGoo9TjNLDvbsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=leDuMnQSVqMDmEM4JKTMxiSaTDuw8cjfb+YXoIltkLtZs04QDsYUqdMjkbqcDMh7+tfuc4ex5AsaoWSE2p6MBLhkbPk19eVxuTNx5b+pi7192D/G5hqTGrSUYQnEi7m3fEayHHwjuCEQstDnRi83fgAREim+twzW/I4cYb27WbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=VA3C1pew; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VA3C1pew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720647156; bh=b7b3GXAlU2glNXwloqVD3w7ERKrqK7caIaq5HFy+qSw=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=VA3C1pew3Bt/sojm47veP9MSfNhXfLRH/7CfPPLT8B+zENIt5XnFiGIppvUcK7wvOUemwCFO7HPliOvS4veuoBXFw14Sxr6YY1HBJ49b+Noo1yf35wMOiuV7OBB25z5lR277fEWX/KaoyndJf0mzRkQm22TxvUk9I+Co+ZpiR/uco8MWlRG0kN4xGK6AHZ8Taud3AC1saFGNXxaYkcLSP5q5bHvuDqw5uxNkMy9bS4Ak+sZJ8lQMrcwqExIEA3/2FfArgoAyBkhuQHF7ZaZf90yr47UTnByEEte8HK5pddJ5sShBvfeGDQX5fe42Zks6uwEbCeRLstUbIcslyL5PBQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720647156; bh=Mdho92EjifXCm/S6fuVl7ORrvCVirJiflQt1zpNL2eN=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Wqot6sZbMdOHCcjDF2q+jq9akrov/tmOqhnSh7uyYox5lOa2yrms3EsCpKT3En19mir0WkwNxXVdlHZvn2A2/Lf7y7mSJZ/bzsG9A2lryl6jOMgIGdApqB03IeXAASZqa31jsHHQvvJS2/NPcQAq4SQI+8mhChx18bsngoB4Xwvx2QBb7syTsJIrUtIFk6gHK3hJgPQP/gPFVPKLFV9yC71LRIKYIuvZsSMGKhO5H/YTkyuaBu1FDOMcuRARTSD7Bddl6L4FGFaT6WubrR6RGaAWZOFWouP/WrWMZcYJAONuwm0P1cCT2VYHUcoxhW1gZoUBjIeCRORTZfxqmpAncg==
X-YMail-OSG: n0BOOIYVM1n3KfiUG5DkrvsoW4lBLbH_3fVBg7Lu.iG_5DxLpKU_R7YAO_edd1u
 zhArCWd62JO4ef51deub1W4WD1SEWpzQOPIGmjMPCHoubOA.v.qSlxMRV9H4sVKPzc4EcsH73GYg
 KecJlwWCKrINZWcGALrH4INnK_4IZyveyTNZC1P9yn5iXkuOQ4gcx6Xe7Y4i7HbcWjDduUyVtOk9
 iF_zfZEvPnDDVYQ7csNHjNCIQmT4LBX8yyVwfGIsbYmUSxnFDIceBuCeE0P53Ca9KPHSbp3pzrtz
 ACNZbjxWZGdxtQ79pj5ULvGkmhpB4_dghqg6ImTnqaHfkLuQ9Q13GaBe8JCt6d21yD8LqOc5Zqqo
 gpSW3SsrZ8Y0imTh1ZUmABGab0dhcB.l9HpW8SdqikxFhB0lUTyDem1PEYd2VOXUZwaiF9B1h3gm
 WlO0XcOlLduuZAvBhDYv.zNDTr.DKCt9Tf8Uv9j2zpKquAiuvEXfNCKS1ldFOEE8WzmOoViMPBSg
 AvuKz87celaxPjBqGtbNzGuNkQVSqrFum98R7w.SO8FpYWnaECOlxuaVL222a8Cd34HXUeCGOzel
 .L_KxIyyFIwnl01nKJGnZLNS83_bLlMrgSNjTFDZt9n45HJAFfB7AI9YPmF3TBXAcKUSkqifdk9o
 lf.h_5CbtzGNJlywZNH3aFuWBMgJJNZKZUrggc_aUY56I9EgHq97YsEvOglfqf2wh.EQTVyYtvzK
 5nBOqskqlNcRIF7zOjqsYQJBrGKXhrqsPj4HXnK4r2JWGpBI1ocdRMu00zldUQ4mHpJdrQcT6QDB
 gv_WUZZdx8UvCqXu.iPd_qSBhLzUbp9VnFsOccU2wb_1_wLgXDBkkmZV9aSj5hk6aJnhnre3VVlb
 0SqqxuI5qVW49locKhGWcDYYU_9X.uWDToGs8yfsWKU82KA8QW5hHG7_7GcBGgyuXQOcF92V52mI
 suVPpEICbqJ_N_7vG2BJ.TlDU.oKgYq5HQ2LMRs3yw33TBpBwR5..KUGeEb8XARLil2Q8JumTsHx
 wY0LDPwzYHHdo7YEfZrbL8TG_QQubv5d9Yz7Tb8EPkOoQZ_MEvoREp.lZR2H8wNSCfkI08oPtlRM
 ssHX9w596cmkm4WUxuZYIjEpwJE71FkYT6hQ6TFla1isDjNXwhICauT2ROxCqHQ57mtXHq3zWVP1
 rAOk92eGLSuzyq7Amq_S2RBRBjc50y7k8w5aTSlJo6ilxsHD5QqWk1NdWd6yArH23bsaXRfmLSyD
 RLS7h8e__k7Rj1HE8uyPTqOKrZE7AaNCaLxsmOZiB3aHan_b8Y16IX5C.MTllmXEhlQsHlsL2uDX
 vVxpbjLgG.C2kgWt3XIFq41PBTUh_Kg4RWGWBs_0Q9csmkPQZ3uqbpTVRjJlfEItl40oeHMGgByg
 nDY.h6PHu3i57QStDx3Ou3zEPvm1jlB5d2uujYP009NGK2VGa69_tfkGJCvYRsn7ccqJhB7Pj4Wl
 V34LxAbpSAIQ65Ebbmo79RkukKd7QAGI.U3z2PNykJr3oZl8Uv993JpKgdI3yLse5PvOboVVpFi1
 cPWfLPSnSgeBPwwTjLF9z9.BcAugn24P5UnDCnGBrKmYmqjIinC4EOUdeeR2q.pHjg04aKax2GUX
 PvQ2EhK.3VemKQKHDOFzRVSBqKgy7MhJNeweS5s2MG4q990q_ujDmrrFIqHZzPZ0Ju1PBbL4yyGN
 HQvTYfcNcnApYZ.ZAdh8eQw_FHQBph4EwT_M0C5y9P3Wnu8x5tq.Bo2xnFDqB4448TEX9vNgJNNV
 czKIznrU3t0M.xPMiHseO1UcB9C.M3pIR5dVhV06ykUlHjwpAMSDp9ikVu0amI1ZlZQY.pxHIm5j
 PrcviEzy12AjVhuI9wdoKxHozbrqzixSq7mWEgFMX_FV3xs5XFNpQMKkGmbbsVIgwWh9DCMlV2wl
 4tnC7mtfCgIP4A2689NZAaUfI.7AYQEzOvsK.hwfAviqfOcFil0l8F3Rbj8yO9StnnXPh_RICnao
 Rkpo9HewI71vWWusSH3gU7pstbMlG.GQB3Y6ZysIjxhvL7DMgeIqK5toZx_sIu9H27bSuffMsHmq
 qPspgwS9g7qVaDjE0CaTcwXh0s6cipGvnX.Gcr3IMiS7QuewQ3.9hjbx3EIVOwYa6JwjnUWdVapa
 xJhbjpC8lrtnmDbimZp1WY2Cfko5z4FvEzZ4WBVI8MbP1HCicD3Lm8BpgBz17Wnll.GfNtA2xr31
 M1XcJ1P6Z4krHpBt0pjeWcwG77dNUPMDGh.Bpbykqm9qCWE6IzNtt_V72qkBarvuhaI8fqmpuZg-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 338ce9af-6dfd-46f4-a76c-17c30147962b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Jul 2024 21:32:36 +0000
Received: by hermes--production-gq1-799bb7c8cf-hxpdl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6067ff4c38dc9a73b3d19ab334e8cbec;
          Wed, 10 Jul 2024 21:32:34 +0000 (UTC)
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
	mic@digikod.net
Subject: [PATCH v2 0/6] LSM: Infrastructure blob allocation
Date: Wed, 10 Jul 2024 14:32:24 -0700
Message-ID: <20240710213230.11978-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20240710213230.11978-1-casey.ref@schaufler-ca.com>

When more than one Linux Security Module (LSM) can use the security
blob for a partincular object the management of the memory associated
with that blob needs to be done by the infrastructure rather than the
individual modules.  Until now, this has been done on an as needed basis,
with the blob management remaining in the modules until such time as a
new configuration of modules requires sharing the blob.  This piecemeal
approach makes adding new modules that use blobs more difficult, as
moving the blob management to the infrastructure isn't as simple as
it might seem. This patch set moves management of the security blobs
that is done in the modules into the infrastructure. Making security
blob management more consistant improves mantainablity and makes the
possibilty of general improvement of LSM blob managment easier.

No effort has been put into pursuing the possible performance
optimizations these changes introduce. For example, sk_security blobs
might be moved to use kmem_zone_alloc(). The option of changing the
blob sizes to being compile time determined rather than calculated at
run time has been considered for future exploration.

In the cases where infrastructure blob freeing no longer requires
any special action on the part of any security module the hook
definition has been removed as it is no long necessary.

Security blobs for the xfrm subsystem are problematic as the only
security module that implements them (SELinux) has a variable size blob
that has a published external API. Management of these blobs by the
infrastructure will require significant consideration and negotiation
with the maintainers of the existing code.  This has been deferred until
such time as another user of xfrm appears.

Casey Schaufler (6):
  LSM: Infrastructure management of the sock security
  LSM: Infrastructure management of the key security blob
  LSM: Add helper for blob allocations
  LSM: Infrastructure management of the dev_tun blob
  LSM: Infrastructure management of the infiniband blob
  LSM: Infrastructure management of the perf_event security blob

 include/linux/lsm_hook_defs.h     |   8 +-
 include/linux/lsm_hooks.h         |   5 +
 security/apparmor/include/net.h   |   3 +-
 security/apparmor/lsm.c           |  17 +--
 security/apparmor/net.c           |   2 +-
 security/security.c               | 184 +++++++++++++++++++++---------
 security/selinux/hooks.c          | 157 +++++++++----------------
 security/selinux/include/objsec.h |  30 +++++
 security/selinux/netlabel.c       |  23 ++--
 security/smack/smack.h            |  12 ++
 security/smack/smack_lsm.c        | 101 ++++++++--------
 security/smack/smack_netfilter.c  |   4 +-
 12 files changed, 298 insertions(+), 248 deletions(-)

-- 
2.45.2

