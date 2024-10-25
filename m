Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D012B64;
	Fri, 25 Oct 2024 00:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729815792; cv=none; b=fBhD2LjuXrGQ/8Km2YgVjTbWPE+Kx/818HmPdorUPc4ylUgMhnMirVglVkT6tWcvXTVoezeKNk6cV9o0jQai7r+YO3+Hd4aCf4NDx8dSR+lIRimpv4uU7l/bte6qijxSkj3rmV+H7p2eTnCKUQbgW1Vg7KdLI0sZBB7hsa7qPmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729815792; c=relaxed/simple;
	bh=yA3fd96AyDyLhHtFasGToBuZwZd7yo49YJp07DRY34s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKICXCuyeE+IryjWgaspYa6dX9907ZwMBrbA/ySp5KvLBDwS9BiNK7pRNvb1mCWZ+Vq1Nd7vk6p7o3JwyN5i6klWfMk65rzstDRF2OoTiAEispFK5fevSJKUPin/RaUqVFZdFAyFhDavjYMGnHOvcBN5xl8gGYTnbCRpFRvGYao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F66C4CEC7;
	Fri, 25 Oct 2024 00:23:11 +0000 (UTC)
Date: Thu, 24 Oct 2024 20:23:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jordan Rome <linux@jordanrome.com>,
 linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>,
 Serge Hallyn <serge@hallyn.com>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [v1] security: add trace event for cap_capable
Message-ID: <20241024202307.196a2993@rorschach.local.home>
In-Reply-To: <CAEf4BzaZvSHnHBPcgkznq62sm_E2JNi1Bwg3g_a9PutfZLicmQ@mail.gmail.com>
References: <20241024104012.1815022-1-linux@jordanrome.com>
	<20241024091904.2650d758@rorschach.local.home>
	<CAEf4BzaZvSHnHBPcgkznq62sm_E2JNi1Bwg3g_a9PutfZLicmQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 10:48:55 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > You record cred, targ_ns and capable_ns but don't use it in TP_printk?
> >
> > It's fine to print pointers there. Is there a reason you do not?  
> 
> Are those pointers really useful for anything? Maybe it's better to
> print ns->ns.inum instead? At least that's something that is usable
> from user space side, no?

Pointers are actually useful from user space. It allows you to add
eprobes to get data from the structure. Yes, you can do this from BPF
but sometimes a shell script is nicer to use.

  $ gdb vmlinux
  (gdb) print &(((struct user_namespace *)0)->ns.inum)
  $2 = (unsigned int *) 0xe8

  # cd /sys/kernel/tracing
  # echo 'e:cap capability/capable num=+0e8($capable-ns)' > dynamic_events
  # echo 1 > events/eprobes/cap/enable
  # cat trace

Thus pointers give a nice way of getting info dynamically, and having
the pointer printed out in the TP_printk also helps to know you can do
this.

I realize that eprobes is not documented well (or at all) which needs
to be fixed.

-- Steve
