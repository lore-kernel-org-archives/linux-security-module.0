Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8D171D2
	for <linux-security-module@vger.kernel.org>; Tue, 20 May 2025 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747769327; cv=none; b=GWwAa8Iuy/w1iG7K2coI49zqcUAD08ZIrwj/QA4Ck4r7q0F2cO+MEydtP1+qdyIddx2TTOBTdg/CF9llLE+YA21EfjGOzPP5ILH7F6YbOnKWcVRZwue2vrek6QOvTvvGtMxpOdylG0gl67vnz0Fz2ADscL1u1f3RJF0HDJAAd6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747769327; c=relaxed/simple;
	bh=VDO3T/W1YczuPEGQTj+B/DwdwmAGf+sUsv2s865z87w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKwo2+/TKpl1K4FGJEWqRY5kB4tyaiLpoVIh3XEi9+ScrpYrZOu5g+vkaSyyML3vtfQ5RdOTrXnJ2zLXn6iXvxmqR3JO0NShXUz6xoxiQGjmFGqevrHhRcodv5ABI36s5siN8n8xhXukoNdnHoWzTcuumCySGGK1fTC06aECt30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=jhTEBsgU; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="jhTEBsgU"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ecfc2cb1aaso63011716d6.3
        for <linux-security-module@vger.kernel.org>; Tue, 20 May 2025 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747769325; x=1748374125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSq28DpagvGJS4EtTRrUgm0EArBYqtzS+oqfIhFoB8s=;
        b=jhTEBsgUQidpFVnE5qLU4pKv1nO0I3DDJyO/CWdXlDVk2gHDOscqqAzWn7+/FF39en
         lxYNaWQm5QZ4DMclGefY/P+xGhIY2b6PoFItz65MxCZwhaqQ6QX6H1B+9O1fhi1qhnRL
         qRqE6HP6qrB0PiCETsG03zm04CNW5LAOqjMzZ46geJbg/LfI5dqlqeERuC4LMdvHF/ky
         wmRKoyiL8u+h4sm71CqoDz/lY5dEgoauNUd/BxyJ31CUMMVIflS0cu4zy3naIas+MxPf
         yRN3TH8CzU59pCMzKQ81NzUX9w3A47wnO8cDF/nyaOFtYsvDS+AnBzXRT+jPb87UFK93
         TKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747769325; x=1748374125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSq28DpagvGJS4EtTRrUgm0EArBYqtzS+oqfIhFoB8s=;
        b=B5i6aIvc+Jg6fvM+fj+bYeTayTAogUe81+8pxZXg8fPyP2IoVd8JCk2jmymG99XbI9
         UvsHrqgX7VgmEZpX93LLrRkO41u5HHFZMmmzOv4JYQjvjwftaJjxksMBCyzGxn51sS7c
         6tjkcxL23KiGGgLfMasb7rT0CbKGcFfQAIuzE8VuAoufvRYCFHdoqnfqTkyTVoO+RmP3
         LSPFalRwBXqODnd3Ts0AHR6QLNqMXanBnozpLnASfxDaBunek3wxFifUA1zx7Uglff32
         cp8ChwJjrJFiY02nMJOXwzZKQkxpAv7btLYK3Kw6BDfmt/dTgnhiRDuukO53MYM5svQK
         fvuA==
X-Forwarded-Encrypted: i=1; AJvYcCVRs2OVemwwOGgZewpF7il/kpuBp70XdFFkZvMFpFfDsETvSb59biLiBWG9zQv54NnRpbWLoazInK5oozBMXqKS2gdqAgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrzOfUzLDJC0/qUr5TibNw8dtaYU7kcdF67spF9XjuDnwu6wNx
	r0bw1cZodq8Ui0ELOmAapRr4BAqADua0o2qJ3z6pRWajlI1BqufaqhCRjALuG6Yorco=
