Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD038B13B
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147102; cv=none; b=hVEvaQpzZ7EPq/eDt0C3JjJ5TGXesTdj/IlIUssEJTr6PdM8ba4K8cGhmeMtzqf/NFPEbA+Mjo4U2Pm3kG6KkAPUsRjOh/L5G6OYn7RZB3VtPhmN1w4+UyBGRSIlkXoFgTgBAEtOfeuIP/h7THUhl9Baey5qQE35OaOrbPHaYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147102; c=relaxed/simple;
	bh=Hi00dQS7Xoc6m5aJOnPBBwSWvC+Fe+QdENhRjcQI6+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsCHr1ZfbT29t0qmveTIpm0ovxR4C8mdOMLDfDKdB4CbwijadFN7x3iTV3ePdqTBDXOL850DUPhTi7GkViiOenmbWE7PeSnhV14fvzvWmnDqeqTkdgfzSFVXkR3MonIPPqXa20bykZ5WVQlkVgBetbOxsYgwsoNG3bv9mgmhZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZqqqgs/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZqqqgs/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso12633825e9.2
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 05:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773147099; x=1773751899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxYLALGt+hvoOXwoZbS+8lgx0al1f8BirDazUyVeoq0=;
        b=lZqqqgs/fjI5ZYNu1UDaZpqOLkRkS0jE6mVq2nzPKVSuLnI+9edcmfnSZJ3fE/2rrd
         au/3wIYdweEOh4dGBYsprarpWVhZZreyTGwqeZ0bpcaGfjUOHSQqQo/cTl9ys8Cspusw
         DsHpiVwQmFpJQf/lcyjfksUlM3GxYiTCwWyUhlJCwTYqkx9tXVZBFnpgmSnN0ix/JqHy
         cNqKQ6hyzKSbaVOuWeG9AYpABw0sBuzfo7KyuRexxhIMYV41EOLvU8NfQkPb43r3l+U+
         ItrynjZKkrdNJdcPbd4pvTZyDEjWJlYDcdcpL7jmAWfYTVp4fi4UEYNlXHltjJDg0LX0
         56RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773147099; x=1773751899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxYLALGt+hvoOXwoZbS+8lgx0al1f8BirDazUyVeoq0=;
        b=wNB0A8JLSykFxg7HW0SD8l8y10c1Opulu95paOCdU0l0qvCFct5CpiZ34Zjs0IiSZm
         JAn/UNgMKSVk3je+3n3yeFTXRer2IHj3uJpdi2vzUv4/e+xBQCQOyRWWdsUNjLyiBTEf
         cwmFRVvfUJGqHiLaqwMv+oQK3ICyye8AizLimDNnXMIU6c6gyiDP2hJSq5wiCJJFrYxq
         AIx4A4S1c1lkzpZ/aPX+BQi0iL0HJXpF4LCy+TKiPhC6lV3pqgr2AK6SYrP4bU2+LT+d
         mKSnNYjDXvfBQmr4qtv3jbWFl04eW77ysWqD/qgMMvUsfelISB1pYPewQyt7mS+B6vXx
         DVMA==
X-Forwarded-Encrypted: i=1; AJvYcCVoRlZk/sHsZHQP+DfAa4FbfXPmHQ6xz3VeKsBoC1JVNbw9JFuDu6JHKad68vjyjkepQP8ud+3gToFzvyWJuZ3YZHkzhO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHhqL5w+JLYIz6wpzfy3ZrN4fgL9PXVzIFNK3EPCZJ9wX7bhka
	jejfOAxd5W7RqA/Gx4X3jo4U//5ccHPlaxEQHvrs3QJtNHaSXvHgQF0ydPh5CV1CHQ==
X-Gm-Gg: ATEYQzxbIKfgNtXbh2jNlGpm12hqxBuHmNY9hAZXZ+xMiJ3aG+sxlq9PZZBAXsFZU+q
	30KmfiP5dpRbreBdcS7BKXGMdcptUUMceHtM89fRwKev+5wsTZ5YUulUxjysaGn5NbCXuASZCI6
	HTTU8I1OCjcLo6NUDlUtUX/QsUntEP1Elro3ltp5gPE7wPynZsUx8Y7ChTcZJI65Gntpb12pe23
	o2v/B3N/8HVdAzplYsxrRN29b5vgh/J4tkhms+iaeKYaJGGJyh5PopzrqiNPtDNtW4sq9LxJg5a
	qzMERER+iUtH1ZbuvaXf42+Qy+HRfGsv5jbtnOT3QynbJAPNfSwRcs/UnyVUjjoOALojd2gdRJG
	n2V5P9+IT3MvRD4PIIz0HUO8dSpG1fVH1Yq4cJlKAs9gekaS7nG31M6ECiFCDxGMWkCxH6mjYtm
	6+BoPboPKuUs+Uc7L0/gUpCJyZXQxDBf2dIYlI1pR5ubjc36w95Oqmch9Ru+2KGFUM
X-Received: by 2002:a05:600c:4591:b0:483:6d4a:7e6d with SMTP id 5b1f17b1804b1-48526978644mr225780075e9.30.1773147099081;
        Tue, 10 Mar 2026 05:51:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:43dd:a0ed:65ba:bc74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d95dsm39194254f8f.7.2026.03.10.05.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:51:38 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:51:30 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: syzbot <syzbot+741e2278ef71fef03a10@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, mic@digikod.net,
	miklos@szeredi.hu, penguin-kernel@i-love.sakura.ne.jp,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fuse?] general protection fault in task_work_cancel
Message-ID: <abAT0q5bMfFYGT6V@google.com>
References: <69abb4e3.050a0220.13f275.003d.GAE@google.com>
 <69acf111.050a0220.310d8.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69acf111.050a0220.310d8.0003.GAE@google.com>

On Sat, Mar 07, 2026 at 07:46:25PM -0800, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    4ae12d8bd9a8 Merge tag 'kbuild-fixes-7.0-2' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17dc475a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=779072223d02a312
> dashboard link: https://syzkaller.appspot.com/bug?extid=741e2278ef71fef03a10
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130b075a580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/010ac4052aed/disk-4ae12d8b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2aad8bef9031/vmlinux-4ae12d8b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fd350ec4896a/bzImage-4ae12d8b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+741e2278ef71fef03a10@syzkaller.appspotmail.com

#syz dup: general protection fault in task_work_cancel_match
#syz set subsystems: lsm
