Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5973A9D94
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770288704; cv=none; b=n62mrJVMXPa3w9S8gXLsZo6i1xEMAdqoYM1q1hiu3l4Jj4tPgjdFAjM5DP1qB/W2onCmBGXz45+5xfqO62XfJgfmMdjqkFtKRsdZxXRLNRBy5d7HRl+DWwQzor2yAp5qOYppxcfAarDO4TNd0OhC8onoqgoL7XMKBDPmebd0x9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770288704; c=relaxed/simple;
	bh=w6m8/CBcsVO45PErliVcnFx0D1tqtbL2J7ITeUkz298=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zh/aHPXhj9wXhxUrvDWfHzE91TUWMdCZ9kuItn5/1SxwsJn2vsEeiCZ2T0WRmF7l2yGW8ibsSBUD2SQ4M8Ii+0FvdtLIAeer0n5faFln/0KPaXwlxNyLYCm8Gzw9wXRsxOfmkF9QbaPcic24s7eqYYhBIxfVSVjgOrly/+VA0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yNO8CTMB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yNO8CTMB"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4806cd00e02so5448165e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 02:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770288702; x=1770893502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FUC+IUQsyh6FSH9XQxPnuJxAw63qa2QoaAdOGHxWeSY=;
        b=yNO8CTMBEH/nZzCAsH56kirpau+5pm5SOGETqU2JF2tNKt2R+DNzWjqsjtVSBl/25d
         Fgu0paAOHifbiu9bpj+6EczqFa5GahKXzjaxGPBGConDfwnY2P0Kg8Y/OYlwSt3Osgsl
         t3buFh4BqX/u6P+yc+xweP6Psljf6tLnmpKE3lnD33YJqMZh9LJeoBRI9RANaHjKuGiO
         mvKhpr9wvvPW02F2q91NC1zRZOsuwHKndUWCJwaXtoa8E9KeQLRINcDvXQk9tK9yg8+x
         5LkyKYn/TjNkOC+JHK0+nixH1lPmpmVJzUFD3eUh4r1B8TfLPJJFYSGnrSHr7YLMnvXz
         Z+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770288702; x=1770893502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUC+IUQsyh6FSH9XQxPnuJxAw63qa2QoaAdOGHxWeSY=;
        b=PBGuAwj4NYyGsIP1LFJKmnRKF0WcSYz7w/xMK2SfAuFxjV1kPdkimlMqhZVwI2ZwkZ
         C3JEzdjDmbZqby7lKNV0o7WFgjMGAPGBn/WvwEX9EZ9JZhjLj1/uIL8TwcIWUpF59TUM
         Dr0P8OfKcCYVXUWYALIm1W3yHiXaVkSkAdSGzQYvhnyMrCd7MLZmG5F97raT3EpBc4gV
         otagAEQfsRG72BxP3QbTZ/tvjnYlsL8brGa/zuBo7E/kLv75nHAP/n91BYUNyVzmFItI
         YZfHg+2dHSlH2ov261hFGUDXhhv8BYf912Q0mRSlZFmv9qTzPyEM1FSyda0h6a84ymEL
         zRbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqfJler3t+ItNX1/Lmf1o112GVJrNlUVOufP/lN54AI9DgQspgUkY3JmnvKnZ52H4GfNLJ3OG4qJmBI4Za5Vm3TtxrUpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ9GyJciaWjqQKlQk3PGLpuZRlPVxEBpcjDUieE9JIvmo3Dipt
	PYD7FZuWSPZ/UDxN0lEdxIosK0CE1oNej4M+h3gNddMGA7/fWkv/HWsBGzSdElbCHTrw0wsJc7t
	YEjnNjVSCqxQqrSiPrQ==
