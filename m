Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CD829C327
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 04:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774239924; cv=none; b=JazNZ3b2C2B9PISg2Xjc+2OZRJxTW3+De7NNJER66XezNnp+DuXN8JzNS9a8E/uxtLSu94S55zUmj7cTFTVJpge2lslCm/DIBDCkV+6alP7NpL+C6Iw/7QIuFYux280ZGK0maBnzUpgavVzXUQ0Tp0XUev2JOJyyCD5TeY2Rrr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774239924; c=relaxed/simple;
	bh=9CQVC13UfnGA+k7t8MLBC3z2a9+S87m7Va2FqPx1Gpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IHRrefGgi8NSf4Kh2DEYw+2BBEAeJAjUruxWrcP3k+S6mV3rzfWnNTUL6rfr3wIx65uJy6a0ukI5lwUYFcS9RjM2lS5fvE3+sdSQf9iC6JkMT8WDxVpM9qu/xQiJXl083XOLFf7zwfvq2SouuvfNPZenDKwDHf3iWll4uS2eDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L7SKQgsw; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L7SKQgsw"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cfc1aced74so385063285a.2
        for <linux-security-module@vger.kernel.org>; Sun, 22 Mar 2026 21:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774239922; x=1774844722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHNU+T5mQ52dsDV+e3ezWpkvnj+dhj3Dc5R6m19Ae3g=;
        b=L7SKQgswiIi65AfM5bbqq8OwWMKTtk5IxpH57PRJEwNgk5XIG9sd2XkEr2ase3CRU5
         8CTiFME0Iaj8RCJ12hHPnbbZfgliDDnVtOKT5tfgr+e3I0bcUR8olKXpMhPXyH69ue1z
         lHEcJ86UIYZKbhQ/ZB7veE16p/01zOzlXeGTWseFkZr9X/+/Fio+2U4SaMuP0Z8btpJs
         lTVgV+2hlad3dtZdDMVmqmraKMNWdqLiSXECCfI0ZC66T1TO0uDqCXPVmtmcN0IlST9Q
         tFBKSn8TFbDBvOxc4ufU+YbJfHmalXKa+ro0cDcq71dMK5JL/BeE9SBKCo4ibyA52zwo
         lrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774239922; x=1774844722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHNU+T5mQ52dsDV+e3ezWpkvnj+dhj3Dc5R6m19Ae3g=;
        b=eaiD67FXvtc3QfnP43WygPXEjCaZafn8si1SCfn9ehBN6IC+XIajBAy5yw3JMgmiIP
         YvC3aB/drw85snA18MjPTQonPuXMBq13wNZI8v5tAdfPPsTmE1k3CNULo/cEZsPFvuJX
         YQwjE5/KD2qiN9lhfJOV9gHChJsJb3Zncf7d07wSR8Msr2dqXZ801seF8thG2baOPGbk
         JOLBGotqXbD47MARKr7rQIWXWN3Gnn3wndXh8MaNbYeckvyZc1pJ7KlAUaB+GrvDnOe6
         uSnP3SQXAybdLABCSAnOciMKLwn6MFmj5udrA/T3PdxVAWY57P1LJMb8eNn4Mp9aJFsU
         pTyA==
X-Gm-Message-State: AOJu0Yw5gXolOpmjX7USnCPYRdLfyE9HNDwg1zR/sJB7pUfj7VQPYDG1
	06F+tqMe25LkWINcFpvTQAbd0t6TMOd85kfV0/EAvTKrey2Kt4fjTe3Gzw3V7WMy4/yNA5+NR18
	9ILE=
X-Gm-Gg: ATEYQzyVmuvqaskvDGWAgvHiMmu40zRh2Y9gCDpy0IUDBWlG2+VoTzp88yGxOTqEoax
	dgCGBTHH/JitNkgpDMiuvJVIKxelYWfCdgz0C2v4Fyj/n0vOXx8oKCu43pTnqlo1R5rIbB8buNg
	Dst8h6B8MSa75yTKtImp5muUjzXJIaK385S/ZRSRUFJETi2vT0ZjgE3nIFmCYLzGCfwQvongDl/
	K2Fj4nqjniOvlIvrnsTvDnPzSunNyDPAeHWy1m3ihfR3wRT4ffsy6QhBH5Wdob2Bt6mSFlWXXWR
	VlLsWBGnQzNh8K+35AhohAYuT3zKpYaURHexHsFlaOSRh7pWMi7PZ/+dQU1+tbAtpF7YPBBc3o0
	3NQM74KhHH/ec8txQXpEnsOmxVlQsXTPzV/voshnWkn8RfkzC69MvSRFbBvojFspvHesRBVHm65
	2Fm+MK2G0jQOickiFjgmzvR4MzUTMeLuciMVvYDDAMzde+Jde/k4XzPuKZ5MXVLJX8SNoz
X-Received: by 2002:a05:620a:3193:b0:8cd:94a5:2f22 with SMTP id af79cd13be357-8cfc7e6d7eamr1552756685a.20.1774239922032;
        Sun, 22 Mar 2026 21:25:22 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8f5fa29sm677110285a.10.2026.03.22.21.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 21:25:21 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>
Subject: [RFC PATCH v2 0/2] Fix incorrect overlayfs mmap() and mprotect() LSM access controls
Date: Mon, 23 Mar 2026 00:24:17 -0400
Message-ID: <20260323042510.3331778-4-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up revision to the patchset[1] posted a week ago.  This
second version has changed significantly in terms of approach and
implementation, as it has become clear that the overlayfs/VFS devs are
unable to make the user O_PATH file approach work.  Unfortunately, this
pushes a lot of the complexity down into the LSM, as opposed to the
backing file code, and will likely result in code and state duplication
across the different LSMs, but at this point in time it doesn't appear
we have any other options.

I'm marking this patchset as a RFC since I've only done basic testing
on this patchset, and I still haven't satisfied myself that the code
covers all of the different cases.  Additional inspection and testing
is required, however, please feel free to take a look and comment on
anything that looks odd.  As always, additional testing is welcome and
encouraged.

[1] https://lore.kernel.org/linux-security-module/20260316213606.374109-5-paul@paul-moore.com/

--
CHANGELOG:
v2:
- remove the user O_PATH file patch from Amir
- add the backing_file LSM blob and lifecycle hooks
- update the SELinux code to reflect the other changes
v1:
- initial version

--
Paul Moore (2):
      lsm: add backing_file LSM hooks
      selinux: fix overlayfs mmap() and mprotect() access checks

 fs/backing-file.c                 |   18 +-
 fs/erofs/ishare.c                 |   10 +
 fs/file_table.c                   |   21 ++
 fs/fuse/passthrough.c             |    2 
 fs/internal.h                     |    3 
 fs/overlayfs/dir.c                |    2 
 fs/overlayfs/file.c               |    2 
 include/linux/backing-file.h      |    4 
 include/linux/fs.h                |    1 
 include/linux/lsm_audit.h         |    2 
 include/linux/lsm_hook_defs.h     |    5 
 include/linux/lsm_hooks.h         |    1 
 include/linux/security.h          |   22 ++
 security/lsm.h                    |    1 
 security/lsm_init.c               |    9 +
 security/security.c               |  100 +++++++++++
 security/selinux/hooks.c          |  252 +++++++++++++++++++++---------
 security/selinux/include/objsec.h |   17 ++
 18 files changed, 387 insertions(+), 85 deletions(-)

