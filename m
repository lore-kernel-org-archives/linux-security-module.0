Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56C72F4A14
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854934; cv=none; b=VGHSK9g+WUOtJbd0q5nOBj6wzhWIzX4KGi9I8zUb5R6jnV/t099e0mzhcwUAcG/JI/p6V/8QvDQBk15RMfqjWH4Jc3daadA4nskNCdOzjc1u7bUcGaHKJqgdbaE+YU34RDxy6B/wFtE7Z0dZFdY634gD7r/QMOSrVi7ZPulU9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854934; c=relaxed/simple;
	bh=/0GsNLutMbOq5XqKTN2ShLINQLlbmlqI+PoxuMdzNo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nm38r7CzglVn+lDi+EiDxYd4QtkaXmmALHt1gHIaCddJIghBDBvCsSNawugOxA6YdyeHyJH3z9SK1Imu8hcY9r+ploOalj2vGLfBuwnGNF790hbHiCYCFckGafJbIiikh3CidZSgxO97ONMF+yn0fEst0p7qk/xpFx1pNSlUYfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhIT1FeH; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhIT1FeH"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b870732cce2so718009466b.3
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 12:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768854931; x=1769459731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PBGuMUgOlG9tW15ANz73eelpLo/6n8nR8ahYAgYRA8=;
        b=IhIT1FeHe/nREbEqnHXrvdRPCfTohG31iKZkgWCEWZVPt/enWLe759IdwFAutGD9TL
         O5IlLL0y6BEZKNDtaU+o3mN2LnPYaFxVTcJKovWP3g9hCttfqdQbMa3qT0WakE0U9/AH
         +CaY1k7IhyyVkYSqAIUjqMINdeBwUuGBJ7bqUruGaPcfDoK1fbB6eI1i1fLH3OzaKebf
         hGvQ4sPHGrzMwslmO9PPRinUn/JRNpgtN59IG2eSbUFSuFlyYzpjYmr2bzwMWMPuDeLj
         Yc9t4a9Ua1VULk5QyI/zK930u6awLDiHX0j5Ln3CenoCx66M3LXSS41ob1MbnGJ/eHa8
         AwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854931; x=1769459731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1PBGuMUgOlG9tW15ANz73eelpLo/6n8nR8ahYAgYRA8=;
        b=gmcRuXTZzP3eoZPDOniyJY30ipIvyE4poxiT+5mgklfTdjlOInev1XH0CcBP80dJTJ
         jBiAMZatcNZSxtn2mzl8v+uc6K5hgmGodXWvLYQfkU+7GrJ5hFL2ANA13AlQM+pvqQFI
         zCd3TorfAvtcLAshW8nhwzZfnSbVCxteFFMYQQ1GrbAfPKjzsyH+Z2gHEvH6aTgsIh3W
         l6XIJI52he4zNAi8/Gek1ZSum8lSsLfk+u6KOC4ZtIrNevuI+ZwRzcdlAJk5oNpveJD1
         uaiJ7pXgPXpdnfRtG3+3VmILaak75XW4A6NyhFW76Q0KhJDaWbQ1UcwCxkUW00Yv7vmg
         8/zg==
X-Forwarded-Encrypted: i=1; AJvYcCUbfCilYuSPNZhVRzH9R091ixjeXYhIsfcwrBiwG/NRZVoaWrzxnNBkuWYF+pBjnnKHv1mT7Yq8S+kCqq00jvD5hX7qP3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyASNYJ68mQUNg90I4j+HMAwFx6wLcfYzBaRxZlua4xdCUL3vgt
	0S+YOot9RU56pP/mW0jw6LGV9EdsmTG4hUp4sOhx3HWx+gJj1EWLlUFr
X-Gm-Gg: AY/fxX7fixAF/Qewppiv3QZ+h60d1MDoD9pl6+0/HY2tRqUOQpc7NyAhJrff3TwV3te
	jrgAOZpENgur6zgecvcvelAGtCWIOoBdRyjhyEF/nFHAGDjjLnTGnF1mpuFUfYNl8vaWDSwvIk9
	2FHMFlA+B+CcPn1REHqAVXpoNaaOtRVvDkfkZTN79SSK25gR+GEhYVGTOgBmtUDi36e9VT7kRPA
	/cyQOX8agTK6CZQEcZClRz0QDhx0PtBIh3Ilz2GA/tEjVFhgxim0m5Il8XgYs+L9towsaoeSZL0
	D1TOzjH7C2P0wGcTS9BJ1geJD+qtfyKcxPID93esY7+vJ40uTOsk7/mniGJWwx8IyTcige//p7/
	x5N2WCuSReVBCcjn9pwAl5lHO7A6/A3kqHcrWdUVLV+VQKR5lFFnLSc/47QCvkpojDYmVQOBZWL
	k/KzG/jd+XBp6CIm6Hw2BtgqRqQ3vNMntr0q3G
X-Received: by 2002:a17:907:e10d:b0:b87:a0df:2f98 with SMTP id a640c23a62f3a-b87a0df4c96mr734668866b.63.1768854930996;
        Mon, 19 Jan 2026 12:35:30 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959f6e53sm1217029466b.47.2026.01.19.12.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:35:30 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>
Subject: [PATCH v3 3/5] samples/landlock: Add support for named UNIX domain socket restrictions
Date: Mon, 19 Jan 2026 21:34:56 +0100
Message-ID: <20260119203457.97676-6-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119203457.97676-2-gnoack3000@gmail.com>
References: <20260119203457.97676-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The access right for UNIX domain socket lookups is grouped with the
read-write rights in the sample tool.  Rationale: In the general case,
any operations are possible through a UNIX domain socket, including
data-mutating operations.

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 samples/landlock/sandboxer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e7af02f98208..8dab67ac7915 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -111,7 +111,8 @@ static int parse_path(char *env_path, const char ***const path_list)
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
 
 /* clang-format on */
 
@@ -295,11 +296,12 @@ static bool check_ruleset_scope(const char *const env_var,
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 7
+#define LANDLOCK_ABI_LAST 8
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -444,6 +446,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			"provided by ABI version %d (instead of %d).\n",
 			LANDLOCK_ABI_LAST, abi);
 		__attribute__((fallthrough));
+	case 7:
+		/* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 8 */
+		ruleset_attr.handled_access_fs &=
+			~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
+		__attribute__((fallthrough));
 	case LANDLOCK_ABI_LAST:
 		break;
 	default:
-- 
2.52.0

