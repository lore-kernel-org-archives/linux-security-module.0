Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A87256D
	for <linux-security-module@vger.kernel.org>; Sat, 21 Feb 2026 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771675212; cv=none; b=QbcuxRCY98qLzEUWdDjhfXLqgYr5yLJDt0ehIz+g9wfm4hXPEs5lhtoPK8Bk0Ip7wBbyrb5C+1Ycy6BtW1tfnz3+Ao8zg1D1hcSt97m/D231sTzPRAmqlvieuvCGyipGUKxBcWAmdkBubFAb/fSqIzRFCaQ09gr7nd40VVVTs+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771675212; c=relaxed/simple;
	bh=GB3RSQEmANtlu614hSByTlR6kjWKexUj+udygbuXgSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCxydBQBjeocpLRXLj3k/ZZlPK/hRFsAmLGQnTL8qrFnaDXXlTKTFZnCfUnrWv/RXn2KW4Smhu+sTXRg7dRJeQGZXrFZUrbAmE1RbbFV7FbqO65/0H+jtYhUF+507y7sj74lDCyfkusP8ZDfCIpIpeL+qxFHLY9TM5Lp5CWkN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3nkUp64; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3nkUp64"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4807068eacbso23247905e9.2
        for <linux-security-module@vger.kernel.org>; Sat, 21 Feb 2026 04:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771675209; x=1772280009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fNqjB+Ub5nJ0By5ZkI+w/9P9K8BlLSxFpbdIA8/2X6M=;
        b=P3nkUp64NTZdEo2o58n2fJjblBAslUJpjSyclJ/Mr0/kn7S0g9l+rLg+ZiJGSmskWT
         7tXZ1XQtnDLg12qBS6QFsqKvf5og/hAP2sD5arjhBQHBancSamjUzEXmaz1fF0wGVqiI
         +IvnI3Pc3wQ13k+xLbV1kGRl745qgPjtPqCVR68FZVTMyprznOyw6tRVPNZzbhdx2hDp
         5djcbdkNRs9FNMYJhHWcFAuJ8bOtY6Bt9QL76EFI0ffO/8/q4LdW3MGTK5jtkmkOycy+
         6b39jbedkPViVwLJLU2kvFxVy4C9KhuFI7kRlknRwuM2CwKyv14oxW0XyjgetL3qKidk
         NQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771675209; x=1772280009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNqjB+Ub5nJ0By5ZkI+w/9P9K8BlLSxFpbdIA8/2X6M=;
        b=Vq4aS/iA8wF0+1Ik4tHyHRGNOwILHMhNVjluwliU+TolztwCtlAyLf3NoQRzBe0aQq
         KKRgAjVXullh5LXoToRmNGXU8dNVpaE8cJusEvyeBOS8+JWOAmGl7hR0n5hqy43idOB5
         7j6NSNGI7B5ncI6cUHOM5wKDmkZzCpT38IInCH0jAMH29aXnmWb2HRDsvIVBZ9CB15Yq
         AHAdAgiypUSccU7iq5qpPBXWGsftLpR0hUdDBoAFIF4NrJVaUnIpl9BBd2hoZ/d2gGTg
         L+iFN3qGKX8bzW1TMOZtbDWwHUMhpL/07Oh71lfiBbps427QLH4x8QH/fCjfV7CjL2D/
         Wxew==
X-Forwarded-Encrypted: i=1; AJvYcCV0gIYbx1zN8JjV7tadRZaD/XTIzY20NCE7jsTBfXar3I4DVXh6+OjEocyH8QotBCgu4pJx21r0MBUyr0zj+3epFTXt/0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOenAxgeRPiIxmBLuEOch31Cu2rkTiX8fxjLq0k4A3dWG0KBf6
	fidDKbjCwxw6fwNRuTxls7tYBEK887lfVKfE+13PfP3GphS+LKHPpg5P6Zry9qUT
X-Gm-Gg: AZuq6aKIhY8qM4B7NttlqieZeAo2ck+9cHN8qYckb+JUIkI0xerllZ0Gjd8z6CJ0Skr
	lYlmsHXo2A4JhzJxxCIM7JKmVKg2/7DnMQF9fdfcYvSfIrk7GLwUoMrk4xAQvza5zSke37HehWg
	wCeQTT8xlwY6WspnUTgFjAFUiJ3sCdX6BR0X7Zfwt7kNnS00yNGsNgxMmV2A185fO03lVaAOxDz
	Bm+B0by2myaKd4aVEvS7qHZWEk/7pN8ucbAG38r0XiFD/68STmk8Yl3t2au8Rs7kRw5u3wNC16q
	ZBIgsexDWKGHymEBHbDFXq1VHa8av3Jr99vGCc2ZMZUi2nDX7EaB1NkvvYUJS8p7BaXp12ynDZs
	qSxLEeiJ/5DXwBvGE5oj09O5Oquf6IuhROLwDouZ0pq0907B21I0KK/oE4FRQnKLHeGYQZ/DQLK
	xWMoC+X4zlwgCZjJ8r4Gea+P5wITcpwwZCIDcjyYKMRm6V1YXBPQXbMFFetmQ=
