Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AB34084C;
	Tue,  9 Jul 2024 03:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720494489; cv=none; b=oqtARfPD2fjB5lvvgvSP8WprJX+k6i034KAMSra+reDdtWMdJ4PcDsgl9Ysv4rF8q3/QUjU8QJnyRqXCiCLa85VpwUhN4Sy4/+yElxs3DjotBfhS/511Y5+TS2Bb2M9hbvZYAmFN42+iRILgXSdx30bCsDKDGJAA6myqweLW1qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720494489; c=relaxed/simple;
	bh=HuIO3QXNrsFEjYOkx/nY84ANjiP1hdQ5WeQN+NW30Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vFQYvAPm2j1l/p/8KCl3PmNhIcRMoFZhsW5ChmdEwi20aj076aIcQ8eJkG0S/P856mBnBHIpJXuPS94SvnWemKJBcTfhjj/GDtLP54e22Q6Q7kkTayLLC4cZA36ghL8urd5df/KowOSmWUCFooE5FHFo3re8oV0DWKp/Ue2O3vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts+N4i2g; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts+N4i2g"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f8d0a00a35so4483949a34.2;
        Mon, 08 Jul 2024 20:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720494486; x=1721099286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PwwuYSXB90fKktmKvx7XHMxW0xqHEFFAvhcbieHh5ZM=;
        b=Ts+N4i2gslCfThP9RDjUs0bXfDTENt7Bk0oQEwVztvwYwP/rLzTRwYnqszMehgHl4g
         zmbCylD0hgGasvBBPyjOkObec+mDLtDBHux0z6ol18lxBBLINXILMkgqYNQp8Q2zqIWW
         HNSNz0/5OKuHkZx45278qseZ0t1hQTHk1JiXUSWznbuQ/isTVjAhHLarBNtI35obDrnf
         B/KfdSlsdc47seaDPZ82/KSQ5Nt8Vpo7FtSXo6NNSxG8ePTIFvQ6Bm89pQ7xyUrxPWXr
         pFYhoQudXWyTJ+0FcAU++at+6TcYxOW1AW/ohSpg+6lSHaowqZmp8fRTSNpfhpMN8xWj
         HmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720494486; x=1721099286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwwuYSXB90fKktmKvx7XHMxW0xqHEFFAvhcbieHh5ZM=;
        b=CVgS8KytQ3HcAM+DxxRk1ArHIsMw/LRokNLz7W6/5yqeo/apQLg3hlOsxSb+5fWhxE
         OJ0mVCW1Ov371WU9jiSI5cW5goJCAbY+gZ6MwFQazXHbwN6Ye4Ei+F4PKTSG1H51yxEg
         PxpdB1n1Kj/u74E1L0aLGfKU+Mtm+Z4DjLvtn9H9H1R0Xeuj/y+rVKQK42IM9UC6Lznn
         wNhABe2/qiF6FSbFfGTn2J814pHjSHPjlA9sB1u+6szMmoflCLIlRcIazFhznFx+IRyk
         QsxFSUyxylOckKq/ZnnCd+j7bXgV4sUX0WPmWfagnuBNM1PIbmDv83cPwyAGXiIiUR/+
         0n5g==
X-Forwarded-Encrypted: i=1; AJvYcCUJBcDtGtE6AcdotEqhZzl1QLAvrg/p6TaEriJeNA8OA2zAHNuOMWrtxxyRpQLhpT/dmTi7Lbgy7yzy0mR95d1AzceH/ZPtfmrNry43u3+ajYx1rnlC5dMxwQw2nYxx0CsRrwJcBrXe2EXTB58KLAjTgdUe
X-Gm-Message-State: AOJu0Yx4DhN63Fw1OTjjFCGo4hO2Ev3xWu8rUm1IvV1NhRm6UXmb7Ky3
	VmhBKf7u2+6Uj4kIW6OKMF+mVbL7UKjBETs654ORdgXalJ4OZdVy
