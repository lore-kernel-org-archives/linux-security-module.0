Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2C129D275
	for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771152771; cv=none; b=ePOUCF24Mj7hncvlYCeBQAbrxgvYSQrp8p8z9y+4G71rdTcx0PM42hfhW5RDfpp/+kbI8moXZeh+yXUdSITrB9b567MVaGd1mlxn9IslDjPTU2T0KxUIAd3fhP1EfU1TDa2HoglSMdU95btZERB6vDTLPVWB085Av4GuEht7qV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771152771; c=relaxed/simple;
	bh=H95up0PdF0wT3xiTVLsjcbw/FTqiwcIzLRTN7EvNT9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dD2vlpBgW2sn8m/2ELJyabjjEN9TVZPGHIabXKo49i1oCPQScq82uWcXOKUbvmunRYsQyPc39enJ8XzPM9925yBg7L5ONNiVW3yqKZqIYcMCwBjprl/Fq0Xp2gDaSjaSNATxWQxwFM2mfOoARj3Ok4WRqOpFRSTiQt8TF3XDfbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aG0/vNfW; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG0/vNfW"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso16814705e9.3
        for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 02:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771152768; x=1771757568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuQwtV+v7wYKCTQx1ckWEl3T2al+gSB4N7kOmT9I2y8=;
        b=aG0/vNfW1/hkFGKjJljP5ZK19NRhTcoxM7fxSV04llX+3HKV9vlIBy186fLoLZsARX
         6bLJzVUtltpLhQnRHVGmFjjJKgZlPYAnMKNUTDgTI9Ap4ceZEwwqxr8zPr88yMavu+Cv
         KuDXdR+gGWCo3MdQeugnc6N0IwxOpRmny5A9ry3Y7tQx6FkD4b4JBPEnRUTgM675COD7
         AuLOd/kXcEkUBhsy/TzDtzL7B7y7aXBTX5vhBg8Yn3Q78aAIGx1yDo0/ldzXbF6qP1hB
         IJGnwA0VA2OK2EOuOletx26/H5ZGtutVcYfMZDiTIRD6hJX8uDZcwY6tHy5z6zpbcRnI
         wd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771152768; x=1771757568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uuQwtV+v7wYKCTQx1ckWEl3T2al+gSB4N7kOmT9I2y8=;
        b=JBHdv7KQzcMjJoD5dbYKrqb0V3o6VjQLPH5wtxvGx74TnpxGxkdJ/5sxEaqyftW7nb
         sDZ5zn2rEdbmITLE1g/xahK45WMFjlWiuxA1USRS+SmHP1AsbJXEDTS3QTFW1wQiWdj6
         PgtoehuPHPqjACfNu5sUNUa3hmx5Y7MjecO5A8BOvFBvc43kKksH3nrIQZf4Lfcj1VLf
         xJwn0FvdcYK/Xk5PgyqvWFTr0mRV2dVcl1tMf6SFB7v0B33/+j5lF5dC/izFOaBABL/G
         hB1D3IqozPvMxdZV93i/whQ9y8yfjWPg96GVmDK6cBqblSYG30DwsIaWr/55jtBQyFSd
         fNkA==
X-Forwarded-Encrypted: i=1; AJvYcCXYPGG2CNFH6hLcaC3REZzq8Nv6Wkh1lETyGyQM2ZD/DpgAghbvFXO+XLwnxoA4eViaokMFeKuIFwyEUGZ6zK4r3An3qxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwexZL1TwjD2sIk9jVZGk1yBCLunFU1ZQA8jTFPXpllq9YMTTGT
	cKULH8Br1xzUgRFFBNLzzyij2+Ho17Ocl3eG+9+7iGtB5xhFV6WofEtH
X-Gm-Gg: AZuq6aLoASkU4M3z6sQEQb0DYilHxy0B40SlnaEPrnLftfASmOGHIWJNSFT0JU9PlWI
	UHbKIRse/7lrj7gyPTsS9V0W9Aq7bZOi7Uq00yYi2An7JnaGWzD1c29LZYpKkskUERVAw439Dpv
	VTyx1yzrZaOYxXqSHX2aYWzKl/iLdAlkwUkMm03eURSIqfJvx3sa4JSVw3+jsYV+geA6/1N2JBr
	M7qvCJEdrXiqqFGwKn0LSLTCtv0WGbEGK4ZwPTJI7MnpDw5PDsjbcqn4CEH0W/knL1GOEk42iXq
	xECR/gv8KvWadjhYvNPDhqL3tH5capN/9YO/MrGrxTv3CMU1RwdF+9XtPCpKt7h014fD6OS1U+q
	O+rWSSb3YOpW0eIejK072ZnXKIoPSKtKPEUzegcCSDSqr7wJkmFGMTNXvozXTU1cKsQm6hFPPqT
	rAhDuqGpzMAfSmcCh81XmCS58pigbJDtlEk10PAxDdSJHAiyjR
X-Received: by 2002:a05:600c:5246:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-48373a5d078mr140609455e9.21.1771152767917;
        Sun, 15 Feb 2026 02:52:47 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc9b2sm17591886f8f.21.2026.02.15.02.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 02:52:47 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>
Subject: [PATCH v5 9/9] landlock: Document design rationale for scoped access rights
Date: Sun, 15 Feb 2026 11:51:57 +0100
Message-ID: <20260215105158.28132-10-gnoack3000@gmail.com>
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

Document the (possible future) interaction between scoped flags and
other access rights in struct landlock_ruleset_attr, and summarize the
rationale, as discussed in code review leading up to [1].

Link[1]: https://lore.kernel.org/all/20260205.8531e4005118@gnoack.org/
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 Documentation/security/landlock.rst | 38 +++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index 3e4d4d04cfae..49ef02d5e272 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -89,6 +89,44 @@ this is required to keep access controls consistent over the whole system, and
 this avoids unattended bypasses through file descriptor passing (i.e. confused
 deputy attack).
 
+Interaction between scoped flags and other access rights
+--------------------------------------------------------
+
+The ``scoped`` flags in ``struct landlock_ruleset_attr`` restrict the
+use of *outgoing* IPC from the created Landlock domain, while they
+permit reaching out to IPC endpoints *within* the created Landlock
+domain.
+
+In the future, scoped flags *may* interact with other access rights,
+e.g. so that abstract UNIX sockets can be allow-listed by name, or so
+that signals can be allow-listed by signal number or target process.
+
+When introducing ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX``, we defined it to
+implicitly have the same scoping semantics as a
+``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` flag would have: connecting to
+UNIX sockets within the same domain (where
+``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` is used) is unconditionally
+allowed.
+
+The reasoning is:
+
+* Like other IPC mechanisms, connecting to named UNIX sockets in the
+  same domain should be expected and harmless.  (If needed, users can
+  further refine their Landlock policies with nested domains or by
+  restricting ``LANDLOCK_ACCESS_FS_MAKE_SOCK``.)
+* We reserve the option to still introduce
+  ``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` in the future.  (This would
+  be useful if we wanted to have a Landlock rule to permit IPC access
+  to other Landlock domains.)
+* But we can postpone the point in time when users have to deal with
+  two interacting flags visible in the userspace API.  (In particular,
+  it is possible that it won't be needed in practice, in which case we
+  can avoid the second flag altogether.)
+* If we *do* introduce ``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` in the
+  future, setting this scoped flag in a ruleset does *not reduce* the
+  restrictions, because access within the same scope is already
+  allowed based on ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX``.
+
 Tests
 =====
 
-- 
2.52.0

