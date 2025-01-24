Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E8A1547F3
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733503; cv=none; b=N4eq9krqpCJ8pOU/nqMvwYXhbR58w+V6lopjmg5TR5aziPk0LRgm0I7bGtRrcgsbmqDFI678G5H3sh5qIm2XJ8hRHWBIDu4ItbVTpQ1vsGWnLtN8ZGXdLq5arFN7G83TNuwnETS7SQ66wON8DoVuTrkZhdJgk8iX3Y5kMO1FO0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733503; c=relaxed/simple;
	bh=Cl/a/gPKAs8Z5B02O+vIIpPKsGcqpvA8q3YcAkQBuw4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O6d/emIgCJlJc8w5NrYGC17Xhrt/wLlwfEUAeD5ax19nmoXohVZrmLoO+B5hxYqiDyzMZkRHkvGm2XpwOOX8siW1exsoqwW5XHijc6zV0LWEZPnWc39aaxpO82xSaw0zS6aLe+FcfYNZYeWAE9ZRRxYz44nmM+yuLhnI0LsFCzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zRhlLdsx; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zRhlLdsx"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5dbf25864a9so2497036a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 07:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737733500; x=1738338300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HLF5LMiubeHOgTqo99zX9va/k473tzgX63mo49lOwYA=;
        b=zRhlLdsxCGw9MmHfkpAWUWsbRNPCCCdKwtQNdl0g/RvVRcOYDa09qg9jZ+OI4xaBbR
         A77pSrH2uIbwWWOoHSGEIP/MUVQvpO3s8Wn3byXT+3m1j+RGHvmETB2TktJ0h01yIR0l
         GOHGw8Ep4EzkmpodrbyhMeWD8oTLL+xI7bq8cIdPb8NHZK1QukYJB/4Vq15FCdI11/UB
         9ZzHzaMCVhHzXIJPUwRrOv4eyyHJY3iv0wcTlUsx++s18WYblpUcox7tAlGzlmE5h1D+
         EHfG3MoaXE7nmebXr3VosgXSkz8xVGoG0sd6wGspWS8GU9+Z52Kjm8hjH8nAusDpRVX6
         6YLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737733500; x=1738338300;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLF5LMiubeHOgTqo99zX9va/k473tzgX63mo49lOwYA=;
        b=K7ixHFmQ6k3TIs3zB45y+S961gI73DDAVCrg8OmSNKQJ/S1PF97PAB8u2VIIV7klbk
         AJ3GSKXFYYHyTbxgUyx7ktUIpV3HVRSTu+BZOX+X7YxuxdxozAukhqMLXNQLYVE+FmuI
         TxNT9w5azNm+YGQpQacPYhkkLxTTd5lUoy7rpmBqbJQBqTkJV8y8q4BRsL9ol764aE/d
         3rk8+oCELq1KP1X8PEyiN0MLIpLeENnHRzL0R2cxQPndjVsLfNMu0+duLx68L7mQ/wUD
         t8jXmksONZyw9VK26U58L8QO7U8DSgNNoWCakbGmp7oBieGvPSV7+lEjM/jvqJeVLjCa
         EkMA==
X-Gm-Message-State: AOJu0YzEpxBHKK6Nk7wILNPixYWnLFwJR05jNYSjtJsrQpqthOXUAOCO
	+GBoVnxtlTeKjN4+bvmc1PfTzQ61vtPcMvl+y5fvOcteuhjpuarQ7xfr8Ald0VmdY2Kjrhl+CoY
	FJ9Fbi3S2ZnFb6uPnQN0/XW9fa7Jqwapud0V685Bj1f2oY7SnfNQnBOlY/cHCCCIl6tVzLHYq+7
	bUPwwj4+aPhshpQRdTSylvr4w2UV52yKNifIoRaBUV5ygUuqFNAODV
X-Google-Smtp-Source: AGHT+IErstpsPBWU4GJ3Sraq27yBe2cFNfbU55/PrXsiUqPp5vbK3AwNrDsTV7i56dRs4BCybAemZrMSaVw=
X-Received: from edbel15.prod.google.com ([2002:a05:6402:360f:b0:5db:e8e8:da25])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:c993:0:b0:5db:f5e9:6749
 with SMTP id 4fb4d7f45d1cf-5dbf5e968d8mr8509417a12.6.1737733500356; Fri, 24
 Jan 2025 07:45:00 -0800 (PST)
Date: Fri, 24 Jan 2025 15:44:44 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250124154445.162841-1-gnoack@google.com>
Subject: [PATCH 1/2] landlock: Minor typo and grammar fixes in IPC scoping documentation
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org
Cc: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Tanya Agarwal <tanyaagarwal25699@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

* Fix some whitespace, punctuation and minor grammar
* Add a missing sentence about the minimum ABI version,
  to stay in line with the section next to it

Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Cc: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 Documentation/userspace-api/landlock.rst | 4 ++--
 include/uapi/linux/landlock.h            | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index d639c61cb472..ca8b325d53e5 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -329,11 +329,11 @@ non-sandboxed process, we can specify this restrictio=
n with
 A sandboxed process can connect to a non-sandboxed process when its domain=
 is
 not scoped. If a process's domain is scoped, it can only connect to socket=
s
 created by processes in the same scope.
-Moreover, If a process is scoped to send signal to a non-scoped process, i=
t can
+Moreover, if a process is scoped to send signal to a non-scoped process, i=
t can
 only send signals to processes in the same scope.
=20
 A connected datagram socket behaves like a stream socket when its domain i=
s
-scoped, meaning if the domain is scoped after the socket is connected , it=
 can
+scoped, meaning if the domain is scoped after the socket is connected, it =
can
 still :manpage:`send(2)` data just like a stream socket.  However, in the =
same
 scenario, a non-connected datagram socket cannot send data (with
 :manpage:`sendto(2)`) outside its scope.
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 33745642f787..048a2c77c4eb 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -268,7 +268,7 @@ struct landlock_net_port_attr {
  * ~~~~~~~~~~~~~~~~
  *
  * These flags enable to restrict a sandboxed process to a set of network
- * actions. This is supported since the Landlock ABI version 4.
+ * actions. This is supported since Landlock ABI version 4.
  *
  * The following access rights apply to TCP port numbers:
  *
@@ -291,11 +291,13 @@ struct landlock_net_port_attr {
  * Setting a flag for a ruleset will isolate the Landlock domain to forbid
  * connections to resources outside the domain.
  *
+ * This is supported since Landlock ABI version 6.
+ *
  * Scopes:
  *
  * - %LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET: Restrict a sandboxed process fr=
om
  *   connecting to an abstract UNIX socket created by a process outside th=
e
- *   related Landlock domain (e.g. a parent domain or a non-sandboxed proc=
ess).
+ *   related Landlock domain (e.g., a parent domain or a non-sandboxed pro=
cess).
  * - %LANDLOCK_SCOPE_SIGNAL: Restrict a sandboxed process from sending a s=
ignal
  *   to another process outside the domain.
  */
--=20
2.48.1.262.g85cc9f2d1e-goog