X-Google-Smtp-Source: AGHT+IG4PZquzeh4SNLSzENKHm6x9p4wfSaWPtdDgVG+sfwxGbHHf4Ew64OpCozvb5F3dAFFjN23vQ==
X-Received: by 2002:a05:6358:6f97:b0:1a6:2c4d:c902 with SMTP id e5c5f4694b2df-1aade29aa01mr131953155d.19.1720494486049;
        Mon, 08 Jul 2024 20:08:06 -0700 (PDT)
Received: from SYSOS.. ([115.178.65.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a97c275sm8962088a91.25.2024.07.08.20.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 20:08:05 -0700 (PDT)
Sender: Leesoo Ahn <yisooan.dev@gmail.com>
From: Leesoo Ahn <lsahn@ooseel.net>
X-Google-Original-From: Leesoo Ahn <lsahn@wewakecorp.com>
To: lsahn@ooseel.net
Cc: Leesoo Ahn <lsahn@wewakecorp.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: domain: clean up duplicated parts of handle_onexec()
Date: Tue,  9 Jul 2024 12:07:51 +0900
Message-Id: <20240709030751.3825748-1-lsahn@wewakecorp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regression test of AppArmor finished without any failures.

PASSED: aa_exec access attach_disconnected at_secure introspect capabilities
changeprofile onexec changehat changehat_fork changehat_misc chdir clone
coredump deleted e2e environ exec exec_qual fchdir fd_inheritance fork i18n
link link_subset mkdir mmap mount mult_mount named_pipe namespaces net_raw
open openat pipe pivot_root posix_ipc ptrace pwrite query_label regex rename
readdir rw socketpair swap sd_flags setattr symlink syscall sysv_ipc tcp
unix_fd_server unix_socket_pathname unix_socket_abstract unix_socket_unnamed
unix_socket_autobind unlink userns xattrs xattrs_profile longpath nfs
exec_stack aa_policy_cache nnp stackonexec stackprofile
FAILED:
make: Leaving directory '/apparmor/tests/regression/apparmor'

Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
---
 security/apparmor/domain.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 571158ec6188..b73e01b512c2 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -822,33 +822,18 @@ static struct aa_label *handle_onexec(const struct cred *subj_cred,
 	AA_BUG(!bprm);
 	AA_BUG(!buffer);
 
-	if (!stack) {
-		error = fn_for_each_in_ns(label, profile,
-				profile_onexec(subj_cred, profile, onexec, stack,
-					       bprm, buffer, cond, unsafe));
-		if (error)
-			return ERR_PTR(error);
-		new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
-				aa_get_newest_label(onexec),
-				profile_transition(subj_cred, profile, bprm,
-						   buffer,
-						   cond, unsafe));
-
-	} else {
-		/* TODO: determine how much we want to loosen this */
-		error = fn_for_each_in_ns(label, profile,
-				profile_onexec(subj_cred, profile, onexec, stack, bprm,
-					       buffer, cond, unsafe));
-		if (error)
-			return ERR_PTR(error);
-		new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
-				aa_label_merge(&profile->label, onexec,
-					       GFP_KERNEL),
-				profile_transition(subj_cred, profile, bprm,
-						   buffer,
-						   cond, unsafe));
-	}
+	/* TODO: determine how much we want to loosen this */
+	error = fn_for_each_in_ns(label, profile,
+			profile_onexec(subj_cred, profile, onexec, stack,
+				       bprm, buffer, cond, unsafe));
+	if (error)
+		return ERR_PTR(error);
 
+	new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
+			stack ? aa_label_merge(&profile->label, onexec, GFP_KERNEL)
+			      : aa_get_newest_label(onexec),
+			profile_transition(subj_cred, profile, bprm,
+					   buffer, cond, unsafe));
 	if (new)
 		return new;
 
-- 
2.34.1