X-Gm-Gg: ASbGncuZQtFbmBa+eyY4PmTH+PyGdZfL/MDuyzzL/ikjuLkU5wO+L+u+Z6S6JFUYwTH
	6UGGkk7Etm55+OUYrEiTp5nNTwsN2PFJrTSZYrlBnFiM4lhQUhBkk8kPwhsvtu6Jt928iwgEqeM
	+xL0bgSrZgg42EJ4fQzO05XTSoGHli0jsgw+3SEzUw/OFKYr3kih3vY0NR8bMn6MTZ3yVTSjaJG
	QPCRm0yfaL/A/rrSrYtdc50uWn0VzLlmKHpcg1Z4rs0mec80eU1ik1InhgrKxbIcqm8c3M1lH0w
	JolPqq5PUdPtKTjMO+o1dBoEQIlRUOlPgSOFgomXGQ9L1Ke4tB7NQwV6BtID0rlR7uSlkwhFEPd
	b9+Wh2lIpG1sCjZoTxGiP5hBCsjyk
X-Google-Smtp-Source: AGHT+IF2atiktvD9wDULfPXZekAoh4vnDwU+9Pt1AMawvaALaKAT6Zl+DIgg+N+z4H74uEanAqqEQQ==
X-Received: by 2002:a05:6214:2027:b0:6f5:3811:cc67 with SMTP id 6a1803df08f44-6f8b0842b16mr287390866d6.12.1747769324713;
        Tue, 20 May 2025 12:28:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b8778237sm67169206d6.17.2025.05.20.12.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:28:44 -0700 (PDT)
Date: Tue, 20 May 2025 12:28:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, Daniel
 Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg
 <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, Jan Kara
 <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, Luca Boccassi
 <luca.boccassi@gmail.com>, Mike Yuan <me@yhndnzj.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Zbigniew
 =?UTF-8?B?SsSZZHJ6ZWpld3NraS1Tem1law==?= <zbyszek@in.waw.pl>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, Alexander Mikhalitsyn
 <alexander@mihalicyn.com>, Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH v8 0/9] coredump: add coredump socket
Message-ID: <20250520122838.29131f04@hermes.local>
In-Reply-To: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
References: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 13:25:27 +0200
Christian Brauner <brauner@kernel.org> wrote:

> Coredumping currently supports two modes:
> 
> (1) Dumping directly into a file somewhere on the filesystem.
> (2) Dumping into a pipe connected to a usermode helper process
>     spawned as a child of the system_unbound_wq or kthreadd.
> 
> For simplicity I'm mostly ignoring (1). There's probably still some
> users of (1) out there but processing coredumps in this way can be
> considered adventurous especially in the face of set*id binaries.
> 
> The most common option should be (2) by now. It works by allowing
> userspace to put a string into /proc/sys/kernel/core_pattern like:
> 
>         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
> 
> The "|" at the beginning indicates to the kernel that a pipe must be
> used. The path following the pipe indicator is a path to a binary that
> will be spawned as a usermode helper process. Any additional parameters
> pass information about the task that is generating the coredump to the
> binary that processes the coredump.
> 
> In the example core_pattern shown above systemd-coredump is spawned as a
> usermode helper. There's various conceptual consequences of this
> (non-exhaustive list):
> 
> - systemd-coredump is spawned with file descriptor number 0 (stdin)
>   connected to the read-end of the pipe. All other file descriptors are
>   closed. That specifically includes 1 (stdout) and 2 (stderr). This has
>   already caused bugs because userspace assumed that this cannot happen
>   (Whether or not this is a sane assumption is irrelevant.).
> 
> - systemd-coredump will be spawned as a child of system_unbound_wq. So
>   it is not a child of any userspace process and specifically not a
>   child of PID 1. It cannot be waited upon and is in a weird hybrid
>   upcall which are difficult for userspace to control correctly.
> 
> - systemd-coredump is spawned with full kernel privileges. This
>   necessitates all kinds of weird privilege dropping excercises in
>   userspace to make this safe.
> 
> - A new usermode helper has to be spawned for each crashing process.
> 
> This series adds a new mode:
> 
> (3) Dumping into an AF_UNIX socket.
> 
> Userspace can set /proc/sys/kernel/core_pattern to:
> 
>         @/path/to/coredump.socket
> 
> The "@" at the beginning indicates to the kernel that an AF_UNIX
> coredump socket will be used to process coredumps.
> 
> The coredump socket must be located in the initial mount namespace.
> When a task coredumps it opens a client socket in the initial network
> namespace and connects to the coredump socket.


There is a problem with using @ as naming convention.
The starting character of @ is already used to indicate abstract
unix domain sockets in some programs like ss.
And will the new coredump socekt allow use of abstrace unix
domain sockets?
