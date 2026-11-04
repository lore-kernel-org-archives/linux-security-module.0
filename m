Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826557;
	b=TFud+oFq0b2p6X8KWLKK6HVYqc99qQcw5OU2ni15GGY5hpkgUMxSV8W7VkCxZK48EuzQ
	 LPZKV1VIj28d0rPI75joCWdNs/VOW7vtoxcHenHTjvjyqVcDLaOJkJ9DUsuOkeQcHLo0b
	 PfopoyVLJk0kaYEGilRgsZsvrAyupMb+rriEn+6s8i+FaSwj4fdgBbaTYiwGTQVlQS8Us
	 TEEpWm4WPBe/SCJ2MWVy4oes45ikGGfmWpk9kbuU+cMrxlBBSI15vmItN5GmA9qjd6oN3
	 KyJa1SHQYbOffwAwEo3j4YJ/A+sV48XF6ZTt4D+RcJlPXIhMmxw9GlMoUd5rQwwK7rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=3n62GMqbOAMsMIZCGoM3LvCpYu2DKdAMPg4G3hiu3CA=;
	b=A3+stmyCad9Qem2gAOpN2efNPSn+ukjTV+X6vsHZBmRQ53hKt78yX+yeaMxDAfdLBCJI
	 95hflozT8kv8KeOx6Vd7Aw8B9eplgDNf0N08eMGntCehcIUYoEq0OxjrtcuiAqGL3nAGN
	 nP7J7wh7gnCkNlzOeHvxHCn3SuMDWFLP1x8i4J32ffFY8Ya1xM9Hae9xan+U8KaQ33DAB
	 YHsfVZNzOKMeTToEReWqAYVuJw+0lO9Ccx55ccl/5Rz8HEfRQItR682RH+/F+fsyHOHGl
	 /r9JjwAkI7X33VWcKkdiykcmkSScRT5SkTt3crPrjkRJbsnW5E+jPLKltDYg6a4MnBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tA6T845Z;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C7B60A678D
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38C7B60A678D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tA6T845Z
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso5656355e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826555; x=1794431355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3n62GMqbOAMsMIZCGoM3LvCpYu2DKdAMPg4G3hiu3CA=;
        b=tA6T845Zst8zvZj0crLmvmoReAYgyg53vGvAmCFoy//XDngreZDSwBi3wTCNgRw+TN
         wsSpBLGxuNXt95/BAWP/4ctH4keF9mZWwPjYuj+8poKFkj/uB+fmgrA0DluRQby9eXOy
         KyHxc4Iw/K8u/LxUVfpDwFqDotGnKP4jHTWp75jPZS65jp/lAJDlBVnKsTim+yn/C5yq
         TgCbEe6c8PLnKubSrbRXmbRaSfbGlaoktiXcOdg+j22dMlYyGk0k8bW8IrKdL/UF/Mk0
         /gbvWh2OuR3FkCetwF/Xo1dqp5zqyg7lbgsykNTOSokXmUW2e+DSkmwdUaZWN6AMoive
         zLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826555; x=1794431355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3n62GMqbOAMsMIZCGoM3LvCpYu2DKdAMPg4G3hiu3CA=;
        b=1v4NQs2LzLGT2/LsWkmDI3lOEhtnKpnaJtU2YQWo5LjqkISRJU+uQ3K3VShdukFYH2
         yvTX+UgBGp83FGB2o3+NDVPlvn89F9l1ReoWziOp3EyLvzgfk4FbkkItEuXwQDiJQ01Y
         /xl+ZMxH6WZlEss6K2YnX7zbPZasAmgApNbu0DiFwuoI0MRYUcURZkOOc+TTY+EcpXpL
         4Gn1yRWROLc1E+4sk5RbcI2sPoaI+2hyLci67IzcYchgU8LIVIQ5KUB1E3426DayIdwv
         T/yUatIstZqfqA49VZj4VGWrK4OLVLonOfhggaiDUj88JJ0mdwzmxG/lukes77vozrvR
         l4nA==
X-Gm-Message-State: APuU4Z9Pzixvt0doR3h4UJiOYFib85tMOAAFJEXF9ULQv/fv3RqZF2Z0
	IEyCHPxgaErlgNX97zW81p7sHkztrXoU666cWI3zoTxFQW19dsNO+Jwd
