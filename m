Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B523E33D
	for <linux-security-module@vger.kernel.org>; Sun, 21 Jun 2026 03:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782013961; cv=none; b=i1bV8R3q5WNcRrJzEY8MnWYgnTYYqBrFGVqR8oy516mp7OZo5+jzN3YYEGrbbloHgBsndrKgZkDGQM6BYBWB5GWT1ngFSNtv48/T5dvYl/aIL+jZS9pobKeKya3GtPU+KtUsV4AButMJ6CGfHZVRrCJ+BD+EQi/qaTnTg1yYwhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782013961; c=relaxed/simple;
	bh=PCCDk3AlCvl+qrUWHm9UfThvT8NMaurW13nkr8nPfLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ah27zxm6l13GE48TME0cMPxX4X8c/JxdaxnBWEfiWjz0xNx0J81fI5Z/T+rTdDieMD3YmKQsQpkvMynPZklWaLnODTFXCHDhQxKk5iShH4+mQuynszBRujPmiOH1zgUIMPdQfp3RWDE3/LcJJ2AKrRx4YGvfCHqYZLw5jVHocW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqQ0FwD4; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqQ0FwD4"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-660e9ff0587so1803173d50.0
        for <linux-security-module@vger.kernel.org>; Sat, 20 Jun 2026 20:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782013959; x=1782618759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LD4LjUoVOMzDcTPNu6v4CVliQtQuHfqdT2GJbHVPego=;
        b=nqQ0FwD4Z/dOzamy4zIm+fzhaNZBKnOzqJX1oR4rtJtCFwBdPlqWhqI4YpczbMnwkk
         U3hieXSuAKo7GmgbDTfvZPio1mfX8/eBLWoNGJN44m7IcOMVib2H7jzTnEATLb1Eyjl9
         IrmBKyrquz/0Un1FkwNxvlIP2mWETHfY+S9GuoTFs1TnJmUgoH4E7oRR74GpT3aLJH6W
         tDDXSJo0CZerZK6GWoleT9EZL6pca1CEdb4gAks3zfATwD+B3cE0Rqj/Fk/8hkHOcY+/
         gVideyl8FwGvPjDJ5qbfvYynsRjl8XscIYFuQOEaiIVqHbeSZuRMzAP//8LSJ4PqmjbN
         Irzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782013959; x=1782618759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LD4LjUoVOMzDcTPNu6v4CVliQtQuHfqdT2GJbHVPego=;
        b=k/uU00dGEbomejGSXzhJC1ZiUqyyaih1VEwf3WdiTyDa22Iqbebw17diQSx3GXb68T
         /39lK68P+mSYwZGiVyqWTeaV2L62oSNn4vPEs+qInX6CrtiQj0BY2WpllPFeNeqjlez4
         DcG5JgdRsHfaDPSI049SQJmQhFakcpLcfdrCUkq7JitfxnXNAi7JyS+c8SoGoEtjool1
         3CFoIs07Pv2rEHU5b09fFIS7gb1HrMazEDwn1xHLrwZQEGQuOK6JT4Myz9zBURcMz1yw
         OjKCWIwSTXJyucyfrnN2lFnKid3GbacyfMZhYAjZYu90INnHt1nXFM0F0OnAQ9C6P+K0
         d+sg==
X-Gm-Message-State: AOJu0YyZn1Wuj7lYvYP4nHzh9A8B3YrkLuZVpapUwUNQZaSbweC4tp4S
	YvKfOr8a5vB/g1nBBBacrPsz+bf+icatZ4dDEBy9ejdFyWtvZ1rZJnEwZ7nERA==
X-Gm-Gg: AfdE7clzCG6vxH0DFx5JecydwwNQ5pflmrmJAwQ/77E262VpVg+Nb8ubGECkFLTS4ur
	BTID7gfDhuNfW/UBcgRx1Bqryj89oKQpN/Jrwtqtf3x40M4/xo24atbaDurPaxfzAGQq1OxW/0n
	RTp+7dArn0cV4AtCSpcfYyUET6ktOEFEdVGkUJa/wBV+X1knDqBfHm1ZJFSlEjpAjgDBHunEUPd
	LktqEuD62XcIeG4QyJ93dFGodEw3+k8NyCBqZH9p5pxOxXJ9e3TB+StTNmuHuiI8aDlVdRuGvCJ
	buNUz+6DqyDJfRGRErU2f4pFDxd0UKS5oBTKA5Ex/Z6Y8iYxqK4EDWafrjINYdOG7VfFRNbLmUf
	HzekpZgFxvDFgklCOiT9OIkPmJcTEG95dUyBR/CAVji9Il2MQ/6/SBkPcMkqTTvwBIxtg1ywd+v
	FpFjcWz896bfn4P4MVW4dnoZeDC0V4rD/VBSzbeIf/aJlWZA==
