Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550961AC24B;
	Thu, 20 Jun 2024 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903740; cv=none; b=j2qeDS/mf7OjP09ts+i6cAws8NXYJL5M+Yj/S3gw7zqZWIMwKinUuaA8U0+0wT0qqnOgIIr75+u9yDPQzAMMOxppueoaN2nFEka9JYPNZT4YBQmwEuoAhCZkBwFVV2yTJnY4QBLicdgvR+a3vudVlZswtTbJuZt6oeEH1d9s7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903740; c=relaxed/simple;
	bh=gT12HUOyeQpAnsBYlpUmtkBdVmuOFZO12M6sDqqDb+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jrVYMDU+hyb8GE6yHXNmcSDJXmJq1J6BzjqyaY4If3YCnbYeeNbv24NHheNSW3yW3GC3i4F25s1lHvsXD5c52aDj126QkEdRoFjQS/b1g0xnSpCVg+o45Cl68d/lsBeCwEeXwu8wRTayU69F2Y/moSGN5aaYzghMKEMl5+YAob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/OpYAIs; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/OpYAIs"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so13639901fa.0;
        Thu, 20 Jun 2024 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718903736; x=1719508536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aYg/fQs2+kuc4laJDOi7nR98E30rR5KMEuEzLwwwI/U=;
        b=S/OpYAIs/m0mdvCc+QXDihYLMUiqTThV1kJQZs3aE1DPZf22eKQ+rVk31M6E4fy+sV
         cO3c3DatQXr4dnj9rgbobYzzChnzd5X8dAn0gjpLxJ97H5KR5r3Lw+9Jo7Hhw2+vW1tD
         szpt7+D8WjPeeatuo3nQY75U1mZhTpwIL3FCyo+4CZ+5riFVEc05VvFHlFfPy4Vatkfu
         jAEcb/QpTXKb5NoRzA/nRch1hdYJWpts2SiEoRW3i2+z/oDcFQAtSWJ3KSLhB8pF8dqZ
         Qcsq8hfAd6Umk2DINpouN/bweSAzxLfCgHsQaPcDqqjcuoyJktgKutF5sqDV7xVn6+f8
         H6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718903736; x=1719508536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYg/fQs2+kuc4laJDOi7nR98E30rR5KMEuEzLwwwI/U=;
        b=KqndabjuTSVd/HkKLfbSQXVYyZJYcLz8TLfzXfrrosTKxHDfiqvOY/cqzH+w1wkA6K
         gPc13VrT5hCp6W7rJcsD51d985EcBh6f4NrAaj9Sc74QgqyISIGN/nj7VT1F5OysXcYS
         OLMAmLMI9AYwXH7HnX1tk9j/tNmlFC1FeB9xQ1tCSaVSnRzHPI/yBpOx4dBKsgPjuyu+
         Ht3qDASrHoDjZ9PR9WTRfGN1G9QiiOUtJ56TcsTLybsiVq42VL/lV7KXuVjDR2h40D+q
         0YWJMCORD6c62rRgseREeM2na1Zg7L2yqWOMuGPErRtQjre1xKN6CPus5CwhItAVQRoU
         OOew==
X-Forwarded-Encrypted: i=1; AJvYcCXWV059kN5Im4nymDlUP5DC2X94mttlrK1urOx4iReUhWscbA074dEjoOUYBVeswcmk4fk9vgzRrBv+/DeG5GtjeT/WseuQwbeRbSQ/sVFXcTaSMaLtUdEtEWpypDqZpa2q3fcLpQ/chxtVvfAqYjjFCKYs
X-Gm-Message-State: AOJu0YxkXYdQ0UzuJCvWH/bnVtYWfltFbfkoFevMpxMpVVPWOItVH/kp
	6LwsvtL206RYGHm3XShb7j7aatXk+TTl81r4Q6TjQUc+4PqSNUTe
X-Google-Smtp-Source: AGHT+IEiryEnHRn0pakoC9f3F0xz4DDlqEixJnJvkaTjsTfaWq0cDwBI+U6mRxj1AIyUk52rmV5xKg==
X-Received: by 2002:a2e:80c9:0:b0:2eb:1ac4:c9cc with SMTP id 38308e7fff4ca-2ec3cfe1c38mr35389951fa.52.1718903736064;
        Thu, 20 Jun 2024 10:15:36 -0700 (PDT)
Received: from f.. (cst-prg-30-39.cust.vodafone.cz. [46.135.30.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cd449efd6sm6333746a12.45.2024.06.20.10.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:15:35 -0700 (PDT)
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
Subject: [PATCH v2] apparmor: try to avoid refing the label in apparmor_file_open
Date: Thu, 20 Jun 2024 19:15:27 +0200
Message-ID: <20240620171528.167997-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

apparmor: try to avoid refing the label in apparmor_file_open

If the label is not stale (which is the common case), the fact that the
passed file object holds a reference can be leverged to avoid the
ref/unref cycle. Doing so reduces performance impact of apparmor on
parallel open() invocations.

When benchmarking on a 24-core vm using will-it-scale's open1_process
("Separate file open"), the results are (ops/s):
before: 6092196
after:  8309726 (+36%)

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2:
- reword the commit message

If you want any changes made to it can you just do them on your own
accord? :) Will be faster for both of us than another mail trip.

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

