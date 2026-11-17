Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910666;
	b=Ux3/mQGwwHJgOX98s8WywS3zt6xPaHuQNR5HSEP7np0NeNAEi2CUvmhz0Y71BKVNTIOM
	 ozBU6MQXSbTB+JulhRD6FQKGAWELIg5OKTZlzVEFY8aT1z24HlaCu4IvVSgUfHiNmHh3P
	 XXHqTxXRmI1V8dCfspnWAEwRqfwj2qr8KCVm4CmZ0OeumACLMDFr63gnm/MwBr70HL0db
	 2Kpugo2zlbnWoVBRN624i9b2QV8N7Ol7xVwvUMlJXW7HWYSaoIZBxKoXE4RFxNK6Elmzy
	 wGZom/I3TPGZ7opslbC2FXbWrT8eUwVZd9ciZ8PEIGo3rcN0mt/41GwElnDA4NMEfdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910666;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=diZz0z/ARVlxmVWHhnTctsthFSMRnacZCsupfkvb0xg=;
	b=FVdd+/9Ioba17m2UATb9V3KJW7kB/1TLmy3FT1IuDoj6XF/p3ErMhjegyNForMGRf5xZ
	 JZKh8SPMJZFe9mUkePYK6z5zVndSKqIB/MjxQAGuXLzwFeU/Q1HRjYpI8dKmxsVIitCFI
	 xGXjKVAgL7t/8mSQ1yXl8UKrxd7i4ZBo9ZHdv4H4CHqOumemuinWAFIScoYDpDLX/WAhR
	 KYAFIrvcZozQyqSGuNdoHBoqHOys7nQrStfOwdQACbYyvJnjWHafkBABhkCcf/gkFII6P
	 LQ5E8rQunWFuEbKJqaRtgQ1uN3134wJ7J/ErHsAW4IXdAsgwjzLzMlKC9IEPL2IVbrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=KZGGvwMz;
	arc=none smtp.remote-ip=185.125.25.11
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2AE606A338
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D2AE606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=KZGGvwMz
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLJm2SMhzW1B;
	Tue, 17 Nov 2026 11:17:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910664;
	bh=diZz0z/ARVlxmVWHhnTctsthFSMRnacZCsupfkvb0xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZGGvwMzQfa9rBW6OKQ7AYbKPcHsWgmseosOfEDsJ1UGj6fhiTFMhgxVKHTLMfs6k
	 074N9DBRNBvAcSkZb6WCPlBZbVlXfH+207nJXtQwnu2NE8NWr8fjwFDWbJ1v1F14pm
	 3zdeaaw9uGhN99JIINkoXO27c/ZLRaf/ICFmwBUw=
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jTLJk6jtfzPTf;
	Tue, 17 Nov 2026 11:17:42 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <sergeh@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ada Smith <adasmithgt@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	John Johansen <john.johansen@canonical.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	Serge Hallyn <serge@hallyn.com>
Subject: [PATCH v2 2/2] selftests/landlock: Test PR_SET_SECUREBITS mediation
Date: Tue, 17 Nov 2026 11:17:37 +0100
Message-ID: <20261117101738.2523492-3-mic@digikod.net>
In-Reply-To: <20261117101738.2523492-1-mic@digikod.net>
References: <20261117101738.2523492-1-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The preceding commoncap fix routes the CAP_SETPCAP check for privileged
PR_SET_SECUREBITS requests through the ordinary capable hooks.  Add a
focused Landlock regression test for this path.

Keep CAP_SETPCAP effective to isolate Landlock mediation and run the
audit case in a child domain.  A privileged change returns EPERM and
emits an exact CAP_SETPCAP record, then an unprivileged-only change
succeeds.  After the child exits, require the domain deallocation record
to report exactly one denial; this proves that the second operation did
not create a hidden denial without relying on an asynchronous no-record
timeout.

The existing check-exec securebits fixture already covers commoncap's
privileged, unprivileged, locked, and user-namespace semantics.  Without
the preceding fix, this Landlock audit test fails.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/cap_test.c | 69 +++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/selftests/landlock/cap_test.c
index 39ef57a49dc9..144ae866c3bd 100644
--- a/tools/testing/selftests/landlock/cap_test.c
+++ b/tools/testing/selftests/landlock/cap_test.c
@@ -1075,6 +1075,75 @@ TEST_F(cap_audit, denied)
 	EXPECT_EQ(0, records.domain);
 }
 
+/*
+ * A privileged denial allocates the domain ID.  The following unprivileged-only
+ * change must not create a hidden Landlock denial, so the domain's deallocation
+ * record must report exactly one denial.
+ */
+TEST_F(cap_audit, securebits)
+{
+	const unsigned long unpriv = SECBIT_EXEC_RESTRICT_FILE |
+				     SECBIT_EXEC_RESTRICT_FILE_LOCKED;
+	__u64 *domain_id, deallocated_dom = 0;
+	unsigned long bits;
+	int err, ruleset_fd, status;
+	pid_t child;
+
+	domain_id = mmap(NULL, sizeof(*domain_id), PROT_READ | PROT_WRITE,
+			 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(MAP_FAILED, domain_id);
+	*domain_id = 0;
+
+	ruleset_fd = create_cap_ruleset();
+	ASSERT_LE(0, ruleset_fd);
+	/* Allow the child to replace the audit filter before exiting. */
+	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		enforce_ruleset(_metadata, ruleset_fd);
+		EXPECT_EQ(0, close(ruleset_fd));
+
+		set_cap(_metadata, CAP_SETPCAP);
+		bits = prctl(PR_GET_SECUREBITS);
+		EXPECT_EQ(-1, prctl(PR_SET_SECUREBITS,
+				    bits | SECBIT_NO_CAP_AMBIENT_RAISE));
+		EXPECT_EQ(EPERM, errno);
+
+		EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SETPCAP));
+		EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd,
+							  getpid(), domain_id));
+
+		EXPECT_EQ(0, prctl(PR_SET_SECUREBITS, bits | unpriv));
+		clear_cap(_metadata, CAP_SETPCAP);
+
+		/* Receive the asynchronous domain deallocation record. */
+		set_cap(_metadata, CAP_AUDIT_CONTROL);
+		EXPECT_EQ(0, audit_filter_drop(self->audit_fd, AUDIT_ADD_RULE));
+		EXPECT_EQ(0,
+			  audit_filter_exe(self->audit_fd, &self->audit_filter,
+					   AUDIT_DEL_RULE));
+		clear_cap(_metadata, CAP_AUDIT_CONTROL);
+
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+
+	EXPECT_NE(0, *domain_id);
+	err = matches_log_domain_deallocated(self->audit_fd, 1, *domain_id,
+					     &deallocated_dom);
+	EXPECT_EQ(0, err);
+	EXPECT_EQ(*domain_id, deallocated_dom);
+	EXPECT_EQ(0, munmap(domain_id, sizeof(*domain_id)));
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
 /*
  * Denials in the capset and mmap_addr paths are audited like capable hook
  * denials.  The vm_enough_memory hook only withholds the admin reserve, with
-- 
2.56.0

