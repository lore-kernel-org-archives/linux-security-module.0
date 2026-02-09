Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E1F30F93A
	for <linux-security-module@vger.kernel.org>; Mon,  9 Feb 2026 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770673533; cv=none; b=iIymfLBS7FMECeStWnioRTikZ9h/iDl/SLDQUjC//upPMg+wO0FaoKHNLzH13UIh3rfLowLSxxbifuoZd7YKlE2SQE0U46I06AZrNZwdXgLPo6eCHPTY5S11XSi+jK73fc/GlfkOzFyk4P4FaQbEKiz+db+Z9VCCfZvfMLt6oSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770673533; c=relaxed/simple;
	bh=GcmdybO0Jing3L0zpEkoP3KH3BMy5JxR2YEE7hU4y8g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=KNTrtY57QelpY0wvgMeM/k0g0FLn7QZVKJkey9B9r8fIWRNnrcGKjmttg/GKUGoypdmz8xa7nhZgjAtPpLf8EPtNBUav0+zSsPOtaL/sGPXcrPwaL7+1spDi+rDCqDt1wGel5JTlGI2Z7R7CNdkMkF7g6VaUeC3aV1YA2O5H+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=pD6R3ufE; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pD6R3ufE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1770673528; bh=9D0DZb3VA4R2DIkRbb1/klD4uT/vz2/8iSPdu1LA3WU=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=pD6R3ufE+bWueIRBRF2r2v37pKMBSS5yduTxhqyUjZBoICmfxEYiRRSHM42bs41nZAx3CczBxXc4lDcm8WP8XUwIIk4qvXTm6zEfC/944kgEYLKCcIGkFdFt2WBp25loNC+G5BZsE177H311Z0QPVUhObEmldp5VDKppeYsrbJPzrgWP8GOGx+Kjhy8wKQoekXmh8DiHD764qBAMHVlkeVQoxQPP/Y/Ysi4YBA1yKaAMn+0YnbH5+eUhhBKXnXS3EhrfNVXqXwruU8vOI00DXKlkIO3dVy0HCOqprWkE3UkytIjbNFn/Ei53hU6hx+e9fZE2GzwRsdKgLRSQq+W8rA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1770673528; bh=gYmkZwc0Swb0mKVSmEGNcNzm9Bc+68pNMcV6inPdhSy=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=Mt8aHYQyN0ndYtJ5uUwFKyBeLvfLadG6QUdUKqMI9+g6Je0atLcrHXIaQRJsgtI1D4jGod5LO4HnFScv67UUdS+jxqwfdjqpvb2w+cCHWRdcnYbhBjnSKuKOBGNVWo+OPeJrmnDqZ1/GHv5MU4A0eTNiNLurzjcd/KZQPE+XrNRdJ9mAXf+louZRmea2PSGbCOI7H7GB2IhTL2Wdk53NJpTMn7qz7rrbQVfROElXRBXNWGM295pS4NbQJhQ1Sga74yMOpIezRG0mxiajHCuMu7nkeyrHuRvFSz5FW6iCwvy+0Y9bctiGaoF7JOMo4pefu5zDN0qe4pCKhijj5NVGiQ==
