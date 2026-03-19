Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA17205E02
	for <linux-security-module@vger.kernel.org>; Thu, 19 Mar 2026 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773924383; cv=none; b=E/ZbNcTu/Z8mtYmVmaQwsoDf1ykcpFQM0V90zxAnnMLDaQD4902aXD3DcD8MgXyKVIsWkYi8aNg3MhePQM/RenDD+UwQx0bdF6k0blgtTat9UR1hZaw78CYQMwVilJCr7C0PD9RFUGV748uY13JC6muGPZU963ShysJmOsnmCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773924383; c=relaxed/simple;
	bh=m/WKbd6NVVEZ0mhFDkimg6c4YST8HATJJv/9RaC/Me0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpEAit4kveeJIgKjrDz5DwTbPmyEpLYwyUX1WPQzZh8jbAvH0HYUIzn/g6UzAgF+MByNtgaFIA0xn+BbDoVcWPTmUWVCDASfX2REVkakVRnI6Nwlr1fJZpgkh2DWakuyydOcFEncHABpbXmIAEoC3j6d2TyUOsLu2BDcVPjOTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwkJ+vbZ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwkJ+vbZ"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66873d8cc9dso533670a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 19 Mar 2026 05:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773924379; x=1774529179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fAG2luJkX4J4bz7jFU3CZc/r+PYOsZHvj5H6b+VrVUA=;
        b=BwkJ+vbZIA1W0YS3//MkKxxPbkkPUBkkBYDDkQWVyhGKbrKzHyH046806TrGN/OOyW
         DP9NdOLppQUj17bZISKzzOrPQHbKRbrqloPu87KXRQiYrnXW0j02EMNPWIMz+Np42kxI
         4QpadysWpcRhH85wzELDebhIpOZlQfBUaV74KtHv856LYeJXVn/TsZPGA3n2KqBL8xai
         3rxCtu7ZfQsnCUcX89sMjQ6uJ7XbsOmsoLJv6PA6EHABzrmHQppEe7/yHrdolkVfbbql
         B3jeCZ5doNqnBXspXYL+u02W30208LBSGhlh1elJkBIJIXcQpgRR/BiYw3HW2604jr7b
         UEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773924379; x=1774529179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAG2luJkX4J4bz7jFU3CZc/r+PYOsZHvj5H6b+VrVUA=;
        b=Lc6tfCrid83uemVzitnfY+d76M79qf1Uo9Qidb3Y3tZwLVQi7LNnbUWSD2zE7lja3f
         rNwRtafgS5zureU0HjmyFqf40LuWeEyGrkMAbovvYWT+4qUFt1cd4ORiSOCiPN2sB8X4
         lOzTd1gQRxou5ZzfPNwHWRQgFrmQFxPJ8S6HZPAyQRRoJNURbSFJrOkwcpuE8MDYL8Sk
         zfIUw3OnuRYBW9q2TSUXT/0P/1J4b3AkZ1xfZk2ecxAzc1bhtRPSuWpwe0kAbSdz06w3
         xsS02sWmXWVKdaRRv6pHklyGEOz/k74z6Eny7h7pgOtDSdg5l6yiAqFY1R+nnA1rGBN8
         1ASQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe8yx4Mdy+zSYfDKpeDC3jBz9dk/0UsmJNKcbjYTPAuwjfKcPnRsd17eweat9YTGRsV9N1kcoryTfLcfoo1gfFl+puylI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8AZI4NDS9VzSnKIxoKC840WXfwYbH77zmTdJ+Bj5yMDFVY2mj
	zHfh8dx3HnrV7rlNuDAcJyXvU81W2uTQFWn5gbHOeZI+1/0W3PK9WUIZ
