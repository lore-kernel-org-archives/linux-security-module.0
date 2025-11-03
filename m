Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7505F30277F
	for <linux-security-module@vger.kernel.org>; Mon,  3 Nov 2025 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169991; cv=none; b=Ur9OqMqSqxI0c91UGs84WkjaKLWXDjEb2/clQVsLXTigNy7qAYqEYwzAcGSkvtn4ZmBDjoJ0obGLUjAR60xnWQ1HgkIJ50D9MFu5yZJs6zBzDTzbhc5NYC7NEnIxwUa1Qw/N37NXjPn4lDP8/3z5gN/tBlEMLqXKGrt6K23lrjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169991; c=relaxed/simple;
	bh=p293SKf5o/p3baJzQjvB+/sLwGBM0lsd3WQD3vZfrVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2c4bP/2Pg3k5NCM/fTmWPJt4moSxqvlqB2VjRRYN8gM7vZW+wq+ukq88pX9p9W7WhqOHeqr/8Dxx/NQKXg7lH0ZHPh5GlPEB3sLbr7j5ggch93ppB2DjNJsAdTfq6wor+uzV3i5qiUOUtK80KkIkFN4Kno3EC8gQd6+VkV3bSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhMvr4bA; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhMvr4bA"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b991ddb06a9so885250a12.3
        for <linux-security-module@vger.kernel.org>; Mon, 03 Nov 2025 03:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762169989; x=1762774789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/r08ApJzmACuZwLJWForR04uW0kQJLXeWuOH252Kn+k=;
        b=OhMvr4bAQy/h3UdeYzBNYlB7S9TLCnITU+XoyEHhUgvbVhOHxAc69mtCMNTt7KCG1k
         ZlJcyPhp7A9QbnVoVeupFS3U4cUbcrC9PHm+9uMWu8oEogWUAWfDwa1Z6HwX5HD2uKTY
         00Sc+Ptxn7D8/g10WUyh3Sfoj9wCLxZ7tqNZo4eA9RTFjwxw9mW/omY/FQx0DjfhVQ++
         uZBxBtvO+MW7WxvezPiZ970VG7tSAtSe6JBNUP9cWNtBvCV8BJujw/VOwfLVIa0fBioo
         pknFdkzvsSGbH224yWE1FeEN3Xxzi4dXzCXcKSt+9PtcLI0nL8LYZ/p5u/dLsp6OZbe7
         nrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762169989; x=1762774789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/r08ApJzmACuZwLJWForR04uW0kQJLXeWuOH252Kn+k=;
        b=a7yt8ytsy/HnZY/ZT6KjOblxut/efXoayN9QvqOpNvyCwvYxTh8J66MHVM939yrHLd
         VE2hX2cupCKm0h+VJn3nohAftLflR5zMldxnk2rBT/EXKFq6SFLPKN8JQ3o95LaUsjPT
         BUH2DBEIeJ0R6JR/j88yYxXInZYlQ//W9ItTABquMyOJ/WBXl/6OaXAPnxOQIbjMqMJ0
         IGxpFv12oL6X9EyNtNDDmu/4gd/TQUrwmHrU565aS42HLrpRlLnpx5+ncuHhAS8qwnuE
         +JCwj453HUSSTMzh6HfkhtQ9qOS5jeXs3QO0UqGFae5YOuOiVFTGME4+k70hjyL/VbBy
         pUQw==
X-Forwarded-Encrypted: i=1; AJvYcCUTtU7LMlRSzvmPIxWs6ZVgm4tbogg6d6ucYrocOowH8opO2ohkyRAOKVhxCHkPk4AAkHXvU3CbGc82tWW+jaegclzNmDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAtYtIDzOxaERVdrzW2U30/qFIeNBEBDJi8qcoIh2az9BG8WKa
	8rCO/oCsaRO785ufO5eVAkPA6kZzwM+RWV8gUD44oKw2e00ugjroiEVj
X-Gm-Gg: ASbGncuZgM9+iR64nQ4WHVry/8jlt07duDK7RS/0qkfOakAEQgnSwjEMlKs0/ERjb4r
	Iyxn38XgfeuKEg1AI2YG5oyN7t7Fz4nYdVQ7WIvjETzovgB71Uo/vd+XtNXNNhRhMHm7WH7gx8e
	gsf8UnJsy2SfRY27AmqeettLMrAnf1Q6K+LsK7z5WIak/1AirBkFYFl6zOvqxulmCFZddNdRtXA
	mKgLhHveb0uD2Bb9Ws9kllaoRtiumb/d/EeFvOziXNjDFy8Vg+HUQKllun/K3fEptY++meROvM4
	O0YGwujcPT7sEcSFkR98X8f5QQ3oqu6H+Cb7cqetLgverfChHW0GLtfmIeQm4px3qA8usgeTEFZ
	IpIk+vo8QDfGOY23FmyfT+QklI+DznMfsRZz73Nv+Iz6kd8JUfsF85pWq+FVka//GvbeplxBZ7u
	zp
X-Google-Smtp-Source: AGHT+IGVaoQkYMseij6RRLrsVDqj6D0bH7qiXKKA5WqNNjbqxLqG9f/9/U2SkMikJgtrNK8QszUkWQ==
X-Received: by 2002:a17:902:d48b:b0:295:613f:3d6a with SMTP id d9443c01a7336-295613f4033mr92547815ad.29.1762169988522;
        Mon, 03 Nov 2025 03:39:48 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2959e5deea5sm46177175ad.37.2025.11.03.03.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:39:47 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 2D8A6420A685; Mon, 03 Nov 2025 18:39:44 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Security Module <linux-security-module@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Stuart Yoder <stuart.yoder@arm.com>
