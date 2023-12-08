Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GzFCvtFG"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E411985
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 07:51:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d3a1e5f8d6so27481887b3.3
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 07:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702050710; x=1702655510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kdDoWcSv0tcnaDo2x6ejdD3WMv5LtvRZfR97Sl3d0s=;
        b=GzFCvtFGMMCJQWVmVgkYbB1FAg7fqFByt9RYcg/54PIugE0l5nUxVXLhicmUFrreKk
         1t93NHhwKmQPg7QLmMUMnYKbKFtnjMEMAVSIVJATBjizA4yaFTiv4CmOatAvVfcUIX6E
         Y9NIARgflxXGtEjTVpHVuuJAhR6zio/M6QfNL7Soqbx158Pjfe4llnUwJJiJufgEJ6Kw
         VwE/i9qdHYtyUk3P1l0jasb6EwhbAhRl4yQySWZUz9svDfKIvZY56lMt20E3FRbxqVi7
         6JpLqkluIRuUHh7DsEGp96vhgc8g9IOfuQCjobM63Gl7aLExZ75U8Ki1pFqKRgRVX1Uv
         +/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050710; x=1702655510;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6kdDoWcSv0tcnaDo2x6ejdD3WMv5LtvRZfR97Sl3d0s=;
        b=SpItwDA+/jXJv01iHOknKaRyy1+I0NkeHaY7Htgcy3wo+FGccgexNHtwId5o8RwhlC
         82Fx2c/QjUR36aPFFTqjvwlrVRyRlGS57lzj9ZQzJL5xvK5fgqqRkKcIGVj6A0k6LDk4
         zEetN2Cez5uQNYw638l4KYwETtCrrXpuiSGubcrnNStUZhz21AlzU0HgR50rbseprq3L
         RSq3914Tko/3vn/jfzSVSVwrJZ0nlMDb3koCfuS9QqJ1RNqbK1lQ5ju6WSROk82RM8Al
         cVDLhUQ2SeMyfb8n5qmDT/pz658aD99UZqCuQDSf0QDlCWDjuFhea3NLJewDpa94sAqB
         pQkg==
X-Gm-Message-State: AOJu0Yw977TtHne60XPr+Cw6EKz8irdJN+xnw89FZQk82kUAODdXunhM
	+uN47oLNFYNvDZyUA9ABC0K+IE7hDTWkZYjnKCQKWlj6J3vafPRcMGYii/7AxHFWv1Mr7k4IQPk
	tBDmPYlWQZB10/8zf+4NNO2Mwb2oYVqSQsik4HLYK7c7PClTpcEaaDOSu/Mb6bLMNCDdW9DCMA/
	tUIm/hpA==
X-Google-Smtp-Source: AGHT+IH2GK2Km/C+rYT3PFzl4qwVpQygC8rxDh3OJ/ae0rcaiPeC3ig+gpdwmILJ+jIPiMLTvaxKXK7nyak=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:d80e:bfc8:2891:24c1])
 (user=gnoack job=sendgmr) by 2002:a05:690c:3505:b0:5ca:c025:3cb9 with SMTP id
 fq5-20020a05690c350500b005cac0253cb9mr2108ywb.1.1702050709352; Fri, 08 Dec
 2023 07:51:49 -0800 (PST)
Date: Fri,  8 Dec 2023 16:51:20 +0100
In-Reply-To: <20231208155121.1943775-1-gnoack@google.com>
Message-Id: <20231208155121.1943775-9-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v8 8/9] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add ioctl support to the Landlock sample tool.

The ioctl right is grouped with the read-write rights in the sample
tool, as some ioctl requests provide features that mutate state.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 samples/landlock/sandboxer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 08596c0ef070..d7323e5526be 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -81,7 +81,8 @@ static int parse_path(char *env_path, const char ***const=
 path_list)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
=20
 /* clang-format on */
=20
@@ -199,11 +200,12 @@ static int populate_ruleset_net(const char *const env=
_var, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
=20
 /* clang-format on */
=20
-#define LANDLOCK_ABI_LAST 4
+#define LANDLOCK_ABI_LAST 5
=20
 int main(const int argc, char *const argv[], char *const *const envp)
 {
@@ -317,6 +319,11 @@ int main(const int argc, char *const argv[], char *con=
st *const envp)
 		ruleset_attr.handled_access_net &=3D
 			~(LANDLOCK_ACCESS_NET_BIND_TCP |
 			  LANDLOCK_ACCESS_NET_CONNECT_TCP);
+		__attribute__((fallthrough));
+	case 4:
+		/* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 5 */
+		ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL;
+
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
--=20
2.43.0.472.g3155946c3a-goog