X-Gm-Gg: AYBFou1MfRDkV6S31U7bJwyLgr2xEKWb4TwdCFWW0WRauhhvK5yQjLyXW+sbrxmU0TQ
	t8rWNSgU0YC0PCmhgXgOVWmMAyoyXAgpD1JCY0uUl8c3xMzKhaTRzB77/t4XksQF0AT8x5NEiSH
	K06QtXTRMMtibi4MDAYqFntoz0rf7q16bG8OXCZAek/cACHs2jwUwEvOPn2NsjdihYjX5ewDoY5
	JYXOXhrDGKufjFAXcEzSvlIHzCngSD2sYy5yH1d7MyMWOUEHcI7g/8QTYTKfAwOxsmV33vfuoiO
	MWe1monzVPkvdtT1ge0vKsePU6uRVU294RcUMe69vRW8+5QGbe9i9IlN2gSXE0cXcQU8cauDa3p
	ZHS5U85Hq9vaK7dR18SxI+Fj2Vpu2SZtFbbPrIDPXZU6SsUFz1lzW1HPbwO86O9Xmh1hX/Dqolg
	1Yv4PeVONrVW5xprUfZ5/kJJisXr7RzYPv3hAbQTVuNgSrjb7kVzsUA3XC1hZaOqex76offUkhb
	0genOOkaejL5zt3GRY5zKxq60AFh2V6blPe8QryS/6c5wvH1yarlK+WxxOeYJrvLZNUgyRbDtsj
	XGTiaJjezbKgUSrQ8l5fLBx48UuZnb4NwY77/mQnwSbn17Ou6TLfnQ==
X-Received: by 2002:a05:600c:800c:b0:4a2:d99:3171 with SMTP id 5b1f17b1804b1-4ac17753c13mr410685195e9.23.1793826554340;
        Wed, 04 Nov 2026 13:09:14 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4532916f2sm84694645e9.5.2026.11.04.13.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:13 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:08:58 +0100
Subject: [PATCH v2 12/27] selftests/landlock: Assert audit_count_records()
 before using its result
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261104-selftests-refactor-v2-12-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

audit_count_records() fills in the record counts that are checked right
after it, but its return value is checked with EXPECT.  On failure, the
counts may be left uninitialized and the following checks are
meaningless.  Use ASSERT instead.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/audit_test.c      | 20 ++---
 tools/testing/selftests/landlock/cap_test.c        | 16 ++--
 tools/testing/selftests/landlock/fs_test.c         | 86 +++++++++++-----------
 tools/testing/selftests/landlock/net_test.c        | 22 +++---
 tools/testing/selftests/landlock/ns_test.c         | 26 +++----
 tools/testing/selftests/landlock/ptrace_test.c     |  6 +-
 .../selftests/landlock/scoped_abstract_unix_test.c |  4 +-
 7 files changed, 90 insertions(+), 90 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 63b1b2a04eee..325fbb9ca297 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -329,7 +329,7 @@ TEST_F(audit, log_subdomains_off_fork)
 					NULL));
 
 	/* Drains any remaining records (e.g. domain allocation). */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 
 	/*
 	 * Mutes subdomain logs without creating a domain.  The parent's
@@ -361,7 +361,7 @@ TEST_F(audit, log_subdomains_off_fork)
 	EXPECT_EQ(-EAGAIN, matches_log_signal(_metadata, self->audit_fd,
 					      getpid(), NULL));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	EXPECT_EQ(0, close(ruleset_fd));
@@ -487,7 +487,7 @@ TEST_F(audit, log_subdomains_off_tsync)
 					child_data.parent_pid, NULL));
 
 	/* Drains any remaining records (e.g. domain allocation). */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 
 	/*
 	 * Mutes subdomain logs and propagates to the sibling thread via TSYNC,
@@ -509,7 +509,7 @@ TEST_F(audit, log_subdomains_off_tsync)
 	EXPECT_EQ(-EAGAIN, matches_log_signal(_metadata, self->audit_fd,
 					      child_data.parent_pid, NULL));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	EXPECT_EQ(0, close(pipe_child[0]));
@@ -571,7 +571,7 @@ TEST_F(audit, tsync_override_log_subdomains_off)
 					      child_data.parent_pid, NULL));
 
 	/* Drains any remaining records. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	/*
@@ -740,7 +740,7 @@ TEST_F(audit_flags, signal)
 		EXPECT_EQ(EPERM, errno);
 
 		/* Makes sure there is no superfluous logged records. */
