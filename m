Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7041B11EE
	for <linux-security-module@vger.kernel.org>; Thu,  4 Jul 2024 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103953; cv=none; b=XfnfMx5xZhy20QT+oIWtb1TZG+Z0hAQzsLJA+IlMkwVAQbXTMVsSnb3jv+z7af+q3YxkREd2pYXOaYYxgw0ZFBZbYOEONxgHPHAECdWcvPm5g0nbNuCmdeRWMTsR8LoOi4pJles4Zu5hVqlUsqYBV/i3e1nk2mNPyVk8/5TH0hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103953; c=relaxed/simple;
	bh=Cv66tffKqVjlVA5t+Lzf7KRgBGmH3LESz2m7EDSv8Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2Swv2NJ7bc7xAJZaGcGRU2Y/G3hKo0OTXqbcCzwZrwUS9shc3FEwa6n88q36BjOpM+eYbGKbk29yHK9qyUB1temjCmUiZ0uiywOce0dHm2B/+sxeyJx6of/A4m5WwBoPdVbZPiGewYQshL+QzFTJQr5aQh4Ho7ZX5dMgfUuvnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MclbTZY5; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MclbTZY5"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52e90679d5dso3093e87.0
        for <linux-security-module@vger.kernel.org>; Thu, 04 Jul 2024 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720103950; x=1720708750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=72SMMalQNaOPc00MRqfDjh4U4jrxEFf+MGhtcT7Z8UI=;
        b=MclbTZY5wewoVb+DdQkI9n/cwoGJKArbcsEOh9tZBmvb+43akRbVJZDgynxfeNXmDP
         +8UvIJqauDXCHWUfgbGX2lufKmveVKA59ZfXpeSOr0ClCRARQtGlESfrqGSnv6flhtZl
         7cAJDyTzyILkN/6USJteO/xZu3A939jq1vyZ2j1r3UQsFwHB8AZwy1v0/A1N1qIDQteJ
         2mLZvb15f8ZgbqiA8A41sDdcykfdQtDvltBDnFMHLEHeGTmffuSvo7Xrww1i5r6wwZPJ
         fp4sdZH2vn9zEzUZCZwyMCEIBrBwVor8PmRKXlDLHZUwMiiyYuMRcL6vQPRdaZvuxfSA
         EnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103950; x=1720708750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72SMMalQNaOPc00MRqfDjh4U4jrxEFf+MGhtcT7Z8UI=;
        b=m/Y41MlOQbM0iibZwMhH338M5fFFwujEsecCz/knE00bfAGoq6sdusGH493yZoLTHi
         JwQlE5h2VkcBpb3Ul0daD5QpjdMnSd7Bbu9o8i8J86/XNRNKup7iHXpeQw8JHv8zPii6
         3Jm/OfNJbvj8W4/lx/p1QZLNQusJno/HLUIAXCO9TVYCwnSiQkUpEczQVDdU6v6Ji3iV
         NDhPgDQy7EgiFiZwSZ5XqiXei06v66AZo8sTm3VrXOuEw6gIbaIS0cE4JuMp410cCvdP
         fwPMdnxvvJp7xoUaosipQXmtKYtJkDvtBP7judVRE4O0+r36C0GlHej5gTG6p1cGf/Fv
         tzwA==
X-Forwarded-Encrypted: i=1; AJvYcCWGIMIVSkdLsrNQoKgnwtixh2zx4PIjUfEuLF1viIFUtnpMXmVDHUjKGQlakXT8bD30vnF0ADHdLXDRlIBXBbmIKkCbbLNOEo/gjaz/xpMcHNZ7d5XR
X-Gm-Message-State: AOJu0YxEdkYmnFcB8QXbwj0wSl1xhBwC76HMEyyzQFTjT5/992qaxhAk
	GLZFHaYf5D9SyWoZ1aE6fxHRSwfex7pgXfobJuchPMyy0A6jh+IL0/jfh0xpJq+atorkQftR1KI
	+yXyQjP1YOBi2+MzxRo7ASJ0T4IYUHQHH/vPF
X-Google-Smtp-Source: AGHT+IHvh/l3PY7Tetrekb9ks9k4jfyMvlkTGrTTzBBDdKnbqA0KAJiEdqQ1LvOflC1Al32bSxuVnleb9pQfLeQP7pw=
X-Received: by 2002:ac2:5589:0:b0:52b:c1e7:dad7 with SMTP id
 2adb3069b0e04-52e9f2b8cbbmr105206e87.5.1720103949983; Thu, 04 Jul 2024
 07:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000004d74cd061c6c9e68@google.com>
In-Reply-To: <0000000000004d74cd061c6c9e68@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 4 Jul 2024 16:38:58 +0200
Message-ID: <CACT4Y+a1QqOO7XbZrTkppopg3hiUdBkpQLwN8+67PmHJcRHJsQ@mail.gmail.com>
Subject: Re: [syzbot] [lsm?] [keyrings?] KCSAN: data-race in __se_sys_keyctl /
 key_task_permission (3)
To: syzbot <syzbot+8c446f45cf5815e9110a@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 16:18, syzbot
<syzbot+8c446f45cf5815e9110a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    8a9c6c40432e Merge tag 'io_uring-6.10-20240703' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=113817ae980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5b9537cd00be479e
> dashboard link: https://syzkaller.appspot.com/bug?extid=8c446f45cf5815e9110a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f01153f3ec8e/disk-8a9c6c40.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/04b88663a824/vmlinux-8a9c6c40.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/63c518cc63c5/bzImage-8a9c6c40.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8c446f45cf5815e9110a@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in __se_sys_keyctl / key_task_permission
>
> write to 0xffff88812277dd70 of 4 bytes by task 19442 on cpu 0:
>  keyctl_setperm_key security/keys/keyctl.c:1098 [inline]
>  __do_sys_keyctl security/keys/keyctl.c:1926 [inline]
>  __se_sys_keyctl+0xab5/0xbb0 security/keys/keyctl.c:1874
>  __x64_sys_keyctl+0x67/0x80 security/keys/keyctl.c:1874
>  x64_sys_call+0x2bf5/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:251
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff88812277dd70 of 4 bytes by task 19441 on cpu 1:
>  key_task_permission+0x14a/0x2c0 security/keys/permission.c:55
>  lookup_user_key+0x9ea/0xdf0 security/keys/process_keys.c:803
>  keyctl_setperm_key security/keys/keyctl.c:1083 [inline]
>  __do_sys_keyctl security/keys/keyctl.c:1926 [inline]
>  __se_sys_keyctl+0x829/0xbb0 security/keys/keyctl.c:1874
>  __x64_sys_keyctl+0x67/0x80 security/keys/keyctl.c:1874
>  x64_sys_call+0x2bf5/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:251
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x3d010000 -> 0x00000000
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 19441 Comm: syz.1.4799 Tainted: G        W          6.10.0-rc6-syzkaller-00067-g8a9c6c40432e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> ==================================================================

The code in key_task_permission() looks fishy if it can race with
key->perm updates.
There is possibility for TOCTOU and unintentional re-reads of the field.
