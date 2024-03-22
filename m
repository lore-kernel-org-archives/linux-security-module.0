Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD874DA13
	for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120242; cv=none; b=tAIBC0Hk9NZ5YgDeBD+JFtiQ/7yKCsxDyOw4lZg68f0SxGc0Yy7GbXADicT+WnR2o4hbqx03pSu1YAsIDi+C2VqCKcYmXzaFfu6xYtsrTeFQD85k3lgeQZnlJgFFgMPWLg6wei/mKaMf+q+91arw4pgkj7K8At8+nR/67mAHG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120242; c=relaxed/simple;
	bh=I4ujxSWG1rQZvUOG3aGaAfaG34o0FSxd2yK2pMFboO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k7qRu40hyrkJbtJtCyetJB3NrbkTZ1jUcqoHaVvnoey1TQfvrX6QzYyEKE23wxiDK86E7m7gxsQmKXXnNr5eYdm0qAR2XRf+qtuqCSdItyORp7WItOIDZdDJlsd2vC8cFeaQOnnhUVN6uf+vi3+AOmwEDr8RAqWK9UGpyMqpsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1dcz2Iyo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1dcz2Iyo"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a3bb05c9bso36752377b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711120240; x=1711725040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zqw6HHB8TTWWZzHXrC+t6B4vKHkVHyluYvVzQQIi1bo=;
        b=1dcz2IyosX9KKA/3KNSmY5XarlU3xLIluGbKMtygfwNnoyMFBRfWeywZPxHnxy+aG1
         pUGJL17Cyln8hlvNSwB7LCp+jb50RmjMZ1Flhg2s+9pVn2+y/oJ8QC+5kDL/6pwbwXSI
         Iui/JGOf0GZSoVblLDKAMZhRT7OcyH3CrYFSwabzXMUQru3SgVxg4IZcix/y04H3wSQQ
         SqBat4OlSo+MHoxMLQQjwqkP6XEBOkaD2Xdn077IxfRrT8LC25K9gFd/jyfAi7O87cUu
         9qpjOuDlWA698J9z7v90G+f6XEAoFRoYqldeda4P7znZ2JPSfmObE1kPhfy9UtfXCgga
         +GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120240; x=1711725040;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zqw6HHB8TTWWZzHXrC+t6B4vKHkVHyluYvVzQQIi1bo=;
        b=B6YvqzxhTbzGKvyFvnTN8/lf/xYtJ8s1zmwvnr5Ux6TEACxk5IU25KokOqCQiYG9bz
         8UHrrSoEoXIpKP6uVB2O6xDhK+SPe4xs8pLl9LOf1LVh32KdSoXky9h2jmJ5J9DV2qcU
         O9OuhFmMj0UgXsmtjF41mcVYOcvGvhiwHRPh2hlqnA+V9ZB0V0+z6pdeIsuPr8W1C6Zn
         alWdNsIJz/RIweoWhgIJRtA354c5CW8IsnOZfBnWUUZRrw4DpkxalexMYDW8Hqcn42j/
         tyt6VaZ7HRaMKqzBYBaW6xLBRMJhWr9YNYAcxcLvchxqSqLByFNbKFi0SjTn1uy7awW1
         EWUw==
X-Gm-Message-State: AOJu0YyKDcJgeXeycsWzVqIW0mks27YD5+wwCl1Ry/+i3zyZTS4dvImx
	RjS85zh87KolJQQ/hmhLD/WFf8+e4iLEX1vds9YLAuP6jmXYfhuNBqZ5jF9Tjt9YAI7D2t6wYsy
	KFo3OX4xDfCoGuk0Yq6LO7DHuhJ2DwhK1iIjyGievmZCX5fhJTMGfj6hZMv5gfhA1YIQdIQXK1A
	uH8k/eQSYcMcdv/H/9hrvCq18l9joOhiJHtS19w6RpsdA5tm5PWGH7
X-Google-Smtp-Source: AGHT+IEXCHg6NIh+6BQFmtU5UD6PB7Ny9+kH183mfOWzk4uupBXeY0DzvqGg9OiO4ZZ5PXxcNwqEBQGE664=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:2686:b0:dc6:d1d7:d03e with SMTP id
 dx6-20020a056902268600b00dc6d1d7d03emr60950ybb.8.1711120239831; Fri, 22 Mar
 2024 08:10:39 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:10:01 +0000
In-Reply-To: <20240322151002.3653639-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322151002.3653639-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322151002.3653639-9-gnoack@google.com>
Subject: [PATCH v11 8/9] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL_DEV
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

Add IOCTL support to the Landlock sample tool.

The IOCTL right is grouped with the read-write rights in the sample
tool, as some IOCTL requests provide features that mutate state.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 samples/landlock/sandboxer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 32e930c853bb..997f774e88ae 100644
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
@@ -201,11 +202,12 @@ static int populate_ruleset_net(const char *const env=
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
@@ -319,6 +321,11 @@ int main(const int argc, char *const argv[], char *con=
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

