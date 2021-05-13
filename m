Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC984C43603
	for <linux-security-module@archiver.kernel.org>; Thu, 13 May 2021 19:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855BF61433
	for <linux-security-module@archiver.kernel.org>; Thu, 13 May 2021 19:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhEMThe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 May 2021 15:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhEMTh3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 May 2021 15:37:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F13C06138E
        for <linux-security-module@vger.kernel.org>; Thu, 13 May 2021 12:36:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d20-20020a25add40000b02904f8960b23e8so23333388ybe.6
        for <linux-security-module@vger.kernel.org>; Thu, 13 May 2021 12:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Pnc5KHobM9DAhbBV5Sa6uLIgYm7GRUmsgARd8oXUtk4=;
        b=qdj8z0tyEapRCEHGj+KqH2QK8fxUKn095Z0UBOLAKAgycVvBiBNVt2kKMcJWcvk/cQ
         wK0mHvVQb2X6oSreOivh0vEomGETKVOHSufNjH7VGxNjQdSWPGwavzmcmPsIksEN0G0W
         hP/6gu0onwU9JCa10hobeWljzWfrZUk8EdxSo560sTdlefkm2oJ5/nPOVC6onKi2Hzdt
         jpZUNhLDPHsyKKodSZ0kveeWiwUU50nyttaA5W1WxoehIkq8rBockN2XRP23bmfpK/iK
         J0DGje01/GBKdppsjXnrDivp5UePhi2kdqiqxy7alTou8wAldXYekxZSjAB7EocsJ6m1
         XYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Pnc5KHobM9DAhbBV5Sa6uLIgYm7GRUmsgARd8oXUtk4=;
        b=jNceXkNYVP6IQo1+Bs4/hWpAUOga32vcQmu6vOuYw76gvqnNUHF49PvxOI6uJAISp4
         auqgvzIyvBuqf5xVeETDzh4Q1rDKOPb2K5mWfMA7XgnGKc7FIRWmeA/eGM1HdNEfJl/Y
         dTLraa8/mmv1AqDqTX3D9EBYDnKfHp+WKul2gyVyYyr4X56tSBQv+VQSkL359SvrJprb
         XtQB0kLE7LSpcA8sWz9NhEPboRSh77cduXU3IojX6AaJvS0NFNBfEiObAamyrLYCLcim
         isGhaosAM+06HyuRV9+SBceEWTrkhPZzMInvSMk+eixEZjHNQZyc/twJzVswun7wGwdR
         w0VQ==
X-Gm-Message-State: AOAM531nc+0vpKs5442Pma/5tYyZLC+/356Ti7HMj7Sqgv8Igg/KrmUp
        tpzAupf58/N2hkytGRSvBBe42M4INfv5wA==
X-Google-Smtp-Source: ABdhPJx51srw5OAx9CYuU/ovSs3B51DS0yWNunkqHF3XEGT1k2yqzFkADqVwrM7QxX7nv8tG8T89tJDKhPATYA==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:5f61:8ca4:879b:809e])
 (user=davidgow job=sendgmr) by 2002:a25:4fc4:: with SMTP id
 d187mr58699374ybb.245.1620934578714; Thu, 13 May 2021 12:36:18 -0700 (PDT)
Date:   Thu, 13 May 2021 12:32:03 -0700
In-Reply-To: <20210513193204.816681-1-davidgow@google.com>
Message-Id: <20210513193204.816681-9-davidgow@google.com>
Mime-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 09/10] apparmor: test: Remove some casts which are
 no-longer required
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

With some of the stricter type checking in KUnit's EXPECT macros
removed, several casts in policy_unpack_test are no longer required.

Remove the unnecessary casts, making the conditions clearer.

Signed-off-by: David Gow <davidgow@google.com>
---
This should be a no-op functionality wise, and while it depends on the
first couple of patches in this series, it's otherwise independent from
the others. I think this makes the test more readable, but if you
particularly dislike it, I'm happy to drop it.

 security/apparmor/policy_unpack_test.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index 533137f45361..03f78a41ef79 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -177,7 +177,7 @@ static void policy_unpack_test_unpack_array_out_of_bounds(struct kunit *test)
 
 	array_size = unpack_array(puf->e, name);
 
-	KUNIT_EXPECT_EQ(test, array_size, (u16)0);
+	KUNIT_EXPECT_EQ(test, array_size, 0);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
 		puf->e->start + TEST_NAMED_ARRAY_BUF_OFFSET);
 }
@@ -313,7 +313,7 @@ static void policy_unpack_test_unpack_strdup_out_of_bounds(struct kunit *test)
 	size = unpack_strdup(puf->e, &string, TEST_STRING_NAME);
 
 	KUNIT_EXPECT_EQ(test, size, 0);
-	KUNIT_EXPECT_PTR_EQ(test, string, (char *)NULL);
+	KUNIT_EXPECT_PTR_EQ(test, string, NULL);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
 }
 
@@ -391,10 +391,10 @@ static void policy_unpack_test_unpack_u16_chunk_basic(struct kunit *test)
 
 	size = unpack_u16_chunk(puf->e, &chunk);
 
-	KUNIT_EXPECT_PTR_EQ(test, (void *)chunk,
+	KUNIT_EXPECT_PTR_EQ(test, chunk,
 			    puf->e->start + TEST_U16_OFFSET + 2);
-	KUNIT_EXPECT_EQ(test, size, (size_t)TEST_U16_DATA);
-	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, (void *)(chunk + TEST_U16_DATA));
+	KUNIT_EXPECT_EQ(test, size, TEST_U16_DATA);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, (chunk + TEST_U16_DATA));
 }
 
 static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_1(
@@ -408,8 +408,8 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_1(
 
 	size = unpack_u16_chunk(puf->e, &chunk);
 
-	KUNIT_EXPECT_EQ(test, size, (size_t)0);
-	KUNIT_EXPECT_PTR_EQ(test, chunk, (char *)NULL);
+	KUNIT_EXPECT_EQ(test, size, 0);
+	KUNIT_EXPECT_PTR_EQ(test, chunk, NULL);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->end - 1);
 }
 
@@ -430,8 +430,8 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_2(
 
 	size = unpack_u16_chunk(puf->e, &chunk);
 
-	KUNIT_EXPECT_EQ(test, size, (size_t)0);
-	KUNIT_EXPECT_PTR_EQ(test, chunk, (char *)NULL);
+	KUNIT_EXPECT_EQ(test, size, 0);
+	KUNIT_EXPECT_PTR_EQ(test, chunk, NULL);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->start + TEST_U16_OFFSET);
 }
 
-- 
2.31.1.751.gd2f1c929bd-goog

