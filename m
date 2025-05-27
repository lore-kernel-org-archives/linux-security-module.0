Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8618F217679
	for <linux-security-module@vger.kernel.org>; Tue, 27 May 2025 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748386665; cv=none; b=Yu6+6TbuCQGCB/e71bNIIdU1PKX9aqSLw/8duRJE7bdB/5Wx+TTGgAXpdQw6BM02vbcJP82JNElQzx7rc8dNsAXc1vpObQdPo+IGkRpJNXZ3CT7KevBCN38/HmLBbmLxJ4l6xtspebaHZb1g45RXlky7SsBhJn8kNq3virI9wok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748386665; c=relaxed/simple;
	bh=rBSNfux6aJCMU9XyRfXyXn/VcKNBD/GX6joeygBgU+Q=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Bm5ld0VXTpscuSk4iH2/NFpWHgqtzPL7IH27MVvM7jq0oYouXRlKCuAHI9dGzh2+mRDjvtGEt4rbkv6855VbOZSDLgL3SNszKuZvi+Dlji3bdosPKa52GX8lixXluVuIGdujX3Bx/OnGEW8poVgpHENTPPO4VU6JPKwpoFxdSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FsNhW0/t; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FsNhW0/t"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c597760323so366998185a.3
        for <linux-security-module@vger.kernel.org>; Tue, 27 May 2025 15:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1748386661; x=1748991461; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pL35O7+xfYIswFLcuMkNDqKkeKTwpplKlWRQIN/Hqc=;
        b=FsNhW0/tC3M4IsfcwnEtBRFcCP+K9e+zPcA+MzojqpCuVaUrxg8Y1jpLlqzHpWjYpV
         5lCgvMd0WZ+adr1aTFWPWcNShy+mDLzkJJPx/RBGDHdxBclkBmuLnp8f2+cqMP5FaltQ
         RVsaE2fCXB9HtvFXkOouTwyaKAwR29C2D8fX8LfvDU/obl5ITivP5ch01Huobe4h5Dr7
         L+VzMLgX4AiM4+ae66FfAAKucRPE+HM9+ZqxhYgd7nVeT2Ra2Jd6M23tzOfIXd7128c4
         mHwRqLweutSU0gZupvHEdTtsRdcb9BwmsCM7IOo8GHMYI2pFi1Bh+o5Src2nw1euSeZC
         ov0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748386661; x=1748991461;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pL35O7+xfYIswFLcuMkNDqKkeKTwpplKlWRQIN/Hqc=;
        b=L1U5zr/RiealGv40G2izF2GBKutHTRfqCkbp8dheKta7ikm4W7QjnNBPXbQJHQIzBL
         IhZwITTuKq5zhWL36PfbP8a7s9TB6Miyzph845DbRcsu+TTgTQtUsh1wSgpMRVsEZjpX
         QbCO/rq+raovxQWJK5d2SG3AXSnDN4bW0Tr65z1B5HyHntkyyLOFlhCiKEM0v6G+8yty
         FDkDrZOxAQUfPOqOx8mAGDLj3l+I3eTF72UVKvL5lov88VJzMW5bldnDhhKTkp9uTmu9
         NJzKpYgWe/7HHtHTbFMuXnPJZWtoCVFAGo65c0TXxq9tdQnvGQ+rFzp7uLwlr+WNxzG4
         Ef2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMY7ypM3oyeGC/3MZdK2PX0MTyNXBQZfpKxhgI22mAcccai7hB8VNJD8KV7CJD9ATfDlc/WqBwTF0oI5lpZVDIkmtqx2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGugSNyzuVVp6gZnByberXVV0N8D0Fhw6QXgkL2U+ESU1ZzC4T
	X3aEh/Zf1PJUx6bbU85hXHy7AQ3T9GzsYYm6Y8EWTdkNmGUSbQGSYss4imVmmfBvig==
