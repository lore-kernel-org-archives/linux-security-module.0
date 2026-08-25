Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CFF3E835E
	for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787693245; cv=pass; b=AkCMUs76crGyEyS+KVphvu1S46B0g7I6ezuZ0p/V38WbPB6Xl0iY1wYRhVS0iYcbOFsI+1URwl6f25xZpDlivfNMx7FzIgr8uKf0Ici7aaLOWsSn6/50rMIW5Vfr4Fub+ohEao3ckiIZo8+2BbYrTkrnbqZTUers2+a9PKqjPEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787693245; c=relaxed/simple;
	bh=9HjdICmhLtTz6k7OlzAvVfsYT+6y6EVDVq4rDGeTyx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRftCpTZRu7Ag7oOQiC4oJLkM+8H1zFhgE35vGHEOM9H+SrFs9WNZLrz0P7eHl3nNLu5+swVgrzJF4iNCR1T3TQAYluLsnOCUMJG+kZUKrzUFr9TiUTF6MGZRZg98W6k3uGlon3yJPCBxvnlWJMbKGIiBZnRZakI1jPjy8pIDvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1KvuAPs; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1KvuAPs"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a3efa2b38aso434564a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 14:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787693242; cv=none;
        d=google.com; s=arc-20260327;
        b=kjriVu9Y0DC1vOCf5GJu+HnoFDf98MvzwV9L2E+CK2y3XVrUbxTpsJSRPzmedgLFzY
         JUrtZdlMQlUeRuaQYaV6+hbR4EfMeTypPfhgzPVz+4axhwKYLyFJbekao+Smayy15FLt
         71YrUyDKz7/hZ7b6UYASogXwY99BdxiP/uX81gdwbqeeMOe5v5G2qfb28NzSZauQmnhH
         xc9rEWx2yERHcB6YACTbkhpsfcT6a6H/RytuQnkbp+mFkLdot2C9Z7tvvKIAR3IBsHwe
         uZ/5W5u2hvLljhtnfHxDXIV2VfW8wDKWH0/2o+iCL2PCv1QFtmAD0RH+bUA4ecTPBbtF
         3rRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bE5lTVE/l+hmDFQxUEo/OmNLEGESlTEML0H1de8/2cY=;
        fh=m5c3GCrpSVJK+C/q+ZPUfl9VfdXzjlMv8PrScxRWozs=;
        b=etgZ5+jCeZgb4Hd4nITNDPPB2QCMiYFZLtJ3IDclJNGXVgrO5Ia8FA2RQz4CBCYnwh
         taLJrlRf8gkngCqwL9oSGPDtUYZFwfDAYMAJwoMQV6UsBymcIwUDpqyngCM3I9d3XwUA
         qWcB9wJ/ROnHeM/gljebUMDRSFnSid6xsEdKJzkMnvJ2ACR7tc6dNYwljJtFitN1T/Pr
         UQVM+8UsABRDZMQOpKJ8Bu0+K517PJr8U1kitqpxVe7mNofLpNiPlbphVnPafwiUajWT
         HT/4sjnQVZj1YVQPHllIPJekx/BDK8yIyjCU5K/so7Yx+Bsvwlp1ZKb0NrKPSmLOFuC1
         No5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787693242; x=1788298042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bE5lTVE/l+hmDFQxUEo/OmNLEGESlTEML0H1de8/2cY=;
        b=s1KvuAPsIex4dmM++B7O1fMeB7/FwCP64Z8UVBSNIatQmnSxhCm1aXQ+DQFAQAQZP7
         /lZyQirMBHwvCO3kkufwE+jhr+s7cV6xq6V33fjI1T/VrK08v+KHuB9CQ2rVoVvDhVhk
         71qhyoVs9EIx5rJB1S0LqoBjlIFUfa5HRwZmwvco+m60zzGGh1iHnFiMAJL5NtcPadZY
         96WElsSRfahwNMx0o57zdFVk21AMh0PfHuBQhSnaWKCW9D83lQk6KUymMlBoF2GB2SI0
         Cbg1wxYeaP1RwG1xG39Ps4m04QzddW4cU8mwIROFbtmr3H4VuvhH3B+Uq9u63gLPq9Za
         ifnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787693242; x=1788298042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bE5lTVE/l+hmDFQxUEo/OmNLEGESlTEML0H1de8/2cY=;
        b=TZxzebF3Cg4aA5AV46+OyRXruzKPcJ/9pviUJ2LMW05SIXJ8t62/eMvo9x1cjvZy3l
         3E5E4wAd1er9zjAqXuOD4CN1WV86DqIfRR6pnEnvb8qAq8UkBmF478udxsj8Ibvpv+fS
         bUMoxWBr1JtScReXhaIvZk7+WGf/2DkT9vTecuFntd1wptblprYMMJekjmOSrZmlrc/D
         qEggVFpaMxWPSeKtG2EgLuZ6k7srQfYAGcLiMTK07wxOL3HhQEh5b2iOlh6aSO5lvpjl
         zqO4m3G//Owv4NbjsFToPnFL1sgoBps9Dwv2yC/E4eWKmXBfZzoPsR6RogoDPoq4C1/c
         W9jg==
