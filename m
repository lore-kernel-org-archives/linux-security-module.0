Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE233D1CC1
	for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2026 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783454517; cv=pass; b=q2IEgJKS/2yb59NwXuiv+suH1fpWfOGpJkN4PhHIRFTVlET/XaZ/EHWL0HHP+CMiWoOcrN1yBQIBYmlcBVue1aZ7CfHT3SAVUBehXlg77JWA3Ihz0CEvCZh9JuQqp9VkUGLxPFfUcZpKI4KQ2E/Ca6faQcUKmwWHnPRrYIWfAEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783454517; c=relaxed/simple;
	bh=CQw7pbBPSsQXtU1Uj2PUzAdATT3DC/fTZSmkVK5/zlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOxuH+vRO6tijZsfQrVi+AX1n4uTRDItA390jJ1W21/FCz4CC5F8YzJCNmXMZsIA7cHXUUh6Wj4IxVXtFtt9Nbx393GSAfiT9e92EQ92VI7Tco56+MTyG2Mp83y0qKDH+Os2gw2hey5Qn3mOqvIVVhQG1xz3GB1BIfOth8S9VpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rzy56A06; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rzy56A06"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381065a7a03so3603057a91.0
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jul 2026 13:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783454515; cv=none;
        d=google.com; s=arc-20260327;
        b=AjfSZi6NP1ADxj/uBb+VMTDlaKYur4Uug8Ln30m7y3mIeh0bV9S4BSPMlqEZ+7mFCW
         uDM0xpUOVyCnleypv8qYn6s9ALhxu5Np3KQhmIVIjfi3UU+rwUQiLkE+ai5/qNkJiQdg
         /E1VfbJNxILC4TKxXBt6EeaUAOGwsa6iDQa8lLA2vHW2QSL2/nAiEDTZDVxt788UAAlq
         /frGfaw9XC8bduxDvpwO4WY/lce8J+/aD0z3XG5jJ9zPs6LhZUv+nGRioZX2F6ltDgkl
         e3MUHvD9NlKxjqNzfC5om5AANYYMItSnDS61bsF77Va1WpEHImB1welRYapTIbGwuUVh
         3UVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKHaKGkq7zit82xHzq3cQSvjgYMyfS0+fVrI7chNkuQ=;
        fh=Rl/+VueUYBEXox9EDE324R0tDr/50kwzsh9fIDIcn5o=;
        b=NuShKFTvrVr8j9r9gbmLubTfYgtsmlBJ1lK4TVaHvYJSKBLBnuEntBgMPe5wrsmUii
         Be9t0z3BXw6eyf5P9ps1jCipdHfwGOV2LF2WI8dMqr//e6jB3WDX4BM/KjQPJ0gTigwk
         k4tFU6A9qR5XfPSbebInnHLf8j8UeYl3YWExaPMupq0p0G1oPzhOGlxH3Ja2SJd4hed4
         jVOho5Qomxt/SIYAYBvwDfWet7PxRlVAB+58juS1cRlpqP71mI5QMm4POyJaXWmYV1nS
         5sShdN8TqXJIrujOxzSpICrjclBYsy4Dv5jcRkpZH4e9owcYrsWswmZw8/iwpHXWllbq
         qhTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783454515; x=1784059315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKHaKGkq7zit82xHzq3cQSvjgYMyfS0+fVrI7chNkuQ=;
        b=Rzy56A06EuG/557lKXbZj5FzisJs/VspFSC0lA9XwefOL1CiMcLL092fxKJxi8vel5
         q6uFqfoyiy9cS5EmZlVctMrdZt/IlrZKXzLTm6hGDQgfuG01NEI5CPqRE/mjiCEyKHOY
         lyCEYFc1GVDoVD7BNn9nGYhmmIVkW65A5E8e0uXTcCm911FASOXz1nupXw4CHxUkECDS
         xAsQ2XLCzsVeWjzEGnVWn/iiTfMSJr5HygLH8e7S4P3Ty3BxyZJH3qwih3y/ZBLuViRY
         BQmqmu0IlIp6+o0ngXd1D1sL30x9CRmVA88OZSK9UnudGv5km6dBExhAS1GurTUlZMNt
         RqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783454515; x=1784059315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKHaKGkq7zit82xHzq3cQSvjgYMyfS0+fVrI7chNkuQ=;
        b=CpoI7eWcLlcnVmCYMr1qf3O2Z1QGsOfxlLET7VIheZx3B6+9RQ1ITm/g8tuJF5NxwK
         4xm/JbXBhIs6Pntl3ITeqPp4yXWarnp8bxl4AMw55Ak+hRZG5yAI3HKxqWKNKCzlS19d
         D2ZKIGHVKqgwoX8CtSzlq/RaKHDy3uggjHyCpakkWexbIwOdU/dHTp7QiFJ1kv2GYA0c
         KHGF6/xUdEv6GoDxmd5iZfYRMJ8+ISUkW4plTu/SFNJ3u4BpQclEO2np+K3w8mEeJjou
         fiAiQ07xx8UbHCZM8Ea4TULWFzPwBiC4GST5vCW12lp/ElFcjaCUpyNMJqnjx6U6v3DE
         Nm9Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp7leYKYCjaXMOiCqv5t22P/s3zMTviLR1CHRi4nZZYGseSTBOX0ipmStsnTSH9wgGa4tr6zVPSPUNMlNJs1LuCY/Dv3Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdZ7WHAnnS8VxmeNzMU7LlbGTAzccWCn0sgpynR/2BiUhg3N2
	HKZnsJw78KiwVic39KS+OoBodoM4kCIJsJBuBVas8e7ZVmNs0kgmXp2OOKeZBT87yl4ady7Y0jf
	gkLcCvtZjODQ4ME5hhvTUCrydnPAZq8aFHmWtPA1w
