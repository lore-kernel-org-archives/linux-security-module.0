Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310F22156F
	for <linux-security-module@vger.kernel.org>; Sat, 27 Sep 2025 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758942458; cv=none; b=PqAI9cr29fOlfNIX+WK/DuZOBinCybFplWu57DJ887CDNZgo8s1JcNMWjI6aC7oiGYjulRUSACbkWBXy2lfw37Ay5MTdGPC2+vv1RoyPq/dyyJ2/emLh16WlaHJP18cg59XV9VGXnHGKW3AZIvqRyVITCuO7KJFpe8ZpHP2fMqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758942458; c=relaxed/simple;
	bh=ucrbnxHbs6y8rfjx9+39n5L5p/YEYkoVyR9JIDN1sHg=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Zd1aayV5lH8e9fxEHYk2gTCv2dS9RVhjpwXy+1s2sFAqzcygbQ0I45gxYL58k/AFNLfkq9J7jNQ8ckDrUFfcq7CxcgY44sqYYTbnTXv1IK3mt+4PQItrztCw0e7s3nq+jLjVzew08T7sGhHCSxTWnT6vC8iY5FUdMGLhZ9lFRmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ea10qfzU; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ea10qfzU"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8582a34639aso189798485a.3
        for <linux-security-module@vger.kernel.org>; Fri, 26 Sep 2025 20:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758942456; x=1759547256; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qarOpL2GufODFN9/VORlA9hfhsH3FKJWScm5xbA4n6E=;
        b=ea10qfzU3wCzJOzfvkdKZ03UYUlgB/8bkV9jQHkLCoWAQsSLmshvl1rTLjjIt7K4n1
         OFzEmX+p4L3WAPRUu1GXffGT0NyP2UA9ELNlK+mscaBwLmq401V4NzUu3ZNh8pNOXnyj
         QCnVHwQrCWoyxBSHM64lvae6Qj6UghZsfFssF80RWFwSkPrFYlW+N5Otf/2FlCTM034g
         auCtIFHPQNWlDklkmdsK4VUcSQ3RYVc66Ckg/78AZtmQUK4rzUieO7wYHlMpVLfb26CV
         Ay+XaVST/WYvMp7Nl05pBIgg/pqwhj/DYUfk4Q62BqiSktqcx+vDRy1PAd0n9X+OpLv+
         KhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758942456; x=1759547256;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qarOpL2GufODFN9/VORlA9hfhsH3FKJWScm5xbA4n6E=;
        b=tEHWGhnGNZL0Khymx/OnJG8t3oTn28tdyU2hxzuHLA59shNTjA4/k9e3Js8HkJ3O15
         LYeS52xlrsMtVQSw32brZ0hbB6+tBEkTi1kDpk0WP4IoR05huXxKggNOIVIyS7Jjlzi+
         8VUc45TOn7onbKxRlZ2HRuyqRTjZ0OqJKixhSIrvwTcAGzvrv0fJKvP9KwVvHAUIMk3Q
         OMil4Sbkm7saAHGO//7qEwZmCgnzYQ4hY+8aI+wjDbeW1iOjP6CKRU5ZvAAjOrMlhYQm
         sbpYzs3XOq/wLUM3bo6jFGrOtRc+tGI/bScNk7nNF2uWfl0HF7ChrXj/fZeJQnBAlXr5
         EXGg==
X-Forwarded-Encrypted: i=1; AJvYcCWzRVVMsf/Ej0iVqTukRVkjo6n5b1iCUKCsgXouWegXsVDumw5NGvYNoTBHUEifNT1Y4AhAhPUqVqcSbuMjuC95Z4sDIC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ+FctULyu0wu9a758uq1rs9jY86mhWNbxUr2/7CGzxqv5oQxf
	Dw5qjU2jIW6g4OtkhIqLTbYMiFOWGEL4Dd3e0Y+KeDlpsMH8Vq54hDqRpfEEFC8uJg==
