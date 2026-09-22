Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240785616D1
	for <linux-security-module@vger.kernel.org>; Tue, 22 Sep 2026 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092521; cv=pass; b=EJ3TLz3+/SdJGxaAH6w/jUfpwggxbpjsMoeMee0QCq4aBgnxwyR3duGAxmL5SUzb4rLdYkK6JAQgdPCDaTo3XY6qYQuBDfwyVsdmFNr+pcJrEj3AiRi39jabdPXenMGig5hkYztN3k0Ffnwra+RGPy16cVsrtXtO/fjcfRhVjSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092521; c=relaxed/simple;
	bh=opZivKpqxky+OBoIil6sQOCGi1HNiA6ALJhYrvblBOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UP0gJGqPRF4nTgoRGPKG4C5YJ2u5j6JdM3ttjoVXhV0f02CORzDupp+iZ7b2Hi/p77oyFwF8GscfvIg/n3K4rvjZt541M/sES49CBBAMPEAmqhqAiJ2lwSxGbMIFvyx7GJiq10iv9PK2QCya7Ly5mEL6F9aU4PGLqRjdgdyx5YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=StlhYVTS; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="StlhYVTS"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d3b445a84fso112365ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 22 Sep 2026 08:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790092519; cv=none;
        d=google.com; s=arc-20260327;
        b=sg2t0MylpXHYJXaIp4B+z04TbMXey+bSMwzTX10zeBCAHc7rQUG25DWN8yud741jfJ
         gdkmXmmKfb1rS4biRMhSTaJsIUroZmVmFTK1oaeKIWp/lyGzcwYJJxtULA3vpfxxSDpk
         8oqMhs0yjv0PqDxbJ3QLlBVwgcpdPn5VkD/dgc3fMgMXkTBsFqa8GsD+jJ6ps2nxEaea
         BaNhmmsNsAZ/AqB5cYfxAXWlwf/ZknrYcc0reX9zTK5yFkm2yGl5oxFZDu0H8B4PjUcn
         GntKo9xKYidf7F44fzlHqmEmZoANDxP5jdGnVOVeU2s1a45ZRBcgca/fE+2TzBLuXBFB
         v2qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3CnAMf3rYfISbFoQbxUQPDoCBSAVsRITBKeQGlh3KBk=;
        fh=KLJltJxd4S2SMYuWbWG2TFfd25n9lLTU9XjwKOtXK+8=;
        b=U6tXbsMA0ZcbCshZVxt4FDryxyW+hp5z1LJJDDmRH4WJdNnDCpFJjiklY6gROV7zhc
         tvSxqiG/ApepUucCxvfqHyOIRI2ThCCjUid2I85CboaZ0w2FYBNrXiuelc7EXm3U3cFX
         PEsYfEWhXed3C+iPyKBxOxvK9PgAl8YpEnzmeAtdXmG6wpmBxr1+1xm7euGQTK+IXnVE
         pZdD3P2BQMagyEn1o1AeDcU40OFEhLEvomTBSjq4/1/uh+JEC+zO3vslrIsTdmoc1KWl
         o70z6ZzvnwFs8ZUS/XVS6JEj8sZWLLVYabf4X8YxCBrBR8rWJoH1hZkUtjPQ3ZBKIuDP
         4s0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790092519; x=1790697319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3CnAMf3rYfISbFoQbxUQPDoCBSAVsRITBKeQGlh3KBk=;
        b=StlhYVTSJXoufwzvC3o4b9hX4HvKUirvkZAYXzfc/R7vpVlKBT1+ORKtzv/tvuCACV
         o67fmMslcM2uqN3f+pX15yf1dF2UxA2x0kQMcqq9kw5zFf+cGycVbRC7hQ/P0GglnBUK
         Tf3mt7n6W86h7ax53GfBP5qiDSDNxUJUjKm4gAY1AwTjBUXxEMnsoVVvGLa94dER49S8
         qF+pbJpErk/IEM4wIarJq2gs+yyToIzmtTg0utzxjxzMUwonhVdbdrG0OcFX6DImKNj9
         iGhUZ2WYOQ/piDq8q92zjL2LOo1LgAV8bKRJnX3Qc79W0VPpnctLM8pCc1D2HhNWS66D
         hT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092519; x=1790697319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3CnAMf3rYfISbFoQbxUQPDoCBSAVsRITBKeQGlh3KBk=;
        b=OQ1O4t7u3QY8ot9xRonYjh+rbu/huBhp/wTJ+MG9QjYfHT8loSUJVHcD16v50XSqUa
         yVLcowHkruByrRvCWWAKQPLakETTZg0ijoRxWW3tUn0pat0XiLjzl1Gu+w2B3j0V83at
         T1WYRpPPkb/O3UXNVRYCWNQgOY5WeHVJBpXeMfPVjyF8hBR8wobtuJIz+fv36Ljf3B6e
         But0asuWGfQZgAi1f3ORZ0388Xr6CAzJyB3PSYU5TGR8Z/ZmCakOmT8vmeUvHn22hj4g
         PeWPpArPP73xszxMuTiKdOsRKMrnwKeL4utCWMOxS1aGqXRW7NuNbRet1YYEhIQGP77s
         N60w==
