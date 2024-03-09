Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608BF374FF
	for <linux-security-module@vger.kernel.org>; Sat,  9 Mar 2024 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709970826; cv=none; b=n3iDBvWFcO/Okk5zJQKIM2dS3BE8kpwMGCg9VnuTvv2ZzNlPLbyqK1HfFKD2CBWMbau95CBCPlvdgIa5My0hlGP0Rt6t8lviqPoxIONJPBXKwoJji0qaMT6UwsJ7LKnhif4ZGilB3dU2JleGKnNp1vtZDYpzY8/07fQW+jraOcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709970826; c=relaxed/simple;
	bh=XpHNaMw51kfwTcxWhMkN0GRYGhulnMClD0SZLPpObEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cxkJ7o6qgUhnWaJxYPDZzmaKTyfIu+ya4BlIp/JfLGhqm7tnWsw9aieq6F77z3eqc5+lgqOQRDqfqzO/ZMUebGKuoAi+M3ErCoZnqlpJY3GeUiMXyDO2jVFIEp1cF47jXZxYtYiN/xJgO36aMJNNiTsgklI9U+cGJlmi+YPDA08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GIW30M9l; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GIW30M9l"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a44a50d098dso162410666b.1
        for <linux-security-module@vger.kernel.org>; Fri, 08 Mar 2024 23:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709970824; x=1710575624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Jm3POEMybiMvQ/3vdCRUI71c8LtW1JmAsyXMz3gRfE=;
        b=GIW30M9lPpcS0hseNo5AeMpA4EJwPGTXFx4ay7qrx2qJfbiNmmw+q3hJddXHNn2DBq
         NrTvJ2dvpY131mmBmzsdvYzI4SSA4PZ+ezimtR1qdLWpjYx4b9itQtvwoJY+lQq4di76
         Jg7ArejDTCiNBsSxhqgisShp5IyWAvnMOWiIriYQcdxNBbEhgoEQWbOcMT5YFlS6/965
         FZP8JNQQvBU6afeDNTSl8wV3w4BgB2PHa4oHviXN8DrLbyW5etmshV0gLN1Kv9gEQZvd
         8R1HbAbxgQ8mzJ3JroRriRfoXidDUEAW64qlH6f6qTDsyzkyOzG3Vi1/fZP6/7PJwm+6
         SyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709970824; x=1710575624;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Jm3POEMybiMvQ/3vdCRUI71c8LtW1JmAsyXMz3gRfE=;
        b=gyxHoDP/vXaT13AtydGTD6118U1WfywfSqOb7Yo/w6ONAv3RMp1qb1wpgIdwoCUw1O
         WOkyG5jObG4ZxtHcM+D/YFzlSUF3zSGv7/8/LFqvwNBY8lcgtbDxqsGUMkNs9BxZXFXj
         gxKzg1fzCtCriwkuN5HXPiJFIb43U133CVQdhgJZ4J3cfEVP/FMFXjm5QlXno4GkgrwN
         eaPCDj7DxkxUp7eBYf6YZAPvnXbPTOsrVQua10zrPFpMZ6D6Z4Tmw6RDotx+vLA6iWpN
         loNlXGLv5Kspq39H1qcnaWFGxPBnckC3en47qx6xBdr07vaW1BZ9rn7YzNJvcWosmU2d
         yRSg==
X-Gm-Message-State: AOJu0Yyjm3j5wSmSvM61ZiUkZz2LLQKtX6RJAxGSAJ56DYuebHfk02jg
	iDodRW0bblzcwa9R03sw1k6YT2oZbpY5LFYxV2Ntz/V3bU+TDxKE9sksisOz/b/vW5J2n48PkYk
	WEOgJXH9bRyuP+iNDG6DBGTESN1h3JXR3BT3g+BwbeP9zDVdxV7WpqVRJWIwrgAa6CyaNJaFbjR
	6Ne3hu7Yt3IAzZqGtIiLctS354dmLZkyRtMrNoY915+EC/ceBnBrwO
X-Google-Smtp-Source: AGHT+IGLpXM+yuVfUWprHCPTtG+qTgEOtYUZ/27FY+xZlbXBgCi2PYlMNVjPDgR1F3OhtL1jvLlFQ/U3n2k=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:e8a:b0:568:13a1:2c2 with SMTP id
 h10-20020a0564020e8a00b0056813a102c2mr4921eda.5.1709970823517; Fri, 08 Mar
 2024 23:53:43 -0800 (PST)
Date: Sat,  9 Mar 2024 07:53:19 +0000
In-Reply-To: <20240309075320.160128-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309075320.160128-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309075320.160128-9-gnoack@google.com>
Subject: [PATCH v10 8/9] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL_DEV
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
index 08596c0ef070..c5228e8c4817 100644
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
@@ -199,11 +200,12 @@ static int populate_ruleset_net(const char *const env=
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
@@ -317,6 +319,11 @@ int main(const int argc, char *const argv[], char *con=
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
2.44.0.278.ge034bb2e1d-goog

