Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122C438BF7A
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469610; cv=none; b=nN6ZTpPIxSlGgZVVh+2WsbgzkcDRzOAPaY5sDya8NtIGYcVRC6HIvrpuczWWzn1w3q1uMBK4OJRhiPWvrerpr1phcm+9tItB/TGS56deSRRgUrEnViHXawCU078SY7tOC6q0qCJ4InYXb9Kc3YAMyffO7BTaX7xSv1+gpzRmetk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469610; c=relaxed/simple;
	bh=QaPYYNQyOGRWS80Oiyw0TFXYSpFN2iuoAICrlp5a5BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcD8SCier5W9qpJwEFfF7rFFxLGrRNIXy3b/pTcC08n3eW2vE90uuWtF3ZaSksXJOvoqPsCPVUaJxIoB6fM+6/DEIEEI9x8hdTk2gJM+itp/mdb/Z4waZMNS2S8Xwg/wVk2zzGD/GSfe1j4IMBkhN33VaM8nOoefc/vBTTq+aZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4/vmmre; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4/vmmre"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso48665235e9.3
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469607; x=1792074407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=43yKwHnHP/WZ1jZvgC+UcjcrGZuSSGiPrkzlw9Y42Ws=;
        b=H4/vmmreflTCk6hgkiycfgHJnii+outZ89Tz6KkxeIncH3pxB2kFW4N9jXBiNCJv2o
         YF1u5j1WtIWqxyZ1Y5NuX5a8fwgvkqT2TRFgw+FXhsiE2wyDpiYXwpOXMXy+lG7H5QJb
         Z99A2moWt863EQckV/lb04kNaJZAAgNrLXNZy6CExUL+qsVnfFOBOh9w+v9Hcw+Iiws/
         rFqz1Iyh+ylroziZ4abRxUyK+/bK2Tb+N0eSCFwXligRBh2TWn5fHYQGef0voCh5hsfA
         gjKz3V4gIKVF3DqHS93KA2o1O+YnDmXwHWCggVBAO0jqqziN1OSyezoFZ41AuoHz9kjB
         //2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469607; x=1792074407;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43yKwHnHP/WZ1jZvgC+UcjcrGZuSSGiPrkzlw9Y42Ws=;
        b=enqLWzxVrG6Jy5Dp0SfI1ib7SfvPvCMY7DkiZczWsitifHyIyv3mBetCgjtD/WsAys
         fK+DRfiVO2/Hd9kkiGFn9ERx01W7rM6Rz/qaFuYPIpzguEsFqNVL+xm4p1KjenEPV9Pw
         WNKwz3IcFjcwEmnrS57WDtTajkHXE4g6FwmvsDCPaV27NqvJ2/Phw/hak0JO9vGUmNp6
         WS4cjhZ+wNmzX6vLUJpFLodefQL/cNKfWYi90/GbQr43Y89+N1/0FKap4WBciHU/P6gC
         Euo047apCkWpzlBdLByzsZU0AxZzppHWATBpDGIAmn1X3MnKuiBXOOxo0W6GZpBJogzi
         1SCw==
X-Forwarded-Encrypted: i=1; AKwUvByAhmoHXE/K2EsW6mEqyangG5/HXwqA4cQEnKfkI2tuEEHkVo1zP5KcIWvhdNTkqJLfCjNTrVcYNP2d09GCR1zSsY51qh4=@vger.kernel.org
X-Gm-Message-State: AFuF++n7yRxu+tjvL4bLk/qXBMNIZP3CU3BWJY3zR5hLz/CPOLLs4ULW
	/jd/E1PX9W+shyBZCp1eRqZXcybZUOvsGFh8JmKfShOjQjvCrawCot/C
X-Gm-Gg: AYBFou0QwyYBoM4OSmN0g57k3f70HKVgH1r3VLpvmyHTCQNhZxrEICuPTpwT5R85qs7
	KO+ZIW/sMGKsjr98994nimGBpKO903YdLx4DtGQMeSSN9OiKuw5leaPZld8eCDZpC87DLnTIWiQ
	03ixe1I4apDloG9M6UiZKymP//6NRl9oxDjw9io3/syzrhuhUncR2EVOe9/0wAMCM3aNn1p/LEN
	TrX9mNWwTYoRhqHz+d29LvWSWtsWaCiRN5otf3ss8kGdvIcEeJ0tTEtJfmRCCWuBpqIJ+Gb4mbC
	rbl9u1zZ/C5nH9HhQuRUq4uX5aTf3yTfiBtSYTTDUnYMQqsPmcgUpUiYsDQxlzFWtrSSf9J9ueI
	+KimcmNK3URwy9aSYtZPzcssHbFEfR02JKtkqLLFxPwFGe+SXfRX4A/nnH7c3ZJ2Wnc6KFvp32w
	7EYIGwjrzn9I2No3+wULgtA+hoamxrUXV7eNY9lA03S9k4h9IN+kdPJ9e65cpK0mTAMrRN1Jizi
	wQ88nJj1BCrBNVgvfLAILQ=
X-Received: by 2002:a05:600c:1c22:b0:4a1:7c56:d4e2 with SMTP id 5b1f17b1804b1-4a180424698mr124373615e9.16.1791469607192;
        Thu, 08 Oct 2026 07:26:47 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d31767sm12022355f8f.51.2026.10.08.07.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:26:45 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/27] selftests/landlock: Propagate grandchild failures in unix_scoping
Date: Thu,  8 Oct 2026 16:25:30 +0200
Message-ID: <20261008142604.39107-3-gnoack3000@gmail.com>
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

scoped_vs_unscoped.unix_scoping starts a child process and a
grandchild process.  Add the missing check for the grandchild's exit
status and propagate it upwards.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/scoped_abstract_unix_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 5dc0debacb2a..e006dba61652 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -608,6 +608,11 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 		ASSERT_EQ(grand_child, waitpid(grand_child, &status, 0));
 		EXPECT_EQ(0, close(stream_server_child));
 		EXPECT_EQ(0, close(dgram_server_child));
+
+		if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+		    WEXITSTATUS(status) != EXIT_SUCCESS)
+			_metadata->exit_code = KSFT_FAIL;
+		_exit(_metadata->exit_code);
 		return;
 	}
 	EXPECT_EQ(0, close(pipe_parent[0]));
-- 
2.56.0

