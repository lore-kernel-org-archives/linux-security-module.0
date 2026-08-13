Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2D233F5B6
	for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613544; cv=none; b=KYzsayEVDV7cBE+ytcWbG/M/LnkYuiq1RnxvyYXWuQ7grSzyCwr4SsV6rT+bVE5X5Je5xMdYvFXK/hED9ogN9pUtFYekABl9CFOMm7572qikRhGa5gGdp3Rl9+/Qdx4rUiCw+lQ1xW0wDgWaWbe5ShzkYQI6gizYt8lAFQRx430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613544; c=relaxed/simple;
	bh=rDAo7z8yghdpFZH6HM+O+h0isSaCh/zO9ufugE8CMGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YGkH0Ba8XVAPlhJTmMioQfkslNK+T/TTtGEO8PmXCU8/C2Kx3GM4eYvU3RPY8Jf6IQo4l+89R56xKsckXDuH2XG2THul6w+x5LltgTs9F7X6bg9jkMVDv8EIwvsYYV3BHijfM4mBn+8qNBA0dBi+6bk8q6aWStil5+nTlLkYLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JPb7gpo7; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JPb7gpo7"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso17723555e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786613541; x=1787218341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zsRMRIgSOidFJURUTREDjID80W35ofIDiREORh8upS0=;
        b=JPb7gpo7RxIliMfrxC0skaZMIQ6LGfwOnfENikj3JTnzqnCJh5g4iBTlkWr6Cz6DAa
         M4rLqr1jriS6mlIT8UNSSjgzqhgTqrk45wpdJIdL+JODAIgs2lwv5Ad2Ylb/nTFInSuw
         5riN8zD4b6JTGgauGrBnq4XC/sMT7dAzfYios3rdHzphSTNW1frmfnhMhWeV4PGQFhCw
         F6X9CAA7H0jy3+5HbrS2ILO82hYEx7yru2KtPxclRrY2J7GXYtTVs56ChyftxuvP0r3W
         CF9VhWliO6LkTyb6/Ir8N0lRBftn2B5ghEKOixgJtRid1+5JFPLwI6DjdV6xkjW/bk5W
         y0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613541; x=1787218341;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zsRMRIgSOidFJURUTREDjID80W35ofIDiREORh8upS0=;
        b=alYT0Nwbt556zAZvB9FCHS5NrLQtoUj97URDYl/e0R2zU8XDi5Xj55Aw4Bwlk4G6fb
         rHd5QdMMeSGjnP0iPZ83a6J5XXoC2OhXltJSizJboXSBntXB4jLbXgzgQuj8iudRO5jO
         6fN21lIacl7+9aooCdP637+tcQfoSqrG/ZHsSjHuAhVNdNEVuP8EIVxk/+oi8+K88RPP
         AoKusuWe7DM6jAk4vXHXvTlm1DEkom8hifC3QecGydzLoOslzxW9EuDCxsbmrb6icRWi
         MjpmGX3h1QhYla5l306XOc9uUwETQef8BFFGa3nkzHO3iS97FX+Wqu+rR3aHTIiLzoca
         JCkg==
X-Gm-Message-State: AOJu0YyNlGrnRA4AHrhZsCK20JNP9zRMQkhO3YLGon7VgAgaCmHM8E4h
	bQcRhMhMTbke3CA0RpkLzNH50yhmYtMp8S8TY1TLe3PtVUcgh7t4kAixELUmNBnf7bZCHdfhCBb
	LxfaqzA==
X-Received: from wmbgw9.prod.google.com ([2002:a05:600c:8509:b0:490:b1af:78f3])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:468d:b0:499:5e50:5be9
 with SMTP id 5b1f17b1804b1-499821d2d22mr42916085e9.16.1786613540809; Thu, 13
 Aug 2026 02:32:20 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:31:55 +0200
In-Reply-To: <20260813093157.1436894-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813093157.1436894-1-gnoack@google.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260813093157.1436894-5-gnoack@google.com>
Subject: [PATCH v6 4/6] selftests/landlock: Add audit test for whiteout object creation
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add audit_layout1.make_whiteout: This test looks similar to
audit_layout1.make_char, but creates a whiteout object through mknod().
Since whiteout object creation is now guarded with
LANDLOCK_ACCESS_FS_MAKE_REG rather than LANDLOCK_ACCESS_FS_MAKE_CHAR, it
also needs to log the matching denial to audit.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 871a5b819b98..a9130ed70af5 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -7622,6 +7622,25 @@ TEST_F(audit_layout1, make_char)
 	EXPECT_EQ(1, records.domain);
 }
=20
+TEST_F(audit_layout1, make_whiteout)
+{
+	struct audit_records records;
+
+	EXPECT_EQ(0, unlink(file1_s1d3));
+
+	enforce_fs(_metadata, ACCESS_ALL, NULL);
+
+	/* Whiteout creation is denied and logged as fs.make_reg. */
+	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, makedev(0, 0)));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_reg",
+				    dir_s1d3));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
 TEST_F(audit_layout1, make_dir)
 {
 	struct audit_records records;
--=20
2.55.0.699.gb54405d56f-goog

