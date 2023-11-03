Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B3AC4167B
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Nov 2023 15:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjKCP5k (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Nov 2023 11:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjKCP5j (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Nov 2023 11:57:39 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F63D4E
        for <linux-security-module@vger.kernel.org>; Fri,  3 Nov 2023 08:57:36 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-5411a36a37fso2719538a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 03 Nov 2023 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699027055; x=1699631855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6BXobpp4sPDST4BqTcqb5616NyPMhrIjRqGtfUtN18=;
        b=Dt3Yl9HCsrU4amyJChUBftK0tRbst+rdHzunPbnYQ3/XGSMcbTu7HvW+HSoLuvQhV4
         NgrPRGJvpbIDJpmObu30fwrJ1E408u2qLDpjXZa55JFlNQl6fm89IBxb+/hCUtknQzbT
         p6mTdvMs/yz04Fpp9qQ4+KO2nelZOaB59Rs0jrvZ8My7epn6yDmLqB8HrykwEEopUArU
         HRBCxXwc2rKrxJYVgsM3O4mDGCFuEN6IpKQEAn+m+0XNQj0JBv8YHF++hNFLaedJGzPb
         v9UBbA7trUJn9uhpoK+nM0bgWHJSpySMpRh3ZOy0oLW0sEHAAgujwvLpONx254ip3jW4
         j9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699027055; x=1699631855;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s6BXobpp4sPDST4BqTcqb5616NyPMhrIjRqGtfUtN18=;
        b=qIsyLvr0ms3HG3IeuNawZe5jPoE2Azn3IXCyLTLr1L5AxdMf8inqmbaDn5XNGDKqxf
         j6wqT6k5qNeGBmzD4D+lIFfhigMULOtHKtfRXvblJbgHJ6UhrQWsko2+iYhLx8gSkOMG
         iMSkX9/1uxSxNW70DQyThdcZeCqTOya8xMtUNLGVw4wrC4DB/+fFI7uZR4TCMILrPOBX
         6EWvTm7I5y+FMQ2y0G3DrDTRv/nl+4x+4klotIudJOMVfSx5M2XfVSHKwePbZEsehRkM
         i93YQ/h+b+Xyj64fCHm8zvV5uX+VA8exWL8SrI6RuVxAhp3eHqxpFyjaToMCjxlQsE78
         aWXQ==
X-Gm-Message-State: AOJu0YwaWjs/ZyZhHqrz8j36bovMGIlWlqD8ciuPhhZuYXaLXaVBvMIa
        M4DCisfgItncPQ4t/lxluoCH8YRPyWHd3xgsphb2CygZMHHGaZwPaBu2gim0ig6SekFDK0irU0h
        VK21VPieRef/A6Wj3gfTlzQ5O1rBc9ebMOyILiAMNkGugEvutMFOMCBfoAFujtJOg+6ZNhJSh7h
        7bMmIh+Q==
X-Google-Smtp-Source: AGHT+IH3Zh4iRAyCpfHS5ZF+J3OqKDW0BOVI3/9VrmNUI86MZogwKLyG6Lha7P7zVEEk42aQQZEi3QTPqkQ=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:7ddd:bc72:7a4a:ba94])
 (user=gnoack job=sendgmr) by 2002:aa7:ce03:0:b0:53d:ad8a:b0bd with SMTP id
 d3-20020aa7ce03000000b0053dad8ab0bdmr36531edv.3.1699027055268; Fri, 03 Nov
 2023 08:57:35 -0700 (PDT)
Date:   Fri,  3 Nov 2023 16:57:11 +0100
In-Reply-To: <20231103155717.78042-1-gnoack@google.com>
Message-Id: <20231103155717.78042-2-gnoack@google.com>
Mime-Version: 1.0
References: <20231103155717.78042-1-gnoack@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 1/7] landlock: Optimize the number of calls to
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
index ffedc99f2b68..fd348633281c 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -724,10 +724,11 @@ landlock_init_layer_masks(const struct landlock_rules=
et *const domain,
 	for (layer_level =3D 0; layer_level < domain->num_layers; layer_level++) =
{
 		const unsigned long access_req =3D access_request;
 		unsigned long access_bit;
+		access_mask_t access_mask =3D
+			get_access_mask(domain, layer_level);
=20
 		for_each_set_bit(access_bit, &access_req, num_access) {
-			if (BIT_ULL(access_bit) &
-			    get_access_mask(domain, layer_level)) {
+			if (BIT_ULL(access_bit) & access_mask) {
 				(*layer_masks)[access_bit] |=3D
 					BIT_ULL(layer_level);
 				handled_accesses |=3D BIT_ULL(access_bit);
--=20
2.42.0.869.gea05f2083d-goog

