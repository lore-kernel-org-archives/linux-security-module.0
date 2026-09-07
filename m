Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DF53F105A
	for <linux-security-module@vger.kernel.org>; Mon,  7 Sep 2026 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814829; cv=none; b=UMu1rpG5BONj+yX/Z/NsQi9XgZ1aRPZZEY25b/M/l+5OX+nTutAHncnX5KY3Dx62JoBx6kbd1nSpJEUYou+GSf2uwG8eQSr3yNkVqx6SvNZoEE88X24s8fxX/k+7fh5U6mIFgTWep6N/86dtp7YZ3DustvfLaYpL6oIxs38OqK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814829; c=relaxed/simple;
	bh=/o20sFF/mtTU8L5mYAb/n1KYsEh2ORlv2YG9SP+nOdE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fnMrAMTRB1bqm2+GihkRP5JGFwz3iZX7fY+s1Z3aDl52CvrSqJt9Huw3MyciBArvZnJvd0Z3vEUl5fO7KnQGIyld/pzKU0x9+lSu9J5MBZDmub/cDsJIClu/zfchaXUqX86eRVpfPIGrsHliyi3pcSMb4l/iJAkx+t2JvSS3UDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j8G97Q/Y; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j8G97Q/Y"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3bc34cso83725e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 07 Sep 2026 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788814825; x=1789419625; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D+b4993ZhKzGPpJvQnPmdXZLIrwAdhGEw0qUUSYMGJs=;
        b=j8G97Q/Yun04nv+mVy9UmI4y4g6OFoQnGAPup0fZ972NWDE5hVU3KHEO0D9QIDZ6dH
         uG/1x1gKrjpWYSbSRlAq+hOX3YhYHzntDhMft8TUMO1jqyy+zlhGXgCdx50rXSrqiN1W
         4Qp0rUCvkCsFF1qUqrz+LFsCkyWEs2IVLg4b2OrjStMSGmIqSuN8TBFMhB0Z1irfmBCW
         HrS2AaxMeNy2PtaCbuL7SKrbI0RfBwRjNHG1E7Tb4Bf+XHXJNsXihml5lbDpEaSL/5zF
         tkzIhf/ADIOyT5AjkrfXx0YPO7gGWBlIA9oKE0U/EosSYuQcz4zCRuvn+zs7nTiJrxJm
         /ZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814825; x=1789419625;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D+b4993ZhKzGPpJvQnPmdXZLIrwAdhGEw0qUUSYMGJs=;
        b=JOvAZQG1JSC6TPcsoVjkGsZa4NFCiZJ2ESrAVBC1TOI9Ip0G6iqsfVQPq9lbJkiBpp
         gqUgU+MhFyd8y96h/LBtDc8ShspAG5Bb+UyDjvGThbL9PCiQBpyPIaMU7EC7HJOJbOUU
         p1FZS7su0FeJHmcAwpDR4uVDovqxWMrS4Yx8X6iy/b+oyH4s1LHILl+bkbEM3fLtT3rx
         SnUolYC9rdGaC4O8IYb4qrW27GYC7si3jZJunopww7PL2PHn81PFUQDWtUaA1fR6R0Gt
         mPFgH/EeMASkwCoCQuwDCdPrfgugkOvTTYAIApK4YzkB1Hk6U2Hh0EVroqwgNeTFyzmx
         RoAA==
X-Forwarded-Encrypted: i=1; AKwUvBzonNmSNeVigffWvBb4i2jP4ryRYj1Bn9+2aTcen6WAwQiHmEdJIuar28X3e/WqBlr0bwpBMElWH9E7JPiHbum1JaSCXdo=@vger.kernel.org
X-Gm-Message-State: AFuF++nJGgUZlzUSmgqrl5LcXQ2b8Z+aMNeJYPg7abZ1tNUJmUdqdUCr
	oaQs5oOdK/NN8meNvsQN7arhyKKUcSbM5FQLSCuarHhK0aaCQSZb4Rd0R2xm2lP3ig==
X-Gm-Gg: AYBFou0cdpywOsb6b6AUyert5bnAALzQ0qQFUEQ8LLloVQnupUZdBcHudnyW+aPL0JZ
	bBnlKaDVOrweB+WHVWtbIYUtrx9XpG450S0u9VydisbGuEbv6wNWny5693o7E6Bq0txg3J+PW4B
	wiEz6PG8BJ2F151XwWIPAPf7v467oftqEenIl5i3mxEyq6oOD9hMXnq2gmgYTVXWqoLYy7GKC4d
	UOgC/JTlcFqX4Y0foE75zFqNFZFCUYLiuq27zTqbjLwcInFVcsEShylGHwhtrt+lM+y67q4gYZG
	gAfz8X5VkIVBZSm37MJlJs8EcLp1had2TJ1Wwe64U4ULxhKxgCwtJW6JOsCm0XM2mpjC1WOZh2I
	r93hxf/KuGILANEmByfbxYYjpEmDNZDevs5sh+ciAYMX21wgkI8goT/bQdHaj8+wWeiAcOJKor4
	OhAVFTuECoLThGVqiGO7hcZ8qg3dS9Jjb0ryXkQoN902IR+ZmuBiflfA/v5pkOrnbYTYjAQGjxO
	KcmgjBZmJrsJYtdkestuX6FNR48LH2prJmQDHMPnEj9aMAR
