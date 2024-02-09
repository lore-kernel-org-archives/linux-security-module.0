Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0EE7F47B
	for <linux-security-module@vger.kernel.org>; Fri,  9 Feb 2024 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498400; cv=none; b=qhiw8Agls3x72Dr0dijZ/4JyHX9NBFwB/EqsFXdHlfaoHUz2EY+vYIMZyiNruMC1eFFWV+Rc/56lG5qCLIVsa4+pQKQdSGDUAKlFgHeb5Qxn5Qddqny3pv9DsyCVRuG2UEUTgDSM3z5o7l51P/NPD7Kzw6p7kFxUHO+1EaU3B9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498400; c=relaxed/simple;
	bh=kIEptzQde7cesZNFjMOm2MmmN9Ek6A0D6Wd9L3b44iE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=BJiK9tiPZKXwOfTrJDd2iH1iMBmNOIE8UAUQPYbBCWHNlHjEXULvYEnM7ovd47QRV7/wMpf7o1wp9HDHT3ocRSu5eh6Avh56JvIIR/Fu5zgFZugRipLVkcsUtsZQj9p2Nm89N08dDRSE5jzRXUY+Y6H2Nffl0P+pZofwWXJDRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qvWr5Mdw; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qvWr5Mdw"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-560127ce17fso707966a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 09 Feb 2024 09:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707498396; x=1708103196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=es+e+wQNjnyIvSqYUyube9Brelr1LLu1DXJz4rbQGc8=;
        b=qvWr5MdwO1Ma+dQRtPBOw4tXF8RyyuWm+fH4CS0yD9gL3bZa6ehoeGQdy4J4NyBrDj
         +pYjHhRYyUrdcrO1uzRmJbWIp5jXYDGaxaJ6R/7yhYnaN670I23eeYNXYPsA7bTAmIwP
         AsRAWjSraIOismKjO1xA3aa2wlH5q/auXMtV+vJz6hr3FiX+dLbGAy7b16oW8e9xQXSf
         yK3/21imzWmy2MvS1hgp4YbRqd7PgRQeUeaE7zWlsQsKlfHSb/o6/CNShsQbjsoQu5/C
         qEJab4eIy1N+Igv9pMp4yPbEgJL5a712XmrWbUyJpRoO5TliV/Kx5N0mHokRkmRoyxDo
         N0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498396; x=1708103196;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=es+e+wQNjnyIvSqYUyube9Brelr1LLu1DXJz4rbQGc8=;
        b=LQ7qmpWUJZyUWqADxrxNU1bktTpUuBktu1JvYWThkqqJ6GPFaEPg1YEbfTmYHjjYPD
         G8gR4SKDFn9FOuTRey7EOr0WMgn4TPpe08H6BBJwNgEGc7Fe101WJ0Qe3Bda7Z/S8RDu
         n531Wn0bdJXLM7iz5N0CioZ9+9Mw03l21KhjNipksCcxXgrNcEFxYdL9Ewel3ap2TvFV
         m+R7tjyLLlDNt5oE08df0xeUka+sK2IqyWt+5XB02HYdIrzgrspfEsj8/2cnalopbtwq
         6Vbqnov1uifUuoLTk61o3bm9Bvtk5gLalK1gpSBdf71gsIJAciKF+kWSxQEQFNv2sAZU
         z5/w==
X-Gm-Message-State: AOJu0Yxh6FfeNk58QafZMtBEdcBmVgoXKObCxypuLjjbFvkKtf685Lv6
	PXMLukoRS89cTd3pyhXQ6sEi0lHz8uzb4yv/f3tvkehfxHScUBHXp2FQ7sJGOmairgrA5CnegZq
	+bsZTEouPaYOeXD9wsmeLo15vTCDaO87EegZkDEsZXTcyKeK9CkNjFdIGEPYd+Q19onUfa268Vq
	5Em+gyori/O7pmDcKH8KQ5F8dGb+vCyWRNuegFa0sJJF/uWNLsWQ56
X-Google-Smtp-Source: AGHT+IFB+/pCN9oyiGtqBzLpOTRwTMJGgBLKeYT+4cNG8iiYDpmKYYsqMea+WwU2IoCoNg5kd4GNsf+JBRY=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:3162:977f:c07:bcd8])
 (user=gnoack job=sendgmr) by 2002:a05:6402:3718:b0:560:ab40:e6bd with SMTP id
 ek24-20020a056402371800b00560ab40e6bdmr9105edb.1.1707498396254; Fri, 09 Feb
 2024 09:06:36 -0800 (PST)
Date: Fri,  9 Feb 2024 18:06:11 +0100
In-Reply-To: <20240209170612.1638517-1-gnoack@google.com>
Message-Id: <20240209170612.1638517-8-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209170612.1638517-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v9 7/8] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
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
2.43.0.687.g38aa6559b0-goog

