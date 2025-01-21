Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F2518AE2
	for <linux-security-module@vger.kernel.org>; Tue, 21 Jan 2025 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737498200; cv=none; b=BBBslnXh294Gy9JVWJ2lW+04DKQvphl7hwA6jLsn0GTbK8jY59ZaeRSdscwjB5pjwvyFPX+B7VTzUBkHII8Rj2JDRk+Ye/wffWbE6xN12jsTRsXSABIZV0Z8mWyJzJBoSO8+40oi9xQSU9Wna8738z8sh5tpjl90hqZij1651jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737498200; c=relaxed/simple;
	bh=wiK6LW5iNDE1RPam9t0huuw+nZ374G2TEM1oXDHGQo4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=XSKaCppunbGBrmtQ5v//7N0kUb/F4aE23vDD9cfmGUb9vZaP0mh/8dwrbDfiZfZMId5/sbggXsbFHM1tFaYb3FNNfmjXa1rgh/YX5gdB/StgyTILOmOe/dl/lgJeLqFcTQXTZ7UzsV0KSTJ3q9emEKuvdGO0bQbQunmcBBRZygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BZ8mIwu4; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BZ8mIwu4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737498197; bh=zdQirC/Wmm7+8ngYM1RY16m3N1O0oQvckYOigorgKBI=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=BZ8mIwu4JE5tT7s6PHNsQrHnOrn0ncl9RPSSWFI1wURzD3om2ab9IvwlTRNSLTLe2UOPVdXNuQXtKrE6FO7EiykoEBtaszlL09XiKPoLuD2kzWZrE6u0yPlSvZl7n7eMhJmlqqwI/YW2t00MOnS3Edhwj0DsALKgEiE4dONC8UQ6DCQNjKmcEf/D9y36LhPdOtU9tYmCCOi3VK5TnFpcY8oX9i5dkqaypUUrDLZXUSC8SktOtOr5+OPPewU0/8cJR5yUW9DHYjwotc0qp/jHjQa5Whg7aI6JgeWTR8Cvj+E8f9XNUD9TIRDEvIXwgxtTyk5gejWuu9DVxwhsujxdzg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737498197; bh=U13AS4SpjEawaIoB5SXXnFIh4QJpJQ26XBojmX4qSlI=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=cdPVKRubUgi7pFhnOdyq2aVvABYqh9t/NuvvsLlO+A7qCYZ11KC015ionNAOXi0IbMyMZ21qzDK8sj7xJKBpFn/u3ac6cRP7vd7RKCymYbCwpWFsQ5kJXkiGGTn9gPchjMJswyoVay1kROaumxUzU7q/7IwjlXfxqxQh/W9seyN+O+n7kLknIlXt6JWFsAjzcG0ATo0Wc1+knLWR8OA4374L45TNXPUD00K/Fhb6jVkLucN4OUiIQQma5RZlpc/m/VcHO3JWcyyzYfBQ9shyDWME7Ivk6TzIxsmnilqIf1utvQ0dbEvTKjlnGKAAjS2DNqQTFrFb3XF+1jOxHuTqAg==