X-Forwarded-Encrypted: i=1; AHgh+RoGw2aGSstq5Y08Udr90UnjDr6c+h+QCDYWTd0HPpkWbvYO2I33LQW/nf4OiS24pUImK8a4MLiaaDn7Gtvjt9te8gw2fRc=@vger.kernel.org
X-Gm-Message-State: AFuF++nvYeqXB14VJZ8bNIGmPbFTK1U8Psi/rcfn976giK7bff7iLF7E
	ELz3q4rtwotKgF0YLgKEVb+gAcr9eOLaVpcQXVXI8gTJu6/IuVttgh8b6eQKcWp1ZEI01xluZQ1
	sa/cI88eDAfpDV0h6Lcr6RuUgQ9+LDHY=
X-Gm-Gg: AR+sD13elaGCd98fLHuqenHvajmnqtoB0Hzn70JmYbh5gG1mELNksuVeVz2GF9z7H8p
	84jPO9Q8waNCwAOSaD15fxrdXtbkHhCN8XSyH92rgeCfJ15phERolPLEmbqCipNcSP7nE2uylyS
	zb4DUxYz+dRiQtDFMPmBAoBzUVRDEw+qkBUYotpBikgyLVYktMR7zyVMXoNZF+SJxY3REz4BIoP
	leM3zqv7LVa4PNt1Pj8y/1+e18LFZPxZWK4n1n1b4zG6gtNkVJnqOHxV5qyXmp+DwbfaQevKQrI
	+B4e/lAddKsFVFDHncDFqzX/g2Tmn/iU2A3dq4u/ohd+BnS/uIaKWuLu65mba+Mdl7wVV/L/9hc
	tIw1fLQ9teIo=
X-Received: by 2002:a05:6402:21cc:b0:6a5:d58a:9640 with SMTP id
 4fb4d7f45d1cf-6a5df61b209mr2046699a12.9.1787693242034; Tue, 25 Aug 2026
 14:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784204592.git.me@linux.beauty> <anJE8SfBLtkh6QSa@zenbox> <1a01795b07a.1f456216580426.3401229391386650127@linux.beauty>
In-Reply-To: <1a01795b07a.1f456216580426.3401229391386650127@linux.beauty>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 25 Aug 2026 23:27:09 +0200
X-Gm-Features: AcwNN1VIk99DyxEcpdaJ9t08bm4LFPXj5Yk5ztu7oKocV4saiMTQcrI1RCnhRcA
Message-ID: <CAGudoHGoOr8rvhSQK+HQp7LmNyE9vP=xTok9eA1ZbV7uaVnMEg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/24] pidfd: add a minimal process spawn builder
To: Li Chen <me@linux.beauty>
Cc: Justin Suess <utilityemal77@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <kees@kernel.org>, Gabriel Krisman Bertazi <krisman@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Andy Lutomirski <luto@kernel.org>, 
	John Ericson <mail@johnericson.me>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-api <linux-api@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-kselftest <linux-kselftest@vger.kernel.org>, linux-doc <linux-doc@vger.kernel.org>, 
	audit <audit@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Whoa, this is older than I thought.

First and a foremost apologies for radio silence, I got really busy
with other stuff.

I did not have the time yet to go through the patchset, but I have
some time to respond to this bit.

