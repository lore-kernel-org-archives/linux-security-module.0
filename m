Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E081B808
	for <linux-security-module@vger.kernel.org>; Tue,  9 Sep 2025 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757376423; cv=none; b=WGgSLIpERDkBD853BDEukzW9agolwFTTcbR0GbwToJF2f7NQOfqnWhtRup8PgfKM1ebTkYGqvTkPy4m8IamQrriQQgCXh2tZfqHMB9q8+O3DqxOWFOpm4BJbGMLQhe0+qsni13MXyqlqi3BE3nkjIVn+1FJLDMWW4pfSsm6NkCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757376423; c=relaxed/simple;
	bh=Csd1vaQ5H38hPbweOO9CK7n6pEI39y1rydMEzDWMQJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8KEl7rkA+cnTC43igUd6MD3bf7gxBhXhxom32nViTeAr4EE8feVqOdxKbYCw9COv9h0cL7jfTR1sORbLSKS56YYsJP3C1p/SU0CsNGSss0ziuEcieaf+Z6R79NGfLjM5xU9GszmlVwGYzZ4uCDRVf7EqQnqHKn3b5YuSEamP4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=oyvUEOzX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D0reK48b; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="oyvUEOzX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D0reK48b"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 42B5A1D0018C;
	Mon,  8 Sep 2025 20:06:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 08 Sep 2025 20:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757376419; x=
	1757462819; bh=VK3YxJkM0uXLdjZar4lbhVAxJ9h/0c6ahhjLeQ9NeyY=; b=o
	yvUEOzXZg9BNLWSKbiltXoDXVzcaUUycslEpX8nluTvJDdukIIP9BPC7qIYxbtiy
	xcCBMT9y3rLcZJ8evpM3pEwSNnnIar3nh0Ii2PLPeQtYo88GBrKV++8QkoLt5uA2
	VYvmFQpzm2PTgRpsHMpIZnTMEP2NSjlCeOXFFMTddBGTN4PcV6/6cVTsOtII82cC
	2IcrkJIfwWcbIlb7XDNjeYR6OnIXPnH9kklS7Lvh/gHCAuH7KE31sf13+AutHGmn
	TW4T9AvzkMKncIJdC82Xz8+vg+Ug8doZ6xTcH5RMjK2IHRPaKh7wqDhDjjI0X+YG
	0upRKeVZLqcdilmtPPRDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757376419; x=1757462819; bh=V
	K3YxJkM0uXLdjZar4lbhVAxJ9h/0c6ahhjLeQ9NeyY=; b=D0reK48bkBrurdkxp
	3y0RVoixD2rrqEVgnGnOCWiY4WIyJY0Iq4clj0yozG5cIBoR5DrTIqOl+2XXSvTm
	FBLOU/3raURzXwgxlsl5Fbusv1HGtO1uPn/wBD6Iynt9SrOZlxjRu0yUUYeYLRW0
	q+Rs+vTzs2IcSvDLKewOTqWModiEd6G3wIUPyO6tbfdmrnHIJ0N97BeLNeBPvcbN
	MXkbz81hMIMEjSWiSRIKyS6DmygayC8YRXPPe5rrN7bifGTj7y/S9rnC3iuFg2jQ
	CaLkBmyORL9pS/SDUszT3EIwHH9U8mOc9+yUb2HUIXA2rPOsv3Ubc97t4I8Pbnn2
	5bikA==
X-ME-Sender: <xms:om-_aOwXcRpf7ACAE-1g5Rg1Pf_B7EC4Uy7wIY0lgbJJOW4uPMCJ6w>
    <xme:om-_aFzKRzbfJeburmiQwtCrkk9tEkNaya5l_GJvAXdYuvJIVcUpo1JNBNodHN9sb
    l2wUvXjJL7dcwRoun0>
