Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793225899;
	b=dQDfL/xypRWz8lPBas8tS/byFB8m9wySZlAWlklSfsS1ppLYpPWWpVlAmnvrznXAG3To
	 p10jO1dqjSlw/Ng7VaxLqGQUORw/mU+0AXeoqDP15TNwArFKd0RTJl7OCya0FyZv9qc4A
	 yMpxlkJgQB1SEHDn3G1nEq0804ldIfG0jJuuWCHU6q8S3u95m5Vn6tZtScZIsWNvjt+EY
	 DOgR3fQC6rXJE3gPpSFEiSzXb8m4HHpADCLM2FBIPMqHKuEkYLF3TLjTSk+HJQs+Corqw
	 45G7eTGML2VbizoVygN6FVJfIkUg74CVzjipe/MBEIb3aQF07bOLHhsuGnXFOcJ5sGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=uR8d+2KzOCc+PCIXuOJ1VzHWTSd8KrcryDy/HkQ7hhE=;
	b=A4toLrNHqO7QAPLFpYwocsAwejv0tByvW4O7HW3mSr7DHjYkrVZ7lcZvy5vEhWBKZHIO
	 BMUYYu5BHYpCYYLRZRm1PFGCcFL9ivMnsyXniKC2iQD8Cng+7+Pf2JMpi0FAN257NTWc3
	 FNRSsp7lYZAtK+FSocg2Lodf8aQJLkxTDPrAV9M7vU2rNPVbZEHY71J3kmXf1CM02Wo+P
	 PZfsXqMuFikzwqxqQiuUGGvcrxCQHwqzIEay4pD6DleY4OLR0pwwhQg2lvlhdcZh25SzR
	 Bs5YVU2LnRgs2yKQsN+s8PKlQ+WHkxrvaLMysJRtksT1qZQijh6a3IcSNRKV07o/jtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--halg.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Naryf3Bo;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744BE60A2617
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 22:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 744BE60A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--halg.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Naryf3Bo
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c3f8e149ccfso153473566b.3
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 15:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793225898; x=1793830698; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uR8d+2KzOCc+PCIXuOJ1VzHWTSd8KrcryDy/HkQ7hhE=;
        b=Naryf3BoTAgS7QAbA7uYgHtdsAfs7go5S+lar2IQfYFDv+/JIJ9a7cszrFOIZyL6tf
         5oHhU63oYx1IVKr5VVmiPISjhp7vO2E584Gxm/ZlmYR4cR3jO3py+08IctQz99Ceq0b5
         knm4LT9KQ5d6cLNyJdOeTTcqHGZpa2l1BhNVnLLUm+zVb547MxbQMXAjvcxSC4KBVe74
         3q/OpGcIrLthHI11T5bhowkmTxjrPp0t7IOcoE0BuEFX68r9dguAB6apV5AbAu6PtQ9C
         1Lso0n8Fq2kIvChHX0JFsJ+iuIEJ6dHrONLyb9LF8ShWotR9Bs9jZoyKrJyQuit9FpEP
         A1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793225898; x=1793830698;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uR8d+2KzOCc+PCIXuOJ1VzHWTSd8KrcryDy/HkQ7hhE=;
        b=0pdfAw92Lk1dS046h1igeX0DALAD6ugiAnk8TKdrxkgT4TPBtop77691hWsmiCFk/R
         PBwPPJlu4QJdtJlHPCyk/ZeWkro2Zz5HAvP2N/FqVd0hOhEiBoI3HIltd1MBzyN0FGj1
         HL045TQDr5++w8tPnenfBkAJ+cXQCzwK1YWMNBJmAhEbvzwuWdwwN2eYbHJlov/XgXx/
         csCO5v/t6utxo0RZyLH6Sme1zNGDJVAz+ONYV118D/deVcGaVlsRsE+OkVet3OlEe559
         i/EHbAKLqwiQ2F/Q/J4oz3TVG+1crVcgi+h3wuWP6cWWLG9VBAj8Bmc55XB7r78sej5m
         gFEQ==
X-Forwarded-Encrypted: i=1; AKwUvBy91vyWEGJSUi1kDh9HwDxAKp6xrwJBuFNSrO6eQ7NrWrST+MdsqQpcbVVRqpFhQYzXbQJJpmwD/XcZKG9WDQUgA1b30IM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmSniQ8ccQq4ZyvdJ4WpQCxdmVeSw8kftxCcQGSqir0xkya9qO
	upzjjA7eW1+e/ZnyHs7WyAtQxRISYA1vWmHW9+/tts2W6J6btxhnamfQRxZsa47ZfIQq26E3DQ=
	=
X-Received: from ejckx26.prod.google.com ([2002:a17:907:775a:b0:c31:9629:c57e])
 (user=halg job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:868c:b0:c26:1648:a06b
 with SMTP id a640c23a62f3a-c49bdf5c1e6mr326815366b.38.1793225897748; Wed, 28
 Oct 2026 15:18:17 -0700 (PDT)
Date: Wed, 28 Oct 2026 22:17:04 +0000
In-Reply-To: <20261028221705.3915340-1-halg@google.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028221705.3915340-8-halg@google.com>
Subject: [PATCH 7/8] selftests/capabilities: add clone3() tests for CLONE_NEWUSER_BSET
From: "Hallgrimur H. Gunnarsson" <halg@google.com>
To: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Jan Kara <jack@suse.cz>, James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, KP Singh <kpsingh@kernel.org>, 
	Jonathan Calmels <jcalmels@3xx0.net>, Casey Schaufler <casey@schaufler-ca.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-api@vger.kernel.org, containers@lists.linux.dev, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Hallgrimur H. Gunnarsson" <halg@google.com>
Content-Type: text/plain; charset="UTF-8"

Add tests to userns_bounding_set_test to verify per-namespace
capability bounding via CLONE_NEWUSER_BSET.

Signed-off-by: Hallgrimur H. Gunnarsson <halg@google.com>
---
 .../capabilities/userns_bounding_set_test.c   | 146 ++++++++++++++++++
 .../selftests/clone3/clone3_selftests.h       |   1 +
 2 files changed, 147 insertions(+)

diff --git a/tools/testing/selftests/capabilities/userns_bounding_set_test.c b/tools/testing/selftests/capabilities/userns_bounding_set_test.c
index 798758e0705d..140c12e16e9e 100644
--- a/tools/testing/selftests/capabilities/userns_bounding_set_test.c
+++ b/tools/testing/selftests/capabilities/userns_bounding_set_test.c
@@ -417,4 +417,150 @@ TEST_F(userns_bset, parent_owner_cap_restricted)
 	EXPECT_EQ(EPERM, run_parent_owner_setns(restricted_mask));
 }
 
