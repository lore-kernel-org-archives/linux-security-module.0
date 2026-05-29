Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F2368950
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 01:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019562; cv=none; b=iFas6gMLgUTNuwfLnf8y/ojmqVRXa21iwhYV7jd+9CCTdRI6AvCSsdr3h0d05o989y1QrzN66Yd/tOvC1UM6hutmeEGydycUGgei3PtHMi0QwznIE8ihUnUUdlZ4vAFfl5/7z75DP1A5+/wAhggPy94PSpQf1XxASUrA4brddcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019562; c=relaxed/simple;
	bh=76kY0d60VUJ26O5KNgAsZo8z7YSKsQZJuHdM+J8sPOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFoich+RgFwyNFJguhLpdsBkuhT6Urj10+TvVWkk/zNlR8ELO6lYZuSIHUEvcX2j8oLAfOna5kRl/5IOjZ9g5hVM98nEh8e6fqdd8JdULklGIFY8GG4RE/hUYgBp+5tfHliD3q2ozfOLJd6pB6M0dEXbG8AkobdX1SEi9iArGe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9D76WVO; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9D76WVO"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7dbcb505578so21160907b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 18:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019560; x=1780624360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqYnzo1LtHIFPy2ScHtDhYLy8CZ9V4kJ5TdrOpsVges=;
        b=n9D76WVO3A0lo5tYhoPojx964qgaALAtWIgyRf68wEW21YwGVACXH0CtgtxW95WAeO
         B1iv5KEyTipADjk0IonAMCam9rXm69b3W02+X7+rGzqwbnCNsb0TEqpGRllXZP3y6qV/
         Zefwifw7WZ1+FDkHNXDadJxU6uEp8FQf/+hWHeIQbNxOrf9StYuRkec70W17OWvWUovl
         IzZ7tu8K7ui483aZRIn8Gju2rb83ro9Tbpi4vC5srEP6QdXBz9SY/0NYC7M6SKApOoxO
         2f7c+UqY/rU0mbstpvdBtEmIJejxzvnyRT/NZF1HcbK/n9wkgL6DX+ELXjP6t3fqxnys
         tSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019560; x=1780624360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qqYnzo1LtHIFPy2ScHtDhYLy8CZ9V4kJ5TdrOpsVges=;
        b=nl5k8cL5mdDViZ6QB12oPGnqbchLLlih4nZqKOEw74uK27lhxOZYzrDHQzVkycQUQ7
         CccI0SsBK8bTsEu7lMuHRvjJRELkP0QrHjcr9fi9RHpEA6FskZEzzgGTR/LqBGXJv7PP
         DniJQ5ek5YRpAntFd2x2dJp43HfIqSpcmJeYx9TEQT64EWkG9TU4ik89XVGn7lwRsQoF
         sbypICFXBkTxVJCmsW2Oj7N51aKugyUg4ZUr433oghP6WS80Pb/lIXiGWlhIcvgg1DCC
         UCcL+dIsS9mtACxtoxleaVyagQ13lzr0L3Mv/Ye9i3h3db6ej0kPin/CpB4L9yzAJvM/
         b0kw==
X-Forwarded-Encrypted: i=1; AFNElJ/ek9cp6CqpyWfkkbg5exJJ3Md2QmeiFsIXAp6MJ6xScttiAtgt9YX0CgZTQWXiDUISTlvCj9/VaCf8nZNLoHLNLwIGb94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU5xMfuF4VJLJgSKJqEeYJ9fXVnb+LjOC3BMV/RzWI9B7cCdUM
	D12PYmQZIt/4napBrxu7BWS9NCUxWf97RsH1gZdhzC90H9dLKALwKB7y
