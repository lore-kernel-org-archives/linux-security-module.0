Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DC8C072A2
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Nov 2023 15:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjKQPth (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Nov 2023 10:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjKQPtg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Nov 2023 10:49:36 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED37A5
        for <linux-security-module@vger.kernel.org>; Fri, 17 Nov 2023 07:49:33 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5c88b8b5367so6774397b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 17 Nov 2023 07:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700236173; x=1700840973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUQR230Th2KVt3Dfu08HOgX0IUW01YM78cSblFoPosM=;
        b=HwD9QI7PMriII0wgYsOrUaAWmcmmpEjfGbLh+yiJvqN9N0WNFAcc/PsLLawINVWFCf
         ITg3bL3XCmz16Jk0c3GZDpbsfqedSs5fn6jiIiiR5eUiekfrC828ahlf4iZPOdV/7LDh
         6rMvB5CXg8Oty+SxMgE940oXRkFlp4t3hHnau4hWDcYmRGOZmYold0qZSjyZZd6puR+p
         Xx52ex6F/bfoTKeS6jOA202rF2223Kcs8joHRGQcEXNsgWgFOvVNNt7Ylw4sgC1S3EkN
         VPaCkHQE5j89Xg7X/AMHRnvbGR8TidLzK2RrffzR5KLxYsxzoeC2x+gcvi9hj5KtDL/Q
         twhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236173; x=1700840973;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUQR230Th2KVt3Dfu08HOgX0IUW01YM78cSblFoPosM=;
        b=aoKIn6KCEvO8otHKtLYTN9OMPNUBtTzYzotXwVnuhYFP3KUY9ih1avRo7LfkTCwNfa
         x9xOvWYAGWr3/nESrJYdlsccA2GdtbN683hMEgOucS2tXAeQV8EyAqVj2L9vlU4jKJlB
         6tbtVth4yUZ36W+UYYWQyRTP1gvEqi98DFESf+vzOR5qstgY2WUpU13PnY9tZDvjb2eA
         Cu7br6JoiMusC3nF0F9UqW8v2I6Efz0OMdOwrH6l6xUAkR/KezsN6vAqtxEgkqRhfE6h
         ZKuxn6P0MD5xwrXDUVk6FJUIhq9qFoeAx9SWj7uYRdwCeNpzY7Kcy0wTiVBklKT+g4Z3
         rU+w==
X-Gm-Message-State: AOJu0YxnW5vj1814wcnaIt5TSBGjiWexPaQFvl/ugnH7cslmuujyVGmY
        xcHmxI8KyfvYroFmCUOoEvrrTNDPQhhS0f2RQsUHT4oxq2daMPqEA3Ruu4HwMebtcO1pJp/1/ZU
        92AJQFAlhq5c2RSBN4qhdOVHArZLPkEexKKDgBCg0wIOiymeoFP+0R/eKMYhETj26+XZU6M3kGg
        LJ37PZiA==
X-Google-Smtp-Source: AGHT+IEL0KN+UN641Uljfkbo9Y8VJux8UtnfrFtKYw25d9lH69ZCE1Akdny0XuTJKn9ys7mvg1QxeivIUMo=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2ae5:2882:889e:d0cf])
 (user=gnoack job=sendgmr) by 2002:a05:6902:206:b0:d9a:e3d9:99bd with SMTP id
 j6-20020a056902020600b00d9ae3d999bdmr460875ybs.5.1700236172782; Fri, 17 Nov
 2023 07:49:32 -0800 (PST)
Date:   Fri, 17 Nov 2023 16:49:14 +0100
In-Reply-To: <20231117154920.1706371-1-gnoack@google.com>
Message-Id: <20231117154920.1706371-2-gnoack@google.com>
Mime-Version: 1.0
References: <20231117154920.1706371-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Subject: [PATCH v5 1/7] landlock: Optimize the number of calls to
 get_access_mask slightly
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This call is now going through a function pointer,
and it is not as obvious any more that it will be inlined.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 security/landlock/ruleset.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index ffedc99f2b68..23819457bc3f 100644
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

