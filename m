Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E31E49E;
	Thu, 20 Jun 2024 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889335; cv=none; b=Rof6SR5aJrWEDBmB9R0+N/3T1P4iJPV7wqeOgs8QP4B4omRiLGI2wjOQrwdd0W4tYoXse69EF6f4FeTrQdQf2tH0eB1uMWtGAXgCgF/av54oBiKW7iklDZRXEvHslFT5V7cZW7bzDIkGQgrI0tlosFLV+1RO4PR1Kty199/kZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889335; c=relaxed/simple;
	bh=Dm+OAoDNq27a8NmdBwsCJshDlb5owqtvCwqqIvl+zsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=INstyemNZrynsY17W7ErAdqKmTsVyRB6Ym9Mzbno4WOUoP8Yc4hkKeYr9NuR0ZX7SY7tQ3bAC3awGn3O4houH1npXFYH5XIDqdXGFkVw9ZzE5WdO9xbaoBJRvcZBwNm2JO1S83OrlRZDPdABpe/+tfBkh0nbMLdCX/GV/cun5/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDU2na7F; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDU2na7F"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6f8ebbd268so330896566b.0;
        Thu, 20 Jun 2024 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718889332; x=1719494132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvxuvoBqoE/GY1YheFb9DI1s4W2tvYezeKtzJ7T24dY=;
        b=JDU2na7FFY87GS6cg1I9dAXj5c8Cprpx4I6LhnUAtUXgjURRLgpuFFjub4EwLT2KWA
         c7XveWEzLC7BD5/XiIc7y80lEF4wBOuQ0gJSIF5h0jJubtikETqQrc+xZRNngkYt1MME
         o9yiD72LywuUVXiC5x0ki7GwQiqeIQbm3iEBAdqWxnWz4RkP13y0mZcnl/lcwInVGJxL
         lj5vFpr+nqMoTik9OcSiNn6tkbcAp9+oxj8XIcRME3COk5ibC6BdpS63DeG2PQn1x3o5
         CHItPil0O0fcBXYsxze1v3KkK+IRNQO9D2AQSwYmT05KlBacWTgU85OwxxAXUjXC3oqB
         Vnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718889332; x=1719494132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvxuvoBqoE/GY1YheFb9DI1s4W2tvYezeKtzJ7T24dY=;
        b=e3uZ1TsPHO5Av/oolfdx/V3wYimyQB+1pE1hg87q/n//nxlCuKe04QIYuARQgPePin
         Hvc8sRQ5sK0LDnDsjrNrKmcRF+QeAkEpTpn9XVbrJncqUcu4qQjLAkQQQTjruv6rmnyz
         KfXzXxWAnEOXipGNeG7uQxTgdnjAZ49mXexgPlfEZBgXoMUa4252jBrma2L5rvTKB3Qn
         SW959WYUthJ6zahlIqpQEf8Mi0kfpgK96pedHnpiHWNv2bLNkMYku6ymLjWRwvEWI/1t
         nuYFxOtor5dC0bTIDjsQBYQnH+eFMJooVG4c4l+C8eAOCEpWf2t564rTEY99XJh55DNd
         rE1w==
X-Forwarded-Encrypted: i=1; AJvYcCWyG2qTf5dhKAGtkL2n+s6Fpzg1On/Od8Gtt+jsYmQaHKUh/9xDuIcFN9TTbrDhXp0Sxv4kne4GSfzV2KcJkkIi2xLAXsZMuvuK3nnDg8g4dyKQcRuI1jwWeXs9mbM4n3HsnL4ps0Ut9YO4/OIdNECVj9gB
X-Gm-Message-State: AOJu0Yz6UoNIILNiklMDBBT5jeHhjAKNKLzhEeQUr2mVmDS5JvtX7Zz0
	GonOLJGFUIHGftsSL5rtWm//c9fevVEzIrLO/oPKQR3X3b166E2Y
