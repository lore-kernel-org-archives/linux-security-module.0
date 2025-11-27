Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D0432E73D
	for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764244333; cv=none; b=R0owVjVmjAhnnubNJ2VkcQrCHv565Q4KDbaGA3qYGBteO9ApNfv3wAGQ23EOjQFDGj7UJtQ553KwdmNXXcl06U4Usnsa8BITBMlx9YLtCu8b9yzzhvOveqNbx3tX+u2/tdnQh3RVFIvPFCdLLavZo68o88wnTK8Ue+KbF0wbnQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764244333; c=relaxed/simple;
	bh=E4+VOev7ntVInLoGUgu0QvL2Aj12H2FR+DYid1rY8Xo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mkXwlPgkl4Ytf8FYC3r+VCggfOoK5QqKNLgRbJdDwIBrNS/PmT5ouz91yYgBwup9F4Ee5B955ZtYLuIJTqSZcMhUYhFHfHmTp2BCPj0bg65OokzEdOju6EUGQsNyYHzeMvN6fBQC2G+DmPghXpjEm6RlrlmUQhZFDNrRRdqEyn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NhPr6d2K; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhPr6d2K"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so5968475e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 03:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764244330; x=1764849130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJ2dEwNUNH5jUyUdNyD7xKzQwfzrE23av1HE0ybWK9M=;
        b=NhPr6d2KPhnTiybn7OMHFCkM7GFt86FYuAv4giMlbJR/yI9luseG5WaV4JDLQ+JihQ
         db1byWbrcddDH9hXKN0/Olzpcoy3TUH9izx8UeF4tybBVECyzYIzB+UgUjxsrKyYSA5S
         JGlD2I2XrKFnmIho4O9Ph6Ts8MWptBnBsWY7c1dB7xeIdpcWlVr35fDSc9+tg1ZqZ0TI
         iXMj35yYErbFHEC/8c67kHb1EmEvL9XBbIIfln8JUSgQV7qyK+90yqxJRC+TIwDzzfqz
         RwW+cXC049DlRrl3kLmZPUr0jJ0DL8BCJrxuaJEZWrcahqujmNB1yznTrT0EshIb7LJO
         vlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764244330; x=1764849130;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gJ2dEwNUNH5jUyUdNyD7xKzQwfzrE23av1HE0ybWK9M=;
        b=sIi3bSaxzCKXoC8fU9a91d3jzeU+AY5PNOXmgm2ySIotxCCNKv5BZBuEbpfMBmaCdV
         HIT0k4UzqCuu/ig3+8lMNYc+BI/agGfxxZV9rcI+t1v8R+w/6vRRjiVSuLhKKyXaW/lE
         tmNXG2Mzcc+FzECoVBXdlxuPuXgcpacrinypmjeh4+J+W5H93lK+xcg4XVARcco69QoE
         0Q+zWvBPkfz0QtZSOfMjS09iHviYqDoc8pjjuLXETnDumysdX5Ok/Slpm0sZ2nC/Hk+e
         xLqhfh/w9tosromHnLf4DiEO/0X4qRfVdzT9PVH8rLa/6PW1pSRIfU481ZF9PmvZv2B8
         REdA==
X-Gm-Message-State: AOJu0Yyc2NK7dUBJL+cyHn4jldEcYExVZU31MiUPkP7/SSpJroK5tnJl
	gwYrlraiYsU5lmOUF8HR6MYuoiu4p+vo0XiMCC/BO3A4ytxV+nOYHlr3jQHxkp9umXbXZZaZ2ej
	vj+H8XzpLnQO4ukSmcVM4zGXhVqbpg0C3ImQLyZnnXXikL3K9PP98m05eTsp8Au21QwTOQfppHC
	NpQuQqj937QK/K8b+yuGKPubVdoHRqfo5sLgoB/Athhi0E8JaLKvKgxbr3
X-Google-Smtp-Source: AGHT+IG62YFzLrPtCp19ADtvM0nr6L2CBSYK870AQMIvmx0QMCOBardW75Fs1G4sxjHevz0Hk3e5cuK0qcQ=
X-Received: from wmco13.prod.google.com ([2002:a05:600c:a30d:b0:477:9d88:de6d])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b09:b0:477:a3f9:fda5
 with SMTP id 5b1f17b1804b1-477c016e425mr179615445e9.9.1764244330632; Thu, 27
 Nov 2025 03:52:10 -0800 (PST)
Date: Thu, 27 Nov 2025 12:51:36 +0100
In-Reply-To: <20251127115136.3064948-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251127115136.3064948-1-gnoack@google.com>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251127115136.3064948-4-gnoack@google.com>
Subject: [PATCH v3 3/3] landlock: Document LANDLOCK_RESTRICT_SELF_TSYNC
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, Serge Hallyn <sergeh@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Tingmao Wang <m@maowtm.org>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, "Andrew G. Morgan" <morgan@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add documentation for LANDLOCK_RESTRICT_SELF_TSYNC.  It does not need to go
into the main example, but it has a section in the ABI compatibility notes.
In the HTML rendering, the main reference is the system call documentation,
which is included from the landlock.h header file.

Cc: Andrew G. Morgan <morgan@kernel.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 Documentation/userspace-api/landlock.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index 1d0c2c15c22e..f1251da9877c 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -604,6 +604,14 @@ Landlock audit events with the ``LANDLOCK_RESTRICT_SEL=
F_LOG_SAME_EXEC_OFF``,
 sys_landlock_restrict_self().  See Documentation/admin-guide/LSM/landlock.=
rst
 for more details on audit.
=20
+Thread synchronization (ABI < 8)
+--------------------------------
+
+Starting with the Landlock ABI version 8, it is now possible to
+enforce Landlock rulesets across all threads of the calling process
+using the ``LANDLOCK_RESTRICT_SELF_TSYNC`` flag passed to
+sys_landlock_restrict_self().
+
 .. _kernel_support:
=20
 Kernel support
--=20
2.52.0.177.g9f829587af-goog

