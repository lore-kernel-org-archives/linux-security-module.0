Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03E038F926
	for <linux-security-module@vger.kernel.org>; Wed,  2 Sep 2026 06:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332082; cv=none; b=RTOZx/8cGpKNLRom0wxc9tvSoBNiwhc0NC1KcKyTVhtnvQ3FQoOy8RUMl73QRbtGEvY8HkT+b7NP2thoQ2kj+l997sHP/t/dX37u8BFFbRJmY1y3G2+qyk/4CrpaOG8Vz+x+5H/yc75+Lg5HCKSfbvpBV/4WT4MmqPTPEagw4Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332082; c=relaxed/simple;
	bh=ixlWqFuSFl+kXQc/tcrrAFQiec5rJ4PZr781QjNJjcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjC4BXZBhXnjjq/ie0YSEyaP6Ifw3/2oLlf4m9EtxjYwxvr6E3NwuJCL5GTqHsq9pcYxXT1gx9hXr2EjlR7hL9KSD8B+TUpZ566tZvA5AgDqYS1U6MgAvJC/QZDHmKD3H2J/zFfYBGl8feJrZ6JJc3/Da69PX4Uxvq+ZQ4cJots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b5e18f0439so588310e87.2
        for <linux-security-module@vger.kernel.org>; Tue, 01 Sep 2026 23:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788332071; x=1788936871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CtlpH4A/FsfIicKK/MMLWRSJhN08nYCVAAoP5yOKMSg=;
        b=RjjNZOrno+L/wH4v/0/3F41gd9xYm6TXUV8TzmBXp+xSPAydyJ/d57GDBK+QYLD8qr
         6DZ7bkQjtvwFsPbxjFAX7xKm654+hml84p5jIG+hMCMGrvfBcb2ZRm0AIstUgq9pmBGM
         oTssCqY34uyqQPXmUkS9/kwojUCncbZCPTPALSEdQlCyD4x66FzaHz5FL4SAbHjPdzgM
         HcQlDQi06T0icd/7maI7UbrO7c0W2bt9UAJLvWAQwxujTsOryVxIjCpdwv6vFg9Cd/fG
         25Gfmg9uUjLeWYGE6TnldvSq5v4wfpT/n8LTUXdiS/UTYaUaL7Ft5dgpc8fDAr5yD6Br
         DQow==
X-Forwarded-Encrypted: i=1; AKwUvBz+lYtkS7/sWFJ1quxgtNDQfR0QSLsIBgO/mkpdKDej9LSCkLC16slPxqkSZbA8MXNp3g/nLN+bOFEMo0nH+uZoYTh37cw=@vger.kernel.org
X-Gm-Message-State: AFuF++mHo+cfyavXtzDjnoD/fokyWDAYIOBm+g8Es6l9pGuDG0WvKPaj
	OkiIsfVNDHu87odsDThmyjOBvdEPbTFOxENTsesRZ7s5wSL4f9qp7ZEhqgifoiOjOTENFw==
X-Gm-Gg: AYBFou3wM3kMbY3x80duLyVcWuj1bjkwcpvJg0jdlBV5KQHbK+D7e32uuO/rt/45Coo
	+TusAeXRMlVgRW5qflIvbzY+bZg6Bjf5pNb51aOAKgKkBfIDYh3ySjlRK8LZZ5Rv7R7LONdNH2S
	LOPm0uX9T7AW56rYUdU1pmkjHjEgTPihrOxrkCcp2s1Adm/cew56a0mupEPiDfB0+83mgLC+5EK
	1XqzV7x0PVaw94cGksRWmUOTkLJoIUyWoq1pptaoVjt+a3NLA6suleCin8cIURfU5aGkIRJBOy3
	SZ5P/HG5H+povR24kU0U4VTdwuA2dLpVmfyUSLysqGodR69+gzGmYXydU36FIYYoQ1sWHb/Urx1
	7F16tgO53l8bzU3A3WpR9hKjoyIWwxQ06pXUUocFPzd2w8biKU78cYJxCRTONWj+fbTTPVHcnaz
	gDVV7woV/X7/2qTc463UuGtgzQlKvFkEWLMpnfFRC6kNYvYOig6yQobdsGYiKzWk1TsF5AzZT8R
	AaMNn49t9Uz4L6ExLssiG3OhSfZC+sMOYY9Y1XU3V69lOdaiQ0dHY0N
