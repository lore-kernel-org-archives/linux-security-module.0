Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22537C0E4
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592154; cv=none; b=TRF4umzBLzWjVl/ySN79KmkhuGDTWzkiJHjVsFy6bs83JfX6TcIOve4+17a9gXYqI/zumbG+6UFPnG9q44A8AQfuHQGHhf7y6Ca3Ymx84/wXXssznJ+l64arfvSO1ZbSUPkY0BfRh21wVKHWYYgFTg3XEy1eAGTMosqKtNkIRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592154; c=relaxed/simple;
	bh=1YZm9Km2g/4He2abMJUbVPzWzEAy6t/GkzsPI6yRllo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEQS86OP+rJN0IdXCX9YPNMH/thf4aFG6DiupQWPBAynhoT073G6Y3NVcdkjXERuQUUGEsu8tVKGbMTq3rB0dVwP3JxZmP/OK0Oor+j7ss0O7ZZ2VykoACIlOoKj/yWbAkDhTCxEIPYJJuPK3Wwvpb0J4oQGISv9N89AIrmQjWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1hQoGnJ; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1hQoGnJ"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6501d32b04bso6088932d50.2
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 13:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592151; x=1776196951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxZmDGuH+b1o7aqh0lLdFfHGJTB8lb/1qma6OWy6m8U=;
        b=A1hQoGnJAesUcu46FkkvREJrsSP0xdvxPZWVSTNQMtU+QBo2g2ipB80ZEfn6/DmDvM
         Ss8OT6KR/dFarp9R4VpnYk1MDCQRby5EdKwqmkbnci0tyJ600mg+ukUr+K24w9L88nvm
         z4h3xjBPycKhxntAnL64ShztpOeGpAkEoPcRCc849Quc2SjR5xSeGGJLA1tAYloTJdxT
         /+qFrAGOYNToFQH+Bq/8/d1HxyfLk3x36vGZNci1vjHYM7RnUVCc6AwIzpw1fgBs697Y
         X7EIO4TDmrtpFn27qsGAZAHkskmnnJeL2+nyISBp4XjW+NljueNapKnLdq197PFjf7aJ
         LIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592151; x=1776196951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mxZmDGuH+b1o7aqh0lLdFfHGJTB8lb/1qma6OWy6m8U=;
        b=niitCSUFBM5kKMC2sjSFd743Em72h8ePA6MKhM5b/wReH2usGeB/HR1OK8DOS4IIli
         NG3pzE/mkxk5IMqdwyICi3TuadQM4WUvz6ROIcmWwDx0S+0m0WIyTOb6KOA7nbOpV+bC
         khZoeRMpx0EXCNM2gnEaf2KWRU9ZHUQpa3+uirxmYwHT4xP/74poBpP6N4sDI0bsCpnc
         +1+vrdWKIMFTmOZ4W+/FQbIcyV6cec0jkYVCywUdzRXEtNeDfdscTVIuDTWnH/BpG+ik
         +IgRbneWFD9IdV3Cue6rr7hFG/Va0ak9s+0WYKH1FgX1cbtouzpHeh3YwNvwcZ+UiUb2
         mCpw==
X-Forwarded-Encrypted: i=1; AJvYcCWmYEeIcUTrZdSYNN85I/1yvfotWAZvDIiH91owae7LuzLdhZhT1AIvfTuRt7koVFn6WfEK9RrOcVgx6fVl8+pY72IuljE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgGys3JA0P2/LQwnxF9cvAu0zVfTGuMjP4CsKajSwGYxgk0G/J
	xOhdppNPZXB8TdEGEmAGDaiPhW3kQ5KXTMWJko7fof2irejfG95z+R9t
X-Gm-Gg: AeBDietBmUx86Fp5753yW/fpkDooJSdtEo6DLqEfWamVKMrAlGRsx+M0O7TF9vM4I4t
	tDxi7mE5xwFFcy3pe4W3OD+faFMRj0nrb0Wc5o/GOrT+yRvVbTXQ3m00b72z5d8I0OdX59japi1
	9JkiFSiYIgklVeWm7VWY1mMD7GM6POCxunLnvs35G0d1m98xonn92p7Xi76rXy+U0c1vk6bj+6Q
	7mCJcmAFb1HMOpVesteBDS6xj7UJ3/nWLPXrfVIqQj4R5zqEPppEkxEr+EuThSc5HZNkwYwqi3+
	PNWVRE9wqSgVGOF5Xnc5qRWo2Z53x5Yrv+lScc12JH4Q3de1zFoh4buoPb5bM+SGCGd6GBQN2vW
	jBhENrEOBGg5BPLGrSfjHgfHmzsr5U1gS5qzTmhuWD8bbbrCwoixG3eaNhhMkYTEIuWjKYkXBYl
	9UgCR1Xll3rPE00UQhQQ5Ipj5UlnlJZEgtCTscx+nFbMaTf6rN6Qnn4XE90h4GuSWoXGtfyu2f
X-Received: by 2002:a05:690e:c49:b0:650:77e5:84e5 with SMTP id 956f58d0204a3-65077e58678mr6105788d50.25.1775592150185;
        Tue, 07 Apr 2026 13:02:30 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:29 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 09/20] bpf: syscall: Handle Landlock ruleset maps
Date: Tue,  7 Apr 2026 16:01:31 -0400
Message-ID: <20260407200157.3874806-10-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow userspace to create maps of type BPF_MAP_TYPE_LANDLOCK_RULESET via
the bpf syscall. If CONFIG_SECURITY_LANDLOCK != y, these
programs will still be accepted by the verifier but return an error at
runtime.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 274039e36465..e885451b64a0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -48,7 +48,8 @@
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
-			  (map)->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
+			  (map)->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS || \
+			  (map)->map_type == BPF_MAP_TYPE_LANDLOCK_RULESET)
 #define IS_FD_PROG_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PROG_ARRAY)
 #define IS_FD_HASH(map) ((map)->map_type == BPF_MAP_TYPE_HASH_OF_MAPS)
 #define IS_FD_MAP(map) (IS_FD_ARRAY(map) || IS_FD_PROG_ARRAY(map) || \
@@ -1488,6 +1489,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_MAP_TYPE_CPUMAP:
 	case BPF_MAP_TYPE_ARENA:
 	case BPF_MAP_TYPE_INSN_ARRAY:
+	case BPF_MAP_TYPE_LANDLOCK_RULESET:
 		if (!bpf_token_capable(token, CAP_BPF))
 			goto put_token;
 		break;
-- 
2.53.0

