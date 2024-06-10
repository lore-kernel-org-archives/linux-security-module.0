Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911C5FBB1
	for <linux-security-module@vger.kernel.org>; Mon, 10 Jun 2024 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007694; cv=none; b=ECb6VEIUwclclfoNpuAFg3R86bwx3RjJJpHqdihN7uaIwYxU/74Oze4IyZOhfXyl+QhFWck1sRlbKylQr7/RL1/GhHZ2ZmkqMeq6ctbxY76W+XdIUy0zqhOYSunDwS8UZggqkbW4f8kkiXBssYOqPpIHJaJF84f1+JaJZItReG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007694; c=relaxed/simple;
	bh=h1/FnOTQSMTt1z4R/KEDZc+lka7aaFToV7EmZ3HCGk0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DiNx66sgibZ+53e4BmiKeLQkhFKxAM9rAhOUt8vWxCJz8nadbVzwSUht4+0d2FFg4I2ZjAQk8bo7w79iPGN5eTnUVGCPEcLrejnprjBVxpuX+ycpHlPAUAFhfOJ/sJPygOs/oP3wmCqjnYdHMQmx8s0Wlz9fNSSV6k8a+srN4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UPfdToA7; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPfdToA7"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-57a49b8a27eso1485511a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 10 Jun 2024 01:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718007691; x=1718612491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rfrEd2rTrsOZHlQKovQ5zuPOD0/iB//vkQmtjp7JHs=;
        b=UPfdToA7YDl/pI49r+CAkW60qB5/7B5N+BzkvHrmpvyEdeiPfNY9QB37ot2PtxWe7X
         MQTwnQm3UtTDfx87RkIj3/PEYmFl9ZZmQtEDqqdQnZHKchCxnwMdcPLPl+CzKrUZgWBY
         6+svRkOQHjbDqavagLtVA3gfzTayzFYiME00DDLURmCCWopAyVixoH27BCun/HnvqZsb
         JblAeBNHHBzkRMBlddpeuotVDG82Tips20/4FUvVGyjm263aQblkoQ4XUuSxWqzXrW+9
         d46We0BYum913J9K1le80NS6QVU6MdHZWPgooxcxP55+i1bJizpHYciTaoc+tK8CCBO8
         Dqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718007691; x=1718612491;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8rfrEd2rTrsOZHlQKovQ5zuPOD0/iB//vkQmtjp7JHs=;
        b=VVLpPvsW+o1gUMdofJgvJwTt/BQadwRZ85JJL9vchjSQD08R8sqz+QsPyRX8a01g2H
         2Ayiis6Rg2ioHv5pUsvoIuzF8mVCHjvVKN7rz80CTy8GAK2BiuCfTqZScydnCQe4lV1z
         r8EJgrt0s10zsyhnYjm/U/zIZ9ISbYbxWgwNamAnUDkjKmE3deKavTaLPMPOhsnG2yt3
         s/WD25sv3h6IeHskgRujYEdaYa6fUFa2qlKqrd3plGZNgVzNSZAgSZ6G+ocPRCyO1q3m
         5ydpHusUwpM90G/sjWwOlJ7P6BH/j/PaqHEnp2zm4hUMRj21upImSFCt7o14aRzgqEp/
         ozHw==
X-Gm-Message-State: AOJu0Yx3u4ZpiXW1+KsibkMWOs9Tk3RHle+pTSnn/+nRIGBOpUkIgzsM
	6WoEk3kVW2EQ/pwdjagYO6n0OzKrDlyCWY2JCfLGLZM8nQFYW3oXRCkwBDkehaVMXojOFGJmDSE
	qEfqO4jAJJ38x4077ovIhETJjJ98iFrSUvHFGPvuq6Vd9G0usa7idEcK+SkTZ/a6aNeQq22hxPD
	2/0g1QzxS3bzmiQBCCDbTjT6VaNh1372scN97IVMopUDCVDc1UNV/P
X-Google-Smtp-Source: AGHT+IEs11M1Y63786D+5Hioh7IKlJvkefxMzqedxEEgmCjuAg4YRWW46YdWl1DdalzWVwqwRbtufKe1O3o=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:5485:b0:57a:6158:a867 with SMTP id
 4fb4d7f45d1cf-57c506c6b87mr10634a12.0.1718007690802; Mon, 10 Jun 2024
 01:21:30 -0700 (PDT)
Date: Mon, 10 Jun 2024 08:21:15 +0000
In-Reply-To: <ZmazTKVNlsH3crwP@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZmazTKVNlsH3crwP@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240610082115.1693267-1-gnoack@google.com>
Subject: [PATCH] landlock: Use bit-fields for storing handled layer access masks
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When defined using bit-fields, the compiler takes care of packing the
bits in a memory-efficient way and frees us from defining
LANDLOCK_SHIFT_ACCESS_* by hand.  The exact memory layout does not
matter in our use case.

