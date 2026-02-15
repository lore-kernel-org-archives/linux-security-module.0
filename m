Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A522D9EC4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771152763; cv=none; b=i8GND0gwYcMKCC/PTlDwLr1LJyqWV5sXB+8blgxSTOrzQ2IXM845KesR2EbuW4mMxyUGXotC0l52zCFm6v9VZCg9+qfrzz3uYS/oEIqbzsiyd+J7UgfLk7EZwnCf9AsTJ8wDK3Vu+Ll+GiPbx0rpd36pRbe7b8H5RxAXROByuOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771152763; c=relaxed/simple;
	bh=h80sxEOdXFLFDt7DGaXKZbjnXQ99dicVj6xW8io208E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/iXqVQAcsEXKzpKLsmwpWWsJIAurY9F0d2yOu4uPnsWkmWTScq5YnC9JAAefVd3rYy7wpD6FOubtxGqCzNdvXhWCUTRepTP8tnLzffUmOTiOjK+9jFnbE6kM/w3ZlnSeFHyh0xZZeFApguGdOkysd9LS0LovHGQzyTyeDviImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYOBqlsO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYOBqlsO"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4359a302794so1515448f8f.1
        for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 02:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771152760; x=1771757560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stjLnHZnUiN1I6gpOl5iO/ChMXCB2ntgCCaeHGo+Y1A=;
        b=NYOBqlsOkmtwheV7C3rAcK7kwmE1WN/gS2uWdmpNWww53MyyVT0YtrTN5kdl5aBGHi
         D8tcbF+aTFHE4AdlEzkBZTxYBPNwe88fK68PpfzX22x4MHnRGWaMIOjnDKojVaz+/SGK
         788vVmL02cIA135IR0V5ctTb9ax5vekUn02YsRz2oKXfmR4egSMZ622ohBpRW0UOsDl6
         DjAKTpiFSRFNlr3BsHkbny7tF+AzRHZr+vLZic3hw0RJYa0DJydaRhlwiDH4Syur8Crl
         TKVD0m2/m40GlfvSFBlwBDp+4pTL9gHtkYwZ3clpoRikRLCDCRkIa9ZP6m4PbX+i6oLJ
         iuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771152760; x=1771757560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=stjLnHZnUiN1I6gpOl5iO/ChMXCB2ntgCCaeHGo+Y1A=;
        b=ewKKPre0jh48dCBs4BayccvvLO0tHCt1pLVXVF3q8p+PyLDH7syC1HNC116gXkHlhv
         krKWhIn3M7557G6cYEKvQocSD2dlky6GyZ+YULeceOIAlEXC7wQxbtGUmQhmuKjQIuhF
         RAsMFXbkJEVxy4fUk+Ng2g9nF36hfWZ3aEi+JRFtLhVvUG6+vrvXjv9xOlfISzimZeeU
         JU92MPPhAAJGGMTG/CqxfDD7gJ7k0M1PXwOIKDewQEP3hxnPQXzDStNZd74FWlOWsvak
         I1sdqsNdzqQWPhJl98JhYuvNtXeArIM65dr/JujZ8oy+Crh1y3ivheXa4tCZ1snL43eL
         2ItA==
X-Forwarded-Encrypted: i=1; AJvYcCXOwoNiPn+mbGXY8c4bd8SiczHORbO6U32tNIIQLdsMBArfu8jHdhXw2QQ3VPjjx66QpHUsNNsywM4qRVTMCU1H/AmkdFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGSHTkE9YW4RYt1bBDppuJaffH6KA2T5sIHXNg2zcJoOTp8EM3
	PtVPTHJat4DY4hxlbhCQuD3DCRGsG3W31+ZQrJk2b5zgfe2Fa6p5fhhh
