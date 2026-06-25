Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0365631F9BA
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2026 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379737; cv=none; b=ESX6EZwjU8N6OgcT7DijzlJW05SeFo6hT2muFEI8xiHYEyUmNifnSjCRixE9SgdrCgrPE1Zx5Jr3ydGppIGThQ9B7N1R3zQ1vMe1z4Mr7TQtqSE/3z1DB9oDV6JFi/Br+6qLM0lou1bPKmSwMLtGF3Zc10L7r47SrZNVv31YuFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379737; c=relaxed/simple;
	bh=kh82R1MsTSPBcl6pG1Mmww4wNBsB15g85rJvFvbgMTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erPrauMfRInghUNLbjPJD2PJvCDdpqfo+jfJ+iemhQ3eY+T2omghP0Jada+tmnjb51oX0V42uzlwMkSPYtmbho4Z+YeONmADq4FJl+r1Kei9OvwBviMB61YcN7peJimGzUIEWMCrCOeF5QlDGJdwRukZOV7IC91TxTQ8UbnmLXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyxSD9Gc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyxSD9Gc"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-492438c79cdso2264585e9.2
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2026 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782379734; x=1782984534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=My51FwaQUcZD/Nr0U6Se3oJ/GMpbaYr9QAz0ZUgNMk4=;
        b=iyxSD9GcEoHRcJOrKzk162NE7QufPAb1Cu5JJIxRTIcdg1tH8w7fF7T7AVvkAbVU7n
         L6v5A6rzDEPUtFLlKSy0v8sJd3HYFHI3E2DKbcC2fpCDwlgUWCwJREaUx0eWhJt7/bWp
         UGaU36jRpEW6Q756j+AioLrajCoZC68KAXWFeFjVEoD/fNy2yCIm/bSmbI+sO8J0IT4g
         OdiTaWD0xuaW6XUydagG8PWUDfIF9iD1mCjxwW/1BIQQYxAg74KUie2DtE6XzqbeNt6h
         EvevZWvWuZpzurDXDLVfOjfYXKe1aqHKXKNfx1sBrVJtxhRYeIFe5BnjnAMoppTunvrM
         3NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782379734; x=1782984534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=My51FwaQUcZD/Nr0U6Se3oJ/GMpbaYr9QAz0ZUgNMk4=;
        b=ISNYE72bbuFgik/uFwYy/CmA36SzpBPJkQmpMN5pASoP6gBJgbcBsfGG4sBZpEYHba
         /XHhE/RA4k9daRCn/CytmP9LLWYJGeJFEJY66R6Fk8YEY/+LE/CpRHF3HTsb4YynOH+Q
         LntBN67YRGOo/ZrU9U3ImjK8So/fRz5sxmHpi4S5V2z6BUKjNpuZ0nvt4cK0MAXN40Fs
         RGpTqJSrGo4VEP0AvCfz3gClRE1rzcfZ792JZ6aGF9DdUkpGskytDOiHWIkZO1Twb6xP
         s6D22KHAfgvC3GZqrjdS/Oo2saAdzknJohkURy2KhFlQ4pQpZxVMPlL+KiTv18AUVPRJ
         xNrA==
X-Forwarded-Encrypted: i=1; AFNElJ9Q6skv7FJJHurJM/Cb90CNm1lfw5XjXoWdW7fxlZz+O9HBJcclDJOQ/62TLF5/G8c4vd+9cJcFyWuYqPymHAq4ip7wMvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4//4507a+UQ2jafZfDE7lbdRknqedTFSR1CZsqbIR//4lTLn9
	1FZEyx4SIMs/4ysIAye51Ik+vmQzXi6DMkGDD9VZxc9CYMZpvrWZnz2D
X-Gm-Gg: AfdE7clEbHj3ohMR7ZYRSZ6YEkJZCtLGUEf5ArcsU3yC74/WAwgoNVVdePFeHWvSgHP
	LFsGBT1HYJN/s9YdGBXxUNUGGMpYD7KpU/xwlCGuYKFCq4A3qu9wfy16infsdPxg3qOaQUJH1/B
	KOQX+oS978gfKNFe9s8Q81fSBdxsQO/C18TTU4Gaqx8Uhn0D9Sfs4ec6jfx1uTHrlqn6vGkQ/r5
	heoTNuLqcAwqeWMPtDHt7GG1ozN9nOBF8uaTZNMXyTyguVcHxp4tVtQz+AD3HK0J8nd2ggVsgsI
	b8vAkvE+zBXp1Yxwa+4j7277hWLxwP3G5CCRr/wK8ILwx91sS3lhoGrNT+gUiNjRfyWB4xNOE4t
	j7RbFXhJbbQdTP4fT0LLIxXa4ORP+CIe3Tys7YgIj0xchUVFPIQw0g89KvUE0R8j5pC+shvYH+v
	VzDZuO9RQRdwR5BDF4GnBqLl4ZNuznX1CquiRwxCtBHaqXoj25HwxzUc8s+r7h1/fMkrAgoPMwH
	XBS0sdmPav9tE8d
X-Received: by 2002:a05:600c:3485:b0:485:c456:5e4f with SMTP id 5b1f17b1804b1-492667ca9afmr12005785e9.0.1782379734260;
        Thu, 25 Jun 2026 02:28:54 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee0189esm14978527f8f.9.2026.06.25.02.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:28:53 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doehyun Baek <doehyunbaek@gmail.com>
Subject: [PATCH] Documentation: landlock: Document fs.resolve_unix audit blocker
Date: Thu, 25 Jun 2026 09:28:19 +0000
Message-ID: <20260625092819.1870049-1-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Landlock audit code can emit fs.resolve_unix as a filesystem blocker
for pathname UNIX socket resolution denials, but the admin guide's blockers
list did not mention it.

Add the missing blocker name and ABI version to keep the audit
documentation in sync with the emitted records.

Fixes: ae97330d1bd6 ("landlock: Control pathname UNIX domain socket resolution by path")
Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>
---
 Documentation/admin-guide/LSM/landlock.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
index 314052bbeb0a..8eb85c9381ff 100644
--- a/Documentation/admin-guide/LSM/landlock.rst
+++ b/Documentation/admin-guide/LSM/landlock.rst
@@ -52,6 +52,7 @@ AUDIT_LANDLOCK_ACCESS
         - fs.refer (ABI 2+)
         - fs.truncate (ABI 3+)
         - fs.ioctl_dev (ABI 5+)
+        - fs.resolve_unix (ABI 9+)
 
     **net.*** - Network access rights (ABI 4+):
         - net.bind_tcp - TCP port binding was denied

base-commit: ab9de95c9cf952332ab79453b4b5d1bfca8e514f
-- 
2.43.0

