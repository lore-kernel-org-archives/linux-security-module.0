Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379E349AFF
	for <linux-security-module@vger.kernel.org>; Thu,  9 Jul 2026 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624996; cv=pass; b=U+AukoI5oFYOxEzl/FqIymiGTSgZtUtMcsBTiHdCf5weM+/cCl8F4vm+mcy8sErLoK3xZTFwUrZiPXgs2amF68xKWRM8Ts3o9u4zOCMDUpP0j5UBSuOr1BciBPOJB/rhtcsGigIRP5/nIxaxV/SWsiZXwzMOLMjYLR4WtEmIyRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624996; c=relaxed/simple;
	bh=P3KfzPSkqzrrDnn9/YRCi/E2VWJhiGCYGZ9lMjKrEmo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ioo7DRLaEa/bzkzh0DdBp0rEFSLIDPZuzt5sDKbT4NecyJ7sIpKMAHIvDqji0sr+NBGmnI4+Ga7QNs+BkNy4+fJq3nAGFMbhGn5m1cA1FYue+YBnz7z5dJfUFsAt3luWH/DY2dRGUJEungdL0VJMHhFMPJnE/s9QR3EUEmkvHdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=ljEtguaU; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="ljEtguaU"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664d530fcfdso268742d50.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 Jul 2026 12:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783624993; cv=none;
        d=google.com; s=arc-20260327;
        b=doPK3zdMjvmS7KtXqTVvj/MHyNnecIWTSvN9omOnvfVsRDJ3q96rMrDDIp4FgXvuT+
         wab7Dp9oo3MKTayEPO62CN4pimYoRrAa4RrWVp+0xkLJRRHUMe5VqBF+OqijVIR7yYiZ
         qraEoOA4BegAab8HwyON0fR5aLLK82kEUV3kuxNbCJMMjCefK7olwjPW2lJE4Kr2VDct
         38xAQgAM5NS11PutSjdMUehOQ4flpIk19euEV8cYp0iy6EzL80ahC6vGnT/FJwXucARl
         x2s1SGeM2PJFCjZFyoPqr4zoGZXtUSxMiog159peZyJiZIi6IaxiD0qA8slCkWAe8/lA
         W0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rLKUCgOPdJB6WTWmQJRFGnXb1O7aYuVdA+Enw8Jcsyc=;
        fh=DU3Zj7ZayLvSas1KOW73cPfwaPvLwGZZ6wGMIGYlPMY=;
        b=YV86HF+Wqiy1MlaDycMrHx1aHwccjF64yMMt956aPYqndAc/qhFbpdE5hyTWaKK73b
         wGpPAXgLKxIEih0tzxzfqLjwBM448sQkIPikEgeJBF0uda5VKeYFdNZhA7WJqBl4F1pd
         CJdKB4GwywyAY1ekcheDbaNsasCvHizXvs6pK7MhkkOSL08UdJr23VEAq8iJZcdswz/l
         1uMRt4PbISJQZcsT5s5y+fv58w1fJQjSanwgqKSKXbluKlrx1s/AJLGVx4LErMMqqs6h
         4dubGvRgz/tfSZkfrieOTr8iyKPisCItnK/JpNkWXWDLRXrZ4NBKfoiG4+HrXuAcwoxO
         EyFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1783624993; x=1784229793; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rLKUCgOPdJB6WTWmQJRFGnXb1O7aYuVdA+Enw8Jcsyc=;
        b=ljEtguaUrlOSM4IV2SAU7NG/Xt3zC3n3DBjx0i6yZ2ajqin+G58jhYLXbAnGDIWMa8
         BZ9PpW5dKDglG6fyO8OH39Hy6bbGiA9y8i6Xs/3RveHZ58YG16waIZOMhzsBAevg1k2h
         xhCNo5pd3NKeud9FQ7AuADR/Qxt7PvlaJ3tVeBVNBNlUwYE6SPzZrlxwbAyV2BzMgoz/
         Qx9X3jP4MDHbux73mAC5KfL+R2YsT5/LqszTOsBeUemwyP2w6SFjzOa1yxYm8dsGRSoD
         fp5Knr+JURHaZ22uuuxBUC88zLk0C4G0P7TKWxr6iWD7foxqdKzwjNaPVLva1qgUqiVI
         WF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783624993; x=1784229793;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rLKUCgOPdJB6WTWmQJRFGnXb1O7aYuVdA+Enw8Jcsyc=;
        b=FKwEclDdmXdB56YHZuCbzG1VaY7af1VF4GdJsjb7WjluNoplZYJXf5AAlqyrwyr39N
         he3Cx+s27uVKZjYt0nsNuM4xzdVegb0eEu3MNo8szqVl2lYDy8T+rxQKZXL3mWWB13pN
         WhRSKK11ms3WkWWb3QjHgv9U8I8IsytpfUpD4VmfrH9/aLaq/cLGoTFQPkmY0oCxG952
         /q4ZBPaqVOLC58KklaMRgN4X2FhqWpiSroEpa/QXzRGMe5nvHxYVMhXtLFnod7wS+Zl9
         8DXd7dVl9fcpO3nhoawQtJTEOkadrF0GMiGwXypNQqawZPpOWBFynXz5AS5c3KVaoI41
         JgqQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjvdBJ0xUNBeuXYGdjB70/dFWooh+EjQGpMGb85eZMh4XuErrrzg5tNd5soc6qc1YAUTPfriCnXq22upADM/i3I/FpQKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOVart2n/3nVFCyufQ3mr7TlH7rIEzlH6kpdk5RXsZWANWeZv3
	Lea1iCOE7afWrW7wl1H3thQGjOwbpsbH+igjbEPetOAbeQZjexpEW0HfKfCjHILTQNhThvDsqIX
	F8peZjKkRjqXyjth3iIydV5/NWyeplsBVfUR46PKa
