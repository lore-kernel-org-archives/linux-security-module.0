Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814DD387344
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592176; cv=none; b=hEK7U5syx0YFwYuLmkXN5PKbMMRAFjgaid6/3V0GYG/q4n1KasPSzA1CxFyH8ayOiCcblyoAUlTW5tDvtKXIcG6H5gAp0GR/ycSo8nsV9irT9KerR0DU/LuEBeEPeifhnfTby4MW040U70ZJMmD+DlQ8kcBDBY9KzHRZ3IlW/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592176; c=relaxed/simple;
	bh=vi5FjNFei0DMVU6UndsLw5X+Sug4/lpzBigVH5ACDgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcFmB92psMgniywB84cfc/kqQQrm4WnCjyfXfzzDRVHIVEKHs94Rdg3L8D5x63Ey0R2O007eZv+ddKnjZ4ozV8N4HezZhTCfP87TiG5wHPyg3Lr2gfk0H5GlCDTAnJGRbAOLNPT2rCSD+e4YfnuzU1OqfyM/bXowN/bfe8BiE/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQD5IOG2; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQD5IOG2"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6501418152cso5229458d50.0
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 13:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592173; x=1776196973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67+cKnsUxsC8cUauaFfSWyXKAlrlKdFCay5MrA604yk=;
        b=FQD5IOG2tWX0D59HiO4K9pEDlYxhmVP4MpXfrNIQSwpTgJpi90+YdCCZixnUArZKcU
         L3wnhMNmFMRXeP+eMdZIimpxKcqGN7Za6dzqbYagzhJLsxNkkzN8Sq0qzpXA093l6Rmz
         5H5A6p1AgkNRnUMO0K1NhxEJl8LsFvmbILHHXH3LKTSJEl/jXjM+LS3cep+M+xtsDPzZ
         gfJEMffOVL0QVhSHcChaNnTKEF3SiDtCMugA2zOz6LxGvRRFIaFSE+C0+HMFfWWbX2K0
         e/B5aZeSOFOOREdPWldZSjSrSr5ICMbWE3KKG2qmR++ITiu/mZCA5hKiaYc2dzL3x32l
         QAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592173; x=1776196973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67+cKnsUxsC8cUauaFfSWyXKAlrlKdFCay5MrA604yk=;
        b=N8he8odC+z/MyPIlf6mfrpLtZTKIQd4jZXVCf84tJkVybvMuOs+0Mb5yjjfeoLyQGK
         Glwk2ZKUw3kC/n7dGDGNs1DDcoyDh4iPMMAftwixqsxJicrQ0WlU8ng5mTKHFOSyh2eI
         ZMEGKUUcWl1FzZQducD/Ql2b2tBPaHrVevQlE54OjvqaKgv4ed9bFPpsoAiepBPtpsRV
         7hzIEHTAWU8nzi8eri1OlpYqM6bwrmf6g8sW6vni5wfDxLr0BziEQk858ed+SLddKd9K
         IyhLVYtA2YQZOe3IzngZPsWKWe2IiYc0I846mIkI9ocoktKAsEzq1L0hvH5XrLNBejHi
         83TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV8f9kZ2xbkKfi8m1Ah1KFDaBU/f8SFJLQA8ArcZgeFv5L8WSPGu3sM5L3Ji/VLGcDSc6oKFra6FMaMlH687BdeY++nmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXXz0Zs5m1pI/j3rOnMknWOHE/FlqZlMsfQzce+HUn1Vbkpre
	ae92BBpEjB2MRwNm0Ec+zh465vcTrYzEK+aJltZqUUCXn6qDVtAz2p7A
X-Gm-Gg: AeBDiesH6nG8LkRTHsRkkdm9MRvxVqj8zrfs1f+aTh7i+KtmGYf0zkz2DC0e608enng
	CvMTx4cPj7J2HcSXM9wO4bcwE2o4pW07mNhr3IIGc/DuHAaczbO1vUEoTmKBNF17xFchvNd/S4e
	AGWiwQw+zK/CdWd4sTCzttetv3fcjUH10tdJ1ZgoWny6bip1nQ/vzc/kuItwqFZURSp4r53RIyp
	3wLQJf4XEkgc1x+TODy5Cj2jJr0dh826l1bfAIlfVSTOVv2GIUIbVxJ5VTg61HEcehUF4dF4Lbv
	BxfXHxwmtjtLnOokT+7/WivyyTb/4l3JZenrfnjDSeK2tBYfQePWffUrp8LkNFuOMul1R6AL9et
	bAPXos5sPiKSPtwIscBbm0JhGByyrBZTrBgldamsj305ZH6lYlmIwuXJ355iZdV0bk9brTPF91n
	ZbX67YvNP5V4ZKeE76gsgXKtJWhm9t1AyoVr8KUWwQuF6tIHJqx3fnm8ZxxUSf42IXYxzUvTbv
X-Received: by 2002:a05:690e:11ca:b0:650:891d:e1a6 with SMTP id 956f58d0204a3-650891de307mr938379d50.51.1775592172595;
        Tue, 07 Apr 2026 13:02:52 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:52 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 18/20] landlock: Document LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Date: Tue,  7 Apr 2026 16:01:40 -0400
Message-ID: <20260407200157.3874806-19-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS flag, and explain
how its designed primarily for BPF-side use cases for Landlock.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 Documentation/userspace-api/landlock.rst | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index fd8b78c31f2f..82c88d75ef21 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -204,7 +204,8 @@ similar backwards compatibility check is needed for the restrict flags
 
     __u32 restrict_flags =
         LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
-        LANDLOCK_RESTRICT_SELF_TSYNC;
+        LANDLOCK_RESTRICT_SELF_TSYNC |
+        LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
     switch (abi) {
     case 1 ... 6:
         /* Removes logging flags for ABI < 7 */
@@ -223,10 +224,18 @@ similar backwards compatibility check is needed for the restrict flags
          * children (and not for all threads, including parents and siblings).
          */
         restrict_flags &= ~LANDLOCK_RESTRICT_SELF_TSYNC;
+        __attribute__((fallthrough));
+    case 8:
+    case 9:
+        /* Removes no_new_privs convenience flag for ABI < 10 */
+        restrict_flags &= ~LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
     }
 
 The next step is to restrict the current thread from gaining more privileges
-(e.g. through a SUID binary).  We now have a ruleset with the first rule
+(e.g. through a SUID binary).  When supported, this can be folded into
+``landlock_restrict_self()`` with ``LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS``;
+otherwise, user space must still call :manpage:`prctl(2)` explicitly.  We now
+have a ruleset with the first rule
 allowing read and execute access to ``/usr`` while denying all other handled
 accesses for the filesystem, and a second rule allowing HTTPS connections.
 
@@ -716,6 +725,15 @@ Starting with the Landlock ABI version 9, it is possible to restrict
 connections to pathname UNIX domain sockets (:manpage:`unix(7)`) using
 the new ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` right.
 
+No New Privs flag (ABI < 10)
+----------------------------------------
+
+Starting with the Landlock ABI version 10, it is possible to request
+``no_new_privs`` as part of ``landlock_restrict_self()`` by passing the
+``LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS`` flag.  This lets user space request
+the prerequisite from the Landlock API itself, which is especially useful when
+the restriction is applied from an external context such as BPF.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.53.0

