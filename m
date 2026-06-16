Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D33B2FC7
	for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2026 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578543; cv=none; b=o0/Eh1FTvnFuFtpSzka/ymFBPewglwI2Xedyvw/5bjb3KpYeOmFRtXuhxw2mvP3+6IH8xpQfSYDF/z/gyOi5faPycw+b1vDW9OW9DLwz1vvAAsCru8B9MjIsxz3KafbO35H5U8M5EJAm9pbw/M3+5Z5YA4epjzz3WpOYyL4Uczs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578543; c=relaxed/simple;
	bh=oEcdHMTdPZgU194AHy5ee4wdXYDUNOIYFkGQvFp4CKA=;
	h=Date:Message-ID:From:To:Cc:Subject; b=ndcHYZ8l84v+ZH/VOHYFCQuWSbYG3TiIN/s79w2rxmKrMV3A6hWOB0MgRUxrSQfuWE0UKLLUskOFvHXwbFUJwfrV/E0b7E5vxfSS2jGJf33FRM8zpbMkDjcPa2GSGUjXCwZE5ZcpyG/SDGtffC5y2gwgatGn1VVKL7TssNjwKXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Icqku+a/; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Icqku+a/"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8ce9df49c5fso64013836d6.1
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2026 19:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781578539; x=1782183339; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0uDegzg5yPNGy1FcFP4w5AeRJEMJy/aOyyQvYzv9XY=;
        b=Icqku+a/uYgyF0cTandpZXwcDJtNRkJXUjw3mkDTBXwsd/b74G59oVXojtI47mE6t0
         XvKrdmbajSCSWrMARNaWzFy76CnjMOTrJK5ZqoKP3riLATpTjN2vj+AA9P/50ZpoJoFJ
         LvACsxlHdhdgpHqecp+NSxwC1sTEi3Z5aNLaqBr7rlKcEG2P+iZSaXXabZPYoQP5yDSE
         hojEbJC0JXRjfH5hIffnVp5bOpdA01Jgq3DoGzNAqybLxoWEKr8b/aMq0NWWFdoonPcp
         esIP5eM5Aolim50kLhzQXcSiOSk13rY4sH0jyPsSFCXeiTcWru9VkiH2mIENdwj+HUSW
         CzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781578539; x=1782183339;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0uDegzg5yPNGy1FcFP4w5AeRJEMJy/aOyyQvYzv9XY=;
        b=nIa/mKSP7vRoNCYibfrO4CIbkKp4GWCBCZPtBOmOOi3Byc7CjN8aBik0o1vFDsZTcI
         crtBU6Q7E/xpAbcWiDfHpiQ9tspa2tagDFiIUJt6ZFqt0mWiBrLOCsFYJsnL4n+Jbk3M
         d4tx0/N5djdPe7LaNBVN7q4Bse8UhJi/QhLapdzXg7MMB6lXV3eU4LqBMaJj+EmE07HE
         PMv01Xe1LBkpKB8HBnzUBwAN+DFR9jQ/kYv3rVhTJZRBf3ciJjjjOykWIqTnp9xQYsdN
         cI0vJkg1VxwDpsaiACtZL3zNFgIYKmT+zJyg3QBF3sUM2T0K2w6tNSCgUIunoO6T/2qW
         rvng==
X-Gm-Message-State: AOJu0Yy/mxG4SRi+TmyVuGXSvAvD0m8MjpMIl3ocHKHVZJ61lPQcLJ9d
	jsvLda2DQnTZudHY06cwwoB4cVocqfnRxDHNIzbsL1lyn5Uv8wc8XtpFU5m75lnOcg==
X-Gm-Gg: Acq92OHnt46/njO2fCjAlph1Cc2ILHLCiCbsrlouOB2E43FGNqS6pntOcFjimRCpttf
	FmUQ8lAkSej6Qh6puTi7unWFg5CTOUnhgXMBYEunFbTX8YC2qByIJd2b2IKS/JkNSLVnIpxh433
	XB+BTaZgWud2ebOkO8lO2MIa/11NN6nCyIG0V3YN/del889X4/b4sN/lwUugLqO4fpgHSujBsml
	iReNgnYr5csewHeps4ZrA3CzPbOycIcrd3ftI9AsTHlcTCLoWjqywxzj/R0WbnA1VhxngybjTP8
	KR0V4Kcg6mMEn5YEsTE8TaXyVJUILFSEfJZwAYS4g3vxo5b8GhG8ULoNHXEYzSnK19jfKtqTXUk
	HrRQ3UoQGrS1NsvcabU7I/9pwik4dUBIMAkHrDqsM6lWjq2kWA6vrRqkLavdS5sNNc8siNF5p0x
	ZCWh3c0DLJdUE0fIVes+4vthOhiaQ0uoeeZ/5cmoOmgdQutLT7BIRPKf1GUSYw2H5ciX8x
X-Received: by 2002:a05:6214:1c8a:b0:8a1:8b0a:6678 with SMTP id 6a1803df08f44-8d44f045b60mr214117586d6.31.1781578539357;
        Mon, 15 Jun 2026 19:55:39 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f4d0f4d4sm19021286d6.34.2026.06.15.19.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 19:55:38 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:55:38 -0400
Message-ID: <9b359189953cc739f62fc94af4c24a27@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20260615
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

A single LSM framework patch to update the security_inode_listsecurity()
hook to be able to leverage the xattr_list_one() helper function.  We
wanted to do this for a while, but we needed to fixup the callers in the
NFS code first.  With the NFS code changes shipping in Linux v7.0 and
no one complaining, it seemed a good time to complete the shift.

Paul

--
The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20260615

for you to fetch changes up to f71ece9712b7712df98871eea9aeb60e49ca5239:

  security,fs,nfs,net: update security_inode_listsecurity() interface
    (2026-05-01 11:29:33 -0400)

----------------------------------------------------------------
lsm/stable-7.2 PR 20260615
----------------------------------------------------------------

Stephen Smalley (1):
      security,fs,nfs,net: update security_inode_listsecurity()
         interface

 fs/nfs/nfs4proc.c             |    7 ++-----
 fs/xattr.c                    |   11 +++++++----
 include/linux/lsm_hook_defs.h |    4 ++--
 include/linux/security.h      |    5 +++--
 security/security.c           |   16 ++++++++--------
 security/selinux/hooks.c      |   10 +++-------
 security/smack/smack_lsm.c    |   13 ++++---------
 7 files changed, 29 insertions(+), 37 deletions(-)

--
paul-moore.com
