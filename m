Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE3939CCE7
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469650; cv=none; b=crnxREF7FFgJjCaOsXyXKSoYiXugiuO2s3latkoPHQPeEg6ykrTKUqO9z/O19NN8tp5WeMyY1izg90cLEmXofrp5ca2eMU5flMsmsl0gBFZlrJGJpsgOUm78S/lpcA6rBni118MvP+If6MD3637n3tD1WlxewxMYfqyon6+L21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469650; c=relaxed/simple;
	bh=iQFJx8zGQZdJF+vd6dzT3I1sdYulHPoS0UNY5Sok/V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuwlHXjHLz8W7izHOqZ3dlAcxy6oo0a9u9W6/fO4apDqQ1w0GbZkWbb6Y0kzo/Y93Nyha9nGm54A3Ov64wV0IWDrWRFoaBh32B9t0sjVCeJ3rsTlIWdSBJwpczcGj5ZZrTq3XVaTJY3AIgXXNa+EHYrdZkDjwuonvBoabFsoI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUqDIQzP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUqDIQzP"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso9449295e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469648; x=1792074448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ypc1R6277opyYpazj7Dj+X/DOrlDGXaNMJ06BesIwA4=;
        b=KUqDIQzPxVleyAMF38WpRyQsaVn6ZNVs5mGjBDRFtDhBoLTkSXgxsRMCEsICmxlb/M
         Jn70QQmKPVGZ3jt1Ra91zCWh5Ct3UXVHYHMyJNsHI2bRt0LCsP1vPlgOhzK62yWW06/O
         6O29L9KOHm4r5CBe+XNBXEV44j20x8z3dKYjiFO5R5mGB83+OHuYr2Fs2VJAUhqm8/xu
         /dj/Xm80Q7kZHELryu1SOQnSWbcK6I0VsKfVZDl93PhE//gNe50NV0e50ol3Q/jpegFF
         UtQDxZS4LEMErE+fL+XCQ4IQFBQi0mCEIkTsoKxF6R0siJGX2wZEAjGbyEuiyc8QR5k1
         TZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469648; x=1792074448;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ypc1R6277opyYpazj7Dj+X/DOrlDGXaNMJ06BesIwA4=;
        b=G/qdL+6DVjDRRvEghg9BrPp1xPAHhOdR7iOJII8sUCpxN577kPhodF90LyMpeaXgES
         bSPabDTZFjt79RPBbO4pgAW7P7x5K6bV0JPhPwT/71vyxTR509dfysMKaIBx30a8T8BX
         tfaLuAg6ttN0n04r6cO/2JvM1TolV+amZmDtbrmi8fBAqr9v6Iv3l0BdbSEWOerB0rKp
         SD6q+JXQ0sBFz5vd+/QoMBbHyUfnRKjn9TLWVuECZ+wILVlTC/lo/C350B5sKFwCfvBT
         AcIGnhIqGPfzln1cu18I7SNKNCz7uxX4RpxsHoP+Gyw5Ws+VM2KXwnzqaUDUt3rwoFIY
         tpBg==
X-Forwarded-Encrypted: i=1; AKwUvBw4C9yOlTGjh5+jbBiS5ime92P8EkxQcIoy1vVXLz5gWWXfl2iHXQClpi7EMYxX76qaWF3rlZH+g1WweWJddpGJAG7ctvE=@vger.kernel.org
X-Gm-Message-State: AFuF++mBcm7IqOep9PZfm5+nKdfhMig/LwgGtiaPH7N/JsV8EBCkNZUe
	BUO4ylUXXOOoETJM4t+R0dd5z3W/6wQBcDCMZYfgqbDIhjYmRE5E3HR3
X-Gm-Gg: AYBFou2pvB7QBa8W7AGKKiUJK3oP0Debt8LR/y8GIpaAKXLg9YN7Qs0bowIEE0qkvci
	XhI2U5vlsEffYVxYgZwppw0uGEEyJAMLMRkVXIKrm4KioxHxJs6wlBgQUn/AUWm4P1yeYkF58Lv
	PLx8E2D6LaGJ9PiQCWbCuDRL/aUoMphmAQBJs4GZVyZCmfhl3POVbdq5bZlGH6GM2qeYXXy3Iq5
	ZX7Q5MbMIUlL7zFcRYO79vmjk/nCgVQeahFomXEVNcHpyAq16RliganTXOj3XdUods9NvGTGgkm
	U5dzUURX7cIBFjhtTpqS/T1PeFcnXegLdRrK7sh/Q6xn1VwvQw6ES38SVsLlh1lBdXk4mevhZ38
	oE8A+L5rNub05fy5bRGXsaCtNVrLtDe896kNWImymw0YtavQ6JQWg+kbXZkfGVEV8Y0i9Ze+L1c
	Kyz3YFmD1aQV4jkw8/B0YzBUgw8uuQsonF8RRg3mCK0r21AfNQdJSDSOnxhD73UES1PZcDAQWEX
	K5tNHlSfmWhrO9ggkICZ2I=