-		EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+		ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 		if (!expect_audit) {
 			EXPECT_EQ(0, records.access);
 		} else {
@@ -929,7 +929,7 @@ TEST_F(audit_exec, signal_and_open)
 	EXPECT_EQ(1, read(pipe_child[0], &buf_parent, 1));
 
 	/* Tests that there was no denial until now. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 
@@ -948,7 +948,7 @@ TEST_F(audit_exec, signal_and_open)
 	}
 
 	/* Checks that we didn't miss anything. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	/*
@@ -972,7 +972,7 @@ TEST_F(audit_exec, signal_and_open)
 	}
 
 	/* Checks that we didn't miss anything. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	/* Waits for the child to terminate. */
@@ -995,7 +995,7 @@ TEST_F(audit_exec, signal_and_open)
 	}
 
 	/* Checks that we didn't miss anything. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 }
 
diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/selftests/landlock/cap_test.c
index 7b3b724e4406..5a7dbd26f92f 100644
--- a/tools/testing/selftests/landlock/cap_test.c
+++ b/tools/testing/selftests/landlock/cap_test.c
@@ -823,7 +823,7 @@ TEST_F(cap_audit, denied)
 	 */
 	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
 						  &domain_id));
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -846,7 +846,7 @@ TEST_F(cap_audit, allowed)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
 	/* No records: allowed operations never trigger audit logging. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 }
 
@@ -872,7 +872,7 @@ TEST_F(cap_audit, allow_and_quiet_same_member)
 	/*
 	 * Quiet is inert for the allowed member: nothing is denied or logged.
 	 */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 }
 
@@ -916,7 +916,7 @@ TEST_F(cap_audit, quieted)
 	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SYS_ADMIN));
 	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
 						  &domain_id));
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -962,7 +962,7 @@ TEST_F(cap_audit, quiet_youngest_layer_wins)
 	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SYS_CHROOT));
 	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
 						  &domain_id));
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -994,7 +994,7 @@ TEST_F(cap_audit, quiet_unknown_bit_no_effect)
 	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SYS_CHROOT));
 	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
 						  &domain_id));
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -1051,7 +1051,7 @@ TEST_F(cap_audit, noaudit_probe_not_logged)
 	EXPECT_EQ(0, close(fd));
 
 	/* The denied noaudit probe leaves no audit record nor denial. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	/*
@@ -1066,7 +1066,7 @@ TEST_F(cap_audit, noaudit_probe_not_logged)
 	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SYS_ADMIN));
 	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
 						  &domain_id));
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 7ff94755b029..100ef02b5d1a 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -7534,7 +7534,7 @@ TEST_F(audit_layout1, execute_make)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.execute",
 				    file1_s1d1));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -7565,7 +7565,7 @@ TEST_F(audit_layout1, execute_read)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.execute,fs\\.read_file", file1_s1d1));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -7580,7 +7580,7 @@ TEST_F(audit_layout1, write_file)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.write_file", file1_s1d1));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7595,7 +7595,7 @@ TEST_F(audit_layout1, read_file)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.read_file",
 				    file1_s1d1));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7610,7 +7610,7 @@ TEST_F(audit_layout1, read_dir)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.read_dir",
 				    dir_s1d1));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7634,7 +7634,7 @@ TEST_F(audit_layout1, remove_dir)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_dir", dir_s1d2));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -7650,7 +7650,7 @@ TEST_F(audit_layout1, remove_file)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_file", dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7668,7 +7668,7 @@ TEST_F(audit_layout1, make_char)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_char",
 				    dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7687,7 +7687,7 @@ TEST_F(audit_layout1, make_whiteout)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_reg",
 				    dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7705,7 +7705,7 @@ TEST_F(audit_layout1, make_dir)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_dir",
 				    dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7723,7 +7723,7 @@ TEST_F(audit_layout1, make_reg)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_reg",
 				    dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7741,7 +7741,7 @@ TEST_F(audit_layout1, make_sock)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_sock",
 				    dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7759,7 +7759,7 @@ TEST_F(audit_layout1, make_fifo)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_fifo",
 				    dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7777,7 +7777,7 @@ TEST_F(audit_layout1, make_block)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.make_block", dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7795,7 +7795,7 @@ TEST_F(audit_layout1, make_sym)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_sym",
 				    dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7817,7 +7817,7 @@ TEST_F(audit_layout1, refer_handled)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
 				    dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -7839,7 +7839,7 @@ TEST_F(audit_layout1, refer_make)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.make_reg,fs\\.refer", dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -7859,7 +7859,7 @@ TEST_F(audit_layout1, refer_rename)
 				    "fs\\.remove_file,fs\\.make_reg,fs\\.refer",
 				    dir_s2d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -7884,7 +7884,7 @@ TEST_F(audit_layout1, refer_exchange)
 				    "fs\\.remove_file,fs\\.make_reg,fs\\.refer",
 				    dir_s2d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -7918,7 +7918,7 @@ TEST_F(audit_layout1, refer_rename_half)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
 				    dir_s1d1));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7934,7 +7934,7 @@ TEST_F(audit_layout1, truncate)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.truncate",
 				    file1_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7954,7 +7954,7 @@ TEST_F(audit_layout1, ioctl_dev)
 					  "fs\\.ioctl_dev", "/dev/null",
 					  " ioctlcmd=0xc00ffeee"));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7989,7 +7989,7 @@ TEST_F(audit_layout1, resolve_unix)
 	EXPECT_EQ(0, matches_log_fs_extra(_metadata, self->audit_fd,
 					  "fs\\.resolve_unix", path, NULL));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 
@@ -8008,7 +8008,7 @@ TEST_F(audit_layout1, mount)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.change_topology", dir_s3d2));
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -8250,7 +8250,7 @@ void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
 						    blocker, target->target));
 
 		/* Check that we see no (other) logs. */
