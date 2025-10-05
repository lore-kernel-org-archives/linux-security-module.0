Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895B158DAC
	for <linux-security-module@vger.kernel.org>; Sun,  5 Oct 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759686997; cv=none; b=CQVHnSpMxqHjYd5+L1P6PAJFOJG+Vdt/vuZbHC9CNCgvUm2V7zFPIsbS9qBT7l42LyITNJyXptrGFNFiiw3xvRJSOgCzVQNe5/7WbDy/y9lNzLmo746eNk/tWFzAx4dXU/2ak1l1up3XWQp90SMF1UQebBJq0vq1+2c7de9I/fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759686997; c=relaxed/simple;
	bh=dY13eVKydPUSaDkMvKdyxmgBRE7pG7RZuygIHjzbd8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLwHz3VkvM5aD/n6LqZKZUxpIorulD17xjnJPuRHOCKhQDRsTfm45eNMuoq+hYEcRvphKvyB6+5AL+GFLa4PNuSJ7EHmS+P3GtcTsmWuQ27SqEC1nAO2Wt9WS1+N/v1q3csTJorh48k/hzqyqYOPmH/MObSd+ve2xFgokceFhnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Qd8HY3Gi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wKhIumzE; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Qd8HY3Gi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wKhIumzE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B57B11D00083;
	Sun,  5 Oct 2025 13:56:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 05 Oct 2025 13:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1759686994; x=
	1759773394; bh=eFiuJbXw4Jj2jfPZuEnfTBroVIKemRAFFnGtqa6m8EM=; b=Q
	d8HY3GioDcJP1qK6BSg6EgLtyUY3CMVVVcwF73YDPKuEHlR/N15NQ9JiXQ++Me1Z
	O1SbADCwK6JJkczl83Rrj0cB53ggp/8/7nUDIOvn57mYcUdT4us1TvJczrkJtofU
	NzdhtRJz73HgscuNB8fpjRmLibVXNHVFUnhLb9Ighh1EB1VqseO2R8PLViuBwyH0
	ybPlsHji+9S0SLvO3duf+QHIQL0Osq3+9q8JKoItj6od1vRm8W5EMb0w4/6HpSDr
	Y0HcN08EDB+6pkxBDGc47/FKVmqCRjwkhVMsU7ItREqVFMN0xJe1IPoWK6LH3bDr
	lb8nrctUkh/at/IOysMew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759686994; x=1759773394; bh=e
	FiuJbXw4Jj2jfPZuEnfTBroVIKemRAFFnGtqa6m8EM=; b=wKhIumzEG6lpcQFxu
	biLfHjmyArqC/+V/oRKiL99rEin+Fj3prmcMIH8PeeEu0jMIZXMn7BzMGArLNYGM
	YU3scUtDeQ5Ut+CBQ0rCvuEtKBsh9IaUaVh/QhfaHa+VBKzefKYftjau2mFbF4u6
	l/ONUSilHjwXxV9APgpVXtS2OHh6rlMt+x2jn7DBgd1hpNhBbLHqdyl09koXuvZX
	OK06HL2h5rCAKMp0KWX7EmkqeVihRwTGkTeRFzbkA8MljeMAAnKhd0Vv/M5NmwzF
	Xfsa+XRkLeDwjmMc8+xf20QI6miAFQqt6/VC35jCUm2AsA7pLahBl2DDu+Myh1nf
	nC/6Q==
X-ME-Sender: <xms:UrHiaITs3HDNpd50PyU6baEwYnLFwmZ3jh-Yn58qwZKLeNwqdRdWcw>
    <xme:UrHiaMoybCfuekX7ufhzdL6VlyjH1CcyR9clvYTZqmHM-UBP5Ms8TG9fVOUOUkHeO
    sIZs9Aqe-JRHwYA6uSgTSrDPUCtVHDmSbE-dHJdAVK-chI6RfewlA>
X-ME-Received: <xmr:UrHiaOKu_Z-A2DUivXVmMdj2tBLiv_4L6zB3MROhcnDta6ZvXdvLvj08GXFQmMncGILIFnUcRR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelheefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepvdfgve
    dvtdevheeffefggfdvieevudekjedvvdejvdegkeffhffgudfhfedvfeejnecuffhomhgr
    ihhnpegrtggtvghsshgpmhgrshhkshdrnhgvthenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikh
    hougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehg
    nhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtg
    iipdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UrHiaHqsG8S8Zuyt_UhtJ4GoDNQGGAwCSAjJnFZGiotuLCrxYe_ApA>
    <xmx:UrHiaOzIS14x0G1L1DrrObuOk5HbCFyavw-gxOh8KVY23hs1T7JQNA>
    <xmx:UrHiaDPuVCKpWqqhAxM90TWnF5l0AoHyU2nPPAaF7qSvlENHgGloUQ>
    <xmx:UrHiaL6FaBOOu6iyWhd4GayWY8cY2m4kcq_R-SmTZVFcIrxYvadqnA>
    <xmx:UrHiaPwLz66r4aRqjwnNQVzSzLrGnrReD1BPBWi0NG2PiGip4xC1Bx7O>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Oct 2025 13:56:33 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 3/6] landlock/audit: Check for quiet flag in landlock_log_denial
