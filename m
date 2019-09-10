Return-Path: <SRS0=YGRx=XF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B91DC3A5A2
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Sep 2019 11:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1130421019
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Sep 2019 11:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L/JcmoL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfIJL5S (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:57:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45302 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731955AbfIJL4m (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id l16so19551847wrv.12
        for <linux-security-module@vger.kernel.org>; Tue, 10 Sep 2019 04:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xx8OQzLGeYj3y8P8kHo1vFFB3UBFSHmtM6b5jQ7aUbc=;
        b=L/JcmoL9YFbmK7b5Ew8OA1Fu7G6qYLk08zlfibWCYa5wLOBEtncRKjJHOAC/3GgUNH
         tyH4p/RGx2W8u2s5Z5zmnBfGz80YsBhI+p+vULHEpkDHhJg+ymK5RN5K/0jBPlXyb2Yh
         0Dwg1BkJ5ku6v9PobnKdYpGahlhHlgU675J58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xx8OQzLGeYj3y8P8kHo1vFFB3UBFSHmtM6b5jQ7aUbc=;
        b=nuUsE1GJUm+64Zy3cLi2LTONwMnsJ6TxLoIDoWg2TczqqGL6dTqtn5SHhCVGtpmsD+
         cZ9xP15RmbYEj3tpFVdJmlNk9ebWrRd5J7qFtLK6M30P+GX+8F8z4bs7NazpHj+BKsUF
         d+SkjMJ2jj4NlmG8orBjeFiiaEof3FnB9u27+aN9PJsdWWvxGSf5KUxIpZ8Qah52t7PT
         jAR2EPN0vY2G6v+8xF3UzFXRHUHb044SfRSFkqtqbi6o/yfRONwJ7yqwraNe3F7MgA8B
         2Ee5zUytBwW9QGGwkyQ74VpxSwB/+1PyYrTO42STBp41lBhewDezMNuKGV3KdbKewo1Y
         vSvA==
X-Gm-Message-State: APjAAAXjlB0spNQ7qSeDjcrRMfno+uLAFStnxhIMoqKq+2liFHKNqlGo
        DcVeixNGqPoLKP0vJowiS30ilQ==
X-Google-Smtp-Source: APXvYqwNk6DvXrD4yaS/Fc0Y482stWXQP2rzXiEmcLEygo6h6UhjTxAsjVjo58V1vhNDVNYvKl8pLw==
X-Received: by 2002:adf:e852:: with SMTP id d18mr24404287wrn.225.1568116600270;
        Tue, 10 Sep 2019 04:56:40 -0700 (PDT)
Received: from kpsingh-kernel.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id q19sm23732935wra.89.2019.09.10.04.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:56:39 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [RFC v1 10/14] krsi: Handle attachment of the same program
Date:   Tue, 10 Sep 2019 13:55:23 +0200
Message-Id: <20190910115527.5235-11-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910115527.5235-1-kpsingh@chromium.org>
References: <20190910115527.5235-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

Allow the userspace to attach a newer version of a program without
having duplicates of the same program.

If BPF_F_ALLOW_OVERRIDE is passed, the attachment logic compares the
name of the new program to the names of existing attached programs. The
names are only compared till a "__" (or '\0', if there is no "__"). If
a successful match is found, the existing program is replaced with the
newer attachment.

./krsi Attaches "env_dumper__v1" followed by "env_dumper__v2"
to the process_execution hook of the KRSI LSM.

./krsi
./krsi

Before:

  cat /sys/kernel/security/krsi/process_execution
  env_dumper__v1
  env_dumper__v2

After:

  cat /sys/kernel/security/krsi/process_execution
  env_dumper__v2

Signed-off-by: KP Singh <kpsingh@google.com>
---
 security/krsi/ops.c | 53 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/security/krsi/ops.c b/security/krsi/ops.c
index 57bd304a03f4..1f4df920139c 100644
--- a/security/krsi/ops.c
+++ b/security/krsi/ops.c
@@ -65,11 +65,52 @@ static struct krsi_hook *get_hook_from_fd(int fd)
 	return ERR_PTR(ret);
 }
 
+/*
+ * match_prog_name matches the name of the program till "__"
+ * or the end of the string is encountered. This allows
+ * a different version of the same program to be loaded.
+ *
+ * For example:
+ *
+ *	env_dumper__v1 is matched with env_dumper__v2
+ *
+ */
+static bool match_prog_name(char *a, char *b)
+{
+	int m, n;
+	char *end;
+
+	end = strstr(a, "__");
+	n = end ? end - a : strlen(a);
+
+	end = strstr(b, "__");
+	m = end ? end - b : strlen(b);
+
+	if (m != n)
+		return false;
+
+	return strncmp(a, b, n) == 0;
+}
+
+static struct bpf_prog *find_attached_prog(struct bpf_prog_array *array,
+					   struct bpf_prog *prog)
+{
+	struct bpf_prog_array_item *item = array->items;
+
+	for (; item->prog; item++) {
+		if (match_prog_name(item->prog->aux->name, prog->aux->name))
+			return item->prog;
+	}
+
+	return NULL;
+}
+
 int krsi_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	struct bpf_prog_array *old_array;
 	struct bpf_prog_array *new_array;
 	struct krsi_hook *h;
+	struct bpf_prog *old_prog;
 	int ret = 0;
 
 	h = get_hook_from_fd(attr->target_fd);
@@ -79,8 +120,18 @@ int krsi_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	mutex_lock(&h->mutex);
 	old_array = rcu_dereference_protected(h->progs,
 					      lockdep_is_held(&h->mutex));
+	/*
+	 * Check if a matching program with already exists and replace
+	 * the existing program will be overridden if BPF_F_ALLOW_OVERRIDE
+	 * is specified in the attach flags.
+	 */
+	old_prog = find_attached_prog(old_array, prog);
+	if (old_prog && !(attr->attach_flags & BPF_F_ALLOW_OVERRIDE)) {
+		ret = -EEXIST;
+		goto unlock;
+	}
 
-	ret = bpf_prog_array_copy(old_array, NULL, prog, &new_array);
+	ret = bpf_prog_array_copy(old_array, old_prog, prog, &new_array);
 	if (ret < 0) {
 		ret = -ENOMEM;
 		goto unlock;
-- 
2.20.1