X-Received: by 2002:a05:6512:3b20:b0:5b4:b03e:b17 with SMTP id 2adb3069b0e04-5b60831eb64mr767670e87.4.1788332070643;
        Tue, 01 Sep 2026 23:54:30 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b606b94450sm361139e87.50.2026.09.01.23.54.30
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 23:54:30 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a0faa764beso4642511fa.2
        for <linux-security-module@vger.kernel.org>; Tue, 01 Sep 2026 23:54:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy/faZ4vE1cxykh0DRcZdxXz61roDep1CGjK3Z/uIIdICGQLz7ixOQGa29CtSENrhvfCQ7eroryPP18/huAH5m5MNbxPiU=@vger.kernel.org
X-Received: by 2002:a05:6512:32c9:b0:5b5:e8af:a5f6 with SMTP id
 2adb3069b0e04-5b60831e880mr829854e87.3.1788331663502; Tue, 01 Sep 2026
 23:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-pidfd-get-paths-v2-0-c59ea6a21b72@black-desk.cn> <20260831-tauwetter-werkbank-dramen-b37eb4025283@brauner>
In-Reply-To: <20260831-tauwetter-werkbank-dramen-b37eb4025283@brauner>
From: Chen Linxuan <me@black-desk.cn>
Date: Wed, 2 Sep 2026 14:47:31 +0800
X-Gmail-Original-Message-ID: <CAC1kPDMK_D4nhyRmBHg6KC7SmmCkH73Xtc5DhXeJbSvf3LcqcQ@mail.gmail.com>
X-Gm-Features: AcwNN1WESqzlj5-w8dgp1OujQBVwB04y72AI-TKWGXGM1Ob33MtgcQyu2-BCfjY
Message-ID: <CAC1kPDMK_D4nhyRmBHg6KC7SmmCkH73Xtc5DhXeJbSvf3LcqcQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pidfd: add task path ioctls
To: Christian Brauner <brauner@kernel.org>
Cc: Chen Linxuan <me@black-desk.cn>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 4:49=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On 2026-08-31 10:59 +0800, Chen Linxuan wrote:
> > Obtaining a target task's executable, working directory, or root
> > currently requires walking procfs symlinks such as /proc/<pid>/exe,
> > /proc/<pid>/cwd, and /proc/<pid>/root.  That makes the operation depend
> > on procfs being mounted and visible to the caller, even when it already
> > holds a pidfd for the target.
> >
> > This series adds PIDFD_GET_EXE, PIDFD_GET_CWD, and PIDFD_GET_ROOT. Each
> > ioctl takes no argument and returns a close-on-exec O_PATH file
> > descriptor referencing the corresponding task path.  The new ioctls use
> > the same ptrace permission check and nonzero-argument rejection as the
> > existing pidfd namespace ioctls.
> >
> > The target task is sampled while holding its exec_update_lock. This
> > keeps the access decision and the task-state read in the same exec
> > critical section, preventing a concurrent execve() from changing the
> > credentials or target state between the check and the use.
> >
> > The first patch factors out helpers for acquiring referenced task paths
> > and reuses them in procfs and AppArmor.  The second patch introduces
> > scoped cleanup for privileged pidfd task access and separates namespace
> > lookup from namespace fd creation.  The final patch uses these pieces t=
o
> > implement the three new ioctls.
> >
> > Signed-off-by: Chen Linxuan <me@black-desk.cn>
> > ---
>
> I really have difficulties forming an opinion on this. So this sounds
> very useful but it has implications.
>
> Right now, pidfd ioctls are available even in situations where the task
> in question would not be accessible via procfs, e.g., when procfs is
> mounted with "hidepid" options or similar. So this would expand the

One point regarding hidepid: for callers that can pass
PTRACE_MODE_READ_FSCREDS, hidepid does not provide an additional
restriction. With hidepid=3D1 or hidepid=3D2, has_pid_permissions() falls
back to ptrace_may_access(..., PTRACE_MODE_READ_FSCREDS), and
hidepid=3Dptraceable uses that check directly. In addition, the
/proc/<pid>/{exe,cwd,root} links independently perform the same
PTRACE_MODE_READ_FSCREDS check in call_proc_get_link(), regardless of
the hidepid mode.

So for these specific path lookups, hidepid does not block a caller who
would already pass the check used by the proposed pidfd ioctls.

> surface of operations you could potentially do.
>
> But again, I do think it is actually useful. Adding Jann.
>
>