X-Received: from wmbz19.prod.google.com ([2002:a05:600c:c093:b0:480:4a03:7b7d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f8b:b0:480:1b65:b741 with SMTP id 5b1f17b1804b1-4830e93566emr86248865e9.15.1770288702092;
 Thu, 05 Feb 2026 02:51:42 -0800 (PST)
Date: Thu, 05 Feb 2026 10:51:26 +0000
In-Reply-To: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2600; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=w6m8/CBcsVO45PErliVcnFx0D1tqtbL2J7ITeUkz298=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBphHY4wQ4kwP9Io25J2mxMCK0RJeRY4R9bMrUFI
 K93z2EKoVeJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaYR2OAAKCRAEWL7uWMY5
 RhmBD/4kCYBswFm2BtpYeMGLP4ihYfx7f4XUht5vAtF6sKzLqkxWIxbMVo6sn/e59ZLr/Dxxvnv
 HDEelcjeJTEabMLBoH1FKvnerzLzGiGkxX4IHCUX3rYm+WVsuluY8NrnGrXgzmBXWlVqaaQlscx
 i9PorwuCwYxjtYHwlJZkQqXnQmhXZHV0jz/9cPC6G/4jDtn4CcWYpBwx2rJOlKDzwaUrMwt0qtb
 IHi5T0drgp8PpJ1YYGJVRFbKbIogwsOBBBkEESh55KhgIixlaYSE6MO/ydSA+alfi591dhhUmV+
 lYnqlg6s1/COwZs06MokoR1jqDstgg6GjM3SF+e1H/Xu8MVJzkj/e5zjPWSlRFC7OL5jVV0sEk/
 szu7SlqvpdFFCUGsuuuCFVJU/viD5uebiBRLO9ZfNlFAZ7mk8sRnSXIYYae9qCBpJLEq3O9U9m9
 C+PDh2b3Ym5sDs+L5aq8eC3dhqO46LkvonWRJrZoQTQ+DiKTnef0ULt31jYO6uerKX3uGJvcSqf
 SP4b20Y8o/tRQgVejrU+MvkXUFpqY1kKs2m+8npV9m838jez0jY3C2jI2Dm/xDW++Mfnv7vYmni
 zDK3CV8BK2B0hmQOVgCGefVXoOlUeg9ktxWHg7qkv8LSoM0KxzGHcGCalsA/pTveoxGaeixjUGV QCNnFbOAhUfMrBQ==
X-Mailer: b4 0.14.2
Message-ID: <20260205-binder-tristate-v1-1-dfc947c35d35@google.com>
Subject: [PATCH 1/5] export file_close_fd and task_work_add
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This exports the functionality needed by Binder to close file
descriptors.

When you send a fd over Binder, what happens is this:

1. The sending process turns the fd into a struct file and stores it in
   the transaction object.
2. When the receiving process gets the message, the fd is installed as a
   fd into the current process.
3. When the receiving process is done handling the message, it tells
   Binder to clean up the transaction. As part of this, fds embedded in
   the transaction are closed.

Note that it was not always implemented like this. Previously the
sending process would install the fd directly into the receiving proc in
step 1, but as discussed previously [1] this is not ideal and has since
been changed so that fd install happens during receive.

The functions being exported here are for closing the fd in step 3. They
are required because closing a fd from an ioctl is in general not safe.
This is to meet the requirements for using fdget(), which is used by the
ioctl framework code before calling into the driver's implementation of
the ioctl. Binder works around this with this sequence of operations:

1. file_close_fd()
2. get_file()
3. filp_close()
4. task_work_add(current, TWA_RESUME)
5. <binder returns from ioctl>
6. fput()

This ensures that when fput() is called in the task work, the fdget()
that the ioctl framework code uses has already been fdput(), so if the
fd being closed happens to be the same fd, then the fd is not closed
in violation of the fdget() rules.

Link: https://lore.kernel.org/all/20180730203633.GC12962@bombadil.infradead.org/ [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 fs/file.c          | 1 +
 kernel/task_work.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 0a4f3bdb2dec6284a0c7b9687213137f2eecb250..0046d0034bf16270cdea7e30a86866ebea3a5a81 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -881,6 +881,7 @@ struct file *file_close_fd(unsigned int fd)
 
 	return file;
 }
+EXPORT_SYMBOL(file_close_fd);
 
 void do_close_on_exec(struct files_struct *files)
 {
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 0f7519f8e7c93f9a4536c26a341255799c320432..08eb29abaea6b98cc443d1087ddb1d0f1a38c9ae 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -102,6 +102,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 
 	return 0;
 }
+EXPORT_SYMBOL(task_work_add);
 
 /**
  * task_work_cancel_match - cancel a pending work added by task_work_add()

-- 
2.53.0.rc2.204.g2597b5adb4-goog