X-Gm-Gg: AZuq6aLfMaTor/xDGmQgZWNpYdiY80Ulp6IquzjTIlXzp0UFxr/ibEN1EwVIfLOoDM+
	GJaW+9fD+lG/YWqdm8Fl9bc2PPVwQJylUAfEBmWioPnCJP01KTdPurlKh4hDLoHeapjz8IV6++4
	6QSO5+rUXsjtC7eE6zDUA3LnMFRimI4h2Dyek3vKs3u9efguxvNVTVlH6mPY9bbuswCJMHTK66n
	TkUHNRXmeMAbbPAEwsfbkgcLL89UkmMucx6aq3hyT+ziyx+Bk4S09WxXbnBZx2q0lcm9cvXubfN
	ELgQseF7bWjRlSPqqO0CMKRJsWVFNGcdv1LH+ISc4SdsmJO0uNy//L859MvmNfIuB3jNYu7Xun+
	KXpJG75kGpjmEzFRzde+WGZOvRj/9GHKsPNfYWneHIhrYYzVFO3TTKu4HKtkBdtuKXjI5i1M3HL
	jL7PklocE56CckWPqxssuP2M/a4Cnqfz7tnZx47ZPiLvHhH1aP
X-Received: by 2002:a05:6000:26cc:b0:435:d859:5cf with SMTP id ffacd0b85a97d-4379dbb0298mr9092172f8f.54.1771152760133;
        Sun, 15 Feb 2026 02:52:40 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abd793sm19130775f8f.25.2026.02.15.02.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 02:52:39 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>
Subject: [PATCH v5 5/9] landlock/selftests: Audit test for LANDLOCK_ACCESS_FS_RESOLVE_UNIX
Date: Sun, 15 Feb 2026 11:51:53 +0100
Message-ID: <20260215105158.28132-6-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260215105158.28132-1-gnoack3000@gmail.com>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add an audit test to check that Landlock denials from
LANDLOCK_ACCESS_FS_RESOLVE_UNIX result in audit logs in the expected
format.  (There is one audit test for each filesystem access right, so
we should add one for LANDLOCK_ACCESS_FS_RESOLVE_UNIX as well.)

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 42 +++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index bdeff2e0e029..8fa9d7c49ac3 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -7530,7 +7530,8 @@ static const __u64 access_fs_16 =
 	LANDLOCK_ACCESS_FS_MAKE_SYM |
 	LANDLOCK_ACCESS_FS_REFER |
 	LANDLOCK_ACCESS_FS_TRUNCATE |
-	LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	LANDLOCK_ACCESS_FS_IOCTL_DEV |
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
 /* clang-format on */
 
 TEST_F(audit_layout1, execute_read)
@@ -7975,6 +7976,45 @@ TEST_F(audit_layout1, ioctl_dev)
 	EXPECT_EQ(1, records.domain);
 }
 
+TEST_F(audit_layout1, resolve_unix)
+{
+	struct audit_records records;
+	const char *const path = "sock";
+	int srv_fd, cli_fd, status;
+	pid_t child_pid;
+
+	srv_fd = set_up_named_unix_server(_metadata, SOCK_STREAM, path);
+
+	child_pid = fork();
+	ASSERT_LE(0, child_pid);
+	if (!child_pid) {
+		drop_access_rights(_metadata,
+				   &(struct landlock_ruleset_attr){
+					   .handled_access_fs = access_fs_16,
+				   });
+
+		cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+		ASSERT_LE(0, cli_fd);
+		EXPECT_EQ(EACCES, test_connect_named_unix(cli_fd, path));
+
+		EXPECT_EQ(0, close(cli_fd));
+		_exit(_metadata->exit_code);
+	}
+
+	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
+	EXPECT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	EXPECT_EQ(0, matches_log_fs_extra(_metadata, self->audit_fd,
+					  "fs\\.resolve_unix", path, NULL));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+
+	EXPECT_EQ(0, close(srv_fd));
+}
+
 TEST_F(audit_layout1, mount)
 {
 	struct audit_records records;
-- 
2.52.0