X-Received: by 2002:a05:600c:6343:b0:49c:ff66:7d88 with SMTP id 5b1f17b1804b1-4a1852f61f4mr38293055e9.7.1791469647504;
        Thu, 08 Oct 2026 07:27:27 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d123b5sm11266950f8f.24.2026.10.08.07.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:27:26 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/27] selftests/landlock: Fix regex_escape() error handling in matches_log_fs_extra()
Date: Thu,  8 Oct 2026 16:25:47 +0200
Message-ID: <20261008142604.39107-20-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008142604.39107-2-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use a more conventional error handling interface in regex_escape():
Return a ssize_t, which is either the number of bytes in the output,
or return -1 and set errno.

Before this change, the (log_match_cursor < 0) check in the call site
was never true because log_match_cursor is a pointer.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/common.h  | 20 ++++++++++++--------
 tools/testing/selftests/landlock/fs_test.c | 12 +++++++-----
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index e1aa0ec02c96..91842f618a3a 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -264,11 +264,11 @@ static void __maybe_unused set_unix_address(struct service_fixture *const srv,
  * Escapes characters that have special meaning in POSIX Basic Regular
  * Expressions: $ * . [ \ ] ^
  *
- * Returns a pointer to the NUL terminator in @dst (cursor-style API for
- * chaining), or (char *)-ENOMEM if the buffer is too small.
+ * Returns the length of the escaped string (excluding the NUL terminator), or
+ * -1 with errno set to ENOMEM if the buffer is too small.
  */
-static __maybe_unused char *regex_escape(const char *const src, char *dst,
-					 size_t dst_size)
+static __maybe_unused ssize_t regex_escape(const char *const src, char *dst,
+					   size_t dst_size)
 {
 	char *d = dst;
 
@@ -282,21 +282,25 @@ static __maybe_unused char *regex_escape(const char *const src, char *dst,
 		case ']':
 		case '^':
 			if (d >= dst + dst_size - 2)
-				return (char *)-ENOMEM;
+				goto err_nomem;
 
 			*d++ = '\\';
 			*d++ = *s;
 			break;
 		default:
 			if (d >= dst + dst_size - 1)
-				return (char *)-ENOMEM;
+				goto err_nomem;
 
 			*d++ = *s;
 		}
 	}
 	if (d >= dst + dst_size - 1)
-		return (char *)-ENOMEM;
+		goto err_nomem;
 
 	*d = '\0';
-	return d;
+	return d - dst;
+
+err_nomem:
+	errno = ENOMEM;
+	return -1;
 }
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index b1ce0f810e10..9abc2adef79d 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -7454,6 +7454,7 @@ static int matches_log_fs_extra(struct __test_metadata *const _metadata,
 	char log_match[log_match_remaining];
 	char *log_match_cursor = log_match;
 	size_t chunk_len;
+	ssize_t escaped_len;
 
 	chunk_len = snprintf(log_match_cursor, log_match_remaining,
 			     REGEX_LANDLOCK_PREFIX " blockers=%s path=\"",
@@ -7471,13 +7472,14 @@ static int matches_log_fs_extra(struct __test_metadata *const _metadata,
 
 	log_match_remaining -= chunk_len;
 	log_match_cursor += chunk_len;
-	log_match_cursor = regex_escape(absolute_path, log_match_cursor,
-					log_match_remaining);
+	escaped_len = regex_escape(absolute_path, log_match_cursor,
+				   log_match_remaining);
 	free(absolute_path);
-	if (log_match_cursor < 0)
-		return (long long)log_match_cursor;
+	if (escaped_len < 0)
+		return -errno;
 
-	log_match_remaining -= log_match_cursor - log_match;
+	log_match_remaining -= escaped_len;
+	log_match_cursor += escaped_len;
 	chunk_len = snprintf(log_match_cursor, log_match_remaining,
 			     "\" dev=\"[^\"]\\+\" ino=[0-9]\\+%s$",
 			     extra ?: "");
-- 
2.56.0

