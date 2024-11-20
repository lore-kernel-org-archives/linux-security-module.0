Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA5F1876;
	Wed, 20 Nov 2024 04:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732077314; cv=none; b=Dz8ANj5H4ipgzM9H9clo258GaPYtWl4wnMRCE7HEd37IVFINj9r1oFwgl6At8nqC5UXVlj/LELjBOfXK/uzTdyEexeFu46A17FJcbeG02eIlann0X4J/g22h0U+Rf4WI8WSs8ZlWa3ONwllewgcrdDSAOcqPywVvjEkimZlGufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732077314; c=relaxed/simple;
	bh=bZAs2EVXv9Su66OJydigyuUajfozB0GMQir1n5AvD7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LqSLIKjdze5s9HevPPCxfJ0EpZJI0a+1HraRVKBlW3fMwmhSTOzxBb8y5J/UwQm1WlvIe/0f8e7gDB1b2/bH9sTcbIHQhMF+prRf1yeOphZiAy8qTkFj5fnBwbUuZbovAwnWkpZzIdbD9Il3wjH4a2j3BqvaP19uY0s6ecTYFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6AopNYA; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6AopNYA"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so1257665a12.2;
        Tue, 19 Nov 2024 20:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732077312; x=1732682112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxMql+EXW4DPQoth97/kk9YkFQwiIfg08Y1zFSpXPXQ=;
        b=U6AopNYA1mDbjlHFqYrQwV/ECtoGY1SdZpPvUGqe+BOrSz7lV1V1/fwwoYKEvvbE27
         Ywp0rexasl8IAXnEWiUzIn4Nuevl7qppp7abVacPrNVeb5SxQgLcy4RMhJ/kbCnSmKWx
         You1qxy5309YOYk1+AdgR899xSTKLSG+eHOA5640cpFg7bmJS9eLuDYo/ad4W5aN8rdg
         +gSBdCsfkgIL8p9YuEjK2C9DANl47AHz9MQxv+Yy2TWWfwG2CuIEDiAta2qZVJFSTjhk
         Q7rucAcur1TCYLv3I4viduHG+6djd1y4/PedWRk+7qwHSafoAVucb23Ym7rf9zpmf8Oy
         dQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732077312; x=1732682112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxMql+EXW4DPQoth97/kk9YkFQwiIfg08Y1zFSpXPXQ=;
        b=ViRCZL5MCupnK/T2c6eg+dnWXuYygz9tA/55P0X+3hEEIaYXKuSRe6my5TSH+mW1s7
         2tt1dzqzjC0wc0uUbHqLwHKd+KcP79+4KjJBu9sZ8X522tyoA1CJfRrWHRnKoP4k1bb/
         LEpJtEK7MJ1WGjCuKhDHAQXVbdCGO1UgUybyl0wgeS5W82viY64y9syEZz5g4HQjZI2w
         sPbtAH+4Z01sUfMaBLxuR2WT/s3Ylv/yKczj3D2W4q5usx2CsHIDtLpvqvFl459j6Bzo
         SSOcP4YriuW7Nvcg++FvYJ88PPveYQxoYrWMpEBVE1ub7M2inyKzLRy6tM3Fmu7Zj+FV
         5c4w==
X-Forwarded-Encrypted: i=1; AJvYcCU5dBmiORIouscsCjCEZNCoEL5ZlTlVwuSE3VT5wlmbMYmN1GvBNujPvq+Hw3D3UXYjSgDxqlmV1v65czoaiUu7/Q==@vger.kernel.org, AJvYcCUFF9NQUpkMsrjHAmx4WEFc5AS8DzuS3TuNjrHw85eSk15Sg0keqx2y1pV4GddEvH3q4qBg+lr+mDaWoDE=@vger.kernel.org, AJvYcCUTGxJPUiolf9mbGpEMjAhMdhR6WWOTvsXe08NnyA72G5mZNkYL6qI0e87y9N1a3QhNmGUJR2eDwfIF0oqzQf92HwUqs+e7@vger.kernel.org
X-Gm-Message-State: AOJu0YwY3w1muyqxBalRFo/kFZ0f+qqe1kQjvdRCpBL3tr+yVtpvM9Ur
	HnAazKT6144Jdppw6oSh3sYE/Cza6Ut4ry6TLUZOahYY43Za2lEQ
X-Gm-Gg: ASbGncvX3H5DWDY+YKkHE6xL4nDSFxXmCMFPCK3e185f4aOJHxgd5LIh0kQ5qxsZU84
	Z6sE5QsrJ0JQJiuIVDD5QBDxE9prG7vgnM4l7lW9sy4M3DZFnjPj0jsGmZaYFlkv/TdfmT8Voyg
	IbMLg1hASziNUMOOUZSQPCS1fyNvFFBctGcW5/dTB/AF9iIIs80ROFArwvK9b6tsleOIDo5wMHf
	JBs+0DIBla7EgJQSD0occd3PKwgKPj59Sux8/oZX24r3JkLiVRAJSwI2VC1x7QsijSLGU9uGIrj
	5cISmM7M
X-Google-Smtp-Source: AGHT+IF2e5SqwajlnuBsTj62Xa5V/Apcube6pHNVtVTxDSBcA53ruVxeMk0QcMoLSUEu3J/vZfKlvQ==
X-Received: by 2002:a05:6a20:12ce:b0:1db:f732:d177 with SMTP id adf61e73a8af0-1ddaedcbf4fmr2613009637.25.1732077312310;
        Tue, 19 Nov 2024 20:35:12 -0800 (PST)
Received: from localhost.localdomain ([175.112.156.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befeb5bcsm593061b3a.181.2024.11.19.20.35.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Nov 2024 20:35:12 -0800 (PST)
From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
X-Google-Original-From: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] perf test: remove duplicate word
Date: Wed, 20 Nov 2024 13:35:02 +0900
Message-ID: <20241120043503.80530-1-RuffaloLavoisier@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Remove duplicate word, 'the'.
---
 tools/perf/tests/workloads/landlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/workloads/landlock.c b/tools/perf/tests/workloads/landlock.c
index e2b5ef647c09..1f285b7b6236 100644
--- a/tools/perf/tests/workloads/landlock.c
+++ b/tools/perf/tests/workloads/landlock.c
@@ -10,7 +10,7 @@
  * 'perf test' workload) we just add the required types and defines here instead
  * of including linux/landlock, that isn't available in older systems.
  *
- * We are not interested in the the result of the syscall, just in intercepting
+ * We are not interested in the result of the syscall, just in intercepting
  * its arguments.
  */
 
-- 
2.46.1