Subject: [PATCH] security: sctp: Format type and permission checks tables
Date: Mon,  3 Nov 2025 18:39:23 +0700
Message-ID: <20251103113922.61232-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5303; i=bagasdotme@gmail.com; h=from:subject; bh=p293SKf5o/p3baJzQjvB+/sLwGBM0lsd3WQD3vZfrVM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkckw+cjnnzTlUswkzq8mK2iLyPfdOqpixwvT5l0t21Z sIMeu6vO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRiGiG/+GCr42t+w63Mu1b JdnOVHY9bceC6P3T1+4r3qb1gH/Lt7eMDDPNlu044a1+RXZVf7RzsveVyYc0l83ZxcnU5LMq0PZ FEyMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use reST grid tables for both type and permission checks tables.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
This patch is based on lsm tree.

 Documentation/security/SCTP.rst | 48 +++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/Documentation/security/SCTP.rst b/Documentation/security/SCTP.rst
index 6d80d464ab6e7c..321bf6c8738970 100644
--- a/Documentation/security/SCTP.rst
+++ b/Documentation/security/SCTP.rst
@@ -46,24 +46,31 @@ Returns 0 on success, error on failure.
                ipv4 or ipv6 address using sizeof(struct sockaddr_in) or
                sizeof(struct sockaddr_in6).
 
-  ------------------------------------------------------------------
-  |                     BIND Type Checks                           |
+.. table:: BIND Type Checks
+
+  +----------------------------+-----------------------------------+
   |       @optname             |         @address contains         |
-  |----------------------------|-----------------------------------|
+  +============================+===================================+
   | SCTP_SOCKOPT_BINDX_ADD     | One or more ipv4 / ipv6 addresses |
+  +----------------------------+-----------------------------------+
   | SCTP_PRIMARY_ADDR          | Single ipv4 or ipv6 address       |
+  +----------------------------+-----------------------------------+
   | SCTP_SET_PEER_PRIMARY_ADDR | Single ipv4 or ipv6 address       |
-  ------------------------------------------------------------------
+  +----------------------------+-----------------------------------+
+
+.. table:: CONNECT Type Checks
 
-  ------------------------------------------------------------------
-  |                   CONNECT Type Checks                          |
+  +----------------------------+-----------------------------------+
   |       @optname             |         @address contains         |
-  |----------------------------|-----------------------------------|
+  +============================+===================================+
   | SCTP_SOCKOPT_CONNECTX      | One or more ipv4 / ipv6 addresses |
+  +----------------------------+-----------------------------------+
   | SCTP_PARAM_ADD_IP          | One or more ipv4 / ipv6 addresses |
+  +----------------------------+-----------------------------------+
   | SCTP_SENDMSG_CONNECT       | Single ipv4 or ipv6 address       |
+  +----------------------------+-----------------------------------+
   | SCTP_PARAM_SET_PRIMARY     | Single ipv4 or ipv6 address       |
-  ------------------------------------------------------------------
+  +----------------------------+-----------------------------------+
 
 A summary of the ``@optname`` entries is as follows::
 
@@ -228,26 +235,33 @@ The security module performs the following operations:
 security_sctp_bind_connect()
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Checks permissions required for ipv4/ipv6 addresses based on the ``@optname``
-as follows::
+as follows:
 
-  ------------------------------------------------------------------
-  |                   BIND Permission Checks                       |
+.. table:: BIND Permission Checks
+
+  +----------------------------+-----------------------------------+
   |       @optname             |         @address contains         |
-  |----------------------------|-----------------------------------|
+  +============================+===================================+
   | SCTP_SOCKOPT_BINDX_ADD     | One or more ipv4 / ipv6 addresses |
+  +----------------------------+-----------------------------------+
   | SCTP_PRIMARY_ADDR          | Single ipv4 or ipv6 address       |
+  +----------------------------+-----------------------------------+
   | SCTP_SET_PEER_PRIMARY_ADDR | Single ipv4 or ipv6 address       |
-  ------------------------------------------------------------------
+  +----------------------------+-----------------------------------+
+
+.. table:: CONNECT Permission Checks
 
-  ------------------------------------------------------------------
-  |                 CONNECT Permission Checks                      |
+  +----------------------------+-----------------------------------+
   |       @optname             |         @address contains         |
-  |----------------------------|-----------------------------------|
+  +============================+===================================+
   | SCTP_SOCKOPT_CONNECTX      | One or more ipv4 / ipv6 addresses |
+  +----------------------------+-----------------------------------+
   | SCTP_PARAM_ADD_IP          | One or more ipv4 / ipv6 addresses |
+  +----------------------------+-----------------------------------+
   | SCTP_SENDMSG_CONNECT       | Single ipv4 or ipv6 address       |
+  +----------------------------+-----------------------------------+
   | SCTP_PARAM_SET_PRIMARY     | Single ipv4 or ipv6 address       |
-  ------------------------------------------------------------------
+  +----------------------------+-----------------------------------+
 
 
 `SCTP LSM Support`_ gives a summary of the ``@optname``

base-commit: dfa024bc3f67a97e1a975dd66b83af8b3845eb19
-- 
An old man doll... just what I always wanted! - Clara

