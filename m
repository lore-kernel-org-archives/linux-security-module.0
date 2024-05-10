Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63771369A2
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299852; cv=none; b=DXLbTg9JrB7b6/xGrHxb6zb6SmYfM0q+mQi+QMIVZxCOiQVvS3K5mOZGQ4qnQFlGzS+G7Vhi+NtIlPxTtdK1QedOfrN1x6FI0pEgDa74HnDttFXN5d4e2Qzpk5ubq4qVmMqq6f4h5loel+E/PK5RUKHS++BPda8+DYhieAjWD9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299852; c=relaxed/simple;
	bh=3599aDO6WJ8pRytY2emWkuJQ2LbOev5tgOUVnN1o3YU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dPQLFZ4gumQVK6XGWLiM5iK6T0KrNOnMRrFiRAhHJbzWhk4kTJwGRZxSTxQz1m4huZp8aQOxXAPl83JUPT+Yuo0wl/7fazYWF6KpAewk8HbXjof9JixjXeKYARXb+/DABLfjTiazm2N91ROAE7AW1dq8lrABz11aFDzCUDhut7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jymQnQvF; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jymQnQvF"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-61cb5628620so1370331a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299850; x=1715904650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bektZwrY6X7Dpw89yPQbwlH2LMGiwkQluDbu3J3hz3c=;
        b=jymQnQvFtEjvQief/ZlpSZaGP5OlEPtcbvldH5FAN4cfd7AMH4wSYjdVd9WvgAAVk3
         ddRK/j1poEUOJZTeEIux/DjV5hE5BtWDQUWhZdThW3IJnyWiPxdFMdLimLai4hard+f6
         Uu2IqXiqkboYoc4fID0HlYe9P+KhhgXGFYc9A5lXpHkOVC5nn8e7zkAn7fdUtIIgr1HL
         5ewQ97KF6us7LDZQVZGtkxuZDPCJ2HPgPOdz8e/56o4SLimqRMdss7Itac5LJjnapB8b
         C9uQMjdjt1lI+kj7051czIt9ohhp8e4d9JSj78rT9cr2xjhjhteeBVUJ/S7JOpIEZB3x
         WSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299850; x=1715904650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bektZwrY6X7Dpw89yPQbwlH2LMGiwkQluDbu3J3hz3c=;
        b=THXeFjH+fJysDyf7gsQW6jS6IpBQRHj7sBZ38xkY3Im+Lb78z7P+Njw6kxjAzPcmXI
         xsHhMiJR4d54b6CUMoUSCMmKJBzp3uYzSGHkdojXjmK95KCalGXtG89KNdk03XbiHHgB
         CAtOD6dtaiKKI617squdrbgcNZrYMFgYwcSE344nsC5YLvFfV1vAzYg14YulbJH1S7Lv
         /tyulQYTuCup0fWbemVSBF6UeX0xmdQyjwsZf1QkIhYQD1C41MjxA33PeAaVGJM4nDHa
         3lp/12r4MMwqTuKRM6MwjGVFodyylVesq9ykqlKGaj9wdjzRa98MmucV3f9aJOnZpvoz
         sAgg==
X-Forwarded-Encrypted: i=1; AJvYcCU7VOfBNuahGXFcrb6kcfz7038e+KoJ5AxKRBcDzht5UQNLsHKAjhIX4t1F//d0LhHoGeJLJf2bwpLW48zUOhROPdYN0oee68pyZO5/TF+5F3FG8t/6
X-Gm-Message-State: AOJu0YwBfOY8wgGr3zkiZBK8L0cnsFBxuNTPKAdqbxApMhzEUKxnJz+n
	me02eS9RkhPl0lIzd01CIDuQU73vhCXxUz/QOUPGEoB4hi3hLyPvzAkGA3/L1F/3ca4ZV6W4I//
	2kw==
X-Google-Smtp-Source: AGHT+IFR++Zjt53C83A0ZTqwu8l54Ivkf0uoSk3K8zVOgmN6xwNzb6wjdLB/lVbnRF6C4M3ptYxz3Wu0FZs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:4504:0:b0:5db:edca:d171 with SMTP id
 41be03b00d2f7-6373ce415d8mr2316a12.6.1715299849968; Thu, 09 May 2024 17:10:49
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:53 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-37-edliaw@google.com>
Subject: [PATCH v4 36/66] selftests/net: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 522d991e310e..c608b1ec02e6 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -26,7 +26,7 @@ LIB	:= $(LIBDIR)/libaotst.a
 LDLIBS	+= $(LIB) -pthread
 LIBDEPS	:= lib/aolib.h Makefile
 
-CFLAGS	:= -Wall -O2 -g -D_GNU_SOURCE -fno-strict-aliasing
+CFLAGS	:= -Wall -O2 -g -fno-strict-aliasing
 CFLAGS	+= $(KHDR_INCLUDES)
 CFLAGS	+= -iquote ./lib/ -I ../../../../include/
 
-- 
2.45.0.118.g7fe29c98d7-goog

