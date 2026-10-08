Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B7B395AD4
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469661; cv=none; b=JYXB/XK0YQcyFq+DubAIIO2ZWiek6ZLzcwvdMB11TY8CDOt/q9v00lyOGURinnZUlafJ2V1Cfm+PJlUCj1bvXpIay5o7NnFiCVAYXlPBVe7tOgrUEepgWktPhFv/viL9Fsld0BD0Bf/qLpt87Cl2IqCX+ZCxfEGrbxYjpuDpVSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469661; c=relaxed/simple;
	bh=iKkQeQlMycpf9iMeYIDxTMFKhkm0k4gvvGsiA/LaVio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRL5fTivVT6kBYu3MnY5GJe/dBAi5unzXQXJJlevgG60i2bQlFLG/377Lu3FCHjnUnbGTtF2hTY4eqVkHpUqI1yy4Nfg4xUsVm3CGTWvWxbNc9kilI3VF+Zafk+WDHCKw8z5NMJpBsNQyXV0pWzAhVCYvFt/J8DA9gCN4eJPXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VolJrv2D; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VolJrv2D"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso30287015e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469658; x=1792074458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sSg7ATSQQubxmgcmTMIuOrcHjExSpPhZ5BBe8FJg+Ps=;
        b=VolJrv2DAUnM+SUpkvGiXCm/BMhF763UnKJA15ea+gcsO+VaMoIBMiwdbx5qPRwLBb
         BVQUYzDe/vb0kHQrKTUr3tJ0X1kaFML7vYvJRZz+lS9L5qr6q3w6USFcIQh7jWgex3NY
         Bj6rj2mjvqlVXCYKCbVVhwvDZ+Os4fyFVgjrtU/sARLSfKD4go8tCY7iPpPsoOIrLxFy
         xOzbpyQ9bDvnJrPXLiZYHleu0ARlms1KWtufeh5/YIF6pPN7fV8UnWTAonDjz4a5rotj
         qNnANs0PGcL2k91xlTmMKjKGlzbyxuyp1NRblyoJEH4BN3xCyqoumuEMiIKZXH7Do4o7
         VykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469658; x=1792074458;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sSg7ATSQQubxmgcmTMIuOrcHjExSpPhZ5BBe8FJg+Ps=;
        b=p9HeUCV2vrTuYJPtDb7HS4L2oat2Ih0AP52MGTrrp+JIS2IQIlnZsfiWroXQVKBhhE
         e1Dy7svoshiw5g9GnfA3injgJO46TLJ901kCJ6oTC574jF2XHW8skU8ibDg9bIFZ4KUE
         JLVplz8rrJvVwY+lYHiJTtVgqHBaxA1xqQRBr+kgeHvOfr2DrXBb/0O+i+MOUV29ITgv
         ea+aNYd89dqLp/LdSFAHEv0Z4QFKfAcZaKuzoYhJ24FmDVkZTRoI39dAr4FVnsJq0C6d
         7uGJih4CFSEz58NnuEgqKzgHksMe0c6NhIKhTaKOgash6yYDosY0srQMqm8pfLn06EYP
         /p5A==
X-Forwarded-Encrypted: i=1; AKwUvByJZ2S9vkN1hDT04iyBmrs3tFEAquMxKDd0rit+0WO1DhZZ4Ul5UlNA8+fgSAyiLdVK2TNg4wkhG0qipmK7grqg5EYKqy4=@vger.kernel.org
X-Gm-Message-State: AFuF++nuJsVDopxwekxh43/oKk35XpnA5XzFsGmW763NevG/EcYkFpdy
	mGAALdYqANMB9D6ATz99n8p3qcBVMEWP8khau9pqhaIiTXXfBBaM00GJ
X-Gm-Gg: AYBFou0YUWOiwwx3murD/cIdY6J24YJVePCkGliXYZZspt6rZOg72ZEzrX+of8gW3db
	tCZXpHvkERjFezIRGx2BERdkFFRVVxtth0hXuDwWeSdcmvqHRglK7mpOIMXfCxiwPM7euJHYhnL
	ZbJe4lzXFeAs90LNFMX6nnoIalEBFLVfuyISgkwznADG7pz8HKaFRuccBmyl7d7ZReYUbxJXFJK
	ZjJTzFtIH1wlmieaZJ9Km7sYU68QcX3WmPp6NPrSvWt/NuJLXEC9JQfqqu32J6wku9vhaXxnfuW
	8skLbxmMxRiFFEGh5q2oBzLHj5GsYQ9b3G34Diw5kyYZvKLhiw0IjkWfjQW2sZ1lt4kr5bno670
	mSdzlh5+jvAOAdazv4HB58zFTsWweeBjM7ULQ0W8QsFBelFhE9jdHCewHJ4IMwiBw2yfi7DzNwx
	2ueioAQoyEkTWSkEOmgvfbJwkpeNQSnunKiz9sVZMXWUizsIj1TAyY6/wAoEavtmyAgFJGSqz1P
	d2/9gOWzZnAf6NmygutoHI=
X-Received: by 2002:a05:600c:8b6e:b0:4a1:78da:d271 with SMTP id 5b1f17b1804b1-4a18064be59mr102776565e9.30.1791469658475;
        Thu, 08 Oct 2026 07:27:38 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843bd060sm92856175e9.14.2026.10.08.07.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:27:38 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 21/27] selftests/landlock: Use _exit() in the named_pipe_ioctl child
Date: Thu,  8 Oct 2026 16:25:50 +0200
Message-ID: <20261008142604.39107-23-gnoack3000@gmail.com>
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

In the named_pipe_ioctl test, use _exit(2) like in other places.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 90f63af1d64d..ba3b39ad5882 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4276,7 +4276,7 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
 	if (child_pid == 0) {
 		fd = open(path, O_WRONLY);
 		close(fd);
-		exit(0);
+		_exit(0);
 	}
 
 	fd = open(path, O_RDONLY);
-- 
2.56.0

