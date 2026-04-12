Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3931335028D
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022356; cv=none; b=YshXpT/y9ssJO0X5ZiTc+t2ikBpuSsox6VsiU7wczLYnM/A0xSO5pjnFv1xClikinEZuCqDRxjL7/rS3ZsfG1sCCgsTTA2ri6doXR9RWtlYjWDj5a/Rd1JogUma0JVYUDfqXwdCKoGq5cvnz4djMHUOfL3D5G1QnVlp84P2MKTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022356; c=relaxed/simple;
	bh=uLGvEWaR3qWv9g5Tu27qUJETsT7Q12kr18B3i3OCr+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5QzDqTdCzyw7Lr2dObjlVK2MvlP0JIeq3aSXymYwKZbJDI1lGs3lF92V0bqrPHi5ZCp7yKfM06cH/lhg/cEHjoKwHKk9EkuVgp+gtnOicyI+VnpAfe2KLKLrh4RPiWLQIE8IwKRDKtRurZX4ECjf/EgVizywwax6MqE1H41xVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2Kfq7i4; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2Kfq7i4"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a2ee65171so38048837b3.2
        for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776022354; x=1776627154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coWyIcOwbb4DAZRCjV6Pi187dXypb4FbVjBmnFASSr0=;
        b=A2Kfq7i4PLnBzzjMeZmQfE0XhB2x1cItla260qPO+jJILf5xwQzB5XWLBXK2pnutqa
         xh57661iUJjRBN339AMZkhSryShsCP7D6T/QK9i4/HWLCIN0L1+q6H++8bIH5Nojx/YH
         3j8HkWulA298RYmLtFSkyFofW2Twhbsx1UGdEfYpUROshn0A7OC/79kO5IsLV83G8QWL
         XmEQzYr4/o71J+klqbpLVR0qmBF7R1mxvTtNfuriomg0w68Irzb4kwmEqrS0fxyl0RQc
         7yEvCkvWLUCo+eqKGImA2P3YCh0iIn6LHMAZh/qYcc6T4DbNpzu/0VwNByLhRIxOyqOL
         S0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776022354; x=1776627154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=coWyIcOwbb4DAZRCjV6Pi187dXypb4FbVjBmnFASSr0=;
        b=K6ZKfsDvWMuoTerMEII5XUUZnxFH+dHbHRcjDh7eQWDgrM6nQPT3Zmd+jxjv2VFI7u
         PEJ3gkjy1moA0gpImpRejUIGuLqwwSu00neoKCDpAU3hsP6TblRve5EHYUTfLqH148gt
         0iPdkZNkzDp/L1468+/ZTD/Cx/ZUulDaEQ8C/c3IGObxi5GBsL5j6ptPEOiFFGLqlhpK
         vlfslvpxIIJKRtaRPYhAq2k71iRS8QujiYoyotku4EbFPtEmUiJJwIcqiTxua0/L8jwi
         mY0pUKWLxzWB3Ip8D0o8BvC4iBDfvowCLQZiEjDg0C2ZmNYi+VWcN/8s5cEZBk5xxrGO
         Y1ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/d73nfq2xQRYLt19K/DY7W68cBPRcHJ1qgGbbNQt2KSATS3xlJkim7wlXCNl7bWRRMhwdtaVyOT5FfCDx2C4R2yea74qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz149ytONkZN5RcI1CHx0D8Ts1aJNNg6K6xt/9z3Pz2LU3Lv5E
	zD5o7TApxa6vC08ZOnZrg8mJCEEWxNKERZC3WVT6QAGN4Vm7ngQrWtD0