X-Google-Smtp-Source: AGHT+IEqnJp1SNZXbYGPZ0xa9ovKenpl+H5Wg16kK3FxOFIVW8FaphRKTrag0JDQQqPQVJ6VlHxa9w==
X-Received: by 2002:a17:907:a645:b0:a62:49ae:cd7b with SMTP id a640c23a62f3a-a6fa438df9fmr358825866b.24.1718889332198;
        Thu, 20 Jun 2024 06:15:32 -0700 (PDT)
Received: from f.. (cst-prg-30-39.cust.vodafone.cz. [46.135.30.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f881fbdfcsm370454266b.121.2024.06.20.06.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 06:15:31 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: john.johansen@canonical.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	Neeraj.Upadhyay@amd.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] apparmor: try to avoid refing the label in apparmor_file_open
Date: Thu, 20 Jun 2024 15:15:24 +0200
Message-ID: <20240620131524.156312-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It can be done in the common case.

A 24-way open1_processes from will-it-scale (separate file open) shows:
  29.37%  [kernel]           [k] apparmor_file_open
  26.84%  [kernel]           [k] apparmor_file_alloc_security
  26.62%  [kernel]           [k] apparmor_file_free_security
   1.32%  [kernel]           [k] clear_bhb_loop

apparmor_file_open is eliminated from the profile with the patch.

Throughput (ops/s):
before:	6092196
after:	8309726 (+36%)

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I think this is a worthwhile touch up regardless of what happens with
label refcouting in the long run. It does not of course does not fully
fix the problem.

I concede the naming is not consistent with other stuff in the file and
I'm not going to argue about it -- happy to name it whatever as long as
the problem is sorted out.

Am I missing something which makes the approach below not work to begin
with?

 security/apparmor/include/cred.h | 20 ++++++++++++++++++++
 security/apparmor/lsm.c          |  5 +++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
index 58fdc72af664..7265d2f81dd5 100644
--- a/security/apparmor/include/cred.h
+++ b/security/apparmor/include/cred.h
@@ -63,6 +63,26 @@ static inline struct aa_label *aa_get_newest_cred_label(const struct cred *cred)
 	return aa_get_newest_label(aa_cred_raw_label(cred));
 }
 
+static inline struct aa_label *aa_get_newest_cred_label_condref(const struct cred *cred,
+								bool *needput)
+{
+	struct aa_label *l = aa_cred_raw_label(cred);
+
+	if (unlikely(label_is_stale(l))) {
+		*needput = true;
+		return aa_get_newest_label(l);
+	}
+
+	*needput = false;
+	return l;
+}
+
+static inline void aa_put_label_condref(struct aa_label *l, bool needput)
+{
+	if (unlikely(needput))
+		aa_put_label(l);
+}
+
 /**
  * aa_current_raw_label - find the current tasks confining label
  *
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 2cea34657a47..4bf87eac4a56 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -461,6 +461,7 @@ static int apparmor_file_open(struct file *file)
 	struct aa_file_ctx *fctx = file_ctx(file);
 	struct aa_label *label;
 	int error = 0;
+	bool needput;
 
 	if (!path_mediated_fs(file->f_path.dentry))
 		return 0;
@@ -477,7 +478,7 @@ static int apparmor_file_open(struct file *file)
 		return 0;
 	}
 
-	label = aa_get_newest_cred_label(file->f_cred);
+	label = aa_get_newest_cred_label_condref(file->f_cred, &needput);
 	if (!unconfined(label)) {
 		struct mnt_idmap *idmap = file_mnt_idmap(file);
 		struct inode *inode = file_inode(file);
@@ -494,7 +495,7 @@ static int apparmor_file_open(struct file *file)
 		/* todo cache full allowed permissions set and state */
 		fctx->allow = aa_map_file_to_perms(file);
 	}
-	aa_put_label(label);
+	aa_put_label_condref(label, needput);
 
 	return error;
 }
-- 
2.43.0