The manual definition of LANDLOCK_SHIFT_ACCESS_* has resulted in bugs
in at least two recent patch sets where new kinds of handled access
rights were introduced.

Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Link: https://lore.kernel.org/all/ebd680cc-25d6-ee14-4856-310f5e5e28e4@huaw=
ei-partners.com/
Link: https://lore.kernel.org/all/ZmLEoBfHyUR3nKAV@google.com/
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 security/landlock/limits.h  |  2 --
 security/landlock/ruleset.c |  4 ----
 security/landlock/ruleset.h | 24 +++++++++---------------
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 20fdb5ff3514..4eb643077a2a 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -21,12 +21,10 @@
 #define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
-#define LANDLOCK_SHIFT_ACCESS_FS	0
=20
 #define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_TCP
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NE=
T)
-#define LANDLOCK_SHIFT_ACCESS_NET	LANDLOCK_NUM_ACCESS_FS
=20
 /* clang-format on */
=20
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index e0a5fbf9201a..6ff232f58618 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -169,13 +169,9 @@ static void build_check_ruleset(void)
 		.num_rules =3D ~0,
 		.num_layers =3D ~0,
 	};
-	typeof(ruleset.access_masks[0]) access_masks =3D ~0;
=20
 	BUILD_BUG_ON(ruleset.num_rules < LANDLOCK_MAX_NUM_RULES);
 	BUILD_BUG_ON(ruleset.num_layers < LANDLOCK_MAX_NUM_LAYERS);
-	BUILD_BUG_ON(access_masks <
-		     ((LANDLOCK_MASK_ACCESS_FS << LANDLOCK_SHIFT_ACCESS_FS) |
-		      (LANDLOCK_MASK_ACCESS_NET << LANDLOCK_SHIFT_ACCESS_NET)));
 }
=20
 /**
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index c7f1526784fd..0f1b5b4c8f6b 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -39,10 +39,10 @@ static_assert(BITS_PER_TYPE(access_mask_t) >=3D LANDLOC=
K_NUM_ACCESS_NET);
 static_assert(sizeof(unsigned long) >=3D sizeof(access_mask_t));
=20
 /* Ruleset access masks. */
-typedef u32 access_masks_t;
-/* Makes sure all ruleset access rights can be stored. */
-static_assert(BITS_PER_TYPE(access_masks_t) >=3D
-	      LANDLOCK_NUM_ACCESS_FS + LANDLOCK_NUM_ACCESS_NET);
+struct access_masks {
+	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
+	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
+};
=20
 typedef u16 layer_mask_t;
 /* Makes sure all layers can be checked. */
@@ -226,7 +226,7 @@ struct landlock_ruleset {
 			 * layers are set once and never changed for the
 			 * lifetime of the ruleset.
 			 */
-			access_masks_t access_masks[];
+			struct access_masks access_masks[];
 		};
 	};
 };
@@ -265,8 +265,7 @@ landlock_add_fs_access_mask(struct landlock_ruleset *co=
nst ruleset,
=20
 	/* Should already be checked in sys_landlock_create_ruleset(). */
 	WARN_ON_ONCE(fs_access_mask !=3D fs_mask);
-	ruleset->access_masks[layer_level] |=3D
-		(fs_mask << LANDLOCK_SHIFT_ACCESS_FS);
+	ruleset->access_masks[layer_level].fs |=3D fs_mask;
 }
=20
 static inline void
@@ -278,17 +277,14 @@ landlock_add_net_access_mask(struct landlock_ruleset =
*const ruleset,
=20
 	/* Should already be checked in sys_landlock_create_ruleset(). */
 	WARN_ON_ONCE(net_access_mask !=3D net_mask);
-	ruleset->access_masks[layer_level] |=3D
-		(net_mask << LANDLOCK_SHIFT_ACCESS_NET);
+	ruleset->access_masks[layer_level].net |=3D net_mask;
 }
=20
 static inline access_mask_t
 landlock_get_raw_fs_access_mask(const struct landlock_ruleset *const rules=
et,
 				const u16 layer_level)
 {
-	return (ruleset->access_masks[layer_level] >>
-		LANDLOCK_SHIFT_ACCESS_FS) &
-	       LANDLOCK_MASK_ACCESS_FS;
+	return ruleset->access_masks[layer_level].fs;
 }
=20
 static inline access_mask_t
@@ -304,9 +300,7 @@ static inline access_mask_t
 landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
 			     const u16 layer_level)
 {
-	return (ruleset->access_masks[layer_level] >>
-		LANDLOCK_SHIFT_ACCESS_NET) &
-	       LANDLOCK_MASK_ACCESS_NET;
+	return ruleset->access_masks[layer_level].net;
 }
=20
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
--=20
2.45.2.505.gda0bf45e8d-goog

