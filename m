Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ACE3C9EE0
	for <linux-security-module@vger.kernel.org>; Sat, 10 Oct 2026 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791650705; cv=none; b=XFt5cjHqrgLSV0gH9ZbAqCHwt6d8ILtS5frv3nA9crhpERlpI3/e1HNmPzbETHaUCPkk0LA/qcmYN+c2OXFxLXtscJZMNlTw3GeNy7ZjLjL502/4KVF+5b1H5lz3wqnY71++JexUW2FkIqr4R17xWSevJF4Z1C0qbLK4YyMXb6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791650705; c=relaxed/simple;
	bh=4mXkg6pjMpHSRcU3f83JQMaC6JjhCSK2DlDg91mL8SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssKPZSuWcVeYk4sdN4stjzn9jHGGiTWwfYW75aAiPLvdmYAMNH8i8vaXC5wfodNcTi3Mi6WxC0gsndJ/03eto5JFQ4NICX8gF7QfU85Kqmx1l9XuKi6O5soTlW4Dj50B9i7WG1uw9bheyY+AVd/2qkx0JIXROi2ba32/D8iG1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2xMUeTt; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2xMUeTt"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so1315977a12.0
        for <linux-security-module@vger.kernel.org>; Sat, 10 Oct 2026 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791650702; x=1792255502; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MavqeFwiz7qivrzrIW1HjpN4bRTfbcocClc6dsjot50=;
        b=c2xMUeTtIibmOnn+IG6lUZ8QmNOv4TENWtdqbSvDwJTZYFTe+AJsf2rX9it6GuzIZf
         WsIBPVUNDGO0ttZZlJgpziebRl7vF7b33HynnW8WfeoJ66DB8yRjBN4DrjumBBl4Trwo
         WaRaGKUl5TUIXbSdqV3PPHcwPdgQ+7mTrNxfDTBifV1oV/OnjYPElDaaLYG1FS1+twqu
         onk2gBu3dP4YVOvPBQ0mo09elGOtbh/UZI99bDi1PR22B6vtfzrZBcac5Vg5633Ty9HU
         lxRMCBQYrML7hvsBzkrBxbric1rUzt0zxGbxxFzpuBBv2eCGtLSkTWkwPFWfhGlkwyNm
         qOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791650702; x=1792255502;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MavqeFwiz7qivrzrIW1HjpN4bRTfbcocClc6dsjot50=;
        b=Thdl5GGaJBFAGUg1w4zqmzYuQjcJ8FH6pcWXbm+En9An4DwIDXaETym1peWvdw0lk1
         Rc5WP4egZBaMBcSbvgs9B8p9BO4KzSnOz/Cmdn8AxtNe/JRydKxHlyZF4yXZ3d/0Id+E
         r9V2ZkdfP2mlBIRpJKWMD61DrwjJbbsnCUL2Z83TdQZouKS914JgD9GCUOR8zfSazZuK
         JLuEgJcderEHzkDMsjL7enGwrkmflp404aUz7N1p6EMgSHm8B/OONajkg7Lr+Qtu6meD
         TgDvIkGDqXnG4uXFZ8ETtyr4wDkR5hm3GnUTN6O2LgqTOY4YmtciWXC/a61TYrbNWtvn
         FPrg==
X-Gm-Message-State: AFq9FYICBuvncGtFoc90dXE9OrOcxgnI9A8dNgnqEvIxc9AlhUZM470G
	NA16HlKlxpPSNpNYcSz+85NTp2yNaDeFQvLoHArjGn42nqvvQSgECW+a
X-Gm-Gg: AYBFou31E/Ba0qlRcrRrO+A925UJvJQ2QTNRk1UxW0Wh1rju7hs6HtjUQANXdNzf5Aq
	8R+hRMUdBjfeOTYPWMMUhigVWGAvXJtvfExR6+wBq4YV69o7GDyejli4MlbQJtcAO12xyIY9i7u
	EGrJNlvnP1rKGfomjn9l+4AiTf6xn4WeYPO/d5EJDdO29u3iffo9ULNPc3nxN4TwCw59pWiUrTb
	G9KARdeNtFydnpB9GVZo7XalnTgI3P/eu86v1R9zEj2X4qwDMc9oZAHXy6PLgBtMydO2m4ed5ih
	qYD2KspDOesNnRHhCWYhTbnElRicBh7LuckyV79WAZUH9C61MRjlpsbYLEC4mQeKrKn+7kRSl51
	QU4s14FSl3oC2SBsuuae7cI6bB5Jy8NSXuLgmYW0GN/yNO0zlSsasGoEJqC3qaU6Nng9dbH7CWb
	mTUxECslo9s6hkP38tC+YBXhJhh0MlI3HXFl/joE717xcYPkat5U1eCeKjGn7ntHeqmh8E6A==
X-Received: by 2002:a17:90a:d006:b0:3a0:c31d:80c with SMTP id 98e67ed59e1d1-3ab3a953313mr2454468a91.9.1791650701717;
        Sat, 10 Oct 2026 09:45:01 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7a80:50::3cf:2d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm9096896a91.4.2026.10.10.09.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 09:44:58 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>
Cc: linux-security-module@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
Subject: [PATCH] landlock: Drop __counted_by from landlock_domain.layers
Date: Sat, 10 Oct 2026 23:44:49 +0700
Message-ID: <20261010164450.194439-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6ac91e98.bbc4c7f9.15faa7.0023.GAE@google.com>
References: <6ac91e98.bbc4c7f9.15faa7.0023.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With clang 22 and CONFIG_FORTIFY_SOURCE, the second
landlock_restrict_self() call hits a bogus fortify report in
inherit_ruleset():

  memcpy: detected buffer overflow: 16 byte read of buffer size 0
  Call Trace:
   __fortify_panic
   landlock_merge_ruleset+0xc46/0xc90
   __se_sys_landlock_restrict_self+0x2bc/0xd40

layers[] lives in an anonymous struct inside the anonymous union
that overlays work_free.  For such a flexible array, clang computes the
address of the __counted_by counter as the start of the array instead of
&num_layers.  The bound is then read from layers[0], i.e. from
the first layer's configuration, which is not a count.  The same layout
crashes clang itself in a standalone test.

The annotation was added as documentation, so drop it rather than
restructure the union.  Keep the information in the member comment.

Reported-by: syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a0eecb22de4d821a9e5d
Fixes: bd3a19800dd1 ("landlock: Add counted_by in landlock_domain")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Reproduced with clang 22.1.8 and FORTIFY_SOURCE on mic/next (64b9e6eff524):
the second landlock_restrict_self() hits the report, while 16 nested
restricts run clean with this patch.  Mickaël, if you prefer to just drop
bd3a19800dd1 from next, that works as well.
 security/landlock/domain.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 60e8eb2d6ac2..4bf1555a4349 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -246,8 +246,12 @@ struct landlock_domain {
 			 * properly handle merged rulesets without overlapping
 			 * access rights.  These layers are set once and never
 			 * changed for the lifetime of the domain.
+			 *
+			 * Not annotated with __counted_by(@num_layers): clang
+			 * miscomputes the counter address for a FAM nested in an
+			 * anonymous struct within a union, which trips FORTIFY.
 			 */
-			struct layer_config layers[] __counted_by(num_layers);
+			struct layer_config layers[];
 		};
 	};
 };
-- 
2.43.0

