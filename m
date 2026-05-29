Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355B0363C4B
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 01:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019559; cv=none; b=Wcpsr555NdYneKLCJbXvIdClxPZAiZxtMXrSKD2zRHRUkv3deuLiIGJ9OkbKwmDMsezJc/Mo4UKans6AbnBUMglsIyVIYhv74dgXHsQ9K3MEYBCogm32qyjkueGxFQt09arLdzHSVD6tC5BCcRwQsU9pZwEvjCbR2q59xWZE+pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019559; c=relaxed/simple;
	bh=trxUybHguCoxohnEyn58jFksS/yEq5TOeiwsKGYCY7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HE35qQPTMiXhbGfUUhJxMadLVaCggERYOb5EBN2uk7g9FZff28j5znCtQHy9jIkhyJDhKyzCz1j3g2znPf7tmp9uiRPhdSsm/Jj5yFvQL8gRZEHHrodut5u2LL2YeIizHyE192n6mUhpK9XqlxH0ESTwIfCBxirHbcm/pueofbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUbnCoZS; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUbnCoZS"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7dc6d090381so16573317b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 18:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019557; x=1780624357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weKJSMUU3m3+uwtuJiUMz+guBFkag//BiZTgAufcbA0=;
        b=aUbnCoZSirKaIyvQ4P8dEJJuEPuKrBI2hAt0EJ0OuIzVxE7vC5XgPKCaZ+xCPgBHlk
         /YQtG82eTjzlHIk8ZluXWwqsOLa18Ih9unMgw8kIoWwrkMZZw1UDM7WeOU39pZ4sJfot
         ZM4LEoT4PbA7vRNX8TwpFPfCme3m/fw619BsICEcN969nowY0QMMSzzE/T9QjvE4ddk1
         jSGrm3HdMd7idDnhQa3/abl3+9rEIdtHKAhpJTCZwzVWKHG8AE3UDWaAm6TOjAgC4YqT
         mAzf8pcnC2O8m7BLxGq7KogjXgqh0Xo45jg7kZIrkmH7C3mWuHCO9z7M2K54sq+osqc3
         lucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019557; x=1780624357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=weKJSMUU3m3+uwtuJiUMz+guBFkag//BiZTgAufcbA0=;
        b=WRAPvgpL7a/uUeScbGKP+KNUBwGWLDO3NVgoiMgLkZmjno8WelDvrVypNb2tRhWijG
         ddRujCHh/kfrIAJh3AjVSei8v6fhMigviC7zp7+C5v+HBNhpoq8FTYwR+jMCp8rz5UFY
         EbXvL79tVZsz8oN/6XUgfdXyTg6tTR3US3kTFBd0GUP5o3jXB6nVJNFwJINNilBdo9Aj
         zyu+TDL99y+eNs6VGsxGwe+xvwCkcM3IlZNDUWkCnzmvPeuyyq38EGMbtz1Kw7WAd1RX
         fFAyTEj1lT8iMj3RjWSIPc7IZGPQyz2KHDrioA1KSgGBOdQDM0Ni+ubWuLMi+H9dvVXQ
         fb3w==
X-Forwarded-Encrypted: i=1; AFNElJ8kIc32eI5gQlm19kq5qBMxQ3vaefpd0X+UwGsrF2l6knBn5eW0Z2O4t71CySSF7k0DGiMLQ/NavOlcS+jYrlg5F3PCzQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSLvZaGENE8R6/1wnoFkE4GZKA/a84TcFnqA3Hrc5z/YMQwEVp
	cYHCqKoZb+/od2BFJjybc7ACdiTgo6bICCcJ3IBAbkwzQMyVYc8sYbKm
X-Gm-Gg: Acq92OGPBmh3jAv4Blp6rwi2pBRo0QL6NHsmWZOXNvwD2hQXCsTYW/dV/v29FGrcbcY
	MAK0MrgbTC0po2ikWH7j8S72Nk4iKgBP2oHoeQY+w0cxI8No9/SnUSUOSPhfvzuHyiddi5qQT11
	GE5dqFhF7136oq+YdXkDZc6iMmVkVbvCEKDl2LYzH/Fo4d2zsdVx8ZEO7DDs4gwVRYTqt7s5swn
	AVkufpNhJvDQDwKNp1Q0PaFSuXdV6nfHFiKHfTvJQIiXK+L2kckwzIeGHmsIxfc3g7xv+de2/fO
	hKiS+Rz2ambJ1dd8pvjkGagls2JS4RgSDmxECXMkSFN+Uk6+UbReXax+Tfc8YMpDeRwB6QR1VcO
	PUALOFpUTBRAbBqyWSg15szxOC8Kpu1FWBy0XNj+XNjlFUZp0c3FJvpkjDshcNwY/43DyySbsOe
	/t4nbnlS8zx2l0eIWlrv729V9MARwSFsC7C71GkNn23CCvzE43IQkshW7V8LT3aSwL7Otd8xd2Y
	DsTB6fwUTM=
X-Received: by 2002:a05:690c:e3c8:b0:7dc:d9cd:1770 with SMTP id 00721157ae682-7de47474a55mr7395727b3.22.1780019557221;
        Thu, 28 May 2026 18:52:37 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:7a41:d368:8442:1cb2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6d1f3943sm1284717b3.26.2026.05.28.18.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:52:37 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v8 07/10] landlock: Add documentation for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Thu, 28 May 2026 21:52:06 -0400
Message-ID: <20260529015210.500291-8-utilityemal77@gmail.com>
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

Adds documentation of the flag to the userspace api, describing
the functionality of the flag and parent directory protections.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v7..v8 changes:
    
      * Minor wording polish in the new 'Filesystem inheritance
        suppression' documentation section; no semantic change.

 Documentation/userspace-api/landlock.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 138d504cb498..ae3136461b18 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -733,6 +733,24 @@ struct landlock_ruleset_attr.  It is also now possible to suppress audit logs
 for scope accesses via the ``quiet_scoped`` field of struct
 landlock_ruleset_attr.
 
+Filesystem inheritance suppression (ABI < 10)
+---------------------------------------------
+
+Starting with the Landlock ABI version 10, it is possible to prevent a
+directory or file from inheriting its parent's access grants by using the
+``LANDLOCK_ADD_RULE_NO_INHERIT`` flag passed to sys_landlock_add_rule().
+This is useful for policies where a parent directory needs broader access
+than its children.
+
+To mitigate sandbox-restart attacks, the tagged inode and all of its
+ancestors up to the VFS root cannot be removed, renamed, reparented, or
+linked into or out of other directories.
+
+Inheritance of access grants from descendants of an inode tagged with
+``LANDLOCK_ADD_RULE_NO_INHERIT`` is unaffected: such descendants continue
+to inherit from the tagged inode normally, unless they also carry this
+flag.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.53.0