X-Gm-Gg: AeBDieuWq2Kf9qktdAiHILO6/Z3VxsxW/nEDZygCazpkzZdy0L9l7QFyXyf8yvV/41a
	CMaoJ01cY43ajbpNnA65HNh5FRxkoInco7lVllxbTIvbipmCIaCbtw7XNGlYZkozhXk+hckzOdn
	wFejoG7EtnFmdYFOwKXj91XQ3m9vTqS9eY0VoXBiKmowwAfa++uwNzvJ1hngKh+WO/Di2aR9un7
	LJA6irYdO4UlRKD1d3EG4eUCRqsXkoq/PuBTw0kEDn8z62n2/UGxML9uSTDrToh5PnJQ43D4YTD
	LkhkRgtjSbt1+bEogN7tzuqUvQoqsmnX5Qxk65GImkEuiOSKH6z5iRNhwhFn262hKi13H6lIQ72
	sOWZLLt/SfTgMqzfUdKug9oL1UMQZRzSAnDyJSINPFTVHVub3sSTOvxw+MQ3iXBHnZP65lXf5Ns
	wbC+uAdl6b5IXcIMFiBSYVsxzh6XopH417jpVOtnnnqJGlueyiAUAlhmwWBcNeOGoL9uVEaJZW
X-Received: by 2002:a05:690c:c241:b0:79a:6751:1489 with SMTP id 00721157ae682-7af71d4375cmr119075537b3.38.1776022354266;
        Sun, 12 Apr 2026 12:32:34 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:1192:20dc:2cb3:dcdc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3c8decbfsm42395807b3.8.2026.04.12.12.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:32:33 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 05/10] landlock: Move find_rule definition above landlock_append_fs_rule
Date: Sun, 12 Apr 2026 15:31:56 -0400
Message-ID: <20260412193214.87072-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412193214.87072-1-utilityemal77@gmail.com>
References: <20260412193214.87072-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move find_rule above landlock_append_fs_rule to allow usage of find_rule
from within without an additional prototype declaration

Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v6..v7 changes:
    
      * New patch split out from the v6 core NO_INHERIT implementation.

 security/landlock/fs.c | 58 +++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 7ec26c671f91..86a3435ebbba 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -352,6 +352,35 @@ static enum landlock_walk_result landlock_walk_path_up(struct path *const path)
 	return LANDLOCK_WALK_CONTINUE;
 }
 
+/* Access-control management */
+
+/*
+ * The lifetime of the returned rule is tied to @domain.
+ *
+ * Returns NULL if no rule is found or if @dentry is negative.
+ */
+static const struct landlock_rule *
+find_rule(const struct landlock_ruleset *const domain,
+	  const struct dentry *const dentry)
+{
+	const struct landlock_rule *rule;
+	const struct inode *inode;
+	struct landlock_id id = {
+		.type = LANDLOCK_KEY_INODE,
+	};
+
+	/* Ignores nonexistent leafs. */
+	if (d_is_negative(dentry))
+		return NULL;
+
+	inode = d_backing_inode(dentry);
+	rcu_read_lock();
+	id.key.object = rcu_dereference(landlock_inode(inode)->object);
+	rule = landlock_find_rule(domain, id);
+	rcu_read_unlock();
+	return rule;
+}
+
 /*
  * @path: Should have been checked by get_path_from_fd().
  */
@@ -388,35 +417,6 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	return err;
 }
 
-/* Access-control management */
-
-/*
- * The lifetime of the returned rule is tied to @domain.
- *
- * Returns NULL if no rule is found or if @dentry is negative.
- */
-static const struct landlock_rule *
-find_rule(const struct landlock_ruleset *const domain,
-	  const struct dentry *const dentry)
-{
-	const struct landlock_rule *rule;
-	const struct inode *inode;
-	struct landlock_id id = {
-		.type = LANDLOCK_KEY_INODE,
-	};
-
-	/* Ignores nonexistent leafs. */
-	if (d_is_negative(dentry))
-		return NULL;
-
-	inode = d_backing_inode(dentry);
-	rcu_read_lock();
-	id.key.object = rcu_dereference(landlock_inode(inode)->object);
-	rule = landlock_find_rule(domain, id);
-	rcu_read_unlock();
-	return rule;
-}
-
 /*
  * Allows access to pseudo filesystems that will never be mountable (e.g.
  * sockfs, pipefs), but can still be reachable through
-- 
2.53.0

