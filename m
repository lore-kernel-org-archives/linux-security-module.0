Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780E312C7FC
	for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374031; cv=none; b=fNXSFDkp7VHXi9Lp9xxUXxvr8i4xYSPGx0+5U+Ljzy4jIyZKc9G7/oxfSCdeZhvW6iMVE8M6w0e/KIlWCz6yYvmbLIX4dmSjveyFo2i9p2Q4hhX/Bhx+SKwoItx2mvP31Xq526V6OYTXadqmcfWqxwUoVDbgVZZsc6yMRqAYods=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374031; c=relaxed/simple;
	bh=I4ujxSWG1rQZvUOG3aGaAfaG34o0FSxd2yK2pMFboO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bSO+o0l/UgHWpizGq1AAAcS7IJLJN980k+xgzPPnDb6M76RkjDQv5BGRq3iJZbNhcAXtSNluXby+5rOm4r2L1RdJdvZH6xd3MvDaICCUM6Z5CLq61JzRrVzNX0DeobF4ySDtfT+lbLMA2E3rcPHU7wZ5IzQwZNHIfhZ45s/uO4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ynwRLXR4; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ynwRLXR4"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a46cc88be5fso300092366b.2
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2024 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711374028; x=1711978828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zqw6HHB8TTWWZzHXrC+t6B4vKHkVHyluYvVzQQIi1bo=;
        b=ynwRLXR4/N2fgwLq67Xq65v4rvA0LrBZNozy+29d9g2A7iuAemsHMJ9GE3zwGI0YaT
         NvYVCu3ZUFgjvWTCk49Ubc86XUxIsP3+Ir7v6RyO+OusC3WW+sItUYYQLk0dIeRBa+RG
         x06lU3xkZucnxLZjcJTlsns2dnufVF8TwGhytdT+QfWMCIk0kwBZUa7+J6A+RIT5r2WV
         e+QG72xqv6OnHBlCC9tK3WPZS5oqEZbVM2+84uTgu2zAMOHhzHDFT8nVdRLR6GpSV5An
         wmAuXh4Q3YTcQ8srBgitxX84dCArC2D0pA4Q4ye7jKxCtF0qKYHyRo+GFEl/255UL3jH
         TdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711374028; x=1711978828;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zqw6HHB8TTWWZzHXrC+t6B4vKHkVHyluYvVzQQIi1bo=;
        b=pOmOuAN7eM0vnlB9o6QxmIJrvZvVHWTO982dpVm3P59BWGejwoyiQBFpbnMPTyTrC/
         etMZSHbcIr0J4PxJcRsgjpvYapfvkzGR88WtWmL4WonE146XzmAq9nvYPtOobg/szW35
         U6QEj2suvum5TfYs0OX7L57bqtqjqAuBZBbUqxIl5a63Md39U3EeGRSqe3ZGnMOWRliX
         G+ESXM3s5DotF3dm431qOF4dYMOydYGT3Z6S3ddCGV1KNEN0iMcAitHbpHqTrVDQK2MU
         dT5AB7w6XUlRMnSESMW3fxnhx0UTeDFnyIjImvsWYn4vB9Loa2E3PN2iA7y5Ubcf6z9Z
         x8EQ==
X-Gm-Message-State: AOJu0Yxytj0jDB/hXe0vwiNGs6YUYFE4Tjmzwo1ri8w20BYwIZ3sqnmq
	pbfp5Chy7I/uintXxMwrsQ8xSo608h19oCMfhWmG/RmA1mLvIFfK0J0QIijxVSQ/ongPyqrYPbE
	O18NAeQPRkU/Nii29iDzB/TzOsb59ZCxa3wMJhYrfync13/0xSXrztwjt/a/60X2PBEFj0IOPWi
	zy7yCdF3OO9rUrDu9SAqHptDD2O9+JC71S+Q/loBeaU2dZlHNaNGW2
X-Google-Smtp-Source: AGHT+IEook1Vy3rWJYUAL71ECA3zPQwVSnll+1PCbdZbB6UG9EJ/1AV9JwkMpaOLemUblQM8SJ6KZHRqJvY=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:af06:b0:a47:3b6a:36bf with SMTP id
 lx6-20020a170906af0600b00a473b6a36bfmr24943ejb.2.1711374027753; Mon, 25 Mar
 2024 06:40:27 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:40:03 +0000
In-Reply-To: <20240325134004.4074874-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325134004.4074874-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325134004.4074874-9-gnoack@google.com>
Subject: [PATCH v12 8/9] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL_DEV
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add IOCTL support to the Landlock sample tool.

The IOCTL right is grouped with the read-write rights in the sample
tool, as some IOCTL requests provide features that mutate state.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 samples/landlock/sandboxer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 32e930c853bb..997f774e88ae 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -81,7 +81,8 @@ static int parse_path(char *env_path, const char ***const=
 path_list)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
=20
 /* clang-format on */
=20
@@ -201,11 +202,12 @@ static int populate_ruleset_net(const char *const env=
_var, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
=20
 /* clang-format on */
=20
-#define LANDLOCK_ABI_LAST 4
+#define LANDLOCK_ABI_LAST 5
=20
 int main(const int argc, char *const argv[], char *const *const envp)
 {
@@ -319,6 +321,11 @@ int main(const int argc, char *const argv[], char *con=
st *const envp)
 		ruleset_attr.handled_access_net &=3D
 			~(LANDLOCK_ACCESS_NET_BIND_TCP |
 			  LANDLOCK_ACCESS_NET_CONNECT_TCP);
+		__attribute__((fallthrough));
+	case 4:
+		/* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
+		ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
+
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
--=20
2.44.0.396.g6e790dbe36-goog

