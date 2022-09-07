Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF65ECAAA1
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Sep 2022 01:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiIGBSV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 6 Sep 2022 21:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiIGBSU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 6 Sep 2022 21:18:20 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBFD86070
        for <linux-security-module@vger.kernel.org>; Tue,  6 Sep 2022 18:18:17 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id b21so76118plz.7
        for <linux-security-module@vger.kernel.org>; Tue, 06 Sep 2022 18:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=M21ssd+SCSSsGeh27JWFSofpx9BWcRpnZarG7AT/Oog=;
        b=KIp7sG710pR+n2lsiIIsKkJbaVjzrITBiMhGQFivaAzcpPBgTP91QkTJBvPLwVVvYK
         80W5WL97zPXhfm+AVq+PNCg6UvQCpg07CANHcX/eN0Uy5SzJW81AB/RMeq30HnAsQotU
         GDD/anS4eAQvEBJ+BXMo5D7dv6umuSzac9DNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=M21ssd+SCSSsGeh27JWFSofpx9BWcRpnZarG7AT/Oog=;
        b=L13DjYGCsv7RR6EekCyJLbAUrr7sxDkXKr/lpHblZCQM7k/ffDLUD4HfvNjxRv7dms
         bfrFGcvDFfSJO0x/lfL9Hn1gQuBcREb4G2F+AWC9GCZqsXjkgrTcX0kRX1NpvleDUb0w
         +Wsk/0gBOo6mLaSZ4Wn7GD4LauhaWB+JQhgGYauqt3biXz1FuyG29Arr1Nqd/PrsAR1s
         AtTZ8E8am0NpJ5xKJwOKZrWLc1IRcft7y+Xp0jnMGSbYwrd6i6dPcr/Vs2AjDmsKuGj+
         1M46c0UlxA/VZE+hR3PeWrkULiMbicViG1/Z+2KQ7t00xXlVt1+77+sBVKy2znPHtsal
         /ONg==
X-Gm-Message-State: ACgBeo392YsgpxU52T16xOiD95JMpXRZxpt6A2JqlbIilSfwXfAwzIDy
        xYS10rEIi3xzLqBsvRydvJYkMw==
X-Google-Smtp-Source: AA6agR67U5AZIaBfuvGuyZMN0SCDmBt4kBb19CNC0XD8eDVqoMBDP73Ihp3hsT/46KNNwQ/a9j6Weg==
X-Received: by 2002:a17:90b:3e81:b0:1fd:8357:cbc8 with SMTP id rj1-20020a17090b3e8100b001fd8357cbc8mr1327020pjb.48.1662513497037;
        Tue, 06 Sep 2022 18:18:17 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:acea:5f9a:4de:10c7])
        by smtp.gmail.com with UTF8SMTPSA id d13-20020a170902654d00b0017689960d10sm8321906pln.156.2022.09.06.18.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 18:18:16 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH] LoadPin: Require file with verity root digests to have a header
Date:   Tue,  6 Sep 2022 18:18:12 -0700
Message-Id: <20220906181725.1.I3f51d1bb0014e5a5951be4ad3c5ad7c7ca1dfc32@changeid>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

LoadPin expects the file with trusted verity root digests to be
an ASCII file with one digest (hex value) per line. A pinned
root could contain files that meet these format requirements,
even though the hex values don't represent trusted root
digests.

Add a new requirement to the file format which consists in
the first line containing a fixed string. This prevents
attackers from feeding files with an otherwise valid format
to LoadPin.

Suggested-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
It could be argued that this change breaks existing users
of the LoadPin verity feature. The risk of this actually
happening seems very low given that the feature only
landed in v6.0, which hasn't been released yet.

 security/loadpin/Kconfig   |  7 ++++++-
 security/loadpin/loadpin.c | 16 +++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
index 994c1d9376e6..6724eaba3d36 100644
--- a/security/loadpin/Kconfig
+++ b/security/loadpin/Kconfig
@@ -33,4 +33,9 @@ config SECURITY_LOADPIN_VERITY
 	  on the LoadPin securityfs entry 'dm-verity'. The ioctl
 	  expects a file descriptor of a file with verity digests as
 	  parameter. The file must be located on the pinned root and
-	  contain one digest per line.
+	  start with the line:
+
+	  # LOADPIN_TRUSTED_VERITY_ROOT_DIGESTS
+
+	  This is followed by the verity digests, with one digest per
+	  line.
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 44521582dcba..de41621f4998 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -21,6 +21,8 @@
 #include <linux/dm-verity-loadpin.h>
 #include <uapi/linux/loadpin.h>
 
+#define VERITY_DIGEST_FILE_HEADER "# LOADPIN_TRUSTED_VERITY_ROOT_DIGESTS"
+
 static void report_load(const char *origin, struct file *file, char *operation)
 {
 	char *cmdline, *pathname;
@@ -292,9 +294,21 @@ static int read_trusted_verity_root_digests(unsigned int fd)
 
 	p = strim(data);
 	while ((d = strsep(&p, "\n")) != NULL) {
-		int len = strlen(d);
+		int len;
 		struct dm_verity_loadpin_trusted_root_digest *trd;
 
+		if (d == data) {
+			/* first line, validate header */
+			if (strcmp(d, VERITY_DIGEST_FILE_HEADER)) {
+				rc = -EPROTO;
+				goto err;
+			}
+
+			continue;
+		}
+
+		len = strlen(d);
+
 		if (len % 2) {
 			rc = -EPROTO;
 			goto err;
-- 
2.37.2.789.g6183377224-goog

