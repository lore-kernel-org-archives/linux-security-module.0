Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E72363C4C
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019549; cv=none; b=MClCS0/QW0uQSUeWjPe0uPrqr96i5/aa9NOzZY34pLQehI0SK4lIim6JigJPE6VUeHn0q6fOe6uPph3wD5g/WqC8++vGUQwo7hTT9qY200+MzKb6Zlmo1PBDIEjWQTpEseCGwtilCyH6Dea0FY5Eswt0Kfav+Jnf25ZHMdNU3Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019549; c=relaxed/simple;
	bh=IJxeqyvQtrG7azVvLM4HbRy2GIShu6mc8HVuzDsthyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNQjb9plTTxOrRa6nLhWkG3i0xLdd1a3EZxuAdQybnJVxOlu3iuO6HLNelX2UDViLVqV4pfiBm0x6ap9ERPGpe4IrozD5KNa/k8G24ADrfTy2+tche65wlLgSHHrvQPWNsF14tVfeZB/mJ/l2VWfS53QbIugLjNFCQPZmuH6wLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd+4g6up; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd+4g6up"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7cb345cb5bfso114275507b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 18:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019546; x=1780624346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kEiKlLtYvS3U2wrQqnl+tM6yv07t9VLzyTDJ7RzJ6w=;
        b=gd+4g6upVDq4eexNco3Rm2m3FKLk8XuaCqEByPSu+BRX409nb6FrBenv+mXhQ2gO/R
         gbLEQOHYgYZmCwWpFlnvrwLquUCGqQXllte6vuDebZStD74acD8phUQPl9ZRwSiYCaO5
         Im8kTVOIAHaXVQBCU/qKSFcArTmZZIZyxcoBKupfgpPdhKK6ZGQ3/RiWtWfjnAfEa4eD
         0tpLemoLoeWKfOjOm3BcMM5/1arJHEZv7NUtwkylHtQzRZQ2u2c6g01z1G/eEMZp7jm0
         3k9khnb8zVnzZTVVoLrg/iAbUOlWGCn5mVIDeB6IfSRwHhfZuGoYR3t58YBL6CsfFKzx
         FqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019546; x=1780624346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2kEiKlLtYvS3U2wrQqnl+tM6yv07t9VLzyTDJ7RzJ6w=;
        b=TNuV6Me+jNVJ1v6rHs6+47uR0VC4BKFO81Rbz+xfzdx3IJT14/bnqoBSrnisunaCva
         ehRtjW+qYwBlWjNS+tcP3iJ6VAs1O0JeoUm2JA6OLdK3JhdagWdcS7ySSnSz3LLWZQul
         6IOSGUiRUw4KaSuuz4bqaKsQLmfKtnu586k4teZcwphNldCBMqGcyku81TALvzRASX+l
         J0tw+fVD1hnx1JGzzspVLB0MdEvPmRP76IzeCNqk9J3cwGEdQcN3lVqwccnKIjOVSZvx
         WoOJZC0BoZhYOqxhsRJKK831TsTA4kLO5+EkiyhiLPpp+KwZOk/6Wte1qa7iHPxfEQXS
         9Tng==
X-Forwarded-Encrypted: i=1; AFNElJ9gltYuAd6nJlrEzStzePZfkMQnnRXe6oNrMpB70NsfwSUtrE4uAqFUtGL/UJ6cly+Y0cMmxWudExC7jFag5hEJLlAQ3PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvrNQF1eEsksgUB+kYRIZajsATSZHy+OiYKWx0OOll3hyNZSsv
	AU63/4CwxM+S8keygWOxKtemQ+2WG5eSIn4i5s+CrEpM/Un5eYm0Knf3