X-Gm-Gg: ASbGnctR2ZrCn6u/LkniKakdc9PxnKqhI25pc4Ev+BlBNEZlECSiPMYwc1VegSum+0/
	WHyqhl+nT+OgVVX5H8uDfkNOnp91tHtKUNYj7iG8EtTPDk8UTDbxmhRk+OvVqXr/W7yWzvvWlFd
	ZoiY+Rw+y9PVrCLNOySppdvQPc05XMImJrn2tIJKqbWyYdgzcxOP0N0nWTVlYa7oKKNuDjDklTH
	q4cpd7xjw/xBnz48pZr2FMQn5NHhtpg7ulGAdN9OHnzzPmFDEGoFeO9nf6iK6Ldm24PV9hg5AzQ
	X4f8GirEow8NCCPq4kbIZ49k6QCA4hlx2gEDL98T0fnNvrTYLrptOeRdYoYkRY6ydLioABrzIGC
	63E8jli/OgnnKBsIe+rCLH1X0pTXOePxczTaKKNPkz5ndyrOwuTxb+jG7XXV9bn2ZsC34
X-Google-Smtp-Source: AGHT+IH7/95OX7mDmeLwjFg9UQBqc4U9wVQ3WQqLE+SJ450L4afnkagQt2OSLDQqm/vQMLWRbYZQVw==
X-Received: by 2002:a05:620a:17ac:b0:865:cacf:e11d with SMTP id af79cd13be357-865cacfe675mr27248685a.12.1758942455861;
        Fri, 26 Sep 2025 20:07:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4db11cd52e5sm36709041cf.47.2025.09.26.20.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 20:07:34 -0700 (PDT)
Date: Fri, 26 Sep 2025 23:07:34 -0400
Message-ID: <6edbd0e6dc79902981bf9a34e8d41128@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20250926
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Here are the SELinux patches for the upcoming Linux v6.18 merge window:

- Support per-file labeling for functionfs

  Both genfscon and user defined labeling methods are supported.  This
  should help users who want to provide separation between the control
  endpoint file, "ep0", and other endpoints.

- Remove our use of get_zeroed_page() in sel_read_bool()

  Update sel_read_bool() to use a four byte stack buffer instead of a
  memory page fetched via get_zeroed_page(), and fix a memory in the
  process.

  Needless to say we should have done this a long time ago, but it was
  in a very old chunk of code that "just worked" and I don't think
  anyone had taken a real look at it in many years.

- Better use of the netdev skb/sock helper functions

  Convert a sk_to_full_sk(skb->sk) into a skb_to_full_sk(skb) call.

- Remove some old, dead, and/or redundant code

Paul

--
The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20250926

for you to fetch changes up to 68e1e908cb7682db9fb7f79907f9352435a81c0f:

  selinux: enable per-file labeling for functionfs
    (2025-09-07 12:54:56 -0400)

----------------------------------------------------------------
selinux/stable-6.18 PR 20250926
----------------------------------------------------------------

Neill Kapron (1):
      selinux: enable per-file labeling for functionfs

Qianfeng Rong (1):
      selinux: Remove redundant __GFP_NOWARN

Stephen Smalley (1):
      selinux: fix sel_read_bool() allocation and error handling

Tianjia Zhang (1):
      selinux: use a consistent method to get full socket from skb

Yue Haibing (1):
      selinux: Remove unused function selinux_policycap_netif_wildcard()

 security/selinux/avc.c                     |   13 ++++++-------
 security/selinux/hooks.c                   |   10 +++++++---
 security/selinux/include/policycap.h       |    1 +
 security/selinux/include/policycap_names.h |    1 +
 security/selinux/include/security.h        |    4 ++--
 security/selinux/selinuxfs.c               |   18 +++++-------------
 6 files changed, 22 insertions(+), 25 deletions(-)

--
paul-moore.com