X-Forwarded-Encrypted: i=1; AKwUvByRX+fA9gwUivzGNXgJzRWvNTcIzYZaL0ti4HomK14+U2yrv3TUpEhW2LP3R0H/th1OdFt72GtSU2Ree3l2s5sLcJxkk+A=@vger.kernel.org
X-Gm-Message-State: AFuF++kZHKxpMMHVh1mPasZCUkeCqly/k2J8J64le289Fm+Xtm/HjZtI
	394TjXeGKkSV5Ml9el+uUctJqjz3ME/EjqoF8g7qcBPOiPAojpu6FmzKh7mhPv6Fk7QqKqkYIou
	EwqP5E6UKzUAO5s9P6UuZhR+UYIgr477FJqXSiKv4
X-Gm-Gg: AYBFou3hZvuIlgTOxtFTqSrZcdmB9B5UFSCN//dwHokggVr9uZAxrKvaJJ2D9BmZTHd
	XsXzfs7z5FNHnxC5LER/DmyCzheQ7C/3eC4Mp3oXhnzo/Lin4XvQ3j3fKljSZj1zflaTTjJrBtC
	n4nSSGDM2+PUVBCEZHnXc3drOHDVh5YJ9ozwjaBxLOVbGIFMOjxu8BaDO6JHAxjk2nT+ov9IGz8
	fc5nRj8F9quC9VKix+Y/nWh2RyKWWu5EZnknU0/ywQtdn9F5x1CtYPlC4Y0MLzqslB3iYTd3Wt5
	5jVE6o+xzDecGcmJxKedv8kI6vF7Kbvl94fZpI4DilqhMNBV4rd4e7GhTj66wEEmE5c57JEnONk
	GRbEN520FANQf1wjphsRGzBlwm9yo/1lT5QtwOINIEA==
X-Received: by 2002:a17:902:fda3:b0:2dd:b837:48b8 with SMTP id
 d9443c01a7336-2df6649017bmr1392335ad.14.1790092518734; Tue, 22 Sep 2026
 08:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-pidfd-get-paths-v2-0-c59ea6a21b72@black-desk.cn>
 <20260831-tauwetter-werkbank-dramen-b37eb4025283@brauner> <CAC1kPDMK_D4nhyRmBHg6KC7SmmCkH73Xtc5DhXeJbSvf3LcqcQ@mail.gmail.com>
 <CAG48ez1T5-tUHVK_iHsgUtWa-inVdrZxA3E-ZCW0iENJvasKfg@mail.gmail.com> <CAC1kPDNamG4BpfsX0mn9E-Y+ujGTLe-oU63kJFOjxW6bDmSLnQ@mail.gmail.com>
In-Reply-To: <CAC1kPDNamG4BpfsX0mn9E-Y+ujGTLe-oU63kJFOjxW6bDmSLnQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 22 Sep 2026 17:54:41 +0200
X-Gm-Features: AcwNN1Uevf7qvaoQ92TUBe1sUrMlhIbUuw3ph8s-vQAhL_GIcCXy5aT7MdRHJGg
Message-ID: <CAG48ez0+kYEdLm305xY7HsXgfXxeqFGYQB3N4UY7ppoyQ4t=9w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pidfd: add task path ioctls
To: Chen Linxuan <me@black-desk.cn>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
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