X-Gm-Gg: AfdE7cl8w6ucaWw/0shTwMmKqZc/TqRkNQV8aFJM152+UDPWayPEYUgBOMFnsuPixbK
	ce9rnL3kG3Nnzdlugg4Bm+4Op9N+PFlh3knM4O1n9YSvEf3LsfX90SJnYxwyQhdoXgSw94nIJ0F
	1/4h614QQYoHC1kbjnHkz8zxRK+JtlydFAvuIFP6jaAbSqzWDQXB9WzKKm9z5FSqD6Smk4vQN38
	XzDcBTGf+HZySECdv4H8g1DKYSVlHYQ0EhldfZQXMwYuJ1tNI+5ug3ytO9LEPuWSndfQa0I
X-Received: by 2002:a17:90a:b108:b0:381:5ede:1296 with SMTP id
 98e67ed59e1d1-3875547805amr4916450a91.11.1783454514983; Tue, 07 Jul 2026
 13:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102759.9626-1-achillesgaikwad@gmail.com>
 <20260707152305.15324-1-achillesgaikwad@gmail.com> <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
 <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com>
In-Reply-To: <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Jul 2026 16:01:42 -0400
X-Gm-Features: AVVi8Cc7whlyPeGuIcUVaMUhLCElVCGHeTQu6aN6Xlm0ZbpD5vFbi_OphdfvdLo
Message-ID: <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: Anna Schumaker <anna@kernel.org>
Cc: Achilles Gaikwad <achillesgaikwad@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	stephen.smalley.work@gmail.com, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 3:12=E2=80=AFPM Anna Schumaker <anna@kernel.org> wro=
te:
> On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> > On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> > <achillesgaikwad@gmail.com> wrote:
> >>
> >> A call to listxattr() with a buffer size of 0 returns the actual
> >> size of the buffer needed for a subsequent call. On an NFSv4.2
> >> mount this triggers the following oops:
> >>
> >>   [  399.768687] BUG: kernel NULL pointer dereference, address: 000000=
0000000000
> >>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
> >>   [  399.768722] Call Trace:
> >>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
> >>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
> >>   [  399.768731]  nfs4_listxattr+0x21f/0x250
> >>   [  399.768733]  vfs_listxattr+0x55/0xa0
> >>   [  399.768736]  listxattr+0x23/0x160
> >>   [  399.768737]  path_listxattrat+0xba/0x1e0
> >>   [  399.768739]  do_syscall_64+0xe2/0x680
> >>
> >> security_inode_listsecurity() (via the xattr_list_one() helper) now
> >> decrements the remaining size even when the buffer pointer is NULL, so
> >> in the size-query case, 'left' underflows to a huge size_t value. As a
> >> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a real on=
e,
> >> leading to a NULL pointer dereference in _copy_from_pages().
> >>
> >> security_inode_listsecurity() does not return the number of bytes
> >> it added to the list, so the code derived it as
> >> 'size - error - left'. That is also wrong in the size-query case:
> >> the generic_listxattr() contribution is only subtracted from 'left'
> >> when a buffer is present. Thus, the query result comes up short by
> >> exactly that contribution (e.g., "system.nfs4_acl" on a mount with
> >> ACL support), and a caller that allocates the returned size gets
> >> -ERANGE on the subsequent call.
> >>
> >> Declare 'left' as ssize_t, use a scratch copy to measure security
> >> hook consumption, and only decrement 'left' if a buffer is present.
> >>
> >> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode_lists=
ecurity() interface")
> >> Suggested-by: Paul Moore <paul@paul-moore.com>
> >> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> >> ---
> >> Changes in v2:
> >>  - Use a scratch variable to track security label size directly,
> >>    replacing the old formula that undercounted the size-query case.
> >>  - Drop the now-unneeded NULL-buffer special case for
> >>    nfs4_listxattr_nfs4_user().
> >>  - Retitled from "fix nfs4_listxattr NULL pointer dereference"
> >>    (the same accounting bug caused both the oops and the undercount).
> >> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-achillesga=
ikwad@gmail.com/
> >>  fs/nfs/nfs4proc.c | 10 +++++++---
> >>  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > [CC'd the LSM and SELinux lists for visibility]
> >
> > Unfortunately my testing was unsuccessful due to an NFS problem that
> > started with the v7.2 merge window that I haven't had the time to
> > bisect yet.  Assuming the NFS folks are okay with this change, I
> > figure they will want to send it up to Linus via their tree, if not
> > let me know and I can send this up via the LSM tree.
>
> Yeah, we'll send it through the NFS tree.

Thanks Anna.

> I'll be curious to hear
> what problem you're hitting, and what patch is the culprit once you
> do that bisect!

Yes, me too :)

I'm still working through a review backlog so it might be a bit before
I have a chance, but in case anyone wants to test it out, it's easily
reproduced using the selinux-testsuite and the NFS tests:

https://github.com/SELinuxProject/selinux-testsuite#nfs

--=20
paul-moore.com
