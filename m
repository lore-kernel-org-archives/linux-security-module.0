Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871E119FA93
	for <linux-security-module@vger.kernel.org>; Thu,  1 Jan 2026 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767295839; cv=none; b=SwtwxxVXmjCwVFH0R159algrogD0KF5N6dFv3c+9kVmHlzKT6nuK8pAWh4pQnSPGoVy0IL+0Jd6EBk7ViHoatbHFZYrP3w/wy5LioGHgjfCEOXIBpr2l1hMfNZqzIbtzuAqqvWO/sE0JPb/V+bBBVC2hHefHP6AdlWdFOGq4jGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767295839; c=relaxed/simple;
	bh=B5IKqrhdW0bPhWMCR5/hc5TvIGu/+iIwuCicrRAVBN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDjeUsYjQIeyPz3K1crSwdpyn0qvz0tvR2n6c5GJ56mgwLhgZL9JkjK7njf4scInVZK3hD5Lrp+cdD+y9LkNOTJZ6sUdwGqJV/Xo1NcomcYjyFSgRg/fG+lso/xxl4M4eSCBrf6WDWYnNWsGl/IX0mU4khHPBHboVgoM4Qolww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuZ2hTuz; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuZ2hTuz"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6447743ce90so10620961d50.2
        for <linux-security-module@vger.kernel.org>; Thu, 01 Jan 2026 11:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767295836; x=1767900636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxZdoBeA6lJiL7xK7Qxgo4muiEwYtXrzwrR4yq314ZQ=;
        b=YuZ2hTuzHIWrW7Up+HVfTheYJUPLUbR48085JanlgAErWuVg1XaJ4N0w7HCR1Fs5RT
         V7pP3CN6JDbRDcmxNvBDmA0/VPxS/4Clf6v7EWVXWVYhZ02VKnxZCwAyQ3xB67M8d2SC
         LsYFdZ3J7YG/ueR+/PKroy2dflYYzCfA8wZmNtMjZFouJKSmilO8EPk7WL+BGYwoGvZS
         WCRXVZDbPs0jKueCPVvWQ1nA9m5p08Om7cNVVYu3imgq39qegZO9iwE0QiXuzvNvyjki
         +TewhDF38U/iHwYOfW5x2QtI2ZE/Aqdm7ycVpBlWlOzLAmOEweGm+R2C8hhxmEs2oxQ5
         88Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767295836; x=1767900636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IxZdoBeA6lJiL7xK7Qxgo4muiEwYtXrzwrR4yq314ZQ=;
        b=LY6+aniGg7C0VWb1Uxwl8uFgi5/2cbWHgLvhe+6uPtQxgLwbx2sdwt8/WE5F5z7y1u
         PMQj284rHX/vbicY28nh1npeVOFWEgqO0ktn8nmQUVbyrwoShUwiydr2DaZUZZ/lbCpl
         Bsf0ZkvEknJfcnNdQLvGob2CrJp437xzEqtFWaNLwWL0o0D3g0QSUp1KrHtRamkAEBCO
         tbaMzGBbnsKhK77/s8xOIsakIuTBW6qj9dByQFEtwP7M9Jqdrak34y7dEuVutF1/oNZV
         6kGHW2IarZo8fwtiboqjV/GTcNC3jKi+up9QC8VD6/vtmDseA1tLw6r0oKzwBax8Nmi+
         6Oaw==
X-Forwarded-Encrypted: i=1; AJvYcCVlHpUrXzl8DIuwN/FEAMsnQUrf0nsAS2CPMfGzB5f2qQkCLY+Aor08wjtb0oB0DmrWpEMYFmHtzKRV1YUQUw4Lj7i2Q7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNdGDxDRbb3wkS+ObnYnYbtImKObT1dkZu/tiASZ8+K+IDpVFL
	jpCjfxa5rRKkXB8J8vy11ktxb4jbJTTW3B45H8yp/ahDiMEYgFEvKBBi
X-Gm-Gg: AY/fxX6a1or/O9BL5za7fOEQngIlfwEUQbcqZXN8k69VdPlGy3f2Tvng5Jbdp9AqOEW
	AwaRpgASkyxAfo/S4qcm4gtMbVEdSV+7er4LE0DVQtBB51euveTNznnpxXRW7t3LFFmmARhsMVf
	sYLlWoBZ3QURrGckuFnDUOcK8TVjYOs4u868sSpC+hzLdD1MpEzcDX7+eCgjbhtoz3EbD1zplHj
	qX4ARISieYQIbA1koBffhUpzaSPb+i2owbFRWkPIDvpoi4FY8dweDfhN4PYfjXM8VIA/FrEPh08
	8Py/FCM72hdd++wwLkVRzMlFDNCiGuAp4PBegDKobi1xO9dBUEERSvXJjYc7GXMWWjmuJOzTGV7
	yhvqertxHQgsF0BJAGYdlEqwJ4R2ChDUjlXEAvYaeoCmCLwfRnzhbFEEGC3Hdg1tFmdjHQYOq8w
	tAoa4rypavrSRxAGde+f5zJHXN0MNovWCci/arN7wwURYgYuTOPqr2HyRagmxC
X-Google-Smtp-Source: AGHT+IEPXgpDYLnB9QCsAagrSJIdmVqjlVp3cb9qjjMo7Y1T2JML67SMnvJrACDUDeY0rl5h1ikfIA==
X-Received: by 2002:a05:690e:1918:b0:646:81e0:1340 with SMTP id 956f58d0204a3-64681e015a5mr26590446d50.71.1767295836293;
        Thu, 01 Jan 2026 11:30:36 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a92d913sm18923576d50.20.2026.01.01.11.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 11:30:35 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com
