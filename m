Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B629D275
	for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771152769; cv=none; b=hiQoCwWTYT00cMhbIxSwxqwOU06gQRKgomeidjyif1uO1ZjWkoy+C5HEytpmulINTts6DedgWcimTTFiu9vhvh6NxzkZhTsYcb67mmHCwdZHyDU8EmHcD3C+54poY8UwUU6ZBXcEcT78bOeUNAoSSfxeoEL2B/CUAKaSU/lL2VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771152769; c=relaxed/simple;
	bh=ZbVK+8pBr5xeYnZaIo3CQyYa8Q3kgiyu/MsamnZItIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5z4Z6XRWmcphIK8gc8/0BkzyGoMjGy07hwsGydme6ozKhNVSJsNW7ji0mSGkoQ9BxCl/dGnbLSl6de71Enycn73YpDWltPqPzg978MArnbsUF/m21RPV/s5f2beID5hKbFvEFLX4+5k58PWrKkIM12JOILEKkiQaAJeiyDI6Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoHvBX2D; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoHvBX2D"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4837907f535so10865045e9.3
        for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 02:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771152766; x=1771757566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGWhWsCxMYkvicF33836VUAINQXBaIg696pKAr594Pc=;
        b=LoHvBX2DlGJnRKIJ2KFJd8srX/8X65+E8MZP7dUs1jKoDRmDAZiUXD1ugKUex75plI
         9AM0NiyaLNq4cdaQMDAUEh3byvVJfnk9+Fe9tqssLV/+CiEZxGaO0I8tBvIr0YmBhF/3
         uKKdSKi+XGsAy/qooymbLw62bMI3nJiRBTgZy5BVKAfcOBEIojQ72P4okg1xQME7hxnR
         tHZTtIFL7IMSlyJCNOWM5HQ+6uUWQK+DdSrzqR8q55W+GCLUvOu9izrkyfw1DuCWk49+
         H+tYye4fF/n9l3hCAddKVk3zQaf2F/3b5XQce8wJWRLiD6/BuU2udI+1W7Yna9+cxkpZ
         4xAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771152766; x=1771757566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yGWhWsCxMYkvicF33836VUAINQXBaIg696pKAr594Pc=;
        b=WkGsoD0XTr8bMNDvI/E9F3EfYcq2dhY5JyhGoKKj4ZUWy087FGSnGLzv7+nMy1u7S2
         S2dOUzvMDkaI54TTu8a3LAzvXYX3dbuF/2IKBJR8KneYppqKYPCqbrlYbEMLMV3faxvL
         thSS5yZBf2enkW3lPnCkm38nztfWPmSF9fXnBfNXiWXTxfMuoFEyoqYED4ndDdPg4Fk8
         I2mPKaPvPRteS2z2G3959+i3g56BGy1lNuULyJSmsKbCF4OouKI8VYfq+NqT+qVw3y0d
         fmab7I2hf1z3u1yRWRmBuoihc1pTcZ6TDlvPEAxIiVfB5NGB1TT2vBIuXxy3cjT4cBkJ
         fDlg==
X-Forwarded-Encrypted: i=1; AJvYcCW1Gj1u/CQUmRK4dqhaYsFmsqiagTMtpPRmJWfwPOpYvR3o0LwTJ3l4DbYTiF78YHc6ZqbAIyXzryZgAKVk40MKlay6lws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcC6BrNfG4ttq0MgDlzfif4bT4DuUw9JlQFK6ryoUlGFRsxnYh
	N8ShL/Z/nXdUX0/UkJ2KaCL+rylI/E5mM+B11aZOlYGu8uhCqgzvrWri
X-Gm-Gg: AZuq6aIEN7f2WMIRUhCLf2pvsZicj38BKyi8H+CGqmQdZOnQglnh2rm3j4SvTu4/eoU
	jZvA9cTWzl+IqGEyvwa7fmCLuHta6e2H8HNuPSYG0c0AFEEIwS0qD1rxhOSCcBxYGLf7RQa32Ep
	7ymznolacuOwirz6Nrl2bBPFPD/wpvQI7mtnSGCiN9n+Fd58ORZ/dAY/+SvuxeksiDFZShHweEp
	T5X4iTR42TXY0bPenfRA0gQqukFwx+ImdN6kGCQb3RMGHXUq/Cpys9TQU1yGxwsPyhrsYWchktX
	qNryI6BQElzy2q4tEFSKuMjj056PnykXFcW2PKj19NK6SwA5dAEVYZrLB8cop7vIep2R7Jk823Q
	SrIQ8mGsIfThidYne9wTrInzy116uppxqVaazmZWma66Ek/65y9kLTGoFZBtFyH4XggJTFySQlp
	LdVAwxmBjsVbWCtswXgyIH7eb3mDLTkktSqPCGdyryKrlyMvMH
X-Received: by 2002:a05:600c:8709:b0:480:1c53:2085 with SMTP id 5b1f17b1804b1-48379bd731emr80632405e9.19.1771152766026;
        Sun, 15 Feb 2026 02:52:46 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837e565f5esm138095105e9.10.2026.02.15.02.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 02:52:45 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>
Subject: [PATCH v5 8/9] landlock: Document FS access right for pathname UNIX sockets
Date: Sun, 15 Feb 2026 11:51:56 +0100
Message-ID: <20260215105158.28132-9-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260215105158.28132-1-gnoack3000@gmail.com>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 Documentation/userspace-api/landlock.rst | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 13134bccdd39..3ba73afcbc4b 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -77,7 +77,8 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_FS_MAKE_SYM |
             LANDLOCK_ACCESS_FS_REFER |
             LANDLOCK_ACCESS_FS_TRUNCATE |
-            LANDLOCK_ACCESS_FS_IOCTL_DEV,
+            LANDLOCK_ACCESS_FS_IOCTL_DEV |
+            LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
         .handled_access_net =
             LANDLOCK_ACCESS_NET_BIND_TCP |
             LANDLOCK_ACCESS_NET_CONNECT_TCP,
@@ -127,6 +128,12 @@ version, and only use the available subset of access rights:
         /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
         ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
                                  LANDLOCK_SCOPE_SIGNAL);
+        __attribute__((fallthrough));
+    case 7:
+        __attribute__((fallthrough));
+    case 8:
+        /* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 8 */
+        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -685,6 +692,13 @@ enforce Landlock rulesets across all threads of the calling process
 using the ``LANDLOCK_RESTRICT_SELF_TSYNC`` flag passed to
 sys_landlock_restrict_self().
 
+Pathname UNIX sockets (ABI < 9)
+-------------------------------
+
+Starting with the Landlock ABI version 9, it is possible to restrict
+connections to pathname UNIX domain sockets (:manpage:`unix(7)`) using
+the new ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` right.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.52.0

