Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88734388899
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469613; cv=none; b=JVLG4IPkHEU9Ruoj354dTs+cSSI1JH0USlC2yg5dIf6QD5t5L7WNPO93tOXJu4t4yf/E3FIbx4VKu8S4m6Xol8OlQtJXGCDJbzvvMXG/xMCBdLWvNrsKG7a6L/jVD5esDbvNHfI2cW4xO36lXNy37Udb0m1MHaS5sip9jDbsKMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469613; c=relaxed/simple;
	bh=Sq83sWgPxq753TMVkvw11SCU7d6BvqA9WAomtxNAP2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxLP37YwgZIbk4zN3qHr364fZjlcrZh8yCBQB08KVwkyfsQZgB0HtAmw50WSCJXD2CSt8RdW5t6DBrmcIgFZdUmgsCrLQE43UGxsY3Cej/kBtuLcnpJ5bAv6bLTYOIVY9La0Pyc8NtK8KRFpcTWyARyvney5DFsD12EtELYAAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYiraxQo; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYiraxQo"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48c4649b3aaso2083179f8f.2
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469610; x=1792074410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LM/aN7BQpimjltFN28wgfCpiPJLZsjHzgp0MSN+55g8=;
        b=OYiraxQokE341DYT5OUoGA03NSNylmPaHiGqEjPakYw+obWVKt+ffPiWwctFH0nW0J
         Zm2gJkoXjWaGmK8OIwS6b8Ilh2yh53KF/ZQsbrq7Lsjf6qxi1ozsBnsY6deDmqhKDOZ8
         /g851856LWbO60g4khd4AjTJhcd7z+xUlkNAbAh/ywla3hSOBCa8/+NVf4FCSh8ouB7w
         zHW4gQD/Kwzc5/y/LDVFRvMmJbXCUNWx3WWXQbAzlsM3bWyxJ/bvl5dr5XL9NNR5GKIa
         Z7p4bwt/l6xyK9cT2xv/gFpXqUT8tU/9wBohMKhheBQUREnh1LK+FZfBM4YbISqQ3Ov4
         zggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469610; x=1792074410;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LM/aN7BQpimjltFN28wgfCpiPJLZsjHzgp0MSN+55g8=;
        b=Xt23xlBqP7IvHBaiWPNEA81l1goEcAHRv/46UJ9Y6KPsArpTWugsxfu6lYDpI32wsP
         40E0tEPLPzZy0qU4YkJImYAqc1hzjfnHG5bAEgf3TBVF2QiVYkuPGF1rhVSRCYhVFHj2
         53HkvlQHR3MfhoshPc+DeLqY/W8KOMqYoLUCDnnuefWbJp5vZTO3v77Pk+k02Tw0+6Bx
         kL/jwibr0XX1rFVpNJ3x6nh1aBpvJKImm3PANfDMuFyxei1YePdGKv8g5saEwdTh5izJ
         dLX3+l3pCpzQxbLt0eDQ7LeL8WfmC2bod1O/ni5LBkQJt4mpmTlswgt0+vnT9vhDmgS9
         FvPg==
X-Forwarded-Encrypted: i=1; AKwUvBxkppUIrMG4N6R8vve/LqYk4vYqh7OKARt8wdbqQzT6toD7QVJG9FPjiD75QnuiDTz7/DipsnrwqB38TCya3SuO/8bFTRs=@vger.kernel.org
X-Gm-Message-State: AFuF++l+mOktlTX+pDJZFDAJRnn2aG7Bruu5vZ+FS1HY/4I9+NH/9BHI
	vhcMyJ2t7Zu6d/pfFBsYquGgg1AArwBj+z0JzfWjGwYMbTCw2JVLZm87lAHTl6Yj
X-Gm-Gg: AYBFou2vN2x9IE3Q0nTM2Ha2XJBtJRroIb3hONvHtD8JuTxqDk04GYbeFJ/nv146wYx
	kRnwmT6IWiVFel442zzaDDxINgb4T599QHv2BUMHM2Gu/otBQRVB0eG4cxMK99vm8xSd3iSE3CH
	n9nD+6VC8TlpRpn4QPwpwtXT08m4s4eDwZi2HUsVmDVso50GWGOwWXoRkw/gpGjPqP3fqCjZj4Y
	96uA9idf3L+qOdM6rU57kVUvZDWWTVCu4iaeFJof7P76hOfl5sqYu82vX1Ms5onOtBDhhK+anSv
	IBxh2dCLDyeEy7PI6R7/AINLGuI0ZatKcvRNR1hPBZqNdU7Pae324/26CIKnTZkDtF1qyCke42G
	zzvI7mioPz1NSwSKNyFFCz8fhsALeJOz30UpTd4SN0tmE4WnVPA3Rns4Aq7Gqcko7NLgGNuT+uw
	1af+cKveCvHLWnDT5eXf8MskW2orUcuFvGN0rTCxvPn5CH6qvHo+OjNQttw5C8K9h05fEzmLKtX
	Ga5Zw85LEsa5ha1AJeYPv4=
X-Received: by 2002:a05:600c:8208:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4a1800d3dcfmr104088285e9.4.1791469609477;
        Thu, 08 Oct 2026 07:26:49 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1842a16b2sm82106035e9.3.2026.10.08.07.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:26:48 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/27] selftests/landlock: Propagate EXPECT failures from forked children
Date: Thu,  8 Oct 2026 16:25:31 +0200
Message-ID: <20261008142604.39107-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008142604.39107-2-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A failed ASSERT in a forked child calls abort(), so the parent sees
the child die from a signal and the test fails.  A failed EXPECT only
sets _metadata->exit_code, and a child that exits with a fixed status
of 0 hides that failure from the parent.  The child in
trace_fown.deny_scope_fown has this problem.

Exit with _metadata->exit_code in that child.  Do the same in the
audit.log_subdomains_off_fork children.  They only use ASSERT for now,
but this keeps them correct when a check becomes an EXPECT.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/audit_test.c         | 4 ++--
 tools/testing/selftests/landlock/scoped_signal_test.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 4bea8c880a4d..502a0825d877 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -314,7 +314,7 @@ TEST_F(audit, log_subdomains_off_fork)
 		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
 		ASSERT_EQ(-1, kill(getppid(), 0));
 		ASSERT_EQ(EPERM, errno);
-		_exit(0);
+		_exit(_metadata->exit_code);
 		return;
 	}
 
@@ -347,7 +347,7 @@ TEST_F(audit, log_subdomains_off_fork)
 		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
 		ASSERT_EQ(-1, kill(getppid(), 0));
 		ASSERT_EQ(EPERM, errno);
-		_exit(0);
+		_exit(_metadata->exit_code);
 		return;
 	}
 
diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index 259cdcc8aa5c..47307dd2e242 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -1090,7 +1090,7 @@ TEST_F(trace_fown, deny_scope_fown)
 		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
 		EXPECT_EQ(0, close(pipe_child[1]));
 
-		_exit(0);
+		_exit(_metadata->exit_code);
 		return;
 	}
 	EXPECT_EQ(0, close(pipe_parent[0]));
-- 
2.56.0

