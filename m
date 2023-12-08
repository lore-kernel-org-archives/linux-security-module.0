Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eb6oqZD7"
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7411718
	for <linux-security-module@vger.kernel.org>; Thu,  7 Dec 2023 16:21:03 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35d718382b7so5549645ab.1
        for <linux-security-module@vger.kernel.org>; Thu, 07 Dec 2023 16:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701994863; x=1702599663; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BgmRaIToo8A38WoiYLZrCH7dIhMjfXItf+GcOyWNtgA=;
        b=eb6oqZD7LcSYbSZC0LHjJcnVIu/ksGGWlFaO6Poio/yO9bCBUnX07V+2ZSA4zAq+dT
         gi0+5eDjTBt7lNh3Skvyniqg1I8pL3nJ9/eB/z3a9fWjaSFCDgwQhBUCdOcl9y1LqxQI
         c1QHvwa+PWw8wBkHhz+MrM2nAOzlUBD9k5Hjk0io+5ihM6mKPChRXP3VYWgq6ilGfW+3
         HC9lAeq6AKe7F8hrbUdhttbZ1yCGq1Vj2SAspBCFyUVBeXM6NBOUHmkqVVdeHxV+kNy4
         j6DRUNEAw7baJHiLreAjotZ09Xoeo8ipzG+c4M7JmTLtC3OdJbfXFIs8qZdVh7DUr9Pe
         ghiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994863; x=1702599663;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BgmRaIToo8A38WoiYLZrCH7dIhMjfXItf+GcOyWNtgA=;
        b=LoD9u4zXV81jJbpaa+UtimrTqD4MAWEs3o7TieQibnvZ84sVDhNYNj4QSg082PhjFH
         E3IEdLOYocqlKg10PKxOZaith+sr+RljtKjLMSauCEXeWblf1bNbNJTLiErALJQbenzn
         xQo7R91oJWOIR3qW+nYUgDd/+Hv9jU/B1Bn/IIGzb5XraC1SpLom/MrLe9fQEK4NY/6W
         PUyxt6ym+0c51olfXkG6Yutm3fK4NeKD+vHEZ5bFmkOFTHwZSkfeGOPMon1rEK547AwW
         4tuRg6GLZMahL8SQaP7dVvx6kPHH1XFbGYVP0otyfkrKhKk3OtAGHRDkP7vYMYMxl3NA
         HL1A==
X-Gm-Message-State: AOJu0YyOkUzkuQyzeuBy7kXXLfLdtuuG2eQV+Z1lxWldGt9jQhRnJKWV
	KLuAgQIC4jCJTo4+SU0+4+So4w==
X-Google-Smtp-Source: AGHT+IFmxqOvYC07N9/6k2J967esvjWO7wXuxjQi97yOmGtF2PTiTD7E9tSpSfZkIZXE81DkykeiTg==
X-Received: by 2002:a05:6e02:2143:b0:35e:6b86:3c1e with SMTP id d3-20020a056e02214300b0035e6b863c1emr346798ilv.34.1701994862788;
        Thu, 07 Dec 2023 16:21:02 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:9478:4e6::7d:47])
        by smtp.gmail.com with ESMTPSA id b23-20020a029a17000000b0046678ba8d7asm194028jal.94.2023.12.07.16.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:21:02 -0800 (PST)
Date: Thu, 7 Dec 2023 18:21:00 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Song Liu <song@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, revest@chromium.org,
	jackmanb@chromium.org, bpf@vger.kernel.org,
	kernel-team@cloudflare.com, linux-security-module@vger.kernel.org,
	paul@paul-moore.com, laoar.shao@gmail.com, casey@schaufler-ca.com,
	penguin-kernel@i-love.sakura.ne.jp
Subject: Re: BPF LSM prevent program unload
Message-ID: <ZXJhbHpIC3zHIYXs@CMGLRV3>
References: <ZW+KYViDT3HWtKI1@CMGLRV3>
 <CACYkzJ5iyiUi_3r439ZMRnjM2f9Wd0XYoGJYQY=aXJ4QmX7e-A@mail.gmail.com>
 <ZXJViQDsdj7Bg4e9@CMGLRV3>
 <CAPhsuW6dib__mB8RJUPQGz_f+NLKmdVE3HsZ1JTy6_Ga7ysViw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6dib__mB8RJUPQGz_f+NLKmdVE3HsZ1JTy6_Ga7ysViw@mail.gmail.com>

On Thu, Dec 07, 2023 at 03:42:49PM -0800, Song Liu wrote:
> Hi Frederick,
> 
> On Thu, Dec 7, 2023 at 3:30 PM Frederick Lawler <fred@cloudflare.com> wrote:
> >
> [...]
> > > While, I think this may be doable with existing LSM hooks but we need
> > > to probably have to cover multiple hook points needed to prevent one
> > > action which makes a good case for another LSM hook, perhaps something
> > > in the link->ops->detach path like
> > > https://elixir.bootlin.com/linux/latest/source/kernel/bpf/syscall.c#L5074
> > >
> > > What do you think?
> >
> > That's what I was thinking for option (4) "introduce a
> > security_bpf_prog_unload()". Anyway, I agree. Paul brought up a good
> > point that he'd like to see more discussion around this idea [1].
> > Mucking with the mounts (see below) is a bit of a mess, and there could
> > still exist other methods for unloading I'm not aware of yet.
> >
> > Yesterday I whipped up a hack such that:
> >
> >         mkdir -p /run/fs/bpf-lsm
> >         mount -t bpf none /run/fs/bpf-lsm
> >         ./load-policies /run/fs/bpf-lsm
> 
> Trying to understand the solution here. Does load-policies add multiple
> policies to stop different ways to unload the LSM BPF program (unpin,
> umount, etc.)? So the only way to unload these policies is reboot. If this
> is the case, could you please share the list of hooks needed to achieve a
> secure result? 

./load-policies loads multiple BPF object files (policy) each containing
N programs. Then for each program, pin it to the bpffs and terminate. 
There's more there for atomic loads etc... but not relevant
for answering the question. For this hack, I created a bpf object file
with two programs:

	- lsm/sb_umount
	- lsm/inode_unlink

More could be added to this list as necessary depending on finding other
ways to unload. I've only found the filesystem to be the most consistent
way so far. libbpf's unpin functions seem to be also trapped by the
inode_unlink program, but more exploration syscalls is on my
TODO list.

And added the object file along with the rest to load in.

> If the list is really long, we should probably add an option to
> permanently load and attach a program (until reboot).

This is an interesting thought as well. I think that would fall under
idea (5) [1]. But the list isn't that long, and lonterm, I'd like the loader
to have permission to load/unload BPF LSM progs. But, this won't help folks that
leverage BPF's skeleton loading methods and users that rely on anon
inodes tied to the task. I think KP offered some ideas there [2]. 

[1] https://lore.kernel.org/all/ZW+KYViDT3HWtKI1@CMGLRV3/
[2] https://lore.kernel.org/all/CACYkzJ4QpQZ8JmdNXKWeSh8oc=jAyRh4Zj98Z+TG37Ce=cfE0w@mail.gmail.com/

> 
> Thanks,
> Song