On Tue, Sep 22, 2026 at 8:08=E2=80=AFAM Chen Linxuan <me@black-desk.cn> wro=
te:
> On Tue, Sep 22, 2026 at 4:22=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> > On Wed, Sep 2, 2026 at 8:47=E2=80=AFAM Chen Linxuan <me@black-desk.cn> =
wrote:
> > > On Mon, Aug 31, 2026 at 4:49=E2=80=AFPM Christian Brauner <brauner@ke=
rnel.org> wrote:
> > > > On 2026-08-31 10:59 +0800, Chen Linxuan wrote:
> > > > > Obtaining a target task's executable, working directory, or root
> > > > > currently requires walking procfs symlinks such as /proc/<pid>/ex=
e,
> > > > > /proc/<pid>/cwd, and /proc/<pid>/root.  That makes the operation =
depend
> > > > > on procfs being mounted and visible to the caller, even when it a=
lready
> > > > > holds a pidfd for the target.
> > > > >
> > > > > This series adds PIDFD_GET_EXE, PIDFD_GET_CWD, and PIDFD_GET_ROOT=
. Each
> > > > > ioctl takes no argument and returns a close-on-exec O_PATH file
> > > > > descriptor referencing the corresponding task path.  The new ioct=
ls use
> > > > > the same ptrace permission check and nonzero-argument rejection a=
s the
> > > > > existing pidfd namespace ioctls.
> > > > >
> > > > > The target task is sampled while holding its exec_update_lock. Th=
is
> > > > > keeps the access decision and the task-state read in the same exe=
c
> > > > > critical section, preventing a concurrent execve() from changing =
the
> > > > > credentials or target state between the check and the use.
> > > > >
> > > > > The first patch factors out helpers for acquiring referenced task=
 paths
> > > > > and reuses them in procfs and AppArmor.  The second patch introdu=
ces
> > > > > scoped cleanup for privileged pidfd task access and separates nam=
espace
> > > > > lookup from namespace fd creation.  The final patch uses these pi=
eces to
> > > > > implement the three new ioctls.
> > > > >
> > > > > Signed-off-by: Chen Linxuan <me@black-desk.cn>
> > > > > ---
> > > >
> > > > I really have difficulties forming an opinion on this. So this soun=
ds
> > > > very useful but it has implications.
> > > >
> > > > Right now, pidfd ioctls are available even in situations where the =
task
> > > > in question would not be accessible via procfs, e.g., when procfs i=
s
> > > > mounted with "hidepid" options or similar. So this would expand the
> > >
> > > One point regarding hidepid: for callers that can pass
> > > PTRACE_MODE_READ_FSCREDS, hidepid does not provide an additional
> > > restriction. With hidepid=3D1 or hidepid=3D2, has_pid_permissions() f=
alls
> > > back to ptrace_may_access(..., PTRACE_MODE_READ_FSCREDS), and
> > > hidepid=3Dptraceable uses that check directly. In addition, the
> > > /proc/<pid>/{exe,cwd,root} links independently perform the same
> > > PTRACE_MODE_READ_FSCREDS check in call_proc_get_link(), regardless of
> > > the hidepid mode.
> > >
> > > So for these specific path lookups, hidepid does not block a caller w=
ho
> > > would already pass the check used by the proposed pidfd ioctls.
> >
> > Agreed, I think with regards to hidepid there should be no issue here.
> >
> > If I try to come up with scenarios in which this could introduce
> > additional danger, the main one I can think of would be: A task T1 is
> > running inside a pid namespace and has a unix domain socket connection
> > to a task T2 outside the namespace, with both running as the same
> > EUID; T1 sets SO_PASSPIDFD on its socket to obtain a pidfd pointing to
>
> Does SO_PEERPIDFD matter too?

Yeah, I think that would have equivalent impact.
