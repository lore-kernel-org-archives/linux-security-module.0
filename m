Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657BD374E6D
	for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773613389; cv=none; b=NzxuE6ZOUtCtl8fQY143/yhbPtbQszdHyprmxj9TYfNM/28TmiYjzUCCMJOCtaEwNzpsanFsHEptwEGQ4j/rtlcCZrmPWsmjGReMhCucsX1oT1oAaH+CH7MdOexjZskZem8KuCv6u4GB9Q7IFvaCc4oGtbC5902L3TxXkDZPFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773613389; c=relaxed/simple;
	bh=MMdSMBecKa/TVU98iJiDSbCIk1byxGLIXqsd3WjosZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6C5h1emNM2w/eMK8IK1ZCb2XRhnNjwJ9Z8ywMtn70f7mok+dyOK0EDGSGVuibLs4h6oPNK5UjVVvGQ6PPuknGKM7I24I05phSoBvFEYa+u+VMainkjy5fo09LUj5ao5MXWF8uMwJcPDjkFk2A133yJeSUhpDGay5LGzfyN1KJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItGg44et; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItGg44et"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b4121c40aso513439f8f.0
        for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 15:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773613387; x=1774218187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPdWHU0zkWkQGTU3Guu3XTl04XmO9/pIdYUT1CZEMAg=;
        b=ItGg44etnCdPCyWtPRCQTyhjk+CWWhD5InhrbmpJw77fCbci3FZi4HVP0wqgyMStFt
         FE16XrahxZJOwULNHakLvPNvSGgZ0PBRwiMd2dvMbCucOpZ1RQw0SFbfbGIse4rTvd8Q
         iKHVe1w/MWuQcoPGO4ooJB7iqx6Imz7MGxgbj2Y59KS6SXYGeBNrAS3g0t6XsmqKzu2e
         yI+1C3a8YblDssFUUZ+r+90bw5n29atiyvKMQkcDRawP9yv0lOxXCX88Aqge6QP97FbM
         k2ll0K2SZsVTjQ0iLHu+5VAfzfhL12nSglabXwtcaksHWkZyQDQIAU1Qsv0rjbO5xWTT
         omEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773613387; x=1774218187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZPdWHU0zkWkQGTU3Guu3XTl04XmO9/pIdYUT1CZEMAg=;
        b=UmPSqk8EfMvtn0lld4hhNuxH+F9CRcLBc+Ks/fNTvJvR4j0TSOxGLT9bizAZbbi8wj
         1XdcGgKfTfhoQ4ngUNXB8BzocyO7uoaz6k8xFX1xAwmO4/uixK4d8qk0b4uUg+EwfQxC
         z3+bbBybLF1sw1ZlvKkM+YXZrFxbLn/G+SV/Df3URfEVJ9orT+950Z2P8sqGYbWBTbyz
         HiyZ4/2W9Y66+1vmaI9rQNlKdZVmFOPtVFQL58IFaUFGE6AdRMvTYiAc1drQZLArh748
         zroIrfzrb8SI5sn4mViduwj9BBBCgkyhA9fkx/4C2IEBhjwG1t6TEizCi0aU2D4vJhtG
         uWOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3z0Hm5ft+a4VjCUHL78SxDO5+Qkpqpyj6Hm5KeLrzyDAj9+Ef+XgnDEVhGl2kr0Yd/ymNdKAWm0/su+/NgaqL5uaGd+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6+sVQW7NZo8EPKnyz6gSDwHjxNZn35PPcxy96HhdPhAZROXlJ
	eMxFM93uyEaTEWXdrRCq8si5ltHhAEljeB8fVHB1VW336EI5tcxqVMe1
X-Gm-Gg: ATEYQzzk26N8ZRIf493t5QP58DIKWn+HnIHVU+et3WWAohPb3E0DeAfOV7d5i1kit88
	YcQN7MgholHRppbUIlYaJ+xYu5Yu+Dzk+wt3dnLYHbdXAukOZzzj6cWIlqPSmQl5umIcdY+NIGP
	H9x/46T3x098U7O17YxjxuKICTG+b7XyOVR1UEmuy7l1uVTcU/ZA5imDgIAqE8JxvttxC+7A4iC
	aA27O79CKcFWLcTL5v77x/Pi+gSjA9S9DxEhg1Xn103p9nvqG0yBKGCLD02cinKgtw4jcCUfjyC
	qMH2LWbyER1kvUfHwU/PF1VuO87+s7DVMPrN9TwxoI3NZVcDW++T/Fx78LDOVIJPW/5VggURzDd
	R96e0cD3zSQiI0u1oFyXsymlFTIDRsCaDbAGDjpit/JY55R0UBxKoVytEx9BI5EHyUDzcpbtW/Y
	TUWV8ZNyPnomokJuaJvU//wn1v0xew6Cgia7ghtmDlKfMcK0LX
X-Received: by 2002:a05:6000:1887:b0:439:fe98:20f9 with SMTP id ffacd0b85a97d-43a04daf124mr20868595f8f.27.1773613386664;
        Sun, 15 Mar 2026 15:23:06 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3d87b1fbsm12150793f8f.7.2026.03.15.15.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 15:23:06 -0700 (PDT)
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
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Kuniyuki Iwashima" <kuniyu@google.com>
Subject: [PATCH v6 9/9] landlock: Document FS access right for pathname UNIX sockets
Date: Sun, 15 Mar 2026 23:21:50 +0100
Message-ID: <20260315222150.121952-10-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315222150.121952-1-gnoack3000@gmail.com>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
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
 Documentation/userspace-api/landlock.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 13134bccdd39..e60ebd07c5cc 100644
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
@@ -127,6 +128,11 @@ version, and only use the available subset of access rights:
         /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
         ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
                                  LANDLOCK_SCOPE_SIGNAL);
+        __attribute__((fallthrough));
+    case 7:
+    case 8:
+        /* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
+        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -685,6 +691,13 @@ enforce Landlock rulesets across all threads of the calling process
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
2.53.0