X-Received: by 2002:a05:600c:1f8f:b0:483:6d4e:9811 with SMTP id 5b1f17b1804b1-483a95ee3f2mr48811895e9.31.1771675208611;
        Sat, 21 Feb 2026 04:00:08 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3ddd3c8sm59132175e9.2.2026.02.21.04.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 04:00:08 -0800 (PST)
Date: Sat, 21 Feb 2026 13:00:03 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Ding Yihan <dingyihan@uniontech.com>
Cc: syzbot <syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in
 restrict_one_thread_callback
Message-ID: <20260221.5d8a306bcaf1@gnoack.org>
References: <69995a88.050a0220.340abe.0d25.GAE@google.com>
 <00A9E53EDC82309F+7b1dfc69-95f8-4ffc-a67c-967de0e2dfee@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00A9E53EDC82309F+7b1dfc69-95f8-4ffc-a67c-967de0e2dfee@uniontech.com>

Hello Ding!

On Sat, Feb 21, 2026 at 03:28:47PM +0800, Ding Yihan wrote:
> Since I am relatively new to the inner workings of this specific subsystem, 
> I would like to take a few days to thoroughly study the root cause 
> (the task_work and mutex interaction) and prepare a detailed and proper commit message. 
> 
> I will send out the formal patch (v1) to the mailing list later.

Thank you very much for preparing a patch, and especially also for
forwarding this to us.  (The original syzkaller report was somehow not
addressed to Landlock or the LSM list.  We should fix that.)

Timing wise, the feature was picked up for the 7.0 release, so we
still have some time to fix it before this is stable.

As an early review for the patch:

Background:

We had previously convinced ourselves that grabbing the
cred_guard_mutex was not necessary.  To quote the comment in
landlock_restrict_sibling_threads():

    Unlike seccomp, which modifies sibling tasks directly, we do not need to
    acquire the cred_guard_mutex and sighand->siglock:
   
    - As in our case, all threads are themselves exchanging their own struct
      cred through the credentials API, no locks are needed for that.
    - Our for_each_thread() loops are protected by RCU.
    - We do not acquire a lock to keep the list of sibling threads stable
      between our for_each_thread loops.  If the list of available sibling
      threads changes between these for_each_thread loops, we make up for
      that by continuing to look for threads until they are all discovered
      and have entered their task_work, where they are unable to spawn new
      threads.

The question of locking cred_guard_mutex came up in the patch
discussion multiple times as well, the most recent discussion was:
https://lore.kernel.org/all/20251020.fohbo6Iecahz@digikod.net/

If it helps, I keep some of my own notes for this particular feature
on https://wiki.gnoack.org/LandlockMultithreadedEnforcement.

(Very) tentative investigation:

In the Syzkaller report [2], it seems that the reproducer [2.1] is
creating two rulesets and then enforcing them in parallel, a scenario
which we are exercising in the TEST(competing_enablement) in
tools/testing/selftests/landlock/tsync_test.c already, but which has
not failed in my own selftest runs.

In the crash report, there are four threads in total:

* Two are stuck in the line
  wait_for_completion(&ctx->ready_to_commit);
  in the per-thread task work (line 128 [4.1])
* Two are stuck in the line
  wait_for_completion(&shared_ctx.all_prepared)
  in the calling thread's coordination logic (line 539 [4.2])

In line 539, we are already on the code path where we detected that we
are getting interrupted by another thread and where we are attempting
to deal with the scenario where two landlock_restrict_self() calls
compete.  This is detected on line 523 when
wait_for_completion_interruptible() is true.  The approach to handle
this is to set the overall -ERESTARTNOINTR error and cancel the work
that has been ongoing so far, by canceling the task works that did not
start running yet and waiting for the ones that did start running
(that is the step where we are blocked!).  The reasoning there was
that these task works will all hit the "all_prepared" stage now, but
as we can see in the stack trace, the task works that are actively
running are already on line 128 and have passed the "all_prepared"
stage).

Differences I can see between syzkaller and our own test:

* The reproducer also calls openat() and then twice socketpair().
  These syscalls should be unrelated, but it's possible that the
  "async" invocation of socketpair() contributes to adding more
  threads. (Assuming that "async" means "in new thread" in syzkaller)
* Syzkaller gives it more attempts. ([2.2])

I do not understand yet what went wrong in our scheme and need to look
deeper.

Ding, do you have more insights into it from your debugging?

Thanks,
–Günther


For reference:

[1] Report Mail: https://lore.kernel.org/all/69984159.050a0220.21cd75.01bb.GAE@google.com/
[2] Report: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
  [2.1] Reproducer: https://syzkaller.appspot.com/text?tag=ReproSyz&x=16e41c02580000
  [2.2] Reproducer (C): https://syzkaller.appspot.com/text?tag=ReproC&x=15813652580000
[3] Patch: https://lore.kernel.org/all/6999504d.a70a0220.2c38d7.0154.GAE@google.com/
[4.1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/security/landlock/tsync.c?id=635c467cc14ebdffab3f77610217c1dacaf88e8c#n128
[4.2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/security/landlock/tsync.c?id=635c467cc14ebdffab3f77610217c1dacaf88e8c#n539
