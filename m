Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B3382398
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592169; cv=none; b=jxY7EbZTw5BjZpBtVsOBsmEsiD2dxA6+WFno6HRCyvTQOdhGMFAGcechcipvw4xo9aiEFB/Wecp5JOF3pqRcaiOGyp3p7gI6lspZYAAnbBCU3UyA/YJc+2uC9BCjz3RNeKriLqtXVq/GrLHgaWwaQiKDazTwDk95n8v0U2N3lkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592169; c=relaxed/simple;
	bh=YF5J4wceyOoLcHwxWVLkNkzbdQNVU+WfWpCxranP3Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etyqA4gEBiy1F7Vj1mGNlYbOlLfxaJ7bwGYC8QyNfMfTmK5HlQvLdBKDkjsmmzFzgLRaEIGr2knq+rEOfkiqlsVInqllrD/QWF6h54M4AEUWfmkGqhPx3bX8GHh6kaV4v/KSxvU400RzHTFQ2UbiC4MIT59om7WiEBso59L17Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHT2h50Q; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHT2h50Q"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65006c99d38so5987516d50.3
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592166; x=1776196966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gosc7vTE+s0I2lYg7cK7taBHrkIOJO6I43/Qe9FE/Uo=;
        b=jHT2h50QZ71zW1VlkSDxFHhByD1ZPvSaYi0hntnpyt405FuRXUnYjI7ZaCMrbqyqY7
         9H0AxP0A6qYAxNYEVui4b3Cv5kYvs4Wn06JvMdoRMcfm+RfGuvAPwjrZSoqzIvdFqrSg
         AohFzCQ4Mb+W8jXaDY36cdm34szgvGRm0jjMQwPfnXkdMPQtHpNrxtmx22UBB7zHe7wn
         b6mh4rNWwLIaHiK3etEhpeoZVIfCQ96is9CBDRCtOkyCpMFJdf56d0VBH7VW1KcYC+7I
         FgLbXEgnuHiZvNkA3y3KRc3Z4VU8tu3xKJObDgxw+AdtMqMv/CSC1POmQ8LYDoY8f0Ss
         4cLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592166; x=1776196966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gosc7vTE+s0I2lYg7cK7taBHrkIOJO6I43/Qe9FE/Uo=;
        b=gIzfMSWX8y95FTYiW/tcBLYISU3RmwuqZdhOQP6Uzw+j3HugrUB3iHG7OUiwr5IVxW
         nsuqKDbAXNv2pXFJ08UUy0i83Losm0Ua1hFTmGozeA3HBXEHz/QHL4Wpy1tNqAw+7SFj
         eXtYGcPBR4e4UBnS/7bydqIoOGBTTAYtEorLy6mO3NWQx88JcpJkkBHOhcyNoI2uozvb
         SLKhoiPlJ8KIo4xI5J0COs3jmXeI+R6+/yDLxFJv8qEdyffk0uhXGm1rEnEyPm0gioZG
         nUwzsx0Gx7Xnj6WXeRxdBE77/Z+14QYGThE9DBqYX29DM8y9Pka0QywiFroA6eQJliWh
         4Q1w==
X-Forwarded-Encrypted: i=1; AJvYcCV/Cvly0T0BBJGkbVl7ngeTlNqQboucnNWM7drDFT8ebIWlStdJR2fn/XfOswRk33lGa/GTSZKQFzoz6FuywE7xoE1Q+LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgVkvPnQjtmYZKc3QrUdbb2hZG8EmelcLCPyUHmloByHpLt6yP
	0AA6RMgoCwLsQcZwTrgjD38SE3XPAoQ2uMUZuqVpWmpsW/qrb+TkV7LC
X-Gm-Gg: AeBDietK8m4EZ6b6qvgPu3/OwsHJbAbSWrrGS/HFlXsIsWBuSdcOj/1T1pLD5XRtBlS
	6B7ZFB0ivnqKvBcLqwCpKgtaFBPFkhkRTSzuT52E9m+tUPg+0NOwN84LxHtRbPdwuajLFPraC+J
	+NG7Z5Hgfn+iRlTZDKkmzdmfl1qJsoZzlynZhcKmhP9+3AKTCYzZcOf24oa8GTyj+GMvxLHEm3V
	tJXulBLrEHNcoET4OyP2Uk0hY5B+FeMy9nmT+LbnpIoGZrIitKTjxeCG0mauS+CHy0fVtw91JY0
	ogdKj7Wb17skNgh92FuKa6gUtVQnQOX3VqHCLBODiaySDv0OPw7arhy1pWpTc39UnLCK03RPsUV
	hvxGy6kDr+vJe3L0Nvmfn2USXX7Ea2fGpeDT4kyUw5ZBKfUg8YVMD5xcLRGbpN/GY6kxePCtsks
	slJ6Z2BzaFTkQ3R8/3l9ifrgLvTn4JCZ1iFDHjwUT4G2tMgfmYYpu/MFKWmh777C3w2I5i/Kdyy
	wAa9Aftmv4=
X-Received: by 2002:a05:690e:130c:b0:643:1a5f:aaec with SMTP id 956f58d0204a3-65048814920mr17609725d50.47.1775592166553;
        Tue, 07 Apr 2026 13:02:46 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:46 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 16/20] landlock: Bump ABI version
Date: Tue,  7 Apr 2026 16:01:38 -0400
Message-ID: <20260407200157.3874806-17-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bump the ABI version in the kernel for the new
RESTRICT_SELF_NO_NEW_PRIVS flag.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 samples/landlock/sandboxer.c                 | 7 ++++++-
 security/landlock/syscalls.c                 | 2 +-
 tools/testing/selftests/landlock/base_test.c | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 66e56ae275c6..53bd77e55855 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -301,7 +301,7 @@ static bool check_ruleset_scope(const char *const env_var,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 9
+#define LANDLOCK_ABI_LAST 10
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -444,6 +444,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
 		ruleset_attr.handled_access_fs &=
 			~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
+		__attribute__((fallthrough));
+	case 9:
+		/* Removes LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS for ABI < 10 */
+		supported_restrict_flags &=
+			~LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 6723806723d5..790ac046542f 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -130,7 +130,7 @@ static void build_check_abi(void)
  * If the change involves a fix that requires userspace awareness, also update
  * the errata documentation in Documentation/userspace-api/landlock.rst .
  */
-const int landlock_abi_version = 9;
+const int landlock_abi_version = 10;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index a4c38541de70..51c72064c190 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(9, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(10, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
-- 
2.53.0

