Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C616221D9E
	for <linux-security-module@vger.kernel.org>; Sat, 29 Nov 2025 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764449710; cv=none; b=JC/r/qMD6ZSCxlX376TG3v3siH8y7sS8aP2PUHgDglK7OU9WW2mEyIdn+zypUXFwrO8yDXBprNdI4jdzeI+VqGUItcOILq412lEhFRHEQ/G0dBEyLHlYsw9tOLpswQErq7p8Ogy9cZ7qnYn/BYgQ/4oVgN4NdFqB8s5hSVm34hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764449710; c=relaxed/simple;
	bh=LRFz9PLAHDBWeq4L7G9tgDdfgWDQrZBQ++ivlsNtPFQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=hNLz5VO8Wm4hxD2a+aGfYvsZT6tmCwSm5dzjS9e7KjfLdsG3mSyMlrI+WmwBNvhuw0a2HGyfjFlTi0LPldEc9xZQU0RqI+KRg2QuoPCimG0l0FwuTkty7zMKljQEECqaNo6oq2VI4bkJvQvnBT2DPcX7jwF1MQnyBhkdmSVska0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PRGjYmaF; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PRGjYmaF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1764449706; bh=qBsgsU5MdN1caXpcdclp4HwVHLKvhRcW4JUsJACicic=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=PRGjYmaFmprtgIhIDfCRa2dMO1kmVKBhPwlqasdU0nYk38LPWQXjASLMVgrFlbRpC56ebulpybazdBoPFfeHk9X85MHndtwHjwthaTMZujzFIa1Ln32gL2ZrXJ3s4qIUVNQdxMcHDnvyfmv5tB5RryvV4PYWP7oUixZbHr+AZgJaevdouD87lhQJ+OyomAKh9/ogp09hHhgkCidY/FWyCspAEGYwz3LtKRV1pVaV/GQrygrrrQO7nR/vxJpkG43ardhNlBkW+zdkmIv/9iIVEy/5f+cEFHb5/uDFD3EMddWfL4+r4FZgxTD2DVPKDYpKMNRVLTYz+0saXcHmAC/sCQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1764449706; bh=h+3OKbaPNqahulzSPziaK5HRbWRMC+eBsGouAcba7hE=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=rCn1hJ7RL/TW9vr+Zu/LYsdC18w4y33ou189BhA039Up18kIqgG2vlmhq1jnmquohEaveXBAvLtKr56fn4alEbg6h9WoFgMfWvO03M2pJ2uxWwnPAn0DwjEKNDThYXp77EGblv4qET49ZWR9WcsYeYXvHY0QiFqzF8BNsxQqfNQv4mmMS3yMiLKrWii4zwYrZ47aVxiv0ofeUKFHuR4US+0J57fHQsG+gQcvl+Yswd5tqWpgAAHBsGQUmJBuy82NBqGjM0mKXOs8jZdM1VqnX3Qfem48sCPKllL9i88kJ3Vsfa6oiGJ5NK+CDQErsAelVw/ZsJtfhfajzZslSXD/8Q==
