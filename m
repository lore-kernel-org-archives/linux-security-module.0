Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8247431A4C
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512665; cv=none; b=o08u1h7qkIN7Xx9bAVuHyTYNx50H5HCxGGhjzyisi5vEmMSqb5TUtEvuJhXj8H5m/5MSnaGPW1METyPbwvyFoaiwgs58Z6ifxtUK9EByPIZquntvKLkjrvz+g1ftG6BHmyhpy8u+BDAcSf/XCudU8TEz1zNblnBNLoyr3FntXeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512665; c=relaxed/simple;
	bh=ohsvzr0bDfR1gg8p6/BHmzCiAYVxI7fDjAikygk28Qo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t7g34mF35Ua74fcNXWHH/o32kDzlmhE3v8QOXuPk1PHsemfJTAp33qrV29KPICNpP8nPnKxK/2eUyDVFjgDhlO6QnTozcg+LX/eFkzGFgUg5oBwXwNET2BXs/xdpgHVN4xOCnjQqf4pGPw5DhXJvSEQsTvLNXTB3RuU9oqRDNcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVoysGQp; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVoysGQp"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47fd4ee0ac0so576568f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785512662; x=1786117462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n302gOEDGJsgCQNZcD6NmG1uCSg1cag0q9MjKiTpIzE=;
        b=eVoysGQpiNC+FWUzrUJaeELLseXg+uRN/eQB4EpExiPO4OX1Dqpf3YnAU7Ufd2/Ugt
         KYpDiJT1xWZxTjWTJVvjn82xsSkJHZ3wmGo4Qf7CVm/8eDhGXEKzNFA3tBUgVizCFALV
         IB7h9g6Tq0J571y4oA2i/dcuEs7d2PtOKr5pm2IXac0eCMaVZezFuYPFsmAPG57SC5VL
         xon8Q4Ac3cyJAHjmJDcje+q4ySJX0bTEbHCxwUbwCzM2XNQKDMyZ31awicsyOOsQxCiO
         K5KVKDK3sN3zPvctss12a3iN+9GR9Nf24zw8BFaQYbXS0a1gq+YB5F3NddYsKnH1QDfw
         agdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512662; x=1786117462;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n302gOEDGJsgCQNZcD6NmG1uCSg1cag0q9MjKiTpIzE=;
        b=fSBArk4QeLI/1vJGPEmysFCqDBhRaiKWHnKEIyEyGjaYazvGY9rrrYhhO/DbEZpsru
         Zic2hQoC0/WNYVJAuI6dPSayd1ZtkR4iCQ3RVECGdDUUvBq1XUBMiRwKpbyx+PsEJYY9
         vAGTP19MnIG0nRsHWccRq20r65zjLalOt++GlGRf1in9mCySNYLe09Zgb8yeQEpE05CC
         ECGRpKJ0b4blB0CUdg4wcz8lMgUjqN9JUFL+aWcDfAx+vu3hy926PN1C1OdnGih4eLdh
         N/t0HWs6eGVtiYn2MP98T5PrGPTaNOoYMzEtRDXmjmeXXmoGcke09Nwc0JCotPh2Hl6P
         H/fA==
X-Gm-Message-State: AOJu0YybB9dJUf+5j4KWADnT/2ouvrxzhUVnqCbhgkEf/pYAy2X3HOpw
	+Xf3pVEZzCJwxk8/FwUhmEzKfebNAIOCKLKNKfCuPdb06DEQtGHC4NmfEmYpddq5vJxWY8lWUh0
	4PDp4zA==
X-Received: from wrrw13.prod.google.com ([2002:adf:f9cd:0:b0:47f:5050:d6b0])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1a88:b0:47f:9486:810b
 with SMTP id ffacd0b85a97d-47fd729e718mr340007f8f.7.1785512661664; Fri, 31
 Jul 2026 08:44:21 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:43:53 +0200
In-Reply-To: <20260731154353.1790268-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731154353.1790268-1-gnoack@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731154353.1790268-6-gnoack@google.com>
Subject: [PATCH v5 5/5] landlock: Link the erratum documentation for whiteout objects
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The documentation embeds the canonical erratum documentation from the
header file, which is already a self-contained description of the issue.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 Documentation/userspace-api/landlock.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index 5a63d4476c1c..df996ccaee34 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -556,6 +556,9 @@ in the running kernel.
 .. kernel-doc:: security/landlock/errata/abi-1.h
     :doc: erratum_3
=20
+.. kernel-doc:: security/landlock/errata/abi-1.h
+    :doc: erratum_4
+
 How to check for errata
 ~~~~~~~~~~~~~~~~~~~~~~~
=20
--=20
2.55.0.508.g3f0d502094-goog