X-Received: by 2002:a05:600c:4907:b0:499:c3da:6f40 with SMTP id 5b1f17b1804b1-49d010d5333mr1538805e9.4.1788814824871;
        Mon, 07 Sep 2026 14:00:24 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:437c:9ac6:4a41:e58b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c81c3sm31385050f8f.26.2026.09.07.14.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:00:23 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH v3 0/3] proc,security,selinux: let SELinux block FOLL_FORCE
 for /proc/self/mem
Date: Mon, 07 Sep 2026 23:00:15 +0200
Message-Id: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN8ln2oC/2XN0Q6CIBTG8VdxXEdDBNSueo/WRcJJKRUHymzOd
 w9sbTUv/9t3fmdBDqwGh07Jgix47bTpQ2SHBMnm1teAtQqNKKGCFCnDDlrdTzMezBM66DBjgnL
 Oc8kUQ+FqsHDX8yZerp92U/UAOUYmLhrtRmNf20ufxt1XL3a6TzHBJZGKZjwHIPxcG1O3cJSmQ
 5H39AegfA/QAFRMVFKwMhWq+APWdX0D0PGq6AIBAAA=
X-Change-ID: 20260814-selinux-pokemem-44625557c4d4
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jeff Xu <jeffxu@google.com>, 
 =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788814820; l=2679;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=/o20sFF/mtTU8L5mYAb/n1KYsEh2ORlv2YG9SP+nOdE=;
 b=ZmXwRrsF/uOMvXyg2m7GmtJZlNUc+YLd2/rhXAsPu69kHUhI7vrs5qtb/BA9P/iraL5bnyjG/
 PNa4GM+tlO1A+/0obRL7/8fzwsyCzvQVSba93+vtc8dnC/hvGRcnTz5
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The goal of this series is to let SELinux prevent the use of FOLL_FORCE
when a process writes into /proc/self/mem and the system is configured
with PROC_MEM_FORCE_ALWAYS (which used to be the default behavior, and
is still used by current Android devices).

Android has SELinux policy that attempts to ensure that only trusted
code can be mapped as executable in several system processes, but this
protection can currently be bypassed by writing into /proc/self/mem.

I wrote this series after discussion with Android security folks about
the state of proc_mem_foll_force() restrictions on Android.

I'm sending this to:

 - maintainers for LSM hooks
 - maintainers for SELinux
 - maintainers for VFS (because I think they generally own procfs?)
 - some MM folks just as FYI since this touches GUP usage
 - the Android folks I talked to about this

I think this should probably go through either the VFS tree or the
LSM tree.

The motivation for this series is that Project Zero managed to write a
remote exploit for Google Pixel partly because of /proc/self/mem, see
<https://projectzero.google/2026/01/pixel-0-click-part-1.html#whats-the-plan-seth-and-jann>.

Signed-off-by: Jann Horn <jannh@google.com>
---
Changes in v3:
- pass opened_by_owner as boolean flag (Christian, Paul)
- call security hook independent of kernel config
- documentation changes (mainly to adjust for changes above or suggested by Paul)
- add acks
- Link to v2: https://patch.msgid.link/20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com

Changes in v2:
- change SELinux hook to only check PROCESS__PTRACE (Stephen Smalley)
- rename ->introspection to ->opened_by_owner (David Hildenbrand)
- rename introspect_mem_foll_force hook to mem_foll_force_opened_by_owner
- improve comments
- add ack/review trailers
- Link to v1: https://patch.msgid.link/20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com

---
Jann Horn (3):
      proc: refactor /proc/$pid/mem to use struct as private_data
      proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
      selinux: require PROCESS__PTRACE for FOLL_FORCE introspection

 fs/proc/base.c                | 43 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  7 +++++++
 security/security.c           | 25 +++++++++++++++++++++++++
 security/selinux/hooks.c      | 31 +++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 5 deletions(-)
---
base-commit: 2f1baf1fc8929e6c48370be543ad028ac7ad4131
change-id: 20260814-selinux-pokemem-44625557c4d4

Best regards,
--  
Jann Horn <jannh@google.com>

