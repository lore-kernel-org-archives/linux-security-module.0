Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8B2D7D47
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 04:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998111; cv=none; b=E/P6kqlT0f8g6dKX/VA5Abqgzga0jlpdJPBTfawBBcz05XMBkHk18oRSHiTbdWlhVIhduhCWrRkGjBv/MeOM82pTm6JhdktMNvXVk2dTnm2fl5hb2sr015hHsUQu+fc0vRDvI+bKa8dXR7YCl/MmC5Jb5nXmJp2bI31oDGNCkKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998111; c=relaxed/simple;
	bh=ja+bbJPbRSrQwDXA6/q8IikecZ6d8Rw7OMDfeYI0NFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDk77YDvcGvA1lPDkdWqO6B6bVuPzLRwMeMngd75CiMlGqDpYhc786Jtd3gtlpXshWPKjzsGNiQla4ugr0cOjB5XcuAJBzv6AMf35TzqqbtctWGAqh5IWB7dzB292Uj8K2n+rX9DwJsjVTrNZ4bjNmt+SPH6bxrMzxezv0TGSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fkm2iDgr; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fkm2iDgr"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b54a74f9150so3338119a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 15 Sep 2025 21:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998108; x=1758602908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4GnwUXvg4e1SjHBDj7IOnsANmiVf/8g2S4TikZ2k4g=;
        b=Fkm2iDgrcPVBuaesrw7FvVYaF9dMzh7OYHeK4JX3EgxQ++R33RT7gwSxXKWspg2bZz
         5FOFvJ9AkTWPvAhIegP4B+Vj0Gy+5liVRyC8yoicuKPE5FKhfmFF8b8qV0G+MVzpCmms
         4qfEPXAE3lymVWIuTtXVTadXIAI1bFHNZBRgjs69h3p8XbsTTNKEC7MjRXJjx38eAhgc
         zaoIwDnkLZSXNeCZxzCz630o7NNmGpGKTQrdgbdy1CKScwc/89o++bjOv83NkYZeXeTq
         FO51pCkeizUOyu86k/oKP//hAvAEpA9Za35Q8X5WtgOWGeoJmw9MQI/icPPvrJpZWAX+
         n2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998108; x=1758602908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4GnwUXvg4e1SjHBDj7IOnsANmiVf/8g2S4TikZ2k4g=;
        b=r/ZOxPvSRnDNZKwlLC1JwBvAtoKjsWC7Co5sdLg6u+9lEuZbmqv/qalPDmrXPHiQzQ
         rM6B3Ot5gNQnaetCZeeHriSSCpKnyf2yeVZvdgUS35IbZr/vkA8qOvFsvJEaStrz4QEC
         rAIfzUmFE8l0ODd53jXnM21ueXYlHPsVS4csZtR07CLNbZ9fQOK5k9n9JO9iTy7YgBAp
         +K9zVsTBzjCkCffFQpQYtia6XbXPHivPtQL/DWRWEg7XCjE9ndwMzCpoH/7rELrSu0Sd
         tlVP0Xom/sFWzykkCCx+UyjbTA1P8JAnfeG3SMjqdBVry+6Psq251n2XYLwR9H5sbENK
         GJ1A==
X-Forwarded-Encrypted: i=1; AJvYcCWwNWigifRzCxcRXtSW1MbQU3fkw9+FXZDQv8vrLWf3YTY8Mg5Erp2T/JEcXBjBWxqefN2ldYMlULEaRQW5hMmcdkuFwZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfmM2kECYmAzRpJWWmYAQxy8/9gOo8/0fQTdGfKowHXYkI0Un7
	70d64zHuK5AKMLrkku7G+PlQ1dfnHrLitFVNTumOAXvSyBjpZnXQyge0
X-Gm-Gg: ASbGncsp4DAdGfwjX1R09px5f6+fxz9QFhdIbHlp65cYy2+LnUHVgshsDj7+osjwYbR
	QJZVv3GsYhDI6umr5pKz+W7CxFWpPb8T8chWaUW9rcY5fx/ODGwldc0wU41p5glML6Vi+C+evEZ
	blFo+nGqDJTKBqo/jW9FcLToifFEN+YLJOUEGnhm7LObQd0XGERSzaaLsjubFiA5Dphui/Su/Ex
	J9x/4eTjZ0Iiyis5EH5j9lL1hHk+9Njp3nU9rRGl9lxu5L8Z5K7pHCEuea5i2aiXRJpwWbWQkhf
	Vv08CF/yLA5lX16uE7U9i9cKDPbcqDla0LKIHpzo7sh+CAn2h11xIjGqm0E3uvi2kO8/2RSR46a
	8DHV2ZhPkoqDnaVnXBFqIbdFEmKMkAXf9hFFzJYk=
X-Google-Smtp-Source: AGHT+IEX+DuJO9pqL+sh6jlOJbx2wPh/MnPUcew7z+h1RxAPsxkAl191gDKewoy1JkBZ+L5tKb1L0g==
X-Received: by 2002:a17:902:ec8e:b0:25d:d848:1cca with SMTP id d9443c01a7336-25dd8481fbdmr195481725ad.35.1757998107572;
        Mon, 15 Sep 2025 21:48:27 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:27 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 02/14] drm/i915/gt: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:23 +0800
Message-Id: <20250916044735.2316171-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/gpu/drm/i915/gt/intel_ring_submission.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_ring_submission.c b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
index 2a6d79abf25b..bf73166a1337 100644
--- a/drivers/gpu/drm/i915/gt/intel_ring_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
@@ -392,14 +392,12 @@ static void reset_rewind(struct intel_engine_cs *engine, bool stalled)
 
 	rq = NULL;
 	spin_lock_irqsave(&engine->sched_engine->lock, flags);
-	rcu_read_lock();
 	list_for_each_entry(pos, &engine->sched_engine->requests, sched.link) {
 		if (!__i915_request_is_complete(pos)) {
 			rq = pos;
 			break;
 		}
 	}
-	rcu_read_unlock();
 
 	/*
 	 * The guilty request will get skipped on a hung engine.
-- 
2.34.1