+/*
+ * Verify that CLONE_NEWUSER_BSET restricts capabilities in the child user
+ * namespace even when the global sysctl allows all capabilities.
+ */
+TEST_F(userns_bset, clone3_bset_restriction)
+{
+	struct __clone_args args = {
+		.flags = CLONE_NEWUSER | CLONE_NEWUSER_BSET,
+		.exit_signal = SIGCHLD,
+		.cap_bset = cap_full_set & ~(1ULL << CAP_NET_ADMIN),
+	};
+	pid_t pid;
+	int status;
+
+	ASSERT_EQ(0, write_sysctl_caps(cap_full_set));
+
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		if (!cap_raised(CAP_SYS_ADMIN))
+			_exit(1);
+		if (!cap_dropped(CAP_NET_ADMIN))
+			_exit(2);
+		_exit(0);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
+/*
+ * Verify that passing cap_bset = 0 with CLONE_NEWUSER_BSET drops all
+ * capabilities in the new user namespace.
+ */
+TEST_F(userns_bset, clone3_bset_empty)
+{
+	struct __clone_args args = {
+		.flags = CLONE_NEWUSER | CLONE_NEWUSER_BSET,
+		.exit_signal = SIGCHLD,
+		.cap_bset = 0,
+	};
+	pid_t pid;
+	int status;
+
+	ASSERT_EQ(0, write_sysctl_caps(cap_full_set));
+
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		if (!cap_dropped(CAP_SYS_ADMIN))
+			_exit(1);
+		if (!cap_dropped(CAP_NET_ADMIN))
+			_exit(2);
+		_exit(0);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
+/*
+ * Verify that an unprivileged caller cannot use CLONE_NEWUSER_BSET to bypass
+ * the global sysctl ceiling.
+ */
+TEST_F(userns_bset, clone3_bset_cannot_bypass_sysctl)
+{
+	uint64_t restricted_mask = cap_full_set & ~(1ULL << CAP_NET_ADMIN);
+	pid_t pid;
+	int status;
+
+	ASSERT_EQ(0, write_sysctl_caps(restricted_mask));
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		struct __clone_args args = {
+			.flags = CLONE_NEWUSER | CLONE_NEWUSER_BSET,
+			.exit_signal = SIGCHLD,
+			.cap_bset = cap_full_set,
+		};
+		int child_status;
+		pid_t child;
+
+		if (drop_privileges() != 0)
+			_exit(1);
+
+		child = sys_clone3(&args, sizeof(args));
+		if (child < 0)
+			_exit(2);
+
+		if (child == 0) {
+			if (!cap_raised(CAP_SYS_ADMIN))
+				_exit(3);
+			if (!cap_dropped(CAP_NET_ADMIN))
+				_exit(4);
+			_exit(0);
+		}
+
+		if (waitpid(child, &child_status, 0) != child ||
+		    !WIFEXITED(child_status) || WEXITSTATUS(child_status) != 0)
+			_exit(5);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
+/*
+ * Verify clone3() argument validation for CLONE_NEWUSER_BSET.
+ */
+TEST_F(userns_bset, clone3_bset_invalid_args)
+{
+	struct __clone_args args;
+
+	/* CLONE_NEWUSER_BSET without CLONE_NEWUSER must fail */
+	memset(&args, 0, sizeof(args));
+	args.flags = CLONE_NEWUSER_BSET;
+	args.exit_signal = SIGCHLD;
+	args.cap_bset = cap_full_set;
+	EXPECT_EQ(-1, sys_clone3(&args, sizeof(args)));
+	EXPECT_EQ(EINVAL, errno);
+
+	/* Non-zero cap_bset without CLONE_NEWUSER_BSET must fail */
+	memset(&args, 0, sizeof(args));
+	args.flags = CLONE_NEWUSER;
+	args.exit_signal = SIGCHLD;
+	args.cap_bset = cap_full_set;
+	EXPECT_EQ(-1, sys_clone3(&args, sizeof(args)));
+	EXPECT_EQ(EINVAL, errno);
+
+	/* CLONE_NEWUSER_BSET with struct size < VER3 must fail */
+	memset(&args, 0, sizeof(args));
+	args.flags = CLONE_NEWUSER | CLONE_NEWUSER_BSET;
+	args.exit_signal = SIGCHLD;
+	EXPECT_EQ(-1, sys_clone3(&args, CLONE_ARGS_SIZE_VER2));
+	EXPECT_EQ(EINVAL, errno);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index a0593e8950f0..2145d14956e5 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -31,6 +31,7 @@ struct __clone_args {
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
 	__aligned_u64 cgroup;
+	__aligned_u64 cap_bset;
 };
 
 static pid_t sys_clone3(struct __clone_args *args, size_t size)
-- 
2.56.0.313.g2479322e68-goog

