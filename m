Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514A317142
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022361; cv=none; b=kgm3RAgX1zvNB+OhBAF6WmWJNJKjky7sPDK1BauM8zRJGTXqpR6OY4vvw+Hjv0OfuH4r30K6eQL7iw3RA+sc0EiNU6Jyxz+vYJ8gx2gbGOM6J83ywkewm7g/Gc6P1E83PNzmItHT7x/szM8IblJfxJsGmRNDQGEMP7s9+75k3R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022361; c=relaxed/simple;
	bh=2iO6bOQTVYc0L/NHvSLbf3JIQ5fpmlXhxfFmKjsZrnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjKyd5C2d70AnfjuwU/OcjyQIfgXajnBVfktqRLXEKTTiB2gfbyBst1OTpPQjQuE4kvnV7/zRIf4pi3epPtucWss/nKEjo3KxaockJjzeQJmx0GRLhfI6+wCdolfnTie4/dsCCIJlkGZelUt2x0fDQN8ITpzZRI7pNtRhwK6PUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zyurp6CG; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zyurp6CG"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7b186dfc1d0so10187557b3.1
        for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776022359; x=1776627159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf7LxIAdF4UniBGd0ydg6fz6KWxBzxKiGc9FKldIaHM=;
        b=Zyurp6CG38LjxZuSFOKB/MSjnMaVOS4n+rKdb0dBIw7f0hl/ZrjM0XMDcpNoNHEpHi
         dHCrZ/EK0wX/jFm8srG8SKZwc198PvPnoBVrBBEWIqm5YwaZlY6jWvWaoD7dsD6w7FIR
         m310oFyyfIJ19aCqBiTKMItmKd6s5icm7pOxk4gbUFNrCkYL2GRTnMOG3j4BG5x5zruY
         +7F/ktCa0R0dgSLnBikOfxM/LeVTbjpB1IUTomLmYlJu5Jca4WgQPwqMu+jvsBbrRnHH
         28skPJzRQgexxigXqKX3/jl7e6ziPjFpwedwLm7A0Mg3elNNUjgtF1GRVZ1+DxK+pZvx
         vbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776022359; x=1776627159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zf7LxIAdF4UniBGd0ydg6fz6KWxBzxKiGc9FKldIaHM=;
        b=j7gt1/X2prg5g2UFw8rNqsaLaDamMCcp2wML2x6amlLd+cyP6k8459S22lb4GXr/QD
         L9VW7swHgsECBxLSCxB7MYGZpqSRDXb5m6X+Y5eGx7LSoV+MXcjErJ4XNxlxDiaCc+TX
         tkAjEUKxPETqAvru32vM3YIik6JxRHoqHXHNq4ghIv45DvaIchH43+a9naQ0iOakgDHA
         D8bgg6+YFDKv9RkCIRkzUqBeH1njo2ocmAvS1NTEcj1uacHHn2wgh5jLVBrK2Jhf0XYp
         Yn8lMWgnQPX7p06s5r7Pd4A6z57sTD6wTQpQmXm5DTnLVltEgcUvpWijdy/5LJo5Ydaw
         8y2g==
X-Forwarded-Encrypted: i=1; AFNElJ90EwFcXpoK679ch5cbbO/E47p2J15BRFlsw4vzhGFYB+3fXW//RdTiE3v4fK7wJEF8a4AurrQ5XH7dZbR2xbzQmxZ0xlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoy+gN/jIVq8FHyHw0hMjL1krUhwx52h0u+QfCzfsgqOfCqDfZ
	zVvZYHpgzdVpfTRprxQntRqQpyt0cNcKQW8/fZwyYI0H2h1uz6hADY97
X-Gm-Gg: AeBDiesi3aLPWdq8pgtj0T6miDGh+l4dX3B1KRhNLV7t4nE3GK3AFHDGZ1GdDLnqWf9
	V7CW5sqxS5g2UagL3+q9ERHBnCsJtZ7dLH6yaqCGdFUoA/RGY2Mc50TRNnLQobRRxJouPbRVEVb
	+Pp9xoau5Fr7aZmSJD59BGm4eUeMbmetN4bZKFYaBu3/xnUor/TkVQLTYV7ruuDC+tm5PpeiKNk
	I2O3l3vn+A80w+gmSjkjIEHOVNlRCFRigCNucenrWOPdUFZwgoTPyg5/VXeOjo85FK/sxGIsDYz
	6T08gROYGUZyXqTlFmbKrS5WNd2K2uGdJ4a1qYGQSTXOP33rssbTgkZG4GYn/o+v5WoA2XWUQhb
	PHAcrbFo7d2FYetCTNUxiv9hERAiwJ2bII4ylodU7J+aCEmUqB87SWj75b3Gtv5Unz7mlFfE8mk
	iR0UjIsyXKUH2h4us2jB9M2Ioao5Pkg7N0vU8ki73TODQAt5BFoqROo0S5YJfbg+AY2e2qf0pT
X-Received: by 2002:a05:690c:e682:10b0:79a:31ca:6663 with SMTP id 00721157ae682-7adef01f120mr92187817b3.28.1776022359455;
        Sun, 12 Apr 2026 12:32:39 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:1192:20dc:2cb3:dcdc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3c8decbfsm42395807b3.8.2026.04.12.12.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:32:39 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 08/10] samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to landlock-sandboxer
Date: Sun, 12 Apr 2026 15:31:59 -0400
Message-ID: <20260412193214.87072-9-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412193214.87072-1-utilityemal77@gmail.com>
References: <20260412193214.87072-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support to landlock-sandboxer with environment variable
LL_FS_NO_INHERIT, which can be tagged on any filesystem object to
suppress access right inheritance.

Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v6..v7 changes:
    
      * Bump ABI
    
    v4..v6 changes:
    
      * None
    
    v3..v4 changes:
    
      * Modified LL_FS_R(O/W)_NO_INHERIT variables to a single variable
        to allow access rule combination.
    
    v2..v3 changes:
    
      * Minor formatting fixes

 samples/landlock/sandboxer.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index daba6da2fb74..8dc3b4471b36 100644
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
@@ -385,6 +386,7 @@ static const char help[] =
 	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
 	ENV_FS_QUIET_NAME " and " ENV_NET_QUIET_NAME ", both optional, can then be used "
 	"to make access to some denied paths or network ports not trigger audit logging.\n"
+	ENV_FS_NO_INHERIT_NAME " can be used to suppress access right propagation (ABI >= 10).\n"
 	ENV_FS_QUIET_ACCESS_NAME " and " ENV_NET_QUIET_ACCESS_NAME " can be used to specify "
 	"which accesses should be quieted (defaults to all):\n"
 	"* " ENV_FS_QUIET_ACCESS_NAME ": file system accesses to quiet\n"
@@ -432,6 +434,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	};
 
 	bool quiet_supported = true;
+	bool no_inherit_supported = true;
 	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
 	int set_restrict_flags = 0;
 
@@ -526,6 +529,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	case 9:
 		/* Don't add quiet flags for ABI < 10 later on. */
 		quiet_supported = false;
+		no_inherit_supported = false;
 
 		__attribute__((fallthrough));
 	case LANDLOCK_ABI_LAST:
@@ -612,6 +616,13 @@ int main(const int argc, char *const argv[], char *const *const envp)
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

