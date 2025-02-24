Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76FC26136B
	for <linux-security-module@vger.kernel.org>; Mon, 24 Feb 2025 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412123; cv=none; b=V7w1YDf48+u6KKOG9nLQaK5GhOX6AHCoaooYdck94GOw66tL0gRzhWs3bOHcVegp9QPKvfsq7SbfTlGgJrlRazA/s1Ar4RJib3CmLdlUAvcH14TnN3umjW+3424A/RM/lk4TZ89tvoQ6TIaAWLINH91DjsbdhRD4QoBHNps6kYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412123; c=relaxed/simple;
	bh=Yoe+1Q/wd9KnY0rECwMRuQsaRIV7NNTtgYXl3H+TA1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=iukTQ/egpkRliJnxztVhabeidxjJV1tgJ3kCQI0qZGOGvv+QkRjf9VpLovb/hUewev6w59E2i5u2TkJQ4F+G2kMZUvq7dj1CjoFh2pAUGKn44fO/nEr82PQ5j9oF7/m2D2Dn5Un/gtyCezRiuZrf3cW44cgGBG2TdhJq9BtfvFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MleEjGdx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MleEjGdx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740412120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VZ6BYY6WM+ve8w+hCFhsoiQPqDoYIprknITffKagk4A=;
	b=MleEjGdxcJXyycyA6ys8dqPmcdhlFiQ8ebagAFGI666tNYDspE1QuFNM9QOPGKfl4Wbdjj
	oDiwcxcKWK7H6AqYEuQxJ+VaH8gV/pBs38bKGfg3xnZxJ+IpBMqtow4NwtTuCEHLHR+Gs7
	ZEusI4WoPwsGD4sywcQ11X8LSTHIpdo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-KCnXfeGGONKVsCAMUkHFAg-1; Mon, 24 Feb 2025 10:48:39 -0500
X-MC-Unique: KCnXfeGGONKVsCAMUkHFAg-1
X-Mimecast-MFC-AGG-ID: KCnXfeGGONKVsCAMUkHFAg_1740412118
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394040fea1so22578325e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 24 Feb 2025 07:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740412118; x=1741016918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZ6BYY6WM+ve8w+hCFhsoiQPqDoYIprknITffKagk4A=;
        b=L4DDG3DJLyIfltRgn7FeVcrXHY1hb5tZ7smZnXYPHBW/PjW4pTyOOW1goQL9LqBNY5
         UcgMXFPWlr/2Bw1KHFtsPySTMG4lRiA/3eRm8XsBq1Dw9CXUztv96KvV1yoEqVDJPkGg
         Nd+93xS81rV4/fYNHDN/1ZQ4Cza39jv8Pba94sFP38DVjrvN5qULcD40qQYpFe7N9ik/
         2zgqDacTIxz2kktuAlDgymnXDq1bNMzDKyXqXBF4N9i56YVxOw79gwKvvwL8XnBJbjZT
         PxJTM8xNNddBRpbEVZpWIULfqwcgkA+mItPF3IwoiBm62DZdnhxJ4BLNGYP+JTW1BxIF
         0zVA==
X-Forwarded-Encrypted: i=1; AJvYcCWjWFG5gGleO4tTh/VAC/KjyXnF2L0sTVzYcMHWLkE5ISHPpfm4RuJEzcYUFNSg+bQSrOIkBmo2YXmAQwI+8u1Xt2HcXRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyatNcvZCiOlbakufnE3KBgPrNWq6KkmNmBYYXU8DA5gYFjXsWP
	Wc0Xx6e+veZ872GHfzs43K5FzZ1eRsA+PyaayBxtDex9HAScMZVmxIjRKE/53XXWfFbRUGyhIQS
	5J7lNnTpcJO0n7C/N+CcdVIeTYcBkaBlB9QoSRwRdZaw9m1Eo52A2MeW2AiigawJTtTR0b+0PKA
	==
X-Gm-Gg: ASbGncuvs9ZXFtJK1L1iulJRG+tDkCBEyGNXOaRmbjoaDwd2eoeZ3MoIFLFhoAl/4/5
	t/bDBdtTGlF6dGVqojs3LXiQ6PZGvp221JfPafwTKOqnzr5Admvpfh+EaJzh/YG6IV4n4bMyYHu
	1D1i4N97x7PQ89i4t0F6lWUar/+0Ah6wfA2G7ijqLNdgBdBHik4PdpS8nyc82S2ZDuPP2IhF89w
	GlCyYFGglOUi6QRbOrD2eLjMAKj8QtfJBHBcR5sLRZzKzmkq8kguq5HfEQT6ApygI5adNy0+ZKX
	CjILuJ9ZcAgQxFrDbLja2zmu+PSkmTljnK8qp7HuQL1JO4IR/S6OHVJCowVotYxTBnlk6wFa
X-Received: by 2002:a05:600c:4ec7:b0:439:95b9:99f1 with SMTP id 5b1f17b1804b1-439ae2e1d53mr110480785e9.4.1740412117910;
        Mon, 24 Feb 2025 07:48:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6TrZ14Kh1RvspHl0cC4TVOhV53fmM42M70m1mCqCLCXtOJB/rbhrvWdei//Y3u75VLLDQ1g==
X-Received: by 2002:a05:600c:4ec7:b0:439:95b9:99f1 with SMTP id 5b1f17b1804b1-439ae2e1d53mr110480595e9.4.1740412117540;
        Mon, 24 Feb 2025 07:48:37 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (89-148-117-232.pool.digikabel.hu. [89.148.117.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b0371cfcsm108736435e9.36.2025.02.24.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:48:37 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: selinux@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH] selinux: add FILE__WATCH_MOUNTNS
Date: Mon, 24 Feb 2025 16:48:36 +0100
Message-ID: <20250224154836.958915-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W-nl7QkH9yD9Js_mxHg9RhnwSOJk3ezMrXcE5xdxyFg_1740412118
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Watching mount namespaces for changes (mount, umount, move mount) was added
by previous patches.

This patch adds the file/watch_mountns permission that can be applied to
nsfs files (/proc/$$/ns/mnt), making it possible to allow or deny watching
a particular namespace for changes.

Suggested-by: Paul Moore <paul@paul-moore.com>
Link: https://lore.kernel.org/all/CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com/
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 security/selinux/hooks.c            | 3 +++
 security/selinux/include/classmap.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88b..212cdead2b52 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3395,6 +3395,9 @@ static int selinux_path_notify(const struct path *path, u64 mask,
 	case FSNOTIFY_OBJ_TYPE_INODE:
 		perm = FILE__WATCH;
 		break;
+	case FSNOTIFY_OBJ_TYPE_MNTNS:
+		perm = FILE__WATCH_MOUNTNS;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 03e82477dce9..f9b5ca92a825 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -8,7 +8,7 @@
 	COMMON_FILE_SOCK_PERMS, "unlink", "link", "rename", "execute",   \
 		"quotaon", "mounton", "audit_access", "open", "execmod", \
 		"watch", "watch_mount", "watch_sb", "watch_with_perm",   \
-		"watch_reads"
+		"watch_reads", "watch_mountns"
 
 #define COMMON_SOCK_PERMS                                              \
 	COMMON_FILE_SOCK_PERMS, "bind", "connect", "listen", "accept", \
-- 
2.48.1