X-YMail-OSG: vt2aB4EVM1lIP0qOtOya8UR2Hb2PuvhN0uDRUwcmtD25A6a2q0dTMX2ORgodbTq
 We6xODzuuDw1Ey4S0oHy1T2DIRFJ7xRlcOlLTnKamaz6TRpbtG2Z8fK6qWiSQttQ.3Sn6KevcKT9
 uIAX2B5bSboaFb6hlP2jrYQ_plxFBIB8UkHXgWPkmBFXeg3LO9VrM.SZMLXhExxznixeAMn3fZad
 9pfBwGndf.e512l7lTcP1WG9CEu2cCSaGRMuCi3d7zYqgE4NFS7SV2SQAGbi6fwleLooh8A9Boak
 xhtCpAvTg8eCg8f3.uCVpgGpTPxKWNvcfFPmgV54lZvfTMxk4b2ZQ5.IYlKx9_fk_6a4s1Y4PYKa
 PROl1jovsH3J.k4gNoT188yje5fqeTOhaPZR3ksXI5wMSDCIM2.vyRryjJfnZ6uIE44fLBuJf56J
 WAppuRanWsAXVndrRWmeVo7cgEjkaEPmaDfmpb44g_B4UhQwQliku47DY7xeDPtHAUMOd7lPyo5y
 BGwfFylLQbU5PcZAOpEYm02T.XS85zMKFV_Z6.dCNjLjSXBZ8tZ8Cm.kwr3jOBRC231pPbPFW34i
 MHgilOoM3RCthfzHLXAFpcvG59tcobjHSDhQoiwvMky87fao20jTjQXLPuOg57iHHZFi93rzP7FD
 EUAgz_aHMHkBwBlGzFE2K7EaCUrJmrvsWbR.Uyr01X1I7xgyTdld5i2x0swTdzYT86mw9QXOq1eE
 SFBsnfnSND3WEYRePFL3q5DvrOE_UV165_N7ofzWEoY0UeGtrYkaVxv0xrhLdH3rEXgA9ulXqldP
 zMx4oSU0XsSTldslkKnZCfBok0QkB94O1EfE1xc9MDgN0Z2gUax1hyHxpPVbQ.MDqW.JZdFousem
 U.fr7iMgbcdSPzyonnlO47sAk.K_jtIseQgamuJsXiMJ3xDKvS3paDnsswIxf829QuEnLWGwTEsg
 kZ4LP56EchLji4P8hsOxsyRlBje.zdCsWsT4XYVazzNXQnKij1s253a9zeER0k7HdHZdX7NIUwRt
 ua1Csg1Bropau8SHCtKVGIOIh8lOqOAeP6UVC_Sz0vzoRggGCmm9_5RknvQLjU9Svx8i8IdxaXg7
 twtLSMukKlBiAP9nmuDjWzEpIpVA0Hlhc1_jquf_aeMXsUhk29yhXjK0TF.AkhsvBX61M9w5ERi0
 1_TrIVGgClBYYKs0lwWnbjRAa4gd2oFJ.V.PzbWrEO2ODW_3YiOq2dAs2dMtqqDhJiyxcsnFtnMR
 Afn7cbJ.6FA3EbjM7KYN37whMCn4S.YzigGjgZAFUL4pcBvuoMzXz2.qIQzKVrI.XLNjkFPdvk3t
 pUbziCWXOrcvlOJ8ZB9GDhlMozOWTZKtuw7zhVujsDiRJ5YzXMML3qCgKTS.hfNBo5Rx2DhAzIqk
 KJyP0D5Uxl7MVBpN8fVRLftVdME78YZi339AFrqYwEzhk65qy1so_wvhkQTgpWDKwoccdr8Gfzju
 XZuwNH08Olaj5zyRo_RHljblLRMegE6eicQonyhsbxicAZt4UFw4zIgEhDi8tylrcPUDe1RuNs.x
 5c57bPApdFyJMvc6HJ6UXf3cAlW19pH0pZ_tE.0VjITdaam2mmIIE35hqIQvdlXfIXI3nC0G8Giu
 vPkm0yPMzXtdCnOUW6ycXV8YPQbXZphwTN_rZAAa9qdfjL.WUOmcgYSDV_Ug4fuuePyxvh.ZvfU4
 2vE01LCZTGLPzFoiZ0gpcO_5k1xtnYIixygTjn9v1TCxlv_OwOS5PD0dJs8MTN1alc9bPP7DPPhj
 vdrYDZj5lRUclvsDOO91v8wmqjF7Q6rAPYCaI9i1lkUBOld.YzUvqbSSlmS4IzrHY22SeRFZxvjJ
 odM_Vf25AJKrhda_BIyBTVRrQjHcYyqcPco_kDs9CVhCZUFcta4F7VBCoO3BWsndQZexlejHis_n
 4LHCQZNPiHiDlat4AdEL4XG4_frtt970Og93ybfvyTiqbHggliG0zSldvsM2TqmXaDJFM4m1H4gy
 oEyK5OLdnQqxNvyrivgwfZSQZ3Xe.qjdzmRtps7Z15WWOgo4d0bABAQ1IygKj6RR0YrEtgB8mv3a
 LPO5pZagQBr3JyiLCwltDKAuuJwjJXBYD7.644Jofk5PcIT8lygW41FPqho6bMkZzb29OLA1SU6s
 LULJC6jFC4iVTyMp5WXcdBP1i4_1P7Be3zEyQhQLLY8ePwfNH9fjNH9Vxaa6JOZ6ed13.pduPaFT
 GfiQTJssYxaKMzKgcuz8LPXXRgX_umNFLthNlMNHHT2BxnhK_O1SoR6P5eN9Rq2NNiTQXS7cTFlo
 I61JGNLz0NHVMnPj0zGg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c37b914d-b9a4-4a3e-940f-fc7cdfce89b9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Sat, 29 Nov 2025 20:55:06 +0000
Received: by hermes--production-gq1-fdb64d996-m7z2b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b6b41b48273e4c24e8b515e737c55b5b;
          Sat, 29 Nov 2025 20:24:40 +0000 (UTC)
Message-ID: <80229bac-c3d9-4c99-9cca-dade23ef7421@schaufler-ca.com>
Date: Sat, 29 Nov 2025 12:24:38 -0800
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
Subject: [GIT PULL] Smack patches for 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <80229bac-c3d9-4c99-9cca-dade23ef7421.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.24794 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hello Linus,

Here is the Smack pull request for v6.19.

It fairly large as Smack pulls go. There are fixes for several
cases where labels are treated inconsistently when imported
from user space. The assignment of extended attributes has
been cleaned up. There are also some documentation improvements.

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-6.19

for you to fetch changes up to 29c701f90b9341f1f9c1854a9c22b71c2318457d:

  Smack: function parameter 'gfp' not described (2025-11-11 12:00:18 -0800)

----------------------------------------------------------------
Patches for 6.19

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: function parameter 'gfp' not described

Konstantin Andreev (8):
      smack: deduplicate "does access rule request transmutation"
      smack: fix bug: SMACK64TRANSMUTE set on non-directory
      smack: deduplicate xattr setting in smack_inode_init_security()
      smack: always "instantiate" inode in smack_inode_init_security()
      smack: fix bug: invalid label of unix socket file
      smack: fix bug: unprivileged task can create labels
      smack: fix bug: setting task label silently ignores input garbage
      smack: fix kernel-doc warnings for smk_import_valid_label()

 Documentation/admin-guide/LSM/Smack.rst |  16 +-
 security/smack/smack.h                  |   3 +
 security/smack/smack_access.c           |  96 ++++++++---
 security/smack/smack_lsm.c              | 279 +++++++++++++++++++++-----------
 4 files changed, 275 insertions(+), 119 deletions(-)