Date: Sun,  5 Oct 2025 18:55:26 +0100
Message-ID: <730434d416100f6a72b12fb31eb7253bc8b6fcc0.1759686613.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759686613.git.m@maowtm.org>
References: <cover.1759686613.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suppresses logging if the flag is effective on the youngest layer.

This does not handle optional access logging yet - to do that correctly we
will need to expand deny_masks to support representing "don't log
anything" in a later commit.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes since v1:
- Supports the new quiet access masks.
- Support quieting scope requests (but not ptrace and attempted mounting
  for now)

 security/landlock/audit.c   | 70 +++++++++++++++++++++++++++++++++++--
 security/landlock/audit.h   |  3 +-
 security/landlock/fs.c      | 18 +++++-----
 security/landlock/net.c     |  3 +-
 security/landlock/ruleset.h |  5 +++
 security/landlock/task.c    | 12 +++----
 6 files changed, 92 insertions(+), 19 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index c52d079cdb77..ec00b7dd00c5 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -381,19 +381,39 @@ static bool is_valid_request(const struct landlock_request *const request)
 	return true;
 }
 
+static access_mask_t
+pick_access_mask_for_req_type(const enum landlock_request_type type,
+			      const struct access_masks access_masks)
+{
+	switch (type) {
+	case LANDLOCK_REQUEST_FS_ACCESS:
+		return access_masks.fs;
+	case LANDLOCK_REQUEST_NET_ACCESS:
+		return access_masks.net;
+	default:
+		WARN_ONCE(1, "Invalid request type %d passed to %s", type,
+			  __func__);
+		return 0;
+	}
+}
+
 /**
  * landlock_log_denial - Create audit records related to a denial
  *
  * @subject: The Landlock subject's credential denying an action.
  * @request: Detail of the user space request.
+ * @rule_flags: The flags for the matched rule, or no_rule_flags (zero) if
+ * this is a scope request (no particular object involved).
  */
 void landlock_log_denial(const struct landlock_cred_security *const subject,
-			 const struct landlock_request *const request)
+			 const struct landlock_request *const request,
+			 const struct collected_rule_flags rule_flags)
 {
 	struct audit_buffer *ab;
 	struct landlock_hierarchy *youngest_denied;
 	size_t youngest_layer;
-	access_mask_t missing;
+	access_mask_t missing, quiet_mask;
+	bool quiet_flag_on_rule = false, quiet_applicable_to_access = false;
 
 	if (WARN_ON_ONCE(!subject || !subject->domain ||
 			 !subject->domain->hierarchy || !request))
@@ -436,6 +456,52 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 	if (!audit_enabled)
 		return;
 
+	/*
+	 * Checks if the object is marked quiet by the layer that denied the
+	 * request.  If it's a different layer that marked it as quiet, but
+	 * that layer is not the one that denied the request, we should still
+	 * audit log the denial.
+	 */
+	quiet_flag_on_rule = !!(rule_flags.quiet_masks & BIT(youngest_layer));
+
+	if (quiet_flag_on_rule) {
+		/*
+		 * This is not a scope request, since rule_flags is not zero.  We
+		 * now check if the denied requests are all covered by the layer's
+		 * quiet access bits.
+		 */
+		quiet_mask = pick_access_mask_for_req_type(
+			request->type, youngest_denied->quiet_masks);
+		quiet_applicable_to_access = (quiet_mask & missing) == missing;
+
+		if (quiet_applicable_to_access)
+			return;
+	} else {
+		quiet_mask = youngest_denied->quiet_masks.scope;
+		switch (request->type) {
+		case LANDLOCK_REQUEST_SCOPE_SIGNAL:
+			quiet_applicable_to_access =
+				!!(quiet_mask & LANDLOCK_SCOPE_SIGNAL);
+			break;
+		case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
+			quiet_applicable_to_access =
+				!!(quiet_mask &
+				   LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+			break;
+		/*
+		 * Leave LANDLOCK_REQUEST_PTRACE and
+		 * LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY unhandled for now - they are
+		 * never quiet
+		 */
+		default:
+			break;
+		}
+
+		if (quiet_applicable_to_access) {
+			return;
+		}
+	}
+
 	/* Checks if the current exec was restricting itself. */
 	if (subject->domain_exec & BIT(youngest_layer)) {
 		/* Ignores denials for the same execution. */
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 92428b7fc4d8..80cf085465e3 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -56,7 +56,8 @@ struct landlock_request {
 void landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy);
 
 void landlock_log_denial(const struct landlock_cred_security *const subject,
-			 const struct landlock_request *const request);
+			 const struct landlock_request *const request,
+			 const struct collected_rule_flags rule_flags);
 
 #else /* CONFIG_AUDIT */
 
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index b566ae498df5..1ccef1c2959f 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -984,7 +984,7 @@ static int current_check_access_path(const struct path *const path,
 				       NULL, 0, NULL, NULL, NULL, NULL))
 		return 0;
 
-	landlock_log_denial(subject, &request);
+	landlock_log_denial(subject, &request, rule_flags);
 	return -EACCES;
 }
 