X-YMail-OSG: acG_xIkVM1lcWyE28ZcQfCDm1w3XPmu45i_4l0ZpDmD.CM0IeOm.hfcTtKG7.5_
 RZWhx05y8XzCrOumPbZwtFKr.0j.c78R4.nP0fsAj9sbGya7Rpzz6IJgPO3IuvmB3u.ebG88A9NR
 OZFI2Qo0FsMEGamS0jLHtApMXwK1n9wzSaotyIQixVtwl8bIEg.gT6pJuolsVIkLmgJx3MynDIL8
 5qFpisMW7IFJXNrrvM3jWYhn5gX2OgOV3ymZeDb0PF8nEaPA5WqTkT2aqpvTzNv.7MV9KqUhUmRy
 Hsfw4O0ukphekeFTsWt6M4kvXf6eF_DW_aVPAkrehp61j1d9EBgVK01LvFXBfWQDZm5tPNyCXY_a
 UYHgCY9lPBFWu8ooX1H9qBIK7W2TGaYr6uRnrNItl4yjp.tHDRHGk6AZ_xCzr31oh6y8J.t8pLHw
 aj9MkKYsUs1cdZRJa7.BapQkTi2v8CvP6Hbm372BKpXwVUNmOJwNa2AjWJF4T9nt5R2lQUtMpswc
 RuQObY7Wokxv3y3aHMbE4_VFhNM4RQaDr_UPIaDlPBLvhBNvg05IsubWWI_tXJlbqMvyF59cZ60B
 6U6b23zFpuZhFRLNsnaaNda5hQRhvQpfuo8QwVkofR46PFtzNLjqHyZXEWn7KHFiLhHk9KQnL1vr
 L.GTU41soh7HVwvYSlS7U2WYiJWOoFdA_ZEtUH8ZPd60EzZh9jH.oby.Rr6IQDFRoXfrDC6_fwh5
 Y6.6N_nItp1AXn_GHUB9b0JDSCPcL3wHEluCW7MjqaDS50cO57OSlRbiNh_vBxlr10Cbjcac_rJz
 5bolxM3sLfD0QWTVUjx5YMu2htU4zyCJK8EXawvItXDQXXv99pMMwjJtX_nKgG65XMMarOqlsVTm
 xV0nYWGUJwU4CLBG3NUGkazbgH3DtqxrNHCdY7DIMRz7qbvmaCQnQrXzCo3m8YUo6h655.JUdHey
 K.4_.qeOLQ7OHAaKZNXmrODHPrvSTamq90aM0TdAVqEEA6oOOL7D4E9jj.F3oXAx..rurxLda1V3
 IzL0yCPlwFRnC..EATqTIAaq4vvT1RSzO4uP7CkE1s_9t_SEnYCqgRoP2ZamfATqV9SOMF.qa0ht
 zr.y6h4FDXO0Qg87AvHmcDK3vo1rFJgaRmGbJHJylUQioDd7gQsQeCDG1fsAn3_AVtKNPsi8WF7T
 yz1qWWShe5UMCw5l6Abp7Phh38rQWJO.xRrdHCryhn.kJGzPu6QrR4MYaV7Sv95ZLt1ttdggKKSI
 sWulQ63bVVtCMIZQDAk0Grr9jQVb9esNDYOV4SgYd3ENfpasAws7o7wBw2QzUdSw2l_PsEwWIayh
 hETQkKNJRBuoGtM0IDtxws1y_Cy063a_5Zn87shwoURie33vUjvfySrEfKLe4jgAiL7XyHLkiWXZ
 mfeM5g7xZlqMfq29FdOJQIDJ7XOKOoSxkNt7EKPWbvHrtfDZwXQ.44Llzbx0HllpKodL28PWzW6_
 9AUkq3krUvO77VnZODXU9US5QUchHuhCiV0te1rCaMa5eHNrQRrUFXVxDCEsjmyfl9nTrafUCt6w
 WrnIlpG7dMC44M4NIKwSac4kE7Qx1XWrYPVlfmL0ZveK9fsl5ZqKDBnsBD9auG9oUbNXKDgomr2J
 PHBLCRVu_dcwKD_.UQCMEXx7Q8CbSCY9wjqELaobmB5ffxWcgOBilGdkagxcGbDNV1ZOlVLviYWE
 NqxiHbDasC0LIcCXCdLKnt5YQCLaAVBEasBSj3rpZGE4Xcb1l6M2OsaBdWWpToYXoJ0UxEC3yJT4
 FAQJhdm9kO3i_NQsaecTyicBqCBllQnv8Ii0p0LVcmukM6f2rOkqH3C_Cw4jQc.3ltIC4os4Jqql
 dwzBdlxWZ_Nhd3W7MvwXM8H9uDAUkKAirTw8vtP6wZOZzkQ6RUZHNHaPtIvR_yyMLBiawD6tRkIb
 l5m_USNyCW25dWf3_2M_xHIPLMuTGzA3bM6HqOLbn3v8mjLKfWfz_pqhh_pZHWE6lZ3t8JtHlu3I
 R163pBZMnMcvCF2iME12h_AWFErSrVfFWeLvSobquDp.R84Fyruv6P_XP3oWnVxYE5eXX7ZtnEde
 isq0hynI8U5D2wEILPL5pADDsnCSj6yF.RYtQ22ie2vt3drHCRnRaptV1wPDZDqj1z5OvpSvMHw0
 nbFNcpPmG7avzAKNRPAq2PZX_iLX4F76VIP_066.1ulB05_0SR4vfStUgcTXrKyjnAX8PUqbLrHB
 sxpERuOZnOH6rANCGIe001A.krLu101EFit2hlbiDfGT5dhcNtFS7SQ.uhpET4kQKkTAUCQDa4Rj
 RhEf4hvNG8n9.ZLHFQRgMsthj3ENT
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 62b08ad9-d103-48c4-99d1-896b1d2285bc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Jan 2025 22:23:17 +0000
Received: by hermes--production-gq1-5dd4b47f46-sx6k2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cec665c3e16d864cb849a979abca34bb;
          Tue, 21 Jan 2025 22:23:13 +0000 (UTC)
Message-ID: <e79d21e2-1491-491f-b46d-9bd814290771@schaufler-ca.com>
Date: Tue, 21 Jan 2025 14:23:11 -0800
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
 Casey Schaufler <casey@schaufler-ca.com>,
 Konstantin Andreev <andreev@swemel.ru>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for 6.14
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <e79d21e2-1491-491f-b46d-9bd814290771.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.23187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hello Linus,

Here is the Smack pull request for v6.14.

There is one patch. It removes a small code duplication.

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-6.14

for you to fetch changes up to 6f71ad02aae83f7032255863e374acadaa852bea:

  smack: deduplicate access to string conversion (2024-12-06 13:21:12 -0800)

----------------------------------------------------------------
One minor code improvement for v6.14

----------------------------------------------------------------
Konstantin Andreev (1):
      smack: deduplicate access to string conversion

 security/smack/smack.h        |  1 +
 security/smack/smack_access.c | 10 ++++++++--
 security/smack/smack_lsm.c    | 18 +-----------------
 security/smack/smackfs.c      | 26 +++++---------------------
 4 files changed, 15 insertions(+), 40 deletions(-)

