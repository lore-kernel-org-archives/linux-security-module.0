Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9D2EB64DD
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Jun 2023 14:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjFWOov (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Jun 2023 10:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjFWOoV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Jun 2023 10:44:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D0C2961
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 07:43:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56ffa565092so10456047b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 07:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687531431; x=1690123431;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ldydpS+kKCqw7pjyMr2oDwYIVs3m8dRPb+QBqBl/PQ=;
        b=QnNZpV9A1GzVWhS8LGM7I9unsf1mmge/3YU6lInAZ4vvPM88STLC8cjhMxf3xI1D5+
         qMGwQqBtfPeDdiM+b7XM2f7disCu5hnl1PZwAlp9HBLpBJ8Xdm1uQnaRY7UrYhSrQ24D
         etYZKypP1ASViqSZGW/Z5WPjjCKZ9z6/lyz3LD6ZtRBER5JMbz/BMHxOu4x/TH6PSejy
         oq7ntw37z7dbKZkoyLypWJvsbxFYTfIJHmWgwK2GQey+gWOQNEQlDQnFU5L4lzI95d0S
         p8dmZnPbdH0tYt7+8qzkYWhiqG8cxEI+rlZzqvRWXBuyTKV0cg8EBHT7iT3gsWFf0k+W
         FTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531431; x=1690123431;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4ldydpS+kKCqw7pjyMr2oDwYIVs3m8dRPb+QBqBl/PQ=;
        b=F+wj2jUHhFKWEqaZyBt0nP86dSGvKi7XMyxBVOg8nahUcHw2uhuXZagAb5og6Z9BR1
         bG7oybDNLDtcEyucNqTAelX3OLaB/x24qRBeF6tKM2qncjcsJ2MmGKg3nuA551/TJsxI
         mO/fmhIeVuRQfaELH9H74E8lLRT0DPhsvgqKeVGVXKmhyzUmCQSNRxoOBdiYy8huPpKe
         nx0ClwAbKNfoKNkH+BH85VtwTZA8g/ca049bscckYJsx4l3v9N4h8/5/edmfU4jkUDrl
         aP070X/s8vZxPVp8XY3ptG7MH6p9WbTO5PaGBPGN8lowUHtGhfO++vkxdDzARIfhoEl0
         4NmA==
X-Gm-Message-State: AC+VfDyXrp+rL7DWz9/6ViXqgtPtNw7N5p+WRfip4UFqv+XgJav1yHf3
        DHQp6GGkiEp/RUJb22B768vz2lg0+l/h1RQIFZj9lvlmMYeov3Csg+wsQ+3J8iwlGWXxbtizQCi
        xSks7pk8P0Bo63u+J5crjmvJKyeP2fzIjMgcKNb+lms33knGj4+sPRzkzCGfxAr4eZZ9PB9S05D
        fC+cVuiA==
X-Google-Smtp-Source: ACHHUZ401tRoVCak4f99OWh882MFvXdUVKVDovg5nKphtP3uRv/Rg2lyMPyXwHJA0OaDPkuyfP/tdBekZWI=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:8b55:dee0:6991:c318])
 (user=gnoack job=sendgmr) by 2002:a81:e703:0:b0:56c:f8b7:d4f7 with SMTP id
 x3-20020a81e703000000b0056cf8b7d4f7mr8586947ywl.6.1687531431688; Fri, 23 Jun
 2023 07:43:51 -0700 (PDT)
Date:   Fri, 23 Jun 2023 16:43:28 +0200
In-Reply-To: <20230623144329.136541-1-gnoack@google.com>
Message-Id: <20230623144329.136541-6-gnoack@google.com>
Mime-Version: 1.0
References: <20230623144329.136541-1-gnoack@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 5/6] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add ioctl support to the Landlock sample tool.

The ioctl right is grouped with the read-write rights in the sample
tool, as some ioctl requests provide features that mutate state.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 samples/landlock/sandboxer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e2056c8b902c..c70d96d15c70 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -77,7 +77,8 @@ static int parse_path(char *env_path, const char ***const=
 path_list)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
=20
 /* clang-format on */
=20
@@ -162,11 +163,12 @@ static int populate_ruleset(const char *const env_var=
, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
=20
 /* clang-format on */
=20
-#define LANDLOCK_ABI_LAST 3
+#define LANDLOCK_ABI_LAST 4
=20
 int main(const int argc, char *const argv[], char *const *const envp)
 {
@@ -255,6 +257,10 @@ int main(const int argc, char *const argv[], char *con=
st *const envp)
 	case 2:
 		/* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
 		ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_TRUNCATE;
+		__attribute__((fallthrough));
+	case 3:
+		/* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 4 */
+		ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL;
=20
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
--=20
2.41.0.162.gfafddb0af9-goog