X-YMail-OSG: gu_.Ia0VM1nIxG9dYCc2SPRPmeal69JrJpFKCLJXiw4P6sqVrPbXxGAduJwcw9o
 fXQLqrjExJPH4RzgNuSWPul46EXTvZp2rhGzPeI6MOaOLeHJmnjiy_i6bfNw_ToSsnWDGJWT1nqf
 .UGBMptXXFw9YL1sCAVjYQd54tT6ej6ocN20zkAnmnSTe7EwofB8kQMb0UrPWwMblZqJuI2xoZk4
 VomLnmq9jEz2s6h._jfEuBcMVFU6txc.7nNVWEA9E9KUxjfZrGEEAuOXeRsPg2AthArMWC9ru507
 U9sDk467c1pD.Nr1T95fHXN7QQf3Ylp8W3R7M0Ymf5BoBVUDhe3D6EzFqFan85jAemUNBOpM0vc1
 BV61CRRRGadDAdckEnf2wf8VDN6blrVa4qHclP4xDeOjZ190kknITd1WKt1sM_AgAsGVocbZnHN1
 5M4b_rgrCp81wC0cA7P9vlaHFCofWmFlv5C3MAl8IZbaYGJbcb4NlE9zriNHKJJJUXRYJGQMVRfn
 JO4Nx9qYLjm4ctD10CmVhWXZxKTnIoqf1jOQ6a2Jk.Mk9jTxQQ.KLIPyqnEQy8Jd5sXLX_uh0TC5
 f9i7RF0HjCvRa.xGCcDOEdBoL3mjQmGkM1i9RNemRpClEq0YgQAXg3FIuB4c.7ZDik_cjU9Wk4Wq
 WGzbWQ_cWSJtpenXotMroLupzHLWhDE2IhOAh4POEZHGtK5rrKQRY0RaECjtiX9FyffpwjtekwnC
 C0.pQKEvgPAi1u8yTkKFBBmhs0oRG9_JT5OHwbQ_vzy7fgdQP7AMk6vCoAN82H78Ny9KOr6sosvN
 0.KYBqnZEQ9Jh.V2hE.JfpULjiVIVlIG62wzqBe26KuzS0G6b1bmhDKk1dPlYou.A90qg4DRl8St
 V6ZopmLk5P5MPKH52xZYz1YRimgfHWKcQOzoozj2npvgS6JUzAAjHOkZlMcbmPZ6D5WJDmYzpe4w
 VEDl5sk.IESIiJ.TzYIMf5Z0RxH_TUcp86mKAyFjkLtAiMvedbevb10gkMFBGgeRu68OoVU5fH5f
 1txQKlrIl20IeacTxbgSIp5dmDaCPB3wiMsX6D0KWSemLzg7VaH4KlkoO4VmebIBRwHXZNZe_4x0
 b4QvQOOnGFylqt58JyiH.myZEYPZO6KbDzSOL4pZ3S8Og2O8UvtaiwbEBDD3LACMomJv4e0mz2W0
 htU.BiO3_UQQ65p6P5GnyfidPyU4hIgkl5GiAXY9NSKIvUzQWo8LbuGajKIHlamekjzBvG4qBFJ9
 PnPV6bXydSASejc2YdStbVpN4bF7666rlO0R2TPIkobhrnpXfq94XDtMkOyo9g7PrxVVvFtvvIb_
 DVfLm3pe4gFSWy.kWmgzsmBR6_mHzZ.1Uk8vQHyQOeiq3lNeFHEUVWrpRBVueGoe3z1vBoB_gPqm
 dlE8DL_VJaJNqAS51.AJOPXvbcnf9B3p4gNa_6B9pV_WH2qpaJDN6rdeti0aOtL2S0dZpAwID9Vr
 kgPhg3K2osd.zSKSXrHEQ_eGjfJ_prjqXQiiEuuyu7xVeR.DqLqUtUp0hgwy90aVzZkjGsAH.gwA
 t.pdMFtX8DEieZVWBviiI8ztRbd2AvDov4tBRyzP086vu_o6wPR8rXdJFLJyUsSUSo9Cs2KsOr.E
 fFMkHGDCxs6RHdcWtSWLePK_AhiExFPPPG5IW983m4OZWshGT42qoFwWxY5bSf76Sjc0WcZzqFhy
 KKzOegczfrlG81c4fb3I2q_j6f7wmaF1VuE7uN3cYtUpMHYbIEieYi4wOZ33L.kQ3wbf2hzz0En9
 pZ8yZr2VNCxV.eJJ.wmiNGYldW.SyDzC1Fggyn0if7HW5De2O.MIXwe8IlTcySygjA_EDAIS70kD
 3GJyxhaLnvs5zbHcB.3CB9HldTSr.lclHtB3Ul1hdahptmSZdSsviGxPKooBNxeX6_EYQpZhZupw
 ZJRk_HgHcIFNIA8ZyUc.u_sF2vhFb92JuKa2Aw2KOC2aEs64ZwsUU_r0Elos_9zHTV9grm7ZfDKA
 rcbVv6mRa7FLHA2KZJCF5AY2NZJ420rIgYSN9lhjOW1GOQjPFeNqgWP0hqUqaTgDuDFEfu21M4Uv
 CzSoItZ7EivLUYUFlgJK43TdHatNjUNC13BCl6SDiuc9WLBOlBumb8YhheuSxWyr29M6Uff.BkML
 .dzExOIOOvnCVfgqhso0_wuB1Famd34G4RTMnzNtyE.faavq6PuayfnY3XJQsQPpLlbSJEFg5YRP
 ybmF4AFVo.cGyOTB6E.VpONvlyw6ZrKRtK61vMp6Hmtgr6c664cojx_OjYzurW2vK6yyRKeGvwvI
 nKOgjyHTgwMmghYlnCaNF65U-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a9ed23c0-2c0b-4acd-868b-8376c2995044
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 9 Feb 2026 21:45:28 +0000
Received: by hermes--production-gq1-86969b76cd-f7q7z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d4a7a8fb6e72cdf9e3ce5a8c7b38cd51;
          Mon, 09 Feb 2026 21:15:02 +0000 (UTC)
Message-ID: <28dea16f-18c3-4a2f-821c-e85b660125ed@schaufler-ca.com>
Date: Mon, 9 Feb 2026 13:15:00 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LSM List <linux-security-module@vger.kernel.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Konstantin Andreev <andreev@swemel.ru>,
 Taimoor Zaeem <taimoorzaeem@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for 7.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <28dea16f-18c3-4a2f-821c-e85b660125ed.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.25178 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hello Linus,

Here is the Smack pull request for v7.0.

There's nothing exciting. Two improvements to the code for setting
the CIPSO Domain Of Interpretation (DOI), a seldom used feature,
and a formatting change. All tested and included in next for some time.

The following changes since commit f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da:

  Linux 6.19-rc3 (2025-12-28 13:24:26 -0800)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-7.0

for you to fetch changes up to 33d589ed60ae433b483761987b85e0d24e54584e:

  smack: /smack/doi: accept previously used values (2025-12-30 12:17:15 -0800)

----------------------------------------------------------------
Smack fixes for DOI specification.

----------------------------------------------------------------
Konstantin Andreev (2):
      smack: /smack/doi must be > 0
      smack: /smack/doi: accept previously used values

Taimoor Zaeem (1):
      security: smack: fix indentation in smack_access.c

 security/smack/smack_access.c |  2 +-
 security/smack/smackfs.c      | 79 +++++++++++++++++++++++++++----------------
 2 files changed, 51 insertions(+), 30 deletions(-)