On Wed, Aug 19, 2026 at 3:15=E2=80=AFAM Li Chen <me@linux.beauty> wrote:
>
> Hi Justin,
>
>  ---- On Wed, 05 Aug 2026 04:25:25 +0800  Justin Suess <utilityemal77@gma=
il.com> wrote ---
>  > On Thu, Jul 16, 2026 at 10:31:26PM +0800, Li Chen wrote:
>  > > Hi,
>  > >
>  > > This RFC follows feedback on my earlier spawn_template RFC [1]. That
>  > > proposal made caching the primary interface; this one starts with ge=
neral
>  > > process construction. Christian suggested a pidfd/pidfs exec builder
>  > > modeled after fsconfig(), with enough semantics for userspace to imp=
lement
>  > > posix_spawn() [2], and Kees agreed [3].
>  > >
>  > > This RFC is based on linux-next next-20260710 and depends on two pid=
fs
>  > > fixes that I sent separately:
>  > >
>  > >   * pidfs: preserve thread pidfds reopened by file handle
>  > >     https://lore.kernel.org/all/20260716052726.1032092-1-me@linux.be=
auty/
>  > >   * pidfs: handle FS_IOC32_GETVERSION in compat ioctl
>  > >     https://lore.kernel.org/all/20260716052822.1034228-1-me@linux.be=
auty/
>  > >
>  > > The initial implementation is source-based. The executable path can =
be
>  > > provided with the final run request:
>  > >
>  > >     struct pidfd_spawn_run_args run =3D {
>  > >         .path =3D (unsigned long)"/usr/bin/rg",
>  > This should probably be an FD for the path.
>  >
>  > This way it prevents race conditions over multiple configuration steps=
.
>
> Thanks, that makes sense. Using an fd avoids the pathname race and pins
> the executable we actually want to run.
>

I don't understand what race is supposed to be addressed either as
none of the setup depends on the content binary.

Regardless I don't think this is going to fly as it directly shafts
NUMA setups. What's needed is a path to the binary + the PATH
envifornment variable or a collection of paths to try out.

Here is how it harms NUMA: In the most extreme case suppose there is a
container bound to a specific node and you want to exec something into
it. Further suppose none of the relevant data is in RAM yet. And
finally the process doing all the work is running a different node.

Say you are going to spawn ${container}/usr/bin/coolprog.

At minimum this will allocate a dentry and an inode for usr, bin and
coolprog itself.

Afterwards any path lookup going through usr in that that container
will have to fetch memory from a non-local node to traverse it, same
thing for the bin subdirectory.

This is a self-induced problem when using a fd.

In the real world userspace notoriously performs failed execs as it
makes its way through dirs in provided in PATH, and while you can
patch select programs all you want, the mechanism will have to account
for it.

This is where the next NUMA issue lies its ugly head. Suppose you have
a box with multiple nodes, but don't use anything to maintain affinity
(as in, processes run where the scheduler sees fit).

A well-known exec-heavy workload where this is fine is compilation.
Any big project will do, to give you one trivial example, make -j
$BIGNUM modules in the Linux kernel directory.

Say you have a box with 4 domains and 32 threads per each. make -j 128
will end up spilling on the entirety of the machine and there will be
some loss of locality when spawning gcc and whatnot. Even then, a
sensibly behaving scheduler will not migrate processes between nodes
without needing to do it. Meaning after the process gets to run, you
can assume it stays on the given node. The stock kernel with the fork
+ exec machinery is doing a shitty job here, but the new mechanism can
assure process-specific allocation to come form the target node as
long as the scheduler does not mess up.

To that end, the final form of the machinery needs to be in position
to do the following:

1. copy in whatever data it needs from userspace
2. if no affinity is specified, ask the scheduler: assuming something
forks now, where is it going to run? the answer would be speculative
ofc
3. to the minimum allocations needed (task_struct etc.) while passing
the node number from above
4. have the newly spawned task handle everything else

This in particular means that a failed exec would be very expensive,
as it would go through task creation and teardown. Meaning the child
needs to be able to figure out where to binary to execute is. And
user-visible part has to account for it from the get-go.

I'm going to write more after I go through the patchset, should be next wee=
k.

>  > >         .argv =3D (unsigned long)argv,
>  > >         .envp =3D (unsigned long)envp,
>  > >     };
>  > >
>  > >     fd =3D pidfd_open(0, PIDFD_EMPTY);
>  > >     pidfd_spawn_run(fd, &run, sizeof(run));
>  > >
>  > > Alternatively, the path can be staged before the final run step:
>  > >
>  > >     struct pidfd_spawn_run_args run =3D {
>  > >         .argv =3D (unsigned long)argv,
>  > >         .envp =3D (unsigned long)envp,
>  > >     };
>  > >
>  > >     fd =3D pidfd_open(0, PIDFD_EMPTY);
>  > >     pidfd_config(fd, PIDFD_CONFIG_SET_STRING,
>  > >                  PIDFD_CONFIG_KEY_PATH, "/usr/bin/rg", 0);
>  > Same here. Should probably be an FD to the binary instead.
>  >
>  > >     pidfd_spawn_run(fd, &run, sizeof(run));
>  > I'm worried this pidfd_spawn_run just adds another varient to the exis=
ting
>  > myriad of exec* syscalls we already have. Would it be better to just h=
ave this
>  > work through execveat(fd, "", argv, envp, AT_EMPTY_PATH) instead?
>  >
>  > (i.e have execveat take a pidfd directly).
>  >
>  > Then you can get rid of pidfd_spawn_run which looks almost structurall=
y
>  > identical to execveat (with the argv and envp collapsed).
>
> Thanks, but I'm less sure about using execveat() as the run operation, si=
nce it
> normally replaces the caller while the builder creates a new child and
> returns. A separate run operation still seems clearer to me.
>
> Regards,
> Li
>
>