Cc: demiobenour@gmail.com,
	fahimitahera@gmail.com,
	hi@alyssa.is,
	ivanov.mikhail1@huawei-partners.com,
	jannh@google.com,
	konstantin.meskhidze@huawei.com,
	linux-security-module@vger.kernel.org,
	m@maowtm.org,
	matthieu@buffet.re,
	mic@digikod.net,
	paul@paul-moore.com,
	samasth.norway.ananda@oracle.com,
	utilityemal77@gmail.com
Subject: Re: [RFC PATCH 3/5] samples/landlock: Add support for LANDLOCK_ACCESS_FS_CONNECT_UNIX
Date: Thu,  1 Jan 2026 14:30:06 -0500
Message-ID: <20260101193009.4005972-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260101134102.25938-4-gnoack3000@gmail.com>
References: <20260101134102.25938-4-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow users to separately specify unix socket rights,
document the variable, and make the right optional.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
Cc: Günther Noack <gnoack3000@gmail.com>
---

Notes:

    Small fixup suggestion patch to this RFC series.

    Handling the unix connect rights separate from
    other rights makes more sense, and makes the sandboxer
    much easier to use. Also connect doesn't really neatly
    correspond to "roughly write" in my opinion, so this puts
    it in a separate variable documented in the help printout.
    
    This also makes it possible to specify rights on the socket itself,
    which wasn't possible.
    
    before:
    ~ # LL_FS_RO=/ LL_FS_RW=/tmp/test.sock landlock-sandboxer sh -c 'echo "hello" |
    socat - UNIX-CONNECT:/tmp/test.sock'
    Executing the sandboxed command...
    2026/01/01 19:14:33 socat[78] E connect(, AF=1 "/tmp/test.sock", 16): Permission denied
    
    after:
    ~ # LL_FS_RO=/ LL_FS_RW= LL_UNIX_CONNECT=/tmp/test.sock landlock-sandboxer sh -c
     'echo "hello" | socat - UNIX-CONNECT:/tmp/test.sock'
    Executing the sandboxed command...
    hello

 samples/landlock/sandboxer.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index b24ef317d1ea..3df7e7c8b6f1 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -62,6 +62,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
 #define ENV_SCOPED_NAME "LL_SCOPED"
 #define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
+#define ENV_UNIX_CONNECT_NAME "LL_UNIX_CONNECT"
 #define ENV_DELIMITER ":"
 
 static int str2num(const char *numstr, __u64 *num_dst)
@@ -163,8 +164,14 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
 			goto out_free_name;
 		}
 		path_beneath.allowed_access = allowed_access;
-		if (!S_ISDIR(statbuf.st_mode))
+		if (!S_ISDIR(statbuf.st_mode)) {
 			path_beneath.allowed_access &= ACCESS_FILE;
+			/* Keep CONNECT_UNIX for socket files. */
+			if (S_ISSOCK(statbuf.st_mode))
+				path_beneath.allowed_access |=
+					allowed_access &
+					LANDLOCK_ACCESS_FS_CONNECT_UNIX;
+		}
 		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 				      &path_beneath, 0)) {
 			fprintf(stderr,
@@ -295,8 +302,7 @@ static bool check_ruleset_scope(const char *const env_var,
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
-	LANDLOCK_ACCESS_FS_CONNECT_UNIX)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
 
 /* clang-format on */
 
@@ -326,6 +332,7 @@ static const char help[] =
 	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
 	"  - \"a\" to restrict opening abstract unix sockets\n"
 	"  - \"s\" to restrict sending signals\n"
+	"* " ENV_UNIX_CONNECT_NAME ": paths of unix sockets connections are allowed to\n"
 	"\n"
 	"A sandboxer should not log denied access requests to avoid spamming logs, "
 	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
@@ -353,7 +360,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	      access_fs_rw = ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE;
 
 	struct landlock_ruleset_attr ruleset_attr = {
-		.handled_access_fs = access_fs_rw,
+		.handled_access_fs = access_fs_rw | LANDLOCK_ACCESS_FS_CONNECT_UNIX,
 		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
 				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
 		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
@@ -460,9 +467,6 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			"provided by ABI version %d (instead of %d).\n",
 			abi, LANDLOCK_ABI_LAST);
 	}
-	access_fs_ro &= ruleset_attr.handled_access_fs;
-	access_fs_rw &= ruleset_attr.handled_access_fs;
-
 	/* Removes bind access attribute if not supported by a user. */
 	env_port_name = getenv(ENV_TCP_BIND_NAME);
 	if (!env_port_name) {
@@ -476,6 +480,9 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
 	}
 
+	access_fs_ro &= ruleset_attr.handled_access_fs;
+	access_fs_rw &= ruleset_attr.handled_access_fs;
+
 	if (check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr))
 		return 1;
 
@@ -510,6 +517,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	if (populate_ruleset_fs(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw)) {
 		goto err_close_ruleset;
 	}
+	if (getenv(ENV_UNIX_CONNECT_NAME) &&
+	    populate_ruleset_fs(ENV_UNIX_CONNECT_NAME, ruleset_fd,
+				LANDLOCK_ACCESS_FS_CONNECT_UNIX)) {
+		goto err_close_ruleset;
+	}
 
 	if (populate_ruleset_net(ENV_TCP_BIND_NAME, ruleset_fd,
 				 LANDLOCK_ACCESS_NET_BIND_TCP)) {
-- 
2.51.0

