Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194435;
	b=XkvkWP90V4RyFt16H5pIw0WKFsY5zZroEWn9Vih78OnrKuCKAvbmKEe0B+gPqAPv5STs
	 9d4OechPFFTD57Bgr1jX7t+LGALGllbM963UHCa+ntbF+oNPvFrZ3aHBUXnpiREkd9tcP
	 tXA9t3+/ZBMnoU1TeAEIrh8rO2Na5y2pdKb59LeNwnFNIlcUnf+mTr8pqDcC2TQj96zVK
	 g09oB2mHdnm5/iI0MLSYmL0mSDqBjReVa734/x3t8STZEOO/Uqw3hcZgMwha/qEUXp0OJ
	 WiygDCDr8hsAZA+DtaaeElxZvgtsefNWgKVjUfU0QtW/9Kc8Bpf3fcrP/9XNDFDF73w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0jiG2rD9So/arZvMAXmt3lPJiORsbNPvj+sHUkRM/lY=;
	b=0bDzW/6k2/jbNfZC1NbbpEH5haAnaCt9htzz9LxN2fqRQN+xAg9hUd9nYpev6QfZZKDV
	 4lTs48Pdf43AcLcr9AZuzkdEvIN9wMVSbjAXMKXE3WkrGhJ+AxAVkKCRcOO7TQqi43T1p
	 sJcX3M6vMl3YsOP5Lts589C5vP5c3Ov6mHY89fldhJtX3dO2qYEzt/LaYZYTMfwoNWi5G
	 Ei40K6rPjod46IUNYobqdlyZHd3+IbhwHNw9xYW1GyTMwMXLqhmaVzpW73PlGl+RypDrO
	 053Q2IRUD2HBNosObA+c/lmHF5FkcJRHyyK0oY1xEYgD6pLukubrq1qygJlZpNnYzFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=armoriq.io;
	spf=pass smtp.mailfrom=armoriq.io;
	dkim=pass header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="dLn/UHz5";
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE72606A32D
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 13:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EE72606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armoriq.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armoriq.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dLn/UHz5
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67a2efec15cso1007141d50.0
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 06:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=armoriq-io.20260707.gappssmtp.com; s=20260707; t=1793194434; x=1793799234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0jiG2rD9So/arZvMAXmt3lPJiORsbNPvj+sHUkRM/lY=;
        b=dLn/UHz5laULvOPw2Z4Il7Aes12V3tgaa7l8ko/Z6TiMfArXMOE0vl5uTrR+SM5+UC
         UXFW9wsVIwY7y6LQZ8Kp7zfKyM2kDUosLPf1Ulylv65drrBZkQnx9UltIGDC7E6Y8v5X
         vwnC3zFVtn+PPhm6Xqmb90g5fxvW3ExPK0sCXwdU1j6tyT5zdgBDt3uLraIrJulfCxZu
         FACMECN/6hf9PgeufeuE3m5Z/5aJMCrCGQdje9ZZQeU4OZytdlGUyRiMn2lENLTUQC0I
         cX4W5vCVgrdNNQaW6ET7ZfWTwM7jkpctDlFBps+8rRNUpTevoiHxA0NpeASFFj4Jj+Tt
         BQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793194434; x=1793799234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0jiG2rD9So/arZvMAXmt3lPJiORsbNPvj+sHUkRM/lY=;
        b=Dj3tWleThggnDRO2XIOdwGZvmIV2T0C/BrVVEGCaKOUeGy1ozZ/6l+M0nfGc7K2Ljz
         tjOad6yjEPbqXTJWERw2Rt0ClS4L0VwcYUUKoYbeAsTd4t/WEMDa2ZrXPsWF1IwKHt/H
         R88PHLSsS02y4FLHthTjh0MJJqa2VjjnDdzJCCM/m6xHi/0+KQEbdqwp0xiXqeMwiVWn
         XUlzJt9EkrlrYXpuYd5y1QmWEOqCOXeEuLHRlg27oG061EGyQAYaPJmy+9NgfJG4ETUa
         rCIpkUzX3l9LJ1ucWKU4YkCNDkTvvxMUum/hb+0sy0Qb9c9NwKeYJCUI5YOkF7CcpjPD
         2fOQ==
X-Gm-Message-State: AFq9FYKdyven1DY9EVwrk+PrzsGc4m5A7lP8GZkoOMberQQp/46JwVqM
	LeARaIG7tSx+MFbVOiLdvtD/Z1gtKqQW4nMu5pCetwCfeSgBNA0AHZ+CvNSLbJWd7oWE
