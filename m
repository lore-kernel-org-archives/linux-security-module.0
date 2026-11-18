Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.157.188.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019599;
	b=s/1KeNniSSxmBWe2e+s/8zgUcjd17wHbEbdDWhQVoDR4HCVczPd1bSPUqjoFGs+p0gZ6
	 uxR9pVns1G0+RBtnni84hwPETS/wDHOuPfOa/ysm5hp4cngIUA4ICGFEYrKeegywpVvKN
	 WzVLZQ1Seb5yP17TLPB0xoZ3WmT0ScW0VV2KLFzQiO2mm4p99NIyfBy49RLonSe/nvGiU
	 zeAlgem1OU/9EGDkCTC+LH6wj4e1W34vgtrSt0A41IWGIL3dPZhDh5u3MjgRBsm7hGs6o
	 CiWMsPa60I+NMOC5oRZP/cf8ftZGemdnYaJt4ldas4ywEd2S+zq0aXed0cQzq2JpjCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019599;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=I+Dbrs3QptBZJl4e2yqTfL5XvkVcnY9GdfhfJ4l0xYg=;
	b=WLBAkVysToLCQ/iHYLDGnijpP/5TCQ2UXv7Fu1cOa3aMTbGj9Gg8VOB+i0zUBipaK1xs
	 q+4Yi78QAQ7SElhmc+RcWQ0q7KW4CXbo51WxcmFAgL6hlmg+8bxIcO5t/NG6jSgiU7ajW
	 kT+JZkGD5PJ38Xjmo15bWR1Rv0p8C4xKckX8nhCT3z9CBdE0xBf1L2qkUHBKoSiX/qgNZ
	 eLrQp9h+4K9q7TCQeEyNlrp+43avtvBIrOmAnoC/BYQeQzumr2teBalvT253ekWs9+Ws4
	 PRtXJsDQw3zH90cwQiU12+UwxyqD9B+wa3nSp5XfbOopKuENo9rz/lu9lIbcPdu7r/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=kICNzX1k;
	arc=none smtp.remote-ip=45.157.188.10
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9A6606A7DC
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 16:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B9A6606A7DC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=kICNzX1k
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jV6bT4vwjzZhJ;
	Wed, 18 Nov 2026 17:33:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795019589;
	bh=I+Dbrs3QptBZJl4e2yqTfL5XvkVcnY9GdfhfJ4l0xYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kICNzX1kK7IiAgHTL36Xgr6DvPKszhtRb03xo0J+LaYNC42ZNEHnT6M2/LRRHFGqf
	 5EkEW5PQJAFAxCaoDNV7SSQb0TBkVoA84IMm07D0dbMD6zkcV7oeiGZmig8VGDAESN
	 SUec52Rfq0w/Hugffd7WyJpUmMGIiUTCJU0VSj6o=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jV6bS1WfXzmJH;
	Wed, 18 Nov 2026 17:33:08 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Eric Paris <eparis@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paul Moore <paul@paul-moore.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	audit@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] selftests/landlock: Test namespace denial operations
Date: Wed, 18 Nov 2026 17:32:51 +0100
Message-ID: <20261118163254.2554413-4-mic@digikod.net>
In-Reply-To: <20261118163254.2554413-1-mic@digikod.net>
References: <20261118163254.2554413-1-mic@digikod.net>
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

The namespace trace tests cover creation and entry denials, but only
creation exercises the quiet path.  This leaves the new ENTER request
tag untested through quiet selection and trace dispatch when audit
logging is suppressed.

Add the missing quiet setns(2) case.  Together with the existing cases,
this exercises all four combinations of CREATE and ENTER with logged and
quieted denials, including each exact namespace_op value.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/ns_test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/landlock/ns_test.c b/tools/testing/selftests/landlock/ns_test.c
index d4a85cbebeae..52206ad94eca 100644
--- a/tools/testing/selftests/landlock/ns_test.c
+++ b/tools/testing/selftests/landlock/ns_test.c
@@ -2575,6 +2575,13 @@ TEST_F(ns_trace, deny_setns)
 	test_ns_trace_denial(_metadata, true, false);
 }
 
+TEST_F(ns_trace, deny_setns_quiet)
+{
+	if (!self->tracefs_ok)
+		SKIP(return, "tracefs not available");
+	test_ns_trace_denial(_metadata, true, true);
+}
+
 /* clang-format off */
 FIXTURE(ns_proc_open) {
 	/* clang-format on */
-- 
2.56.0

