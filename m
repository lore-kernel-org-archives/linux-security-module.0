Received: from mail-yx2-f1.google.com (mail-yx2-f1.google.com [74.125.224.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2BD48F843
	for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409408; cv=none; b=iR2XaQbYiwxXdz94LKLoDeKooXyEk6FvBI9dXWHyeRO0PjsGKTajEgV8quETEDto4e4mRHO7zo5OWMNr53/LDrZ1F56ScZ/yEUCgtqmvzBM1e1FmHF2bY42ZuTEkIdNzhuDQRGKt6cqVMXt0U0U3/BHEROW2ZdYg0Bh5laqmoDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409408; c=relaxed/simple;
	bh=BYAdkqFw+JhFCbVAYMWPqM8MRr41rR9mE0Rhks0Supk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wl2oF64uigPlGvFbQ9blteZrru13k1GACMJ/miWq4eH1GIECvNJu7h63TUFYT6PQG6atB60hTjjoIx8SnLuWah2uKvR0sN9ngi/xw4fqov8FfMtsNp2j93y8Q1xlsvEqNKIpZJdmwbOgoKl5cum9eqbPTLx3kwG/Z2lx7qyBaRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=vyfnIJsJ; arc=none smtp.client-ip=74.125.224.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="vyfnIJsJ"
Received: by mail-yx2-f1.google.com with SMTP id 00721157ae682-858ef75b39fso839447b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 11:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1789409401; x=1790014201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8OIGXq9LPdM6hJ4yEHsUVyge0A5woOLwG6L03+WxApo=;
        b=vyfnIJsJswN7qzRiqUGOS/VpBIvTG1LFLie1I3KRLjtfYe4LVnMyoWiL55s4kciQkU
         Sw1zeZocv7NNfzJlxTxDvvltpES6mmbICO50PBFPK6I/8stSYm/9etbOQV3Lsu6MKmnA
         +Ag0iDirVLgJrpLT5K1jmUaVef+7J4RatiwgarUlTxUdZKVwfF7F1Dzz3nEkpv+uuTv7
         eZHcYtQMcgiJ26iuGOLPTpYFI22eVpBU4OMBYsCA/N+Gs7hZGuXLW/JwnSkT2x4jA8Po
         oi4x/ZehEz8TCQ1ODwmeJJBR9qXzpMJ+jmOIurT8uHRKaH5LCR7MU+7zf5IhBSQMwmOn
         kDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789409401; x=1790014201;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8OIGXq9LPdM6hJ4yEHsUVyge0A5woOLwG6L03+WxApo=;
        b=QdLiFBLbwE4Zrd3eDob4r2kVKsJebZqaaqnT4AxztvCUP4SbYn2DfS0QhxYEoqutGx
         lq8YOIuo+tKyzjEWAS5f6u0ILxP3JIWr7YBQ+zWRo9EJfoSWqag2lxy9tXv7slQtOVUD
         4pxU1KPyEBXw7AoG+wMoUlNYs4O1Z4nN+x6KhcVEDIteF8PuP8ABmsv9TIhvYEqcXaEx
         c6u3L2KLiADYPAdcluZkgzJTfJd8hGX2envXzK0P46HR1kiaxVbPO5YYGy44CCzCoycb
         e2PB6iCoOvDo/70dyvBjTmaAQwcqe2OOcyltN7Cf6nJL7CeDep+d8GdNftTW/zau8tWT
         RLfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqIvkPZG9X0YdjDBwmevujTg7M8Qj0Mt8UQOyfd+SxevwqW//83C8UNOmqRTgMJt4QA6HPt2k6J/3sv9LhWRSARiQw6lA=@vger.kernel.org
X-Gm-Message-State: AFuF++nRaE2PAbYXFkv0f3cIFgVn28ekS+DOX+gdmNqUomsVx8WP5XmY
	7jNMBq+8yU6SdHXY2sj+Mhq1NMgmvE2MyjnTAi2gufJBuzebxJ5oHpCK4oNSl5+afCTM
X-Gm-Gg: AYBFou1XnRlBoQ61z/HWD/WsD3AjFeutAL5dw2kYb6TbnUREStqv2q//tWSeoRgqFrH
	5/OMbTnrgrPYgWISg5IwkvkF27XEgjsFGc43rCXuCCbcg4gz0iPeBQ2GAH4P8KCNwVFZOzk47ZB
	nNWHIt0JxZrDH0wAxP7jdHrkjcPmJkYsnSRIYG/nuUvRU40faDsZX7aillpt7jddN8QUavfXM2J
	foNoBieIKhEFZpHgUt0NgDyX0kn6oEElNoZM2mkkDpOZ3mqPCBHiTtNfQ2OipBrtAtcndHjYnf0
	9EKpuc5AuS2qL4aUakUS7QNnkZCgTRdqAk6OjAIvz5gngca9s+6sHBBhSsnB+mY+CzjGl/SvWNx
	SLxTLbiS6AZBvaG41hIJW/CCjEzIIOZJKzxlh8RG+U5K2FRE1mkggRqBFIdJuVhl4IqMaVPOHGi
	mDpgmjAG4Rvk3Eaj4Mfjysm9eRkWND+sOu/WbJVP6mk6oN5Nk/C8XzL7NMsJvnnJ1CFDloP4kDt
	FgCvvnOEuxOzpmbyHpDsUGmSRcOJAR1HHK2QBs=
X-Received: by 2002:a05:690c:6c87:b0:861:a34b:7de6 with SMTP id 00721157ae682-88d1992ba59mr15916227b3.0.1789409401043;
        Mon, 14 Sep 2026 11:10:01 -0700 (PDT)
Received: from kelso (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88488856486sm39517817b3.37.2026.09.14.11.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 11:10:00 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: landlock: clarify TTY signal scoping
Date: Mon, 14 Sep 2026 14:09:46 -0400
Message-ID: <20260914180946.1462099-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914.b8a029f9abb8@gnoack.org>
References: <20260914.b8a029f9abb8@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

LANDLOCK_SCOPE_SIGNAL mediates signal delivery when a sandboxed process
selects the recipient, including SIGIO through fowner.  It does not mediate
signals directed by the TTY layer to processes attached to a terminal in
response to terminal activity.  This distinction was clarified while
discussing TIOCSIG handling because the PTY master acts as a capability and
the signal recipients have attached to the terminal.

Document the TTY-driven signal paths which are outside the scope and advise
controlling access to the terminal or PTY master instead.  This records the
outcome of the RFC discussion and avoids implying that
LANDLOCK_SCOPE_SIGNAL covers every signal-delivery mechanism.

The documentation text and changelog were drafted with assistance from
Claude (claude-opus-4-8) and Codex (gpt-5.6-sol).

The userspace API documentation builds successfully with the kernel-pinned
Sphinx dependencies.  The remaining warnings are unrelated to the changed
Landlock text.

Link: https://lore.kernel.org/r/20260914.b8a029f9abb8@gnoack.org
Suggested-by: Günther Noack <gnoack@google.com>
Assisted-by: Claude:claude-opus-4-8
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Christopher Lusk <clusk@northecho.dev>
---
 Documentation/userspace-api/landlock.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 84cb7bf6b3ed..64418b09840d 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -430,6 +430,21 @@ The operations which can be scoped are:
     This limits the sending of signals to target processes which run within the
     same or a nested Landlock domain.
 
+    This scope does not cover signals delivered by the TTY layer.  A process
+    holding a PTY master, or otherwise driving a terminal, can cause the TTY
+    driver to deliver signals to processes attached to that terminal across
+    Landlock domain boundaries.  This includes ``SIGINT``, ``SIGQUIT``, and
+    ``SIGTSTP`` via the ``TIOCSIG`` :manpage:`ioctl(2)` command or the
+    corresponding control characters.  The TTY layer may also deliver
+    ``SIGWINCH``, ``SIGHUP``, and ``SIGCONT``.
+
+    These signals originate from the TTY driver in response to terminal
+    activity rather than from a :manpage:`kill(2)`-style request.  They can
+    only reach processes attached to the terminal.  To restrict this
+    interaction, control possession of the PTY master and terminal attachment.
+    For example, do not pass a PTY master to a sandboxed process if its slave
+    has processes from outside the Landlock domain attached to it.
+
 ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
     This limits the set of abstract :manpage:`unix(7)` sockets to which we can
     :manpage:`connect(2)` to socket addresses which were created by a process in
-- 
2.55.0