X-Gm-Gg: Acq92OGfRIU1vQNhrHPMr7hh/Hb/hDKQntA91CL3nMwysRAXgPctZp8HMI2zzXnxU/J
	TqURvko+on9vzRPhJK9lemUgTJWVmgq0yFvg5jhs6nmVp8PY+N0gBkq3Z7/jv9tMPtjLqEwswkY
	B3Z47L/pR0lkvB98/WX9H5m2BS77oiJDcO2+ApZuHPx5wpL6wyhlBMYW83gX+tVfygbRbIKXdv9
	wWYPxbX8Jvd7SseDZ6kNVl6G/hUuf9SFHmcJ6Cpmp46A3BOE3hjV+3u/Y38ETYL8GhGCI+kmjO1
	kmIrgAi1Jqt6cJU1N8ZiHvLsRhwGEN4nyer7K1IIfiNUzIIaQ11mH4FSYg3J6Ou0HdKpy2MJCFo
	LYMnZU4WjluIO3mQX92VTNEfnsDpfhtutJhLYOd9XeI9zrTlSHXlypw4NodkNkOBXYbj5CeSOcs
	Eftth//Dhn71e3KTV0bcgQe8fi2YLQa3QtTPF3BvP27EgEXqXRhfT8zWiwgp9bHImEz8ELzzWh8
	Q1TYbaIF9k=
X-Received: by 2002:a05:690c:e361:b0:7d3:cf30:efbf with SMTP id 00721157ae682-7de466e551emr6975567b3.17.1780019546080;
        Thu, 28 May 2026 18:52:26 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:7a41:d368:8442:1cb2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6d1f3943sm1284717b3.26.2026.05.28.18.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:52:25 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v8 02/10] landlock: Use landlock_walk_path_up() in is_access_to_paths_allowed()
Date: Thu, 28 May 2026 21:52:01 -0400
Message-ID: <20260529015210.500291-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529015210.500291-1-utilityemal77@gmail.com>
References: <20260529015210.500291-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded path-walk loop with the new
landlock_walk_path_up() helper.  This removes the backward goto and
keeps the traversal logic in a single place.

No functional change intended.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v7..v8 changes:
    
      * Reworded commit message.
      * Reordered switch arms so the LANDLOCK_WALK_CONTINUE fast path comes
        first, and moved the per-case explanatory comments inside the case
        bodies. No functional change.

 security/landlock/fs.c | 55 ++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 8e75583c3ca7..8fb0aa59e180 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -921,46 +921,27 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
 		if (allowed_parent1 && allowed_parent2)
 			break;
 
-jump_up:
-		if (walker_path.dentry == walker_path.mnt->mnt_root) {
-			if (follow_up(&walker_path)) {
-				/* Ignores hidden mount points. */
-				goto jump_up;
-			} else {
-				/*
-				 * Stops at the real root.  Denies access
-				 * because not all layers have granted access.
-				 */
-				break;
-			}
-		}
-
-		if (unlikely(IS_ROOT(walker_path.dentry))) {
-			if (likely(walker_path.mnt->mnt_flags & MNT_INTERNAL)) {
-				/*
-				 * Stops and allows access when reaching disconnected root
-				 * directories that are part of internal filesystems (e.g. nsfs,
-				 * which is reachable through /proc/<pid>/ns/<namespace>).
-				 */
-				allowed_parent1 = true;
-				allowed_parent2 = true;
-				break;
-			}
-
+		switch (landlock_walk_path_up(&walker_path)) {
+		case LANDLOCK_WALK_CONTINUE:
+			continue;
+		case LANDLOCK_WALK_INTERNAL:
 			/*
-			 * We reached a disconnected root directory from a bind mount.
-			 * Let's continue the walk with the mount point we missed.
+			 * Stops and allows access when reaching disconnected
+			 * root directories that are part of internal
+			 * filesystems (e.g. nsfs, which is reachable through
+			 * /proc/<pid>/ns/<namespace>).
 			 */
-			dput(walker_path.dentry);
-			walker_path.dentry = walker_path.mnt->mnt_root;
-			dget(walker_path.dentry);
-		} else {
-			struct dentry *const parent_dentry =
-				dget_parent(walker_path.dentry);
-
-			dput(walker_path.dentry);
-			walker_path.dentry = parent_dentry;
+			allowed_parent1 = true;
+			allowed_parent2 = true;
+			break;
+		case LANDLOCK_WALK_STOP_REAL_ROOT:
+			/*
+			 * Stops at the real root.  Denies access because not
+			 * all layers have granted access.
+			 */
+			break;
 		}
+		break;
 	}
 	path_put(&walker_path);
 
-- 
2.53.0

