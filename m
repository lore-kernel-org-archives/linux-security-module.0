Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020218;
	b=dQhFQQJiKBauXH0VbzPy4LzM92uRi30sqV3LZTQsLkT4Sr2DlJb2keNU0eACp5Ox6ZA4
	 1Du/UVB3TOqM1jkbSiWM+MBeRgvMTslVqUHuNV/30INCYfRIFfH1rwHrMab7VSvhmQqzp
	 efIaUpQIJDIgM79BUdgHqd/LDnJq0NWUY5a0wAI9VfwcxTfJZ7070w4aRAsAdDFVlhAhS
	 /SbltNn3S/l6cVu9cpNrB05BA9+oDsD+YRiINcuPtvFR0ZkUbgfGkb7HCvrgitWC/6MIa
	 AscrMu+Vi5e6KYY3snE5Jkk6XfhLUXDlg/++xVu3YTdHKxl+2ku/RlNzMnQhwD0ZPNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oEEJJC9jODdw1pW8piHdfakNer+PeiPEMKJmH+dgUIA=;
	b=hBIz/o1/OSY/i7xzAij8VSfC0TAh+dmkFNQhzdSU37rGUQBWVW1iXippFiR9rp2cmmgo
	 oUgiCl1W1yh7lj/oOJY0fM7QpTtKhqz3Md8u15XwqEljZp0u6jpxqRfCWiSYoWs6ZsZr7
	 p59YFUFNoOy/5Jkh8NRhrDahr6hh8QCUMTNYIE+sRlAZ91bxrqDd5DtjMO1bSQJEv/DfN
	 F823kUps4gOQcUfIGuyrFki10essFD1E2jWTnIUuAZojNHdpzoe8WSjPT5xUZr6/cr1Qv
	 jmi3GaK/+dx3+fcxHmGxanYRe4Njq0+2lwtQUL0e14IKQ18ywXfiHaNKyJ2ug/Zeutw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gvsexElZ;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B822E606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 13:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B822E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gvsexElZ
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso1706140f8f.3
        for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793020216; x=1793625016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oEEJJC9jODdw1pW8piHdfakNer+PeiPEMKJmH+dgUIA=;
        b=gvsexElZ57Blas3v3GaPwCHAHlwv0U1WXoLKRI135E4lbJmYYDOR5zX8UVIIWZykTL
         vHblzYSY7pfR6tWDnzsrHlHZ2fRXc++lmKPBh1q0hdWs4fd8j/HekPHVDgNKo7LFbLvJ
         R4dOy3Ist/auAgXl+10Aki/CKwaDZ5IuPEDEE4jaETP5hl0HSQr9KHHOst1YXyBZPSfV
         VoYcXXm53dxhSjmuLB2bVhntrxbfJDwAm4GVp57TKs5bgS5rNxa1b2OeO3AO2541rhmq
         NXgdLbnzVMx7E/1ZEU/KUoKG2wFRWMP6mfrkXuSFmM7s0T8qaKq7NJ93ktbRUhb2KvDP
         tTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793020216; x=1793625016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oEEJJC9jODdw1pW8piHdfakNer+PeiPEMKJmH+dgUIA=;
        b=EQ2vWZfAJppRzQYcCp/UVsKUgoRW9JsXXE+8zSwRTovlFWXNaecetAhii2eYBuwbBk
         eM7WIT8yGyHC1DtFlfWpYloakssHHY1ttt1SGN5S9d6zZA+ZJIwP3XxcEWl65vrzL5Od
         7l0qc4e1c35ZotUfwnHmkMAnnx7Wf+3ATiyKPiKxAZb7HKutXIqeY2ndpo5XqHsnfqN9
         g6EITV2zyveCmNYL9baOgQ8qe9/xEI2im/2m4TNzvzPqMixMiqCQUaAy0zUO2wd8aM/i
         h8uzMbcWAUeyu05G4eeCtcgLU0PP9597TVCywiQmI9oBS//tErYUiHH7VYOLTM96GaA5
         1KGg==
X-Forwarded-Encrypted: i=1; AKwUvBwO7PN7fCaZXIiLvBiPJ3bOEAV2Ofpi4J+g5GIJAUhD1WWfXwnYgqOfaliv5MwQYVkPKkhP6etIDOXq+FSgTaYXu/gCZxA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoTodZ9gsMja+mDxt7DXCvveOOPuliwgEG65Juz7p1yzpVhtUl
	sXJMHr4O45jX64+sdRJmv4oj0yCZ3Wl+Fv8QWBOnvBogLApFeWGMcVqT
X-Gm-Gg: AYBFou0eRkfSJ+YLNum/0uIagn/5JSVRB2mBdo7QgroWk6dJD1rOfEG9xdatOGN3jpx
	fk0hK2/SG4vqwwUJH+U7R2+U/NPbpHl7BLAKRFJfkq8QNq9rvjwaLEGlwghXgWXICbicxOr3WeF
	0v8Vyl+tgHZgERZ3GIF+SJrLKVeAfSgnPSbvM0V6SETos+LgfBvFvO1dmkuUwA/7LW3wIhYQ3WX
	HkKsvNTnqNh+k2uU058u+vf5VEaVB4prYcQ7ug2wA00+GO1g4PlFbOPbVcCFBFaQKAX9i3/tx3C
	KafncfiThFm9TZTjCXhtKQ20BDOCnhPY84YU+45T4E4/A6R7skc0yyiec1rOfwUiYnQIrSPLe3F
	tqveY2WfAa9IEMPxclfKLGLTuGlGQtG4kI5dDzlZbb26/zcxTRaF+44IUbp6tm5+RYzslULbrvm
	Z9ea4lHWGIWwJWfi2MyYskBnkqx3MsZexFSs2oKWvxm6MPPNp0UKIMfmYvkQyTt63yyEUgM0e7P
	KXwHC60ed8wA39hkOYiwqm+1UkI/wqQ/KqEoAKwe/8eK451Et4KsS/FwjqTCi5gSo6I9UWYqY1D
	sHee9aiT+xdJ
X-Received: by 2002:a05:6000:2610:b0:48b:11e1:8bc8 with SMTP id ffacd0b85a97d-48e3eb96be5mr11506725f8f.39.1793020215770;
        Mon, 26 Oct 2026 06:10:15 -0700 (PDT)
Received: from adriano (76.red-88-24-137.staticip.rima-tde.net. [88.24.137.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e412cc164sm15323945f8f.7.2026.10.26.06.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:10:15 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Serge Hallyn <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v3] security: commoncap: drop stale CAP_FS_MASK FIXME
Date: Mon, 26 Oct 2026 10:10:10 -0300
Message-ID: <20261026131010.1822069-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CAP_FS_SET is exactly the set of capabilities that an fsuid of 0
historically granted (see CAP_FS_MASK in include/linux/capability.h),
so cap_task_fix_setuid() drops that set from the effective set when
fsuid leaves 0.  Remove the stale FIXME.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
v3: just drop the FIXME instead of replacing it with another explanation.

 security/commoncap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 3399535808fe..484d2b9256e9 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1171,9 +1171,6 @@ int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags)
 	case LSM_SETID_FS:
 		/* juggle the capabilities to follow FSUID changes, unless
 		 * otherwise suppressed
-		 *
-		 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
-		 *          if not, we might be a bit too harsh here.
 		 */
 		if (!issecure(SECURE_NO_SETUID_FIXUP)) {
 			kuid_t root_uid = make_kuid(old->user_ns, 0);
-- 
2.51.0