X-Gm-Gg: AYBFou1ejabXG9TZ1EwDECZqWmKMawS3BXSogLFyb7WeOrNXkoDYDtlziuiSoInmxdl
	rKWfy3jttc732x6dIk7M/Xgdz2Ng3d6biGLNn4pIXu25caJFFuEhRUDp2a3JjxJH2CJcA0hBWZD
	JTk1dE7UiOGLaUWJsk5wEOH2jEjbfr5Sg1tg1NGpwdXd1IM2qpYTs3ZiHFGWNpGfPogv2uw7INq
	gcvpTHVZfUU0mWSCss5YdC5DXUuBzSn7xPmUiWoyi5biUZqgMpTsKsMqTZxieSPOzco27qmmKku
	96GojqZHuZ47mVx7FAu5j/b8ET/CTNstVnpTNMALt27x6vSW/AdTXvsi1c+k9haXf6gFV+tC56j
	xAGcWnaseST+4ZWT3dd+tbk0jEpaAneDt8rzOa+YozcQKuiI+YaHwwcTqu24I0OkLSEGVM0WapY
	rNTLtaIcAfBugE4sfdeDxqymUXsKnTtyVi6LD1xXHcoDyInoYoHK5+bnJf91I6GOHSudMqHrpNh
	2hP+/CLdMNKGucy+nkQLN8x4woHWgVyrgy05wPls2BVSKq3B1vbEwQ1ua3G3qzShs1UDAFrtDDh
	yFdKQV2/85DfLg7GA4y16CtAB/Qhvw98xzzuNsHYIsBYWZGw23bFmvvR40rFLBNtb6px5QQIYqM
	Ha0f23Ivh1wFLj/fL4vCDcz613ZfWR5s4ozfHtDUF/IuSTL0=
X-Received: by 2002:a05:690e:4884:20b0:675:449d:3d72 with SMTP id 956f58d0204a3-67a814bcec8mr653958d50.32.1793194433581;
        Wed, 28 Oct 2026 06:33:53 -0700 (PDT)
Received: from CC-KJQTV599DQ.attlocal.net ([2600:1702:7b5a:ab90:103d:30e1:1f09:a9ae])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a79f38dfesm1694911d50.1.2026.10.28.06.33.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 06:33:53 -0700 (PDT)
From: Ketan Bhardwaj <ketan@armoriq.io>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-kernel@vger.kernel.org,
	"HARIHARA SUDHAN . R" <harisudhan@armoriq.io>,
	Ketan Bhardwaj <ketan@armoriq.io>
Subject: [RFC PATCH v2 5/6] kernel: add KAP checks for unshare and setns
Date: Wed, 28 Oct 2026 09:33:34 -0400
Message-ID: <20261028133335.75899-6-ketan@armoriq.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261028133335.75899-1-ketan@armoriq.io>
References: <20261028133335.75899-1-ketan@armoriq.io>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check unshare and setns against the bound task's authority. Neither
has an LSM hook, so they call KAP directly. Every namespace type is
checked, and setns checks the type of the namespace it is given.

Unbound tasks are not checked.

Assisted-by: Claude
Co-developed-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
Signed-off-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
Assisted-by: Codex
Signed-off-by: Ketan Bhardwaj <ketan@armoriq.io>
---
 kernel/fork.c    | 4 ++++
 kernel/nsproxy.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index eb198c8..4216a2d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -52,6 +52,7 @@
 #include <linux/cpu.h>
 #include <linux/cgroup.h>
 #include <linux/security.h>
+#include <linux/kap.h>
 #include <linux/hugetlb.h>
 #include <linux/seccomp.h>
 #include <linux/swap.h>
@@ -3276,6 +3277,9 @@ int ksys_unshare(unsigned long unshare_flags)
 			 current->fs != current->real_fs);
 
 	err = check_unshare_flags(unshare_flags);
+	if (err)
+		goto bad_unshare_out;
+	err = kap_check_namespace_flags(unshare_flags, "unshare");
 	if (err)
 		goto bad_unshare_out;
 	/*
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 3fb1595..d41d7f5 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -25,6 +25,7 @@
 #include <linux/proc_ns.h>
 #include <linux/file.h>
 #include <linux/syscalls.h>
+#include <linux/kap.h>
 #include <linux/cgroup.h>
 #include <linux/perf_event.h>
 #include <linux/nstree.h>
@@ -589,6 +590,10 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	if (err)
 		goto out;
 
+	err = kap_check_namespace_flags(flags, "setns");
+	if (err)
+		goto out;
+
 	err = prepare_nsset(flags, &nsset);
 	if (err)
 		goto out;
-- 
2.51.0

