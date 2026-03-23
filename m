Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CBE3C062C
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285100; cv=none; b=Kc0m5Jh+Txt6kChium/49sSJ6EXk8EcrOoIPV0blvUJFpLoOTQ2njLeefdpIuBvq9BFnCXmU75gsjbqVTK71zUP4gavGKlvkUG9zHwl6/tS2SHItZU8FKZAmh3ED118wB59WIHzZ9v87oiNBwheuJ6Zfpiwk/HHT7zRi17YXXr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285100; c=relaxed/simple;
	bh=pqMlMz9fQuXVxlfi9OoB+KzPBhR2LCdq6SwUKsE66Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYuoiwthwD9Wq/z4PviNAiIzah34lItL0Nzsl7I8EZb72L2iTaC333U69yg+C8vCNl6X/qMRLF7VzgbdSWvlaLIRieZpdYOkqhh8ltRVKawWBE/W1N+Rtuq+JzNzXJx8rOcRxXaNaniXlLhgIYeXQ55Ynva+1qJVy1xsoLkD9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNc/HIa5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNc/HIa5"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b2965d4bso2153059f8f.2
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774285097; x=1774889897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aQax15r48x8tChpHGKVeKbVuYDhcPcODm0KgJerdHY=;
        b=HNc/HIa5a3W/XTkFPH+iGFU0p02HA4+DWtJNsSNnmxAJ3WFf4M3GRoynUbOg7ldFk+
         gkfYdHsSmpGkBbH9HYXj6GWQHVIYCGDA20v4zsp71Rm8JYevPws3SKE/WmsH6o+NMcJu
         FNkpHzIlifsmqTARDxFRalbntsAPugepNev0DKQOMJ92q99tK/9Vk4+bjvm0WZ8mzwin
         AcREQOthX9L7S37LpZFHUdyQexXwy8G7wEmHB09JCOUWyhvmfZgYcOW7zVJ8v/7CSmiD
         bfco64JY1WhHx4AkYXdvjrGyQ0Ozew2qlgTlktoWZnSQezuCgbrtOAfpe5CO7DN5ja6M
         P0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285097; x=1774889897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2aQax15r48x8tChpHGKVeKbVuYDhcPcODm0KgJerdHY=;
        b=tRZuyXakV0IWQDwzA5OmyUDuHjvv+GiAsBLUfFXHeoiEbO8K+NDRwTVgFsNAxEbybE
         B0Xzmp9KFB1FJNxTeIorydzq0qM10rDQTmjme2clU1c1fASCF17rvvx2cvOnnP4jP6Lb
         zpr2paAssUcZf58wjG714BNGoh4RFIBxpVmt5nFww/YVWaRQR5QRhEjwqciSdbxelBzj
         g8y/rUVhDjY6EWX6uyhfA1bj/937iYWzmUTutxHMvYllWQAgOZL2b1FA8UmC5rYPw+6i
         yh/0J9hOwVnXjByYD74wKZTKBRZHInVF3y9iHGdvCIkIiqwwKDTfqySBNPMBaXygpzHz
         iZtg==
X-Forwarded-Encrypted: i=1; AJvYcCWz5ZlX1D6DO46Mf1QbI1VaewNr67SI2o0wPzotuAqzwzJfCpBbP1wotscYMGBvDuRGV+P/4a9lJ+GxHpxR12TPrxUpSoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+hvG/8dFxp7dqQpDfi+RpiEDrqnPiHLpSCnqQIb3DJqpDxxz
	MCnHa3515y0tAMJrtMWKxWtnfZO+hOOAgyrSFL/b2QxIJ6colxRIzvuU
