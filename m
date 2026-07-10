Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3CE3EFD24
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2026 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671416; cv=none; b=XiiyAWuWm3+BwIwoqPkDMK9QZTtn67/7JvikyCV1gKvw/NDOscPc1xuVLB3fTG28aqococ24Nb5Jw0RG7lPx1Zx7U3mgxhMZdE1vyMXAqLrRWPbmWKg9Qg6T3RAUhQRf5IpUwa7+Uwu/W5UP25K2FNi4Equ6WZjpYwB+6jULCAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671416; c=relaxed/simple;
	bh=7KIc5ogxZwWrfJnko7PciiNQQWmWczwA7bDSRUvGObU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=eGnoUyLMK9gYMGsdIIhH4spkHrgC1WCcGRkigabgqbJu7d7gJ9zJsrgDU5yRzim3K0xqeVl+/oqo+6mC9MzJ73myfAZZZ8MSS+aS9pdfNEFab0h1lESCaYVxvQBo87vDYCHAale9Py18hEGqEJ38+tAJJp9+zzWMJagsFiM9zvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQnj7OhS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQnj7OhS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783671413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v4vUaGFk2l9Uqurf0ksjXpb4C/iQo+zejwWRDADYgb8=;
	b=jQnj7OhSBsxCMEu/87UtAg58Wve5abVR6Q+wgwTtv9H/TPTTSyi46gcUszqyB53drP9uie
	0Ei1IeVBqYDQpcTfh5D4mPhW12OaqTvGzn89saILJy0uipx0FTvDoufaXuPKWOnxnBhRKG
	2PJIvdkSWOdXHcdKj45kJMV/bCffXPo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-rJpTrNr0MlibO6VsPMNLIg-1; Fri,
 10 Jul 2026 04:16:49 -0400
X-MC-Unique: rJpTrNr0MlibO6VsPMNLIg-1
X-Mimecast-MFC-AGG-ID: rJpTrNr0MlibO6VsPMNLIg_1783671408
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13E6A1801BE5;
	Fri, 10 Jul 2026 08:16:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.49.56])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3ACA8180028B;
	Fri, 10 Jul 2026 08:16:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/landlock: Skip scoped_signal subtest with MSG_OOB if not available
Date: Fri, 10 Jul 2026 10:16:42 +0200
Message-ID: <20260710081642.405916-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 2rX6LvzT00P1cKBJY8-0cNeuSl8-IzCiFira8Pj_kfU_1783671408
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Thomas Huth <thuth@redhat.com>

MSG_OOB might be disabled in the kernel for unix sockets (by not
selecting CONFIG_AF_UNIX_OOB), and in this case the related tests
of the scoped_signal_test are currently failing.  Add a runtime
probe using socketpair() to detect MSG_OOB support and skip the
test gracefully if it is unavailable.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../selftests/landlock/scoped_signal_test.c   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index 58d25157fe781..3cf20d769f2bc 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -398,6 +398,24 @@ static int setup_signal_handler(int signal)
 	return sigaction(SIGURG, &sa, NULL);
 }
 
+/*
+ * MSG_OOB might be disabled in the kernel via the CONFIG_AF_UNIX_OOB
+ * switch, so this function can be used for probing for its availability.
+ */
+static bool has_af_unix_oob(void)
+{
+	bool available = false;
+	int sp[2];
+
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sp) == 0) {
+		available = (send(sp[0], ".", 1, MSG_OOB) == 1);
+		close(sp[0]);
+		close(sp[1]);
+	}
+
+	return available;
+}
+
 /* clang-format off */
 FIXTURE(fown) {};
 /* clang-format on */
@@ -460,6 +478,9 @@ TEST_F(fown, sigurg_socket)
 	int pipe_parent[2], pipe_child[2];
 	pid_t child;
 
+	if (!has_af_unix_oob())
+		SKIP(return, "CONFIG_AF_UNIX_OOB / MSG_OOB not available");
+
 	memset(&server_address, 0, sizeof(server_address));
 	set_unix_address(&server_address, 0);
 
-- 
2.55.0

