Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08BD37F730
	for <linux-security-module@vger.kernel.org>; Tue, 22 Sep 2026 06:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790056952; cv=none; b=LiPRdJTaAsxifdiKapgyR3vThGc3aqK+RP5Ju4Lg3KmL5dYDIzAO4GBpOCsIjbrCrPs3MvZFGwCP/4UxF7qHk0XxA66/Ahbb0nxhj4ov+kpYQMhKMoJ5u3AjC0h2vX+KBZSAYz6Z0Mh07/H98Kgf1oSezbTC68v/W4/vYq/clvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790056952; c=relaxed/simple;
	bh=/gkxxAEJ2VEsBzCj+0PCJrUAyaQRh7llGGlVQ5kUCrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNYkC+J2NbCOpGNathuEOCGYgY9qp80JQeRMU8qRreD/HFmscA0ne0bT33V+qu9CIRaeAEcpbEAsv/9GEeZ8i4fKBN/awXbAE5buiCHfZ1c+75ubigDs+yFkOxa8sv0dYDr9SozQ1CGSIi2eUBR61PV0DIPVHTbw5WRvsCKO6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1801fso3746018e87.2
        for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 23:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790056948; x=1790661748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=51dqkeK+6HTCaJdD0DRXH94PwuZHWhVc5MOITOLNdLE=;
        b=lYSw6uqv+Yjb2SC5xiHxtpl5IaXyPf3m+SPnhZ4rEcwH1AGmbVnTjQTIcY4gJHmvOp
         CCCdCUCQ1d65Y7cd1mO4BrlZmSmH5m8AoqLDSjGtzQ2rE3dkg9JwfotsDG4hBI0Mcer5
         6e4kVlX2AQhcIyFPlzpyWiAx4XKfzv2dwBeyTUDfqn07RcMNbTm9sGBcyfC17kZoYhXA
         ZKnVEAyxIlinGesP/6OA7aDImXU6k8BR0JW5u1H1COmYL/72Y5VHe8EgAOd10qP3cXV+
         t8ylW9qKfVI/VOiVRMoWqvgvXl1TV+lQUlVnVosBDT8HQEs1Ni1Hu0I5oUKw9tvA6SVJ
         JYfA==
X-Forwarded-Encrypted: i=1; AKwUvByM2MjMNPitI3fohC0dhnG0oH1+oNxQB7TJGaz35RXTEF8C5Aia66k/1Oc9zj2YhacLr5fDkAHFdBaJhuiylNxw0sddowI=@vger.kernel.org
X-Gm-Message-State: AFuF++mBt/3OyvC0Q0YDcaBKbG5tHQpDtLZKyJ8mQJp/46SU7w0rAJoe
	gnAM8zdkZxMeq5pri4nDUKY4/UsZrh5dWSJr/suRXDg9W1vo1xdlzUi9o/rklu1q9iKzVA==
X-Gm-Gg: AYBFou1iFN/0nN0A9qPNBGrvTZe1F+j2NxEXKkLcrqnd6kiSEnI2sW+crvbKhkWfoly
	M+kM8RqmylhUVnqRRzo42DgIClSJUVv0Vn6VmB3U9pQbyP0JeeceWG/GYPxKerV1QIutytjIpIH
	PGV3rwk3bko3KXfjMeGpR9Nd9l45PgXTrlmKBnjFJllmvoFdr9UZ0AGfKLr+y/oVVU3quxe8kIs
	iUVi1FemUnGnGg+ofbnFmZfhDOeIIIzXfq7Vtp5P4WeEKGYsfg3kfD3F1WcraGdW42jPtNXLaIA
	EoJ5vj2LJQhE0qdUA2eZ/+Q9lm1ZBExgI39zQZV9vIUQyqAK+COYd4FKJQPJ6Fg/bSbw1e85nqK
	eFJ4s2rnC6O8q+T0FabVarE/WJSqGCA1ZrLnMldEa/BQxvy61/Z73RCPGLHuh3sfm6+i6ZNriey
	2UI00J7EwZw9+E1pGe/BsCy37amFwY+k3m5xCMvnhlrY4oMc1ZeMWbrdHswkIzSskbrHV2mmLyI
	5JNNp3AXM4Zz59Nq7Q570+uKneUWNYGpLAvprNIMTgw9tK2DaXKGlbDEAXYdUHR
X-Received: by 2002:a05:6512:3a96:b0:5b8:9c46:d4cd with SMTP id 2adb3069b0e04-5b8c1951288mr4287125e87.55.1790056948150;
        Mon, 21 Sep 2026 23:02:28 -0700 (PDT)
Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com. [74.125.229.205])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d46e8ce4sm207315e87.65.2026.09.21.23.02.26
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 23:02:26 -0700 (PDT)
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8c795f805so2118767e87.3
        for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 23:02:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzLfqUFVC7bZNDYmV90d41T0QuEAlGAsc6gMIqGqYyN4ITpoT9JyuT5koGvpUjv1SuaX9KMTf14pA4uSsUQl9vCHNuYMUU=@vger.kernel.org