X-Gm-Gg: AfdE7clLuKKjEa/outcNIOuJpRN5VJbYqcd6k9VN+sv9hCkDD8xYbEbyWEDOi7gf+36
	f6XYWJKriQr3U+zp/wa5kEEXXelSb/PyD/KcaaYCwvcJBAqKDufX2zzRg5S+9JpU/4jaKL93sux
	qcYqIf6wnkhYTlSLcKWZvLArJcR3h98QB9l14rCYaKKVWBvP2j92e4tYC/4JB6RkxLM/16Of+K7
	oz3gWCsO9Isz6sCbcQ4ghIeEazq1V0wr2GkDdWlKCugG4lvv4HS1kpZsLTy7pwuglbP8YLbKHbP
	9ZB7YavE9p92CoaAvw4Fz1RDL6Y=
X-Received: by 2002:a05:690c:6d0c:b0:81e:6f0d:8e05 with SMTP id
 00721157ae682-81e6f0d8e5bmr31386797b3.43.1783624992516; Thu, 09 Jul 2026
 12:23:12 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 9 Jul 2026 12:23:11 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 9 Jul 2026 12:23:11 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sean Rhodes <sean@starlabs.systems>
Date: Thu, 9 Jul 2026 12:23:11 -0700
X-Gm-Features: AUfX_mzVZtqRRkl9fVhuBIBaSxwAAmVa-vH3CHlHUp7UY50ccQrXa49krBcAszw
Message-ID: <CABtds-0AUr1jD2Sri6ViiFiqyBbjc3-6xeAOr12YLJA9ux-2BA@mail.gmail.com>
Subject: [PATCH] PM: hibernate: Allow hibernation opt-in when locked down
To: rafael@kernel.org
Cc: lenb@kernel.org, pavel@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com, 
	keescook@chromium.org, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Kernel lockdown disables hibernation because the resume image cannot be
verified before it is restored. On systems where external platform or
storage policy protects the hibernation image from offline modification,
users may still need hibernation while lockdown is active.

Add a hibernate=allow_locked_down command line option to make that opt-in
explicit. This only bypasses the LOCKDOWN_HIBERNATION gate; nohibernate,
secretmem and CXL memory restrictions still apply.

The kernel does not validate the external policy or authenticate the image
with this option.

Build-tested with Fedora config:
  make O=../linux-lockdown-hibernate-build kernel/power/hibernate.o

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 kernel/power/hibernate.c                        | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt
b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..0d20ad9c7d78 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1967,6 +1967,11 @@ Kernel parameters
 		protect_image	Turn on image protection during restoration
 				(that will set all pages holding image data
 				during restoration read-only).
+		allow_locked_down
+				Allow hibernation even when kernel lockdown would
+				otherwise disable it. The kernel does not verify
+				the hibernation image; only use this when external
+				policy protects the image from offline modification.

 	hibernate.compressor= 	[HIBERNATION] Compression algorithm to be
 				used with hibernation.
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index d2479c69d71a..71232eece9a3 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -41,6 +41,7 @@
 static int nocompress;
 static int noresume;
 static int nohibernate;
+static bool allow_locked_down_hibernation;
 static int resume_wait;
 static unsigned int resume_delay;
 static char resume_file[256] = CONFIG_PM_STD_PARTITION;
@@ -109,7 +110,8 @@ bool hibernation_in_progress(void)
 bool hibernation_available(void)
 {
 	return nohibernate == 0 &&
-		!security_locked_down(LOCKDOWN_HIBERNATION) &&
+		(allow_locked_down_hibernation ||
+		 !security_locked_down(LOCKDOWN_HIBERNATION)) &&
 		!secretmem_active() && !cxl_mem_active();
 }

@@ -1433,6 +1435,8 @@ static int __init hibernate_setup(char *str)
 	} else if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)
 		   && !strncmp(str, "protect_image", 13)) {
 		enable_restore_image_protection();
+	} else if (!strncmp(str, "allow_locked_down", 17)) {
+		allow_locked_down_hibernation = true;
 	}
 	return 1;
 }
-- 
2.53.0