X-Gm-Gg: ATEYQzxuDoVXjeBmaCRsZ1IP6lHAMNVJNu8oJffpsTt4/sz7cqRbfzN+2UqNU5UG4dA
	IX+WdgtGchNabNgsAN7v/ngtXDMae13zYz+DYeMCGkC6tpGNFTgulmcITNgmpYiS1cqfLLbriRo
	XvXXECAP0cC+ldZguzi3ScvQ0d4HFFywQjZji0r55ZjnNTLS5sW2GMJCjjMQAX5WCqW9vTU7/aF
	j/rovqWG+vDICCKe2GwHcW3G/uTq4cKUAAFuSggJgYOoIMSZ0ZGYhCHa3U7udr9zDh+DNWGrYmH
	6vxUAw8d5+oF3oxxUnh/YyLUG7W024xiEVud55jXZ+yKbUOqGk7By0QhQ7mSVvgu9b17HQCQSkJ
	TG3l0n1CztDk/x2jSgzfy9NCjxC5Q7T9cJOtv2yXqv6bcGWWuyusGt/unaOW2t4oNw5QcpxtbtD
	xtSM1MVMIAzMYTEyyR6bwWVTjgLKCtTdTV9nf/HfeVoZ/d+snFeFxxNwuvjYVMSkaB4iSjf3ChD
	/CBYCeVxxTUGUqUAIaGRGnh2h4c
X-Received: by 2002:a17:906:eec7:b0:b97:3bbe:e42b with SMTP id a640c23a62f3a-b97f4a7c85amr459473066b.28.1773924378353;
        Thu, 19 Mar 2026 05:46:18 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-769d-2f77-d166-4700.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:769d:2f77:d166:4700])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f168c141sm430902766b.40.2026.03.19.05.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 05:46:17 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Paul Moore <paul@paul-moore.com>,
	Gao Xiang <xiang@kernel.org>,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Subject: [PATCH] fs: allow vfs code to open an O_PATH file with negative dentry
Date: Thu, 19 Mar 2026 13:46:16 +0100
Message-ID: <20260319124616.1544415-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fields f_mapping, f_wb_err, f_sb_err are irrelevant for O_PATH file.
Skip setting them for O_PATH file, so that the O_PATH file could be
opened with a negative dentry.

This is not something that a user should be able to do, but vfs code,
such as ovl_tmpfile() can use this to open a backing O_PATH tmpfile
before instantiating the dentry.

Reported-by: syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

This patch fixes the syzbot report [1] that the
backing_file_user_path_file() patch [2] introduces.

This is not the only possible fix, but it is the cleanest one IMO.
There is a small risk in introducing a state of an O_PATH file with
NULL f_inode, but I (and the bots that I asked) did not find any
obvious risk in this state.

Note that specifically, the user path inode is accessed via d_inode()
and not via file_inode(), which makes this safe for file_user_inode()
callers.

BTW, I missed this regression with the original patch because I
only ran the quick overlayfs sanity test.

Now I ran a full quick fstest cycle and verified that the O_TMPFILE
test case is covered and that the bug is detected.

WDYT?

Thanks,
Amir.

[1] https://syzkaller.appspot.com/bug?extid=f34aab278bf5d664e2be
[2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-1-amir73il@gmail.com/

 fs/open.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 91f1139591abe..2004a8c0d9c97 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -893,9 +893,6 @@ static int do_dentry_open(struct file *f,
 
 	path_get(&f->f_path);
 	f->f_inode = inode;
-	f->f_mapping = inode->i_mapping;
-	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
-	f->f_sb_err = file_sample_sb_err(f);
 
 	if (unlikely(f->f_flags & O_PATH)) {
 		f->f_mode = FMODE_PATH | FMODE_OPENED;
@@ -904,6 +901,10 @@ static int do_dentry_open(struct file *f,
 		return 0;
 	}
 
+	f->f_mapping = inode->i_mapping;
+	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
+	f->f_sb_err = file_sample_sb_err(f);
+
 	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
 		i_readcount_inc(inode);
 	} else if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
-- 
2.53.0

