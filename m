Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49B9156F51
	for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545065; cv=none; b=oGtk5DXpfpNYnT3wKXY+8EKS2TH7wMSBIFn22eKYePnIehRTAkURbExzOZnQyHzAi/Qccx6TwGLgJna+ZPkyrbjZJNEA0hwynZdwuhWvmGTMsToj+b2zzl/MwmfEoQILoMwUfnRuh0VcEyizYOiP5NxtDfeymRduaoSg/BCcbSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545065; c=relaxed/simple;
	bh=EeRGwHz6swnOIRlMBlv7zlJ6FdE1ePei2mcknRU4yVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l8C77Mb0atCcQp0hz+CmUrRP0uDF/ohsRoM5SC3o/TYAQXGGQR6ImeDVnnUUZ3qiyYvj3RQ+3O/J6IkcfSeiPEurFNkcYguqKqB1Ym6+7OuJm51tryP1CaH13wPAAgBJjsrak+tSmMSk6LoHP7FRIeUxxij5GraVzBRsbZbf+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HfvMX277; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfvMX277"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a4df5d5069dso133494366b.1
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 06:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711545062; x=1712149862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6KNBzHqVxdWQfnLG5JEHxEU2zjee9ejfwPGlk43wY8=;
        b=HfvMX277j7strc8zKLr+qO61RSMurni1HkSH7C5Mf97NRUDUmtBu5ePPMx/09duV99
         KRVkZNmwYIclfgbISTeWdsEG+F1ZmEzgQ8yn5w3vOfNb9YD8StkndnYKerbmpo5ybvPZ
         IuRMNySoMl4wpK/dnJHOY13DtwDxNL2SUOYwfSUUW5irxqL1M9McvyoRxdTUVqZAS232
         3plg+HdYzl5vh6/A7b1CQcpqbGGVJxVQL2dD6aUkg8wsicfj956+d83ksqiz4kv+tpRD
         toYELv1YquSr6k1KZJDc542W53dNBDdkbqopHzHesutK9m3F5ucIHVNGiw6LuwqRQH51
         2L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545062; x=1712149862;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W6KNBzHqVxdWQfnLG5JEHxEU2zjee9ejfwPGlk43wY8=;
        b=meWQZWJ0SsxwEWCOXUWZnbBf8oEtQ/hgePD72N7hI17EJwblkcxnWvUZ+aJdvUgbjo
         SORLI70nKspS2zAlT4wJD/VQ2EUDkvAW2Kd+TQhSNHzn7gYOJg7O8fk1nLp5Nal6QgDW
         QDkOLhf5WoVEsjozUilxPWcOdmBclOPBiwPVGyBB3VIMaZbFgB3GYVy93Ami1bwhy29J
         AiIL2/XbZICAHwqy81NqVC2/wfgZNs2d/0QXE3g1NLzRjk5yrnCdB+xibiiIPAvOynjq
         gp8FLQBKNXioOsk2Y0sO7vBbpDtFBuCRZJnJDO9XzMfvSzMRwJ4COUvQmBl5SMp3ehaB
         PF4g==
X-Gm-Message-State: AOJu0YzwiwrAB8QTAosU4LR+5KRnvBzQEEAzniG0Icydm1YDLMAVRMzn
	LwFQR0DGTCXGph87jB7BHxAmHTzkD2t3P+ppDGADsGQ4mwtMxZ0+S+HAaVhrBMy38JhnYuOvrAO
	JMwwZvRMl34ucElI/bdlGwul+vxW0ua4oVFPLYP19JYBQnMIGo4njalBq8UyQmczpIGcyUwIYFU
	aGkqUNR3yfveIOz5HQGkU8c/Km/Crp1/KZXwKU1fi0BTwsy5UzpdPM
X-Google-Smtp-Source: AGHT+IHf/kpoa1SkRRq/ZtW1kKi5A0jzz2n9FfDcQSnZ2kISo2yo523exP1bue4OGrTF4QBG1JfkixOa41Y=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:907:b5a1:b0:a47:36ac:ecbd with SMTP id
 qx33-20020a170907b5a100b00a4736acecbdmr55729ejc.2.1711545061763; Wed, 27 Mar
 2024 06:11:01 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:10:37 +0000
In-Reply-To: <20240327131040.158777-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327131040.158777-8-gnoack@google.com>
Subject: [PATCH v13 07/10] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL_DEV
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add IOCTL support to the Landlock sample tool.

The IOCTL right is grouped with the read-write rights in the sample
tool, as some IOCTL requests provide features that mutate state.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 samples/landlock/sandboxer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 8b8ecd65c28c..e8223c3e781a 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -81,7 +81,8 @@ static int parse_path(char *env_path, const char ***const=
 path_list)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
=20
 /* clang-format on */
=20
@@ -202,11 +203,12 @@ static int populate_ruleset_net(const char *const env=
_var, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
=20
 /* clang-format on */
=20
-#define LANDLOCK_ABI_LAST 4
+#define LANDLOCK_ABI_LAST 5
=20
 int main(const int argc, char *const argv[], char *const *const envp)
 {
@@ -320,6 +322,11 @@ int main(const int argc, char *const argv[], char *con=
st *const envp)
 		ruleset_attr.handled_access_net &=3D
 			~(LANDLOCK_ACCESS_NET_BIND_TCP |
 			  LANDLOCK_ACCESS_NET_CONNECT_TCP);
+		__attribute__((fallthrough));
+	case 4:
+		/* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
+		ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
+
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
--=20
2.44.0.396.g6e790dbe36-goog

