Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EA41CBEB9
	for <linux-security-module@vger.kernel.org>; Sun,  8 Feb 2026 23:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770592289; cv=none; b=NGjNEjVC317uaJkhTn03U4vEgXt7M5ODvwoMprtkQDXVqMF5aUMER7XaO9obAFBKSNaTPxSjm2dybBZaRfhu+Rq8U9r/VOOCrbsmyaWz97zxcx4bG/PriqthNK5Hk9kyCbAAx5s5mOY3uTRR4RPzR8NNdARwbayZ3lqvqFZsWRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770592289; c=relaxed/simple;
	bh=ZbVK+8pBr5xeYnZaIo3CQyYa8Q3kgiyu/MsamnZItIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWBSvCmjTPZ5je0VgqeBBTGb7QHWFla7qpB9TWskbcVyq21Hlj0XkesY2leHpVwHeRFT7yEkbl1JIB/2u6+CIBQhtZm0RtUtO/a0Z58y0aG2d6fFCC3X713qxZar8JoRzxr0T0D3DW7izuA4NGoAEVbPtyJjjuoNES03WFybvUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5JL5m4/; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5JL5m4/"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso40961865e9.2
        for <linux-security-module@vger.kernel.org>; Sun, 08 Feb 2026 15:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770592288; x=1771197088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGWhWsCxMYkvicF33836VUAINQXBaIg696pKAr594Pc=;
        b=g5JL5m4/PXc/3XFtZyO3UKWIIIU3xu99yORLbl64QgZ5Fj0FGDLjFwXF57EXN1p2An
         MoZ6lMDsIEKjZM+czrdOOZHi7DglCQxG0YEFh1HMGdoPAwvDWWv9Q6dCcS2owtrlIMV1
         dhmKzNWvfrTnoc0ShuJW9dU/Ci8U14WFxW89i7z6dE4KMLU3d4BErEqDjFd6wog1PuSs
         mvBddzaPOPypxJ3zscofJD1OeSj91FAl8oCJwWjIVJoW1f8RCDgiEHBiXXDxopv4e1uA
         IU5gCPFaDJoXH+DSMMN5PkkWGjgJ2XJxO4e+FZrWByvrHf9yNTjJ8KLmL/G/7/MbE7Tl
         hBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770592288; x=1771197088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yGWhWsCxMYkvicF33836VUAINQXBaIg696pKAr594Pc=;
        b=trjJxuSGwvotk9RdYWQ8v9zKwG2tYvmWlw9X9N5xrJzTwFq6pE4PSAK89DBzpSmexb
         EuQwkOPHGw2lA9CGVP5hjVRU3jf8fdQUdLwqdbjaeYxHvznk8q/EtbfvsvWqbNboZb6O
         S8sscHIjuXuLER38PVutHYDWUT5N2SASI2BnE41XWB8tXMomzOdeVyU5JkylEG7YP8oT
         +QaSUujnPlSGBHXpOOaPmnOIg8IDsNJaOVr44XNSeYReUswD+hEz4tdjpEI8yS2p9UAD
         RoVVA3Tr2MXiIillfWLS1ZkjPeFjW305GVz4pX7OA7O5lupcXFAXGOXPrHLfc/yB74uw
         fQ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSGqOaJkANarBYxRSSUEHpt+cJS8XOAh235CCOh6HvhBP3kk7/VwxdVLWE87x4cdrbYZv+6Ch/m62mT2XiixukfHOxYCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh6TCZMvzfCIrzFzjDn5aXSjrK0o1Wy4W6fGx8JTZJx9SbTIMG
	er9Mwpu6vLyav4tIB1N9+SRTzNr7Y5BbcEZh7V4uojZ+bEVWJ3Q5lWRG
X-Gm-Gg: AZuq6aIXLgJb9bCLGaDcpH8B76JVgFsuHN1z509cQh5hqqIkNKNioIGhtm803oZ7WBA
	NpmSItZJdH5aAgG9zr0fEV4pGDLVw+j2Ul/UQYqNEvvVbWxMAlk/Txl2dqPgy7Ws31eOAx+X6FD
	Ig7pDAlHGeov+veIVmu7Vl0PU1VbR65e4iDSbI1z34X3V1yqEAjO/s8A9gQb1Wy/u5ofLkkdauN
	o6hMO7EfwH5wqRZd4KO72ZbP6o4PxNNHth1M9Khe6kAc2ilMAs00jBkgWujaWqtfyyzAAZkWvGs
	SrY1liemQEO414n2fQmshUSuDOjD5FdTASGqg4TpCacJUbqhufEmDKaUzOpoQybJqkZQX6Ky7bq
	4xMhQ51d8VQRp+izv+tm6lXPCJQRQbt3frLLG1HPaiwvA4KXkQKOenqOCe/Z+OoRZKo3TcGSV8W
	NhCcg4lRDQJ7aeG8vmAE5wqji5DUMbE70XHXc58tBuSxaxsJ4=
X-Received: by 2002:a05:600c:608e:b0:477:7f4a:44b4 with SMTP id 5b1f17b1804b1-48320928ff6mr128958445e9.1.1770592287820;
        Sun, 08 Feb 2026 15:11:27 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483203e126dsm148086675e9.2.2026.02.08.15.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 15:11:27 -0800 (PST)
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
Subject: [PATCH v4 5/6] landlock: Document FS access right for pathname UNIX sockets
Date: Mon,  9 Feb 2026 00:10:15 +0100
Message-ID: <20260208231017.114343-6-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260208231017.114343-1-gnoack3000@gmail.com>
References: <20260208231017.114343-1-gnoack3000@gmail.com>
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