-		EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+		ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 		ASSERT_EQ(0, records.access);
 
 		if (target->expect_open_success && fd >= 0) {
@@ -8294,7 +8294,7 @@ void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
 						     " ioctlcmd=0x541b\\+"));
 
 			/* Check that we see no other logs. */
-			EXPECT_EQ(0, audit_count_records(self->audit_fd,
+			ASSERT_EQ(0, audit_count_records(self->audit_fd,
 							 &records));
 			ASSERT_EQ(0, records.access);
 			ASSERT_EQ(0, close(fd));
@@ -9695,7 +9695,7 @@ static void simple_quiet_rename(struct __test_metadata *const _metadata,
 	 * No other logs. records.domain not checked per reasoning in
 	 * audit_quiet_layout1_test_body.
 	 */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -9814,7 +9814,7 @@ TEST_F(audit_quiet_rename, handle_all_deny_quiet_refer)
 	ASSERT_EQ(EXDEV, errno);
 
 	/* No logs */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -9855,7 +9855,7 @@ TEST_F(audit_quiet_rename, handle_all_deny_not_quiet_refer)
 				    dir_s2d1));
 
 	/* No other logs */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -9894,7 +9894,7 @@ TEST_F(audit_quiet_rename, handle_all_deny_refer_quiet_source_not_quiet_dest)
 				    dir_s2d1));
 
 	/* No other logs */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -9921,7 +9921,7 @@ TEST_F(audit_quiet_rename, quiet_same_dir)
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file2_s1d1));
 	ASSERT_EQ(EACCES, errno);
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -9961,7 +9961,7 @@ TEST_F(audit_quiet_rename, quiet_flag_on_file_ignored)
 				    dir_s2d1));
 
 	/* No other logs */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -9998,7 +9998,7 @@ TEST_F(audit_quiet_rename, quiet_flag_on_file_ignored_same_dir)
 				 "fs\\.remove_file,fs\\.make_reg", dir_s1d1));
 
 	/* No other logs */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10056,7 +10056,7 @@ TEST_F(audit_quiet_rename, two_layers_different_quiet1)
 	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_file,fs\\.refer", dir_s1d1));
 	/* No other logs */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10111,7 +10111,7 @@ TEST_F(audit_quiet_rename, two_layers_different_quiet2)
 	 * The youngest denial will be layer 2, but refer is quieted (and that
 	 * layer does not handle any other accesses).
 	 */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10165,7 +10165,7 @@ TEST_F(audit_quiet_rename, two_layers_different_quiet3)
 	/*
 	 * The youngest denial will be layer 2, in which everything is quieted.
 	 */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10211,7 +10211,7 @@ TEST_F(audit_quiet_rename,
 	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.make_reg,fs\\.refer", dir_s2d1));
 	/* No other logs. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10262,7 +10262,7 @@ TEST_F(audit_quiet_rename,
 	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.make_reg,fs\\.refer", dir_s2d1));
 	/* No other logs. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10295,7 +10295,7 @@ TEST_F(audit_quiet_rename, rename_xchg)
 				RENAME_EXCHANGE));
 	ASSERT_EQ(EACCES, errno);
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10324,7 +10324,7 @@ TEST_F(audit_quiet_rename, quiet_on_parent_mount)
 			       bind_file2_s1d3));
 	ASSERT_EQ(EACCES, errno);
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10356,7 +10356,7 @@ TEST_F(audit_quiet_rename, quiet_behind_mountpoint_ignored)
 				    "fs\\.remove_file,fs\\.make_reg",
 				    bind_dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10394,7 +10394,7 @@ TEST_F(audit_quiet_rename, quiet_on_parent_mount_disconnected)
 		  renameat(bind_s1d3_fd, file1_name, bind_s1d3_fd, file2_name));
 	ASSERT_EQ(EACCES, errno);
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10432,7 +10432,7 @@ TEST_F(audit_quiet_rename, quiet_behind_mountpoint_disconnected)
 		  renameat(bind_s1d3_fd, file1_name, bind_s1d3_fd, file2_name));
 	ASSERT_EQ(EACCES, errno);
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index c1b6e288c965..563e2214390b 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -3004,7 +3004,7 @@ TEST_F(audit, bind)
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, audit_evt, "saddr",
 				      variant->addr, "src", self->srv0.port));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 
@@ -3015,7 +3015,7 @@ TEST_F(audit, bind)
 	ASSERT_LE(0, sock_fd);
 	EXPECT_EQ(-EACCES, bind_variant(sock_fd, &self->srv2));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 
@@ -3065,7 +3065,7 @@ TEST_F(audit, connect)
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, audit_evt, "daddr",
 				      variant->addr, "dest", self->srv0.port));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 
@@ -3075,7 +3075,7 @@ TEST_F(audit, connect)
 
 		EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.bind_udp",
 					      NULL, NULL, NULL, 0));
-		EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+		ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 		EXPECT_EQ(0, records.access);
 		EXPECT_EQ(0, records.domain);
 	}
@@ -3087,7 +3087,7 @@ TEST_F(audit, connect)
 	ASSERT_LE(0, sock_fd);
 	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv2));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 
@@ -3136,7 +3136,7 @@ TEST_F(audit, connect_quiet_bind)
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, audit_evt, "daddr",
 				      variant->addr, "dest", self->srv2.port));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	EXPECT_EQ(0, close(sock_fd));
@@ -3155,7 +3155,7 @@ TEST_F(audit, connect_quiet_bind)
 	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv2));
 
 	/* Quieted - no logs expected. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	EXPECT_EQ(0, close(sock_fd));
@@ -3226,7 +3226,7 @@ TEST_F(audit, connect_bound)
 					       variant->addr, self->srv0.port,
 					       srv_remote.port));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 
@@ -3266,7 +3266,7 @@ TEST_F(audit, sendmsg)
 				      "daddr", variant->addr, "dest",
 				      self->srv0.port));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 
@@ -3274,7 +3274,7 @@ TEST_F(audit, sendmsg)
 	EXPECT_EQ(-EACCES, sendto_variant(sock_fd, &self->srv1, "A", 1, 0));
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.bind_udp", NULL,
 				      NULL, NULL, 0));
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 
@@ -3282,7 +3282,7 @@ TEST_F(audit, sendmsg)
 		  sendto_variant(sock_fd, &self->unspec_srv0, "B", 1, 0));
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.connect_send_udp",
 				      "daddr", NULL, "dest", 0));
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 
diff --git a/tools/testing/selftests/landlock/ns_test.c b/tools/testing/selftests/landlock/ns_test.c
index 6491b53742f1..57d03233bf6d 100644
--- a/tools/testing/selftests/landlock/ns_test.c
+++ b/tools/testing/selftests/landlock/ns_test.c
@@ -1984,7 +1984,7 @@ TEST_F(ns_audit, create_denied)
 	 */
 	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
 						  &domain_id));
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -2005,7 +2005,7 @@ TEST_F(ns_audit, create_allowed)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
 	/* No records: allowed operations never trigger audit logging. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 }
 
@@ -2030,7 +2030,7 @@ TEST_F(ns_audit, setns_allowed)
 	EXPECT_EQ(0, close(ns_fd));
 
 	/* No records: allowed setns never triggers audit logging. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 }
 
@@ -2068,7 +2068,7 @@ TEST_F(ns_audit, setns_denied)
 	 */
 	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
 						  &domain_id));
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -2094,7 +2094,7 @@ TEST_F(ns_audit, create_quieted)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
 	/* The denial is suppressed: no access record. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 }
 
@@ -2123,7 +2123,7 @@ TEST_F(ns_audit, setns_quieted)
 	EXPECT_EQ(0, close(ns_fd));
 
 	/* The denial is suppressed: no access record. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 }
 
@@ -2155,7 +2155,7 @@ TEST_F(ns_audit, quiet_is_per_member)
 	EXPECT_EQ(0, matches_log_ns_create(self->audit_fd, CLONE_NEWUTS));
 	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
 						  &domain_id));
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -2187,7 +2187,7 @@ TEST_F(ns_audit, quiet_unknown_bit_no_effect)
 	EXPECT_EQ(0, matches_log_ns_create(self->audit_fd, CLONE_NEWUTS));
 	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
 						  &domain_id));
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -2212,7 +2212,7 @@ TEST_F(ns_audit, allow_and_quiet)
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 }
 
@@ -2238,7 +2238,7 @@ TEST_F(ns_audit, allow_and_quiet_same_member)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
 	/* Nothing denied, nothing logged. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 }
 
@@ -2272,7 +2272,7 @@ TEST_F(ns_audit, quiet_youngest_layer_wins)
 
 	/* The child layer denies and does not quiet: logged. */
 	EXPECT_EQ(0, matches_log_ns_create(self->audit_fd, CLONE_NEWUTS));
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 }
 