X-ME-Received: <xmr:om-_aGz70Ha22RYFwe2HvIkmIHkw5wngG4hit1v2_1fSxW4sHhHsp9dVh8e2L3Ta1zCvo0qC1J8kV6z-rlHqF_erG3YlqgNg02UidgNBGV317t7SGbCOiGjp7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehj
    rggtkhesshhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmh
    houghulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:om-_aPbRg_1IrOPvyDFXVyjbqJ_Yo_RfiQj21kAh-UUSf9KPhToYBQ>
    <xmx:om-_aHXDh0bw4gKA9y3nx-5RrPbdManiBtyb6NPt6NHFEvw8NX_rnQ>
    <xmx:om-_aNiefv3p5KroAniBevo6luZ0Ur9ZDAyfvPmaIs4mZv-9UUDwdA>
    <xmx:om-_aFvzMGgStdGiK5hialxTSb4VX34lRXqd_VLJN43BNQmrc9EKWw>
    <xmx:o2-_aIdJbvy0H9tuJCBpZ7AMwQnHgUHS6REWU2zIszaRr2A-_xPtdySc>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 20:06:58 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 3/6] landlock/audit: Check for quiet flag in landlock_log_denial
Date: Tue,  9 Sep 2025 01:06:37 +0100
Message-ID: <366f215b1687eb3d530bfde11626ec0256d51180.1757376311.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757376311.git.m@maowtm.org>
References: <cover.1757376311.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suppresses logging if the flag is effective on the youngest layer.

This does not handle optional access logging yet - to do that correctly we will
need to expand deny_masks to support representing "don't log anything"

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/audit.c | 16 +++++++++++++++-
 security/landlock/audit.h |  3 ++-
 security/landlock/fs.c    | 20 +++++++++++---------
 security/landlock/net.c   |  3 ++-
 security/landlock/task.c  | 12 ++++++------
 5 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index c52d079cdb77..2b3edd1ab374 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -386,9 +386,12 @@ static bool is_valid_request(const struct landlock_request *const request)
  *
  * @subject: The Landlock subject's credential denying an action.
  * @request: Detail of the user space request.
+ * @rule_flags: The flags for the matched rule, or NULL if this is a
+ * scope request (no particular object involved).
  */
 void landlock_log_denial(const struct landlock_cred_security *const subject,
-			 const struct landlock_request *const request)
+			 const struct landlock_request *const request,
+			 const struct collected_rule_flags *const rule_flags)
 {
 	struct audit_buffer *ab;
 	struct landlock_hierarchy *youngest_denied;
@@ -436,6 +439,17 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 	if (!audit_enabled)
 		return;
 
+	/*
+	 * Check if the object is marked quiet by the layer that denied the
+	 * request.  (If it's a different layer that marked it as quiet, but
+	 * that layer is not the one that denied the request, we should still
+	 * audit log the denial)
+	 */
+	if (rule_flags &&
+	    rule_flags->quiet_masks & BIT(youngest_layer)) {
+		return;
+	}
+
 	/* Checks if the current exec was restricting itself. */
 	if (subject->domain_exec & BIT(youngest_layer)) {
 		/* Ignores denials for the same execution. */
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 92428b7fc4d8..e6f76d417c2f 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -56,7 +56,8 @@ struct landlock_request {
 void landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy);
 
 void landlock_log_denial(const struct landlock_cred_security *const subject,
-			 const struct landlock_request *const request);
+			 const struct landlock_request *const request,
+			 const struct collected_rule_flags *const rule_flags);
 
 #else /* CONFIG_AUDIT */
 
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index b566ae498df5..ba93b0de384c 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -984,7 +984,7 @@ static int current_check_access_path(const struct path *const path,
 				       NULL, 0, NULL, NULL, NULL, NULL))
 		return 0;
 
-	landlock_log_denial(subject, &request);
+	landlock_log_denial(subject, &request, &rule_flags);
 	return -EACCES;
 }
 
@@ -1194,7 +1194,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 			    &request1, NULL, 0, NULL, NULL, NULL, NULL))
 			return 0;
 
-		landlock_log_denial(subject, &request1);
+		landlock_log_denial(subject, &request1, &rule_flags_parent1);
 		return -EACCES;
 	}
 