X-Gm-Gg: ASbGncsz2vdScwzhO2IDqgwQvq58PknLYxVzhK9yn12ixJLXTtUCTuRO/nrmixuGcxm
	jslrByuzGdcD0VaXB/K0NLLA/pdZ0nAoXHWPnmZ3X+ShgqhDGHkUXXstfha5axBXQkiMMqyO/Hz
	43ys7IvvbkqjjPYZ4PAb/J09O5uz4jIDeucl990NQdMGhDjajxIOVaQ4gAh75TGe0OppJ8gIUZl
	EUfXXvAfQvGs8oEWMNGalYDSSiKqCss4yNGzDro6S10HEHNkoeOzHgjf0TL+LLoRjxWkUH8aosu
	WxCBSvhYhKkbRAImG/tVfnlsmKVv3UMpiEKHmzN0aq8bhj3pgwALYa5UoTmSDZW9F4swKv91Bfm
	NFM/yhiienXZNdmvzDADDRcpsTE9NB0I=
X-Google-Smtp-Source: AGHT+IFRnvsPtp5FkXrNsyop00uJpv0Y9NRwuVvLGL8PfWsIjwGIFwq9g5t0c88iF6drGwVti5SdCA==
X-Received: by 2002:a05:620a:bd5:b0:7c9:50a6:8595 with SMTP id af79cd13be357-7ceecbe440cmr1981672285a.28.1748386661414;
        Tue, 27 May 2025 15:57:41 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cf19d9d599sm15720485a.113.2025.05.27.15.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 15:57:41 -0700 (PDT)
Date: Tue, 27 May 2025 18:57:40 -0400
Message-ID: <c19db64a8086ec30050d9f5012204a6b@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20250527
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Nine SELinux patches for the Linux v6.16 merge window:

- Reduce the SELinux impact on path walks.

  Add a small directory access cache to the per-task SELinux state.
  This cache allows SELinux to cache the most recently used directory
  access decisions in order to avoid repeatedly querying the AVC
  on path walks where the majority of the directories have similar
  security contexts/labels.  My performance measurements are crude,
  but prior to this patch the time spent in SELinux code on a
  'make allmodconfig' run was 103% that of __d_lookup_rcu(), and with
  this patch the time spent in SELinux code dropped to 63% of
  __d_lookup_rcu(), a ~40% improvement.

  Additional improvments can be expected in the future, but those will
  require additional SELinux policy/toolchain support.

- Add support for wildcards in genfscon policy statements.

  This patch allows for wildcards in the genfscon patch matching logic
  as opposed to the prefix matching that was used prior to this change.
  Adding wilcard support allows for more expressive and efficient path
  matching in the policy which is especially helpful for sysfs, and has
  resulted in a ~15% boot time reduction in Android.
  
  SELinux policies can opt into wilcard matching by using the
  "genfs_seclabel_wildcard" policy capability.

- Unify the error/OOM handling of the SELinux network caches.

  A failure to allocate memory for the SELinux network caches isn't
  fatal as the object label can still be safely returned to the caller,
  it simply means that we cannot add the new data to the cache, at least
  temporarily.  This patch corrects this behavior for the InfiniBand
  cache and does some minor cleanup.

- Minor improvements around constification, 'likely' annotations, and
  removal of bogus comments.

Paul

--
The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20250527

for you to fetch changes up to 05f1a939225ec895a97a6b2f1cf64e329b6474f5:

  selinux: fix the kdoc header for task_avdcache_update
    (2025-04-12 11:37:06 -0400)

----------------------------------------------------------------
selinux-pr-20250527
----------------------------------------------------------------

Christian Göttsche (5):
      selinux: constify network address pointer
      selinux: contify network namespace pointer
      selinux: add likely hints for fast paths
      selinux: unify OOM handling in network hashtables
      selinux: drop copy-paste comment

Paul Moore (3):
      selinux: reduce path walk overhead
      selinux: remove a duplicated include
      selinux: fix the kdoc header for task_avdcache_update

Takaya Saeki (1):
      selinux: support wildcard match in genfscon

 security/selinux/hooks.c                   |  225 +++++++++++++++------
 security/selinux/ibpkey.c                  |   13 -
 security/selinux/include/netnode.h         |    2 
 security/selinux/include/objsec.h          |   16 +
 security/selinux/include/policycap.h       |    1 
 security/selinux/include/policycap_names.h |    1 
 security/selinux/include/security.h        |    2 
 security/selinux/netif.c                   |    6 
 security/selinux/netnode.c                 |   15 -
 security/selinux/netport.c                 |   14 -
 security/selinux/ss/services.c             |   22 +-
 11 files changed, 232 insertions(+), 85 deletions(-)

--
paul-moore.com