X-Received: by 2002:a05:6512:110a:b0:5b8:99a5:5162 with SMTP id
 2adb3069b0e04-5b8c180e6cfmr3759117e87.26.1790056945794; Mon, 21 Sep 2026
 23:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-pidfd-get-paths-v2-0-c59ea6a21b72@black-desk.cn>
 <20260831-tauwetter-werkbank-dramen-b37eb4025283@brauner> <CAC1kPDMK_D4nhyRmBHg6KC7SmmCkH73Xtc5DhXeJbSvf3LcqcQ@mail.gmail.com>
 <CAG48ez1T5-tUHVK_iHsgUtWa-inVdrZxA3E-ZCW0iENJvasKfg@mail.gmail.com>
In-Reply-To: <CAG48ez1T5-tUHVK_iHsgUtWa-inVdrZxA3E-ZCW0iENJvasKfg@mail.gmail.com>
From: Chen Linxuan <me@black-desk.cn>
Date: Tue, 22 Sep 2026 14:02:14 +0800
X-Gmail-Original-Message-ID: <CAC1kPDNamG4BpfsX0mn9E-Y+ujGTLe-oU63kJFOjxW6bDmSLnQ@mail.gmail.com>
X-Gm-Features: AclHuK8ITwQn4waky8resdLcCFExt5UoOF-9n53imPe55RkN7kQMS7sWnKkQWLA
Message-ID: <CAC1kPDNamG4BpfsX0mn9E-Y+ujGTLe-oU63kJFOjxW6bDmSLnQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pidfd: add task path ioctls
To: Jann Horn <jannh@google.com>
Cc: Chen Linxuan <me@black-desk.cn>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
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
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 4:22=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Sep 2, 2026 at 8:47=E2=80=AFAM Chen Linxuan <me@black-desk.cn> wr=
ote:
> > On Mon, Aug 31, 2026 at 4:49=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On 2026-08-31 10:59 +0800, Chen Linxuan wrote:
> > > > Obtaining a target task's executable, working directory, or root
> > > > currently requires walking procfs symlinks such as /proc/<pid>/exe,
> > > > /proc/<pid>/cwd, and /proc/<pid>/root.  That makes the operation de=
pend
> > > > on procfs being mounted and visible to the caller, even when it alr=
eady
> > > > holds a pidfd for the target.
> > > >
> > > > This series adds PIDFD_GET_EXE, PIDFD_GET_CWD, and PIDFD_GET_ROOT. =
Each
> > > > ioctl takes no argument and returns a close-on-exec O_PATH file
> > > > descriptor referencing the corresponding task path.  The new ioctls=
 use
> > > > the same ptrace permission check and nonzero-argument rejection as =
the
> > > > existing pidfd namespace ioctls.
> > > >
> > > > The target task is sampled while holding its exec_update_lock. This
> > > > keeps the access decision and the task-state read in the same exec
> > > > critical section, preventing a concurrent execve() from changing th=
e
> > > > credentials or target state between the check and the use.
> > > >
> > > > The first patch factors out helpers for acquiring referenced task p=
aths
> > > > and reuses them in procfs and AppArmor.  The second patch introduce=
s
> > > > scoped cleanup for privileged pidfd task access and separates names=
pace
> > > > lookup from namespace fd creation.  The final patch uses these piec=
es to
> > > > implement the three new ioctls.
> > > >
> > > > Signed-off-by: Chen Linxuan <me@black-desk.cn>
> > > > ---
> > >
> > > I really have difficulties forming an opinion on this. So this sounds
> > > very useful but it has implications.
> > >
> > > Right now, pidfd ioctls are available even in situations where the ta=
sk
> > > in question would not be accessible via procfs, e.g., when procfs is
> > > mounted with "hidepid" options or similar. So this would expand the
> >
> > One point regarding hidepid: for callers that can pass
> > PTRACE_MODE_READ_FSCREDS, hidepid does not provide an additional
> > restriction. With hidepid=3D1 or hidepid=3D2, has_pid_permissions() fal=
ls
> > back to ptrace_may_access(..., PTRACE_MODE_READ_FSCREDS), and
> > hidepid=3Dptraceable uses that check directly. In addition, the
> > /proc/<pid>/{exe,cwd,root} links independently perform the same
> > PTRACE_MODE_READ_FSCREDS check in call_proc_get_link(), regardless of
> > the hidepid mode.
> >
> > So for these specific path lookups, hidepid does not block a caller who
> > would already pass the check used by the proposed pidfd ioctls.
>
> Agreed, I think with regards to hidepid there should be no issue here.
>
> If I try to come up with scenarios in which this could introduce
> additional danger, the main one I can think of would be: A task T1 is
> running inside a pid namespace and has a unix domain socket connection
> to a task T2 outside the namespace, with both running as the same
> EUID; T1 sets SO_PASSPIDFD on its socket to obtain a pidfd pointing to

Does SO_PEERPIDFD matter too?

> T2 on the next message sent by T2, then T1 uses that to get access to
> the mount namespace of T2.
>
> Christian, is there some mechanism that already protects against using
> something like SO_PASSPIDFD to get a pidfd to a process in a parent
> namespace?
> Otherwise, should we add something like a "pid_vnr(pid) !=3D 0" check
> either in these new operations or in SO_PASSPIDFD?
>