@@ -1194,7 +1194,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 			    &request1, NULL, 0, NULL, NULL, NULL, NULL))
 			return 0;
 
-		landlock_log_denial(subject, &request1);
+		landlock_log_denial(subject, &request1, rule_flags_parent1);
 		return -EACCES;
 	}
 
@@ -1243,11 +1243,11 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 
 	if (request1.access) {
 		request1.audit.u.path.dentry = old_parent;
-		landlock_log_denial(subject, &request1);
+		landlock_log_denial(subject, &request1, rule_flags_parent1);
 	}
 	if (request2.access) {
 		request2.audit.u.path.dentry = new_dir->dentry;
-		landlock_log_denial(subject, &request2);
+		landlock_log_denial(subject, &request2, rule_flags_parent2);
 	}
 
 	/*
@@ -1403,7 +1403,7 @@ log_fs_change_topology_path(const struct landlock_cred_security *const subject,
 			.u.path = *path,
 		},
 		.layer_plus_one = handle_layer + 1,
-	});
+	}, no_rule_flags);
 }
 
 static void log_fs_change_topology_dentry(
@@ -1417,7 +1417,7 @@ static void log_fs_change_topology_dentry(
 			.u.dentry = dentry,
 		},
 		.layer_plus_one = handle_layer + 1,
-	});
+	}, no_rule_flags);
 }
 
 /*
@@ -1705,7 +1705,7 @@ static int hook_file_open(struct file *const file)
 
 	/* Sets access to reflect the actual request. */
 	request.access = open_access_request;
-	landlock_log_denial(subject, &request);
+	landlock_log_denial(subject, &request, rule_flags);
 	return -EACCES;
 }
 
@@ -1735,7 +1735,7 @@ static int hook_file_truncate(struct file *const file)
 #ifdef CONFIG_AUDIT
 		.deny_masks = landlock_file(file)->deny_masks,
 #endif /* CONFIG_AUDIT */
-	});
+	}, no_rule_flags);
 	return -EACCES;
 }
 
@@ -1774,7 +1774,7 @@ static int hook_file_ioctl_common(const struct file *const file,
 #ifdef CONFIG_AUDIT
 		.deny_masks = landlock_file(file)->deny_masks,
 #endif /* CONFIG_AUDIT */
-	});
+	}, no_rule_flags);
 	return -EACCES;
 }
 
diff --git a/security/landlock/net.c b/security/landlock/net.c
index bddbe93d69fd..0587aa3d6d0f 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -193,7 +193,8 @@ static int current_check_access_socket(struct socket *const sock,
 				    .access = access_request,
 				    .layer_masks = &layer_masks,
 				    .layer_masks_size = ARRAY_SIZE(layer_masks),
-			    });
+			    },
+			    rule_flags);
 	return -EACCES;
 }
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 43d59c7116e5..6f44804c2c9b 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -58,6 +58,11 @@ struct collected_rule_flags {
 	layer_mask_t quiet_masks;
 };
 
+/**
+ * no_rule_flags - Convenience constant for an empty collected_rule_flags
+ */
+static const struct collected_rule_flags no_rule_flags = { 0 };
+
 /**
  * union landlock_key - Key of a ruleset's red-black tree
  */
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 2385017418ca..d5bd9a1b8467 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -115,7 +115,7 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 				.u.tsk = child,
 			},
 			.layer_plus_one = parent_subject->domain->num_layers,
-		});
+		}, no_rule_flags);
 
 	return err;
 }
@@ -161,7 +161,7 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 			.u.tsk = current,
 		},
 		.layer_plus_one = parent_subject->domain->num_layers,
-	});
+	}, no_rule_flags);
 	return err;
 }
 
@@ -290,7 +290,7 @@ static int hook_unix_stream_connect(struct sock *const sock,
 			},
 		},
 		.layer_plus_one = handle_layer + 1,
-	});
+	}, no_rule_flags);
 	return -EPERM;
 }
 
@@ -327,7 +327,7 @@ static int hook_unix_may_send(struct socket *const sock,
 			},
 		},
 		.layer_plus_one = handle_layer + 1,
-	});
+	}, no_rule_flags);
 	return -EPERM;
 }
 
@@ -383,7 +383,7 @@ static int hook_task_kill(struct task_struct *const p,
 			.u.tsk = p,
 		},
 		.layer_plus_one = handle_layer + 1,
-	});
+	}, no_rule_flags);
 	return -EPERM;
 }
 
@@ -426,7 +426,7 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 #ifdef CONFIG_AUDIT
 		.layer_plus_one = landlock_file(fown->file)->fown_layer + 1,
 #endif /* CONFIG_AUDIT */
-	});
+	}, no_rule_flags);
 	return -EPERM;
 }
 
-- 
2.51.0