X-Received: by 2002:a05:690c:9986:b0:7dc:aa85:5c67 with SMTP id 00721157ae682-80135256f16mr97161997b3.11.1782013959371;
        Sat, 20 Jun 2026 20:52:39 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:2de9:628a:4b2:9b39])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025cf61d36sm17155677b3.11.2026.06.20.20.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 20:52:38 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	mic@digikod.net
Cc: m@maowtm.org,
	gnoack@google.com,
	gnoack3000@gmail.com,
	matthieu@buffet.re,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v9 6/9] landlock: Add documentation for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sat, 20 Jun 2026 23:52:19 -0400
Message-ID: <20260621035223.2651547-7-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621035223.2651547-1-utilityemal77@gmail.com>
References: <20260621035223.2651547-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation of the flag to the userspace API, describing the
functionality of the flag and parent directory protections.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    Changes since v8:
    - Expanded the userspace-api documentation: the conservative seal
      (same-directory renames and hard links denied; rules keyed by inode),
      the best-effort ancestor walk, guidance to discard a partially applied
      policy on error, and the threat-model paragraph.
    - Updated the ABI references to version 11.
    - Rebased onto mic/next.

 Documentation/userspace-api/landlock.rst | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 5a63d4476c1c..01623e0ab95d 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -789,6 +789,50 @@ when at least one sys_landlock_add_rule() call is made for it with the
 ``LANDLOCK_ADD_RULE_QUIET`` flag, additional add-rule calls for the same
 object without this flag do not clear it.
 
+Filesystem inheritance suppression (ABI < 11)
+---------------------------------------------
+
+Starting with the Landlock ABI version 11, it is possible to prevent a
+directory or file from inheriting its parent's access grants by using the
+``LANDLOCK_ADD_RULE_NO_INHERIT`` flag passed to sys_landlock_add_rule().
+This is useful for policies where a parent directory needs broader access
+than its children.
+
+To mitigate sandbox-restart attacks, the tagged inode and all of its
+ancestors up to the VFS root cannot be removed, renamed, reparented, or
+linked into or out of other directories.
+
+This seal is intentionally conservative: every rename, removal or link
+operation that targets a sealed inode is denied, including same-directory
+renames and hard links that do not change the inode's parent.  Landlock rules
+are keyed by inode, so such operations could not by themselves bypass a seal,
+but denying them as well keeps enforcement simple and leaves no edge cases
+that could weaken the guarantee.
+
+Inheritance of access grants from descendants of an inode tagged with
+``LANDLOCK_ADD_RULE_NO_INHERIT`` is unaffected: such descendants continue
+to inherit from the tagged inode normally, unless they also carry this
+flag.
+
+Because sealing an inode also seals all of its ancestors, the kernel walks
+the path up to the VFS root while adding such a rule, sealing each ancestor in
+turn.  This walk is best effort: it is not serialized against concurrent
+renames, so a rename that reparents one of the ancestors while the walk is in
+progress may leave the seal incomplete.
+
+Similarly, if sys_landlock_add_rule() returns an error while adding a
+``LANDLOCK_ADD_RULE_NO_INHERIT`` rule (for example because of memory
+pressure), the ruleset may have been left with the rule's object and only some
+of its ancestors sealed.  Such a ruleset should be discarded rather than
+enforced.
+
+This is not a security concern.  Changes to the filesystem hierarchy between
+the time a ruleset is built and the time it is enforced are outside of
+Landlock's threat model: a ruleset only describes the restrictions that take
+effect once it is enforced, and what happens to the hierarchy beforehand is
+not controlled by Landlock.  Once enforced, the seals that were established
+deny the topology changes they cover.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.54.0

