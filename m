Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49956C433EF
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jun 2022 17:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378265AbiFPRTE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jun 2022 13:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378276AbiFPRSu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jun 2022 13:18:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF81C108
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jun 2022 10:18:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x4so2045527pfj.10
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jun 2022 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tx3qhTHSwY8LHXDagQrNOOhwtj4vpldafKf967ywksA=;
        b=BQgdl2AtVbmbqGhETU/fDbUSCB3QQqWvAxl5b7UCZYhymn8uaP2rVq7BiavS876oZ1
         KVuTCgA6ZFDJeRqMwkFMUbptQ6NmaAPwPyFYB5Cl3Lev6gzVfEIZ15VX6VfC728395Yb
         cqwPWlCwRdPhj1d5kHF6EfExZYkitf93iIENY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tx3qhTHSwY8LHXDagQrNOOhwtj4vpldafKf967ywksA=;
        b=Xk5jWCrKMEtOKzYd0OD5g9pa/CyihHjElex/APGnmqE3ngJpmqJt40rKyW7AtuaauE
         1cOWOEhElG91ty3V2KQoNgWUFVUIlvBylS+ndXDvUiT6MgjBUID5tqAuClhCl6bj+gx9
         cQ0jTdNmjUOCDUQjTfBBmsPBtxkJH0c2kbuwKr1kID/G9JpoT1+BrZHSeKT6IdDxrY5C
         CTS1+p26S7KXFoc48CZt+15LT158mosDuHneNrS2TqNIkuDJej9FcFM+zXm4t9XkI4bD
         bm4BkxhSVrZglwA03DF3I0X2CvJaSiFAmlEB4PIKk5zalxwwaMZk8nbhZVfOuBawhvwz
         vx5w==
X-Gm-Message-State: AJIora+0320CaDqvcurlnpM1mpA04lsS6cSNth6rABRzylIyogp+Gshq
        wi/EibGTu3+2fdmj7vlo5CJK7prK24tqaw==
X-Google-Smtp-Source: AGRyM1vzJR68Jz346hm9ECnS+CsIJwfDvxNyYjLwwb8AFTyXPUw2rkQYlOFWN1yAlApJuXR9ToYqSQ==
X-Received: by 2002:a65:6c08:0:b0:3f2:6a6a:98d with SMTP id y8-20020a656c08000000b003f26a6a098dmr5326283pgu.30.1655399927063;
        Thu, 16 Jun 2022 10:18:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:200:46bc:126f:64c1:579a])
        by smtp.gmail.com with UTF8SMTPSA id f5-20020aa79685000000b0050dc7628196sm2010927pfk.112.2022.06.16.10.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 10:18:46 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
To:     linux-security-module@vger.kernel.org
Cc:     keescook@chromium.org, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 3/3] LSM: SafeSetID: add setgroups() testing to selftest
Date:   Thu, 16 Jun 2022 10:18:43 -0700
Message-Id: <20220616171843.783340-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Selftest already has support for testing UID and GID transitions.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 .../selftests/safesetid/safesetid-test.c      | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index a653c47a4ab5..eb9bf0aee951 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -375,6 +375,71 @@ static void test_setgid(gid_t child_gid, bool expect_success)
 	die("should not reach here\n");
 }
 
+static void test_setgroups(gid_t* child_groups, size_t len, bool expect_success)
+{
+	pid_t cpid, w;
+	int wstatus;
+	gid_t groupset[len];
+	int i, j;
+
+	cpid = fork();
+	if (cpid == -1) {
+		die("fork\n");
+	}
+
+	if (cpid == 0) {	    /* Code executed by child */
+		if (setgroups(len, child_groups) != 0)
+			exit(EXIT_FAILURE);
+		if (getgroups(len, groupset) != len)
+			exit(EXIT_FAILURE);
+		for (i = 0; i < len; i++) {
+			for (j = 0; j < len; j++) {
+				if (child_groups[i] == groupset[j])
+					break;
+				if (j == len - 1)
+					exit(EXIT_FAILURE);
+			}
+		}
+		exit(EXIT_SUCCESS);
+	} else {		 /* Code executed by parent */
+		do {
+			w = waitpid(cpid, &wstatus, WUNTRACED | WCONTINUED);
+			if (w == -1) {
+				die("waitpid\n");
+			}
+
+			if (WIFEXITED(wstatus)) {
+				if (WEXITSTATUS(wstatus) == EXIT_SUCCESS) {
+					if (expect_success) {
+						return;
+					} else {
+						die("unexpected success\n");
+					}
+				} else {
+					if (expect_success) {
+						die("unexpected failure\n");
+					} else {
+						return;
+					}
+				}
+			} else if (WIFSIGNALED(wstatus)) {
+				if (WTERMSIG(wstatus) == 9) {
+					if (expect_success)
+						die("killed unexpectedly\n");
+					else
+						return;
+				} else {
+					die("unexpected signal: %d\n", wstatus);
+				}
+			} else {
+				die("unexpected status: %d\n", wstatus);
+			}
+		} while (!WIFEXITED(wstatus) && !WIFSIGNALED(wstatus));
+	}
+
+	die("should not reach here\n");
+}
+
 
 static void ensure_users_exist(void)
 {
@@ -452,6 +517,10 @@ int main(int argc, char **argv)
 	test_setgid(ALLOWED_CHILD2_UGID, true);
 	test_setgid(NO_POLICY_UGID, false);
 
+	gid_t allowed_supp_groups[2] = {ALLOWED_CHILD1_UGID, ALLOWED_CHILD2_UGID};
+	gid_t disallowed_supp_groups[2] = {ROOT_UGID, NO_POLICY_UGID};
+	test_setgroups(allowed_supp_groups, 2, true);
+	test_setgroups(disallowed_supp_groups, 2, false);
 
 	if (!test_userns(false)) {
 		die("test_userns worked when it should fail\n");
-- 
2.36.1.476.g0c4daa206d-goog

