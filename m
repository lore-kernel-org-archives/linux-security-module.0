Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwRgCFr+"
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED6A1700
	for <linux-security-module@vger.kernel.org>; Fri,  1 Dec 2023 06:30:58 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-542fe446d45so1594328a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 01 Dec 2023 06:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701441057; x=1702045857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzXi78AHjIIVJFmJ8Pjwy9iFwVciKDRlY3Gz48xNASk=;
        b=PwRgCFr+EHfmyv+nhM4HGbwmfpMWpxaRONDGpSDneN5eXd6JKGZ0c/+QEPjUaPZfGN
         PYH1pkTrC8NDHPAOj0PybwJ8rzy7hKscI17dcWDzBr7Iu2yuC0xEqg/itPfbiAXJoTcC
         RNAqwfJ2OTM2k+hzED9ydvrTJnTzP+KGyskVsltySpd9wxmg4ESZDr/csp5YnEF5FcCj
         0iwKFXjiowg8jZpWdGrw9bSfb4VDI4aMKPsTTMcpNj/Y6sndCr5PUwlfduD2VDJAcWe1
         uH2N1705J8BkMfNB3DAnhxLLp7HChyJ2NKwyOykIFvoDW2cHFk9TbLjczFxkkoaGStPa
         Sg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441057; x=1702045857;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NzXi78AHjIIVJFmJ8Pjwy9iFwVciKDRlY3Gz48xNASk=;
        b=G6jxTtt+ZXPQwpi5JTFAeZKnQkXyXEcRp4jMu4Bxgb+V82mitVYuy4vrXZBbeVf8rq
         eMW1czj8adLxrlXD69WTcnzMW1GqWsbl4rEeoFv38YymU7293MuFZ0FBFfJ8Yx2VhUZm
         qZUeEsJC0OlcHV7Y911om/flwgQoTmcHycELtr5FBg/OL2AQ0B9BI88ackzelMCSHjhL
         9A3PyGL10D/kKZ0jLAEgILqEGHuC7063ZhrstIt5PfXuPyi6COerdFeFdCSTCtO5Pxpe
         XU5IE/oLH2retf8tM2rJ3auXLF2T3qq8fHA/vw3XZm9XQphxNaV4In+4k9ALECmgWjCM
         hDEw==
X-Gm-Message-State: AOJu0YxmMPpAAAn/vNtPDNlpO6Xzim6W/xhzWmkGmTMMmbdiXwlBfD29
	eIBLxdROCgScje+9TbC809M6/jM5JEvOrRizj4D5LHWnB/i0yRMqao4aKbd17aGNHIHm/7fEYTg
	WCGXlPfIuB2SQyZQ8MUY2hBesKpr3WmC8YP9taNpy2rbJ/T+EzbUXlspGAeWyF/8o2Tuc+t4vfA
	bEofv4Cw==
X-Google-Smtp-Source: AGHT+IHrfjV9UWblloFL5FiPtnKNBSA+8TPUWL6LBb0pU0Mkj2XV9draZ8tZxUqjUfruJWzLqENcfHs7u8Y=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:fab0:4182:b9df:bfec])
 (user=gnoack job=sendgmr) by 2002:a50:fb81:0:b0:54c:6fc0:484d with SMTP id
 e1-20020a50fb81000000b0054c6fc0484dmr2579edq.4.1701441056664; Fri, 01 Dec
 2023 06:30:56 -0800 (PST)
Date: Fri,  1 Dec 2023 15:30:36 +0100
In-Reply-To: <20231201143042.3276833-1-gnoack@google.com>
Message-Id: <20231201143042.3276833-4-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v7 3/9] landlock: Optimize the number of calls to
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
2.43.0.rc2.451.g8631bc7472-goog