@@ -1243,11 +1243,13 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 
 	if (request1.access) {
 		request1.audit.u.path.dentry = old_parent;
-		landlock_log_denial(subject, &request1);
+		landlock_log_denial(subject, &request1,
+				    &rule_flags_parent1);
 	}
 	if (request2.access) {
 		request2.audit.u.path.dentry = new_dir->dentry;
-		landlock_log_denial(subject, &request2);
+		landlock_log_denial(subject, &request2,
+				    &rule_flags_parent2);
 	}
 
 	/*
@@ -1403,7 +1405,7 @@ log_fs_change_topology_path(const struct landlock_cred_security *const subject,
 			.u.path = *path,
 		},
 		.layer_plus_one = handle_layer + 1,
-	});
+	}, NULL);
 }
 
 static void log_fs_change_topology_dentry(
@@ -1417,7 +1419,7 @@ static void log_fs_change_topology_dentry(
 			.u.dentry = dentry,
 		},
 		.layer_plus_one = handle_layer + 1,
-	});
+	}, NULL);
 }
 
 /*
@@ -1705,7 +1707,7 @@ static int hook_file_open(struct file *const file)
 
 	/* Sets access to reflect the actual request. */
 	request.access = open_access_request;
-	landlock_log_denial(subject, &request);
+	landlock_log_denial(subject, &request, &rule_flags);
 	return -EACCES;
 }
 
@@ -1735,7 +1737,7 @@ static int hook_file_truncate(struct file *const file)
 #ifdef CONFIG_AUDIT
 		.deny_masks = landlock_file(file)->deny_masks,
 #endif /* CONFIG_AUDIT */
-	});
+	}, NULL);
 	return -EACCES;
 }
 
@@ -1774,7 +1776,7 @@ static int hook_file_ioctl_common(const struct file *const file,
 #ifdef CONFIG_AUDIT
 		.deny_masks = landlock_file(file)->deny_masks,
 #endif /* CONFIG_AUDIT */
-	});
+	}, NULL);
 	return -EACCES;
 }
 
diff --git a/security/landlock/net.c b/security/landlock/net.c
index bddbe93d69fd..d242bb9fa5b4 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -193,7 +193,8 @@ static int current_check_access_socket(struct socket *const sock,
 				    .access = access_request,
 				    .layer_masks = &layer_masks,
 				    .layer_masks_size = ARRAY_SIZE(layer_masks),
-			    });
+			    },
+			    &rule_flags);
 	return -EACCES;
 }
 
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 2385017418ca..dfea227ce1d7 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -115,7 +115,7 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 				.u.tsk = child,
 			},
 			.layer_plus_one = parent_subject->domain->num_layers,
-		});
+		}, NULL);
 
 	return err;
 }
@@ -161,7 +161,7 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 			.u.tsk = current,
 		},
 		.layer_plus_one = parent_subject->domain->num_layers,
-	});
+	}, NULL);
 	return err;
 }
 
@@ -290,7 +290,7 @@ static int hook_unix_stream_connect(struct sock *const sock,
 			},
 		},
 		.layer_plus_one = handle_layer + 1,
-	});
+	}, NULL);
 	return -EPERM;
 }
 
@@ -327,7 +327,7 @@ static int hook_unix_may_send(struct socket *const sock,
 			},
 		},
 		.layer_plus_one = handle_layer + 1,
-	});
+	}, NULL);
 	return -EPERM;
 }
 
@@ -383,7 +383,7 @@ static int hook_task_kill(struct task_struct *const p,
 			.u.tsk = p,
 		},
 		.layer_plus_one = handle_layer + 1,
-	});
+	}, NULL);
 	return -EPERM;
 }
 
@@ -426,7 +426,7 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 #ifdef CONFIG_AUDIT
 		.layer_plus_one = landlock_file(fown->file)->fown_layer + 1,
 #endif /* CONFIG_AUDIT */
-	});
+	}, NULL);
 	return -EPERM;
 }
 
-- 
2.51.0