@@ -2307,7 +2307,7 @@ TEST_F(ns_audit, quiet_parent_only_denying_layer)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
 	/* The parent quiets and is the youngest denying layer: suppressed. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 }
 
@@ -2638,7 +2638,7 @@ TEST_F(ns_proc_open, open_unrestricted)
 	}
 
 	/* No Landlock denial. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	EXPECT_EQ(0, close(fd));
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index b951889cd6ca..eb36d4d1ceaf 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -343,7 +343,7 @@ TEST_F(audit, trace)
 	struct audit_records records;
 
 	/* Makes sure there is no superfluous logged records. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 
@@ -381,7 +381,7 @@ TEST_F(audit, trace)
 		EXPECT_EQ(0, matches_log_ptrace(_metadata, self->audit_fd,
 						getpid()));
 
-		EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+		ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 		EXPECT_EQ(0, records.access);
 		/* Checks for a domain creation. */
 		EXPECT_EQ(1, records.domain);
@@ -428,7 +428,7 @@ TEST_F(audit, trace)
 		_metadata->exit_code = KSFT_FAIL;
 
 	/* Makes sure there is no superfluous logged records. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 55a1599819c8..67fcc3380238 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -360,7 +360,7 @@ TEST_F(scoped_audit, connect_to_child)
 		!(variant->quiet_scoped & LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
 
 	/* Makes sure there is no superfluous logged records. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 
@@ -429,7 +429,7 @@ TEST_F(scoped_audit, connect_to_child)
 	}
 
 	/* No other logs */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));

-- 
2.56.0