X-Gm-Gg: ATEYQzxT2liq88scS+LLBy9hkIST6e0cHC7qPoF5TJhjclwcSVnvlcnCxNrNRc59QL2
	S6hAkgzDKPIXD9D4Wd5+5LyWZ/oNM5moqVtFsW+t0ZgVBZWAfsqaGQlAuHZ7fwAqOYfWYt+xUQX
	WAKn9LIC5pYBaUZLB0mBG9ElST26hWB5aJIOjsxl3bvDhVHlCX4WCwEGVDz5eqI/MWNyGKq+oIJ
	Dxw/BlzB1RpTPSrmNuBpZhwzcimCpby2CrdA6lga9Znez4xtbQv5+Kp7Hv4ch+WmKGOjW52o7l7
	mmltTbFmHmj2LfwW6f8PKwL6sSXyuVIAOHSiumDtsjitWYIjOQ30Oc5MYZQYHJvWO0N4qOZRHcI
	tViMBn8QlRrL0rXRUtQTcwdHtEbadjJBHzYzxm5ICeUZVs7OmZDZFBi8eolouQYySV8i0elxrWX
	zV/WvibKYAM2tWAmlI+z92aoSr2uXTTTavn1HHK5b7A0aXyJWa
X-Received: by 2002:a05:6000:2c0e:b0:43b:410d:c4b2 with SMTP id ffacd0b85a97d-43b6427d238mr20136577f8f.29.1774285096797;
        Mon, 23 Mar 2026 09:58:16 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470393fsm32066292f8f.17.2026.03.23.09.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:58:16 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Kuniyuki Iwashima" <kuniyu@google.com>
Subject: [PATCH v7 05/11] landlock: Clarify BUILD_BUG_ON check in scoping logic
Date: Mon, 23 Mar 2026 17:56:47 +0100
Message-ID: <20260323165654.193957-6-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165654.193957-1-gnoack3000@gmail.com>
References: <20260323165654.193957-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The BUILD_BUG_ON check in domain_is_scoped() and
unmask_scoped_access() should check that the loop that counts down
client_layer finishes.  We therefore check that the numbers
LANDLOCK_MAX_NUM_LAYERS-1 and -1 are both representable by that
integer.  If they are representable, the numbers in between are
representable too, and the loop finishes.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/fs.c   | 9 ++++++---
 security/landlock/task.c | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index fcf69b3d734d..c1ecfe239032 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1595,10 +1595,13 @@ static void unmask_scoped_access(const struct landlock_ruleset *const client,
 		return;
 
 	/*
-	 * client_layer must be a signed integer with greater capacity
-	 * than client->num_layers to ensure the following loop stops.
+	 * client_layer must be able to represent all numbers from
+	 * LANDLOCK_MAX_NUM_LAYERS - 1 to -1 for the loop below to terminate.
+	 * (It must be large enough, and it must be signed.)
 	 */
-	BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
+	BUILD_BUG_ON(!is_signed_type(typeof(client_layer)));
+	BUILD_BUG_ON(LANDLOCK_MAX_NUM_LAYERS - 1 >
+		     type_max(typeof(client_layer)));
 
 	client_layer = client->num_layers - 1;
 	client_walker = client->hierarchy;
diff --git a/security/landlock/task.c b/security/landlock/task.c
index f2dbdebf2770..6d46042132ce 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -191,10 +191,13 @@ static bool domain_is_scoped(const struct landlock_ruleset *const client,
 	client_layer = client->num_layers - 1;
 	client_walker = client->hierarchy;
 	/*
-	 * client_layer must be a signed integer with greater capacity
-	 * than client->num_layers to ensure the following loop stops.
+	 * client_layer must be able to represent all numbers from
+	 * LANDLOCK_MAX_NUM_LAYERS - 1 to -1 for the loop below to terminate.
+	 * (It must be large enough, and it must be signed.)
 	 */
-	BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
+	BUILD_BUG_ON(!is_signed_type(typeof(client_layer)));
+	BUILD_BUG_ON(LANDLOCK_MAX_NUM_LAYERS - 1 >
+		     type_max(typeof(client_layer)));
 
 	server_layer = server ? (server->num_layers - 1) : -1;
 	server_walker = server ? server->hierarchy : NULL;
-- 
2.53.0

