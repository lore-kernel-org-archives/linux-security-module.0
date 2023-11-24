Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hbMK9hG0"
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2702719A4
	for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 09:30:40 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-54aa99b8e4dso1492794a12.3
        for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 09:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700847038; x=1701451838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cE5rDFH6x5j4SoKk4DtVJx1DhUKwtpy6ptWA1YpaYbc=;
        b=hbMK9hG07y4xsOwCBLf2mCkaVBU2eI8Vmkh1TsB1CzqRUIeusDsFLTrQzHq1mjd0XY
         MacG7AIZEbySfS4dFT/aI5OzB5F7ZxTWtjusc71+VjfzOJ7FgVbVWFJmr0TreCEL5cJi
         QYPVvvCqCXRwrdsWHASyZjBWWGLSMM0HJ8EVxpKI/YJ/LDQVG+KYvMznTMiM3QQSGxOF
         qLctIFcEShT8b7FedfgFDiKTcjwI9F7zve1jB1w2MRTKVsXgKMAUYVtnZG3a3OStBM+4
         yrl1RJRDDgnVJXELOdbhCUPaXAbMqwE6UcY53D6cbk+cVNQlFROcNZgG4mYcbvt8GC0D
         9flQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700847038; x=1701451838;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cE5rDFH6x5j4SoKk4DtVJx1DhUKwtpy6ptWA1YpaYbc=;
        b=kgVEZ4aicFFFNRlHhnvoVcY50AI3dB+vi2OZat+eBZcCH/u2FJBvX+zxjyn1S332NB
         +snwz5ryFKuAWbDqPV5kxN+xZxnh6BN50bwF890Pn0fvZ+JCMWyIQMOTKF12xd+kL53f
         YUApghuQwCpEi85pI7BUqgtEI8PO3OfjG3RSGw08gCOMR83OKuLOvkfWq0M3YRYaDMRs
         QBatT1UR/MjQl2PETISmHk0SKV0VfvRd07EcDHE/BmCuLQha84Kln6CNL9Wv73n7Wo9A
         yRkoIY6Di4vpcYJCe+GKn0n3GaMDjWTZm532fx3WWt+H/iC9fzSWxSV9N0pxdXINQexJ
         GlXQ==
X-Gm-Message-State: AOJu0Yw0wrj3kourgxCX8xE6xD3azx7Q58rtbwMdQlFr29SxRsreJ3Hi
	tJhKzj98SpYe6Nff+3gGgbZW4LNt+/GqWWXLf2DvE7lZ7nfhru20xS8dM4hy0h468YYtwaxq5iZ
	BuDW6SuuJ9S90Qxys4N4TscQ4NPr8H3q6TQezoMNRMB03A+WtnMoING4S4nRkGeT1LL23torpOx
	KUANsKqQ==
X-Google-Smtp-Source: AGHT+IETe/Dbs3vmeQMZmBig8gIXuHSA29s90JqKtKtH66znmXRynNfy2ka1k2f1tqw+AlU2RXXCzWLwV68=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9429:6eed:3418:ad8a])
 (user=gnoack job=sendgmr) by 2002:a05:6402:11c9:b0:540:37c6:677c with SMTP id
 j9-20020a05640211c900b0054037c6677cmr44850edw.6.1700847038708; Fri, 24 Nov
 2023 09:30:38 -0800 (PST)
Date: Fri, 24 Nov 2023 18:30:20 +0100
In-Reply-To: <20231124173026.3257122-1-gnoack@google.com>
Message-Id: <20231124173026.3257122-4-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231124173026.3257122-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v6 3/9] landlock: Optimize the number of calls to
 get_access_mask slightly
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This call is now going through a function pointer,
and it is not as obvious any more that it will be inlined.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 security/landlock/ruleset.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 789c81b26a50..e0a5fbf9201a 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -723,11 +723,12 @@ landlock_init_layer_masks(const struct landlock_rules=
et *const domain,
 	/* Saves all handled accesses per layer. */
 	for (layer_level =3D 0; layer_level < domain->num_layers; layer_level++) =
{
 		const unsigned long access_req =3D access_request;
+		const access_mask_t access_mask =3D
+			get_access_mask(domain, layer_level);
 		unsigned long access_bit;
=20
 		for_each_set_bit(access_bit, &access_req, num_access) {
-			if (BIT_ULL(access_bit) &
-			    get_access_mask(domain, layer_level)) {
+			if (BIT_ULL(access_bit) & access_mask) {
 				(*layer_masks)[access_bit] |=3D
 					BIT_ULL(layer_level);
 				handled_accesses |=3D BIT_ULL(access_bit);
--=20
2.43.0.rc1.413.gea7ed67945-goog