X-Gm-Gg: Acq92OGP9zEL3+qaurGOi/F+h4vvWWaRGhxXgNx6s/3mbCzRlDrrgubr3G0kqDPBd3H
	04/WNRhcTfp9BLFYjBg0MZtZXfvQRmpWqrTVFjnlzHvC/+X4OreWKQGbk1YopDjEFip04Q9XC8i
	9tU6WX46/Cbc6AJL2YsVl8ho4epb3VJMKdY25Q7YtIzcc1nhPqT5v0cuMJnbTjlkiOsJ7gqaybR
	fieePt9EPrH0udyenP9LJ1DbG/pcJfAQlvwzbFW2pnMkk7OV3ZvX0VnWA4BRQn8eW0PivC46Whl
	WA+LRVWtiA52nqKMVe5pYMaFP1Qns8hxDEx2Uevv3W0WOjEKTNu/59PbNuAcDBNsC8DotmT8flB
	v73t4hH821oCPxwghePriWRjxQ7WNk83QeQcy5XJq0GDL6aHKINupcafQR5s/klXEO1vcNCouRi
	VdKD2LsBWD+f1YDM5rmyyBbQ/Rf3p2nsSSsg0U7X/3tNKcZf+SnfbXKhTOIWfVZM108u2vRpRGg
	VL2Imn04Qw=
X-Received: by 2002:a05:690c:360e:b0:7d0:79f:338f with SMTP id 00721157ae682-7de46ea5662mr6709957b3.33.1780019559909;
        Thu, 28 May 2026 18:52:39 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:7a41:d368:8442:1cb2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6d1f3943sm1284717b3.26.2026.05.28.18.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:52:39 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Tingmao Wang <m@maowtm.org>
Subject: [PATCH v8 08/10] samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to landlock-sandboxer
Date: Thu, 28 May 2026 21:52:07 -0400
Message-ID: <20260529015210.500291-9-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529015210.500291-1-utilityemal77@gmail.com>
References: <20260529015210.500291-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new LL_FS_NO_INHERIT environment variable to the sandboxer.
Paths listed in it are added with the LANDLOCK_ADD_RULE_NO_INHERIT
flag, demonstrating how to set up a parent directory with broader
access than its children.

The flag is silently skipped on kernels older than ABI 10.

Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v7..v8 changes:
    
      * Reworded commit message.
      * Updated the ABI fallthrough comment to mention 'quiet or
        no_inherit flags'. No code change beyond the comment update.

 samples/landlock/sandboxer.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 74ee53afed6a..b126ffd7cd4f 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -60,6 +60,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_FS_RW_NAME "LL_FS_RW"
 #define ENV_FS_QUIET_NAME "LL_FS_QUIET"
 #define ENV_FS_QUIET_ACCESS_NAME "LL_FS_QUIET_ACCESS"
+#define ENV_FS_NO_INHERIT_NAME "LL_FS_NO_INHERIT"
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
 #define ENV_NET_QUIET_NAME "LL_NET_QUIET"
@@ -395,6 +396,7 @@ static const char help[] =
 	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
 	ENV_FS_QUIET_NAME " and " ENV_NET_QUIET_NAME ", both optional, can then be used "
 	"to make access to some denied paths or network ports not trigger audit logging.\n"
+	ENV_FS_NO_INHERIT_NAME " can be used to suppress access right propagation (ABI >= 10).\n"
 	ENV_FS_QUIET_ACCESS_NAME " and " ENV_NET_QUIET_ACCESS_NAME " can be used to specify "
 	"which accesses should be quieted (defaults to all):\n"
 	"* " ENV_FS_QUIET_ACCESS_NAME ": file system accesses to quiet\n"
@@ -447,6 +449,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	};
 
 	bool quiet_supported = true;
+	bool no_inherit_supported = true;
 	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
 	int set_restrict_flags = 0;
 
@@ -538,8 +541,9 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			~(LANDLOCK_ACCESS_NET_BIND_UDP |
 			  LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
 		__attribute__((fallthrough));
-		/* Don't add quiet flags for ABI < 10 later on. */
+		/* Don't add quiet or no_inherit flags for ABI < 10 later on. */
 		quiet_supported = false;
+		no_inherit_supported = false;
 
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
@@ -644,6 +648,13 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			goto err_close_ruleset;
 	}
 
+	/* Don't require this env to be present. */
+	if (no_inherit_supported && getenv(ENV_FS_NO_INHERIT_NAME)) {
+		if (populate_ruleset_fs(ENV_FS_NO_INHERIT_NAME, ruleset_fd, 0,
+					LANDLOCK_ADD_RULE_NO_INHERIT))
+			goto err_close_ruleset;
+	}
+
 	if (populate_ruleset_net(ENV_TCP_BIND_NAME, ruleset_fd,
 				 LANDLOCK_ACCESS_NET_BIND_TCP, 0)) {
 		goto err_close_ruleset;
-- 
2.53.0

