Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C87E0E4
	for <linux-security-module@vger.kernel.org>; Tue, 24 Feb 2026 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771902217; cv=none; b=vELT+7DTQoRfVvDLL3NtC1YAacRwy0gxCfDq3X/6CvZRFq/xVcRI/v4bEZAq5JmedwjeTpqevO1z9AlEoIge1oz4qb0MFx97exwfq1Cvn/xdX2ujt6XE7oxNliCEoGPhN5xzrpxlBU285af8tYZ34ZtMS1mMiid5s7QXs83X4G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771902217; c=relaxed/simple;
	bh=3azx9TY+N/T/gVu+rBV2aHoCCfVR5fzqQMxuu3VVMuE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=kCI5ygwOejG4DMNo9yYNllaJf4b8nLiMJ4QCGYtTmKHsiC/NmTu7aX5Nzuz7oc2YPIOjZXdM/Y4IBwT0vOUWpsibGWX/j5YRkdCFnoaeMrYCe0onLrAGlvtONaR4yq9o44kHaYxLpDK2VsG6Yu3ZC9ChAc7PCbj7lhudD/mOk1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4bd8c44f3so56246857a34.1
        for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 19:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771902215; x=1772507015;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QupUmDECJGjAmJzsEg1ul2yke0jPQCzLFh+A+i8ekKU=;
        b=T+5hMOrbQiPNoqXFpK/bGmNd2cXBXXLmRiMmCovpZQUeFNnCrvt/7sTKOD+Qrjdawy
         CN3Xb6mfkWDq5jahAx3SDGBfWItK1u2V3e4CYzTnQ1kb3SUw5wu44eYsFkHc8vCvvrHH
         Hdevo7ns3QotqRBV65r1wmzmCNwpKM7s3NZJ4QLaCseRbtwK59PdMYe4COaEKrihIPwL
         PRP5cUWSRSUJF+IOv45/VndrFkfzLkvVAPtquCEiG/43VpNPsAeokOop3+jrSECNxPYP
         IAGpKlJEFkYf9NyS6fNG8VLn1t3DWUw/V61JV7wjF6WDhuUrDCSvKWL5JmxjU6/lqTEJ
         KjoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVIlNa9wcGj8Bceu9VpZzes8bLSgzoOnXti3s0nbaufa1RszkZNj33Z5zyMH//gsFjEFirLTl204mhVw6yzKnUcwW/SKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIF6ejZz8DqrB0sc+mMZPeM8b8VzJj0FwC/+j/mj0PdUjIT3QF
	z8dJavsrOfJPh4nHFF77WG3DRPskRSZPOQNPW0fY5n551G8YDdFLgtR5QYYN97J9pbofUdTPfJi
	WsV2M3VCrWkajAqRSYA59eYu3DYCE64dIdd6RgjSWj72GSFII6zHpGiEuPFk=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4c04:b0:677:48f4:3c66 with SMTP id
 006d021491bc7-679c46121ebmr6729752eaf.67.1771902215237; Mon, 23 Feb 2026
 19:03:35 -0800 (PST)
Date: Mon, 23 Feb 2026 19:03:35 -0800
In-Reply-To: <D0013EA515055145+3e08a07b-e384-4c08-ab17-f558f0130d30@uniontech.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699d1507.a00a0220.121a60.00f2.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in restrict_one_thread_callback
From: syzbot <syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com>
To: dingyihan@uniontech.com
Cc: dingyihan@uniontech.com, gnoack3000@gmail.com, gnoack@google.com, 
	jannh@google.com, linux-security-module@vger.kernel.org, mic@digikod.net, 
	paul@paul-moore.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Hi G=C3=BCnther,
>
> Thank you for the detailed analysis! I completely agree that serializing =
the TSYNC=20
> operations is the right way to prevent this deadlock. I have drafted a pa=
tch using=20
> `exec_update_lock` (similar to how seccomp uses `cred_guard_mutex`).
>
> Regarding your proposal to split this into two patches (one for the clean=
up=20
> path and one for the lock): Maybe combining them into a single patch is a=
 better choice. Here is why:
>
> We actually *cannot* remove `wait_for_completion(&shared_ctx.all_prepared=
)`=20
> in the interrupt recovery path. Since `shared_ctx` is allocated on the lo=
cal=20
> stack of the caller, removing the wait would cause a severe Use-After-Fre=
e (UAF) if the=20
> thread returns to userspace while sibling task_works are still executing =
and dereferencing `ctx`.=20
>
> By adding the lock, we inherently resolve the deadlock, meaning the sibli=
ng task_works=20
> will never get stuck. Thus, `wait_for_completion` becomes perfectly safe =
to keep,=20
> and it remains strictly necessary to protect the stack memory. Therefore,=
 the "fix" for the=20
> cleanup path is simply updating the comments to reflect this reality, whi=
ch is tightly coupled with the locking fix.=20
> It felt more cohesive as a single patch.
>
> I have test the patch on my laptop,and it will not trigger the issue.Let'=
s have syzbot test this combined logic:
>
> #syz test:=20

"---" does not look like a valid git repo address.

>
> --- a/security/landlock/tsync.c
>
> +++ b/security/landlock/tsync.c
>
> @@ -447,6 +447,12 @@ int landlock_restrict_sibling_threads(const struct c=
red *old_cred,
>
>         shared_ctx.new_cred =3D new_cred;
>
>         shared_ctx.set_no_new_privs =3D task_no_new_privs(current);
>
> =20
>
> +       /*
>
> +        * Serialize concurrent TSYNC operations to prevent deadlocks
>
> +        * when multiple threads call landlock_restrict_self() simultaneo=
usly.
>
> +        */
>
> +       down_write(&current->signal->exec_update_lock);
>
> +
>
>         /*
>
>          * We schedule a pseudo-signal task_work for each of the calling =
task's
>
>          * sibling threads.  In the task work, each thread:
>
> @@ -527,14 +533,17 @@ int landlock_restrict_sibling_threads(const struct =
cred *old_cred,
>
>                                            -ERESTARTNOINTR);
>
> =20
>
>                                 /*
>
> -                                * Cancel task works for tasks that did n=
ot start running yet,
>
> -                                * and decrement all_prepared and num_unf=
inished accordingly.
>
> +                                * Opportunistic improvement: try to canc=
el task works
>
> +                                * for tasks that did not start running y=
et. We do not
>
> +                                * have a guarantee that it cancels any o=
f the enqueued
>
> +                                * task works (because task_work_run() mi=
ght already have
>
> +                                * dequeued them).
>
>                                  */
>
>                                 cancel_tsync_works(&works, &shared_ctx);
>
> =20
>
>                                 /*
>
> -                                * The remaining task works have started =
running, so waiting for
>
> -                                * their completion will finish.
>
> +                                * We must wait for the remaining task wo=
rks to finish to
>
> +                                * prevent a use-after-free of the local =
shared_ctx.
>
>                                  */
>
>                                 wait_for_completion(&shared_ctx.all_prepa=
red);
>
>                         }
>
> @@ -557,5 +566,7 @@ int landlock_restrict_sibling_threads(const struct cr=
ed *old_cred,
>
> =20
>
>         tsync_works_release(&works);
>
> =20
>
> +       up_write(&current->signal->exec_update_lock);
>
> +
>
>         return atomic_read(&shared_ctx.preparation_error);
>
>  }
>
> --
> =E5=9C=A8 2026/2/23 23:16, G=C3=BCnther Noack =E5=86=99=E9=81=93:
>> Hello!
>>=20
>> On Mon, Feb 23, 2026 at 07:29:56PM +0800, Ding Yihan wrote:
>>> Thank you for the detailed analysis and the clear breakdown.=20
>>> Apologies for the delayed response. I spent the last couple of days
>>> thoroughly reading through the previous mailing list discussions. I
>>> was trying hard to see if there was any viable pure lockless design
>>> that could solve this concurrency issue while preserving the original
>>> architecture.=20
>>> =EF=BB=BF
>>> However, after looking at the complexities you outlined, I completely
>>> agree with your conclusion: serializing the TSYNC operations is indeed
>>> the most robust and reasonable path forward to prevent the deadlock.
>>> =EF=BB=BF
>>> Regarding the lock choice, since 'cred_guard_mutex' is explicitly
>>> marked as deprecated for new code in the kernel,maybe we can use its
>>> modern replacement: 'exec_update_lock' (using down_write_trylock /
>>> up_write on current->signal). This aligns with the current subsystem
>>> standards and was also briefly touched upon by Jann in the older
>>> discussions.
>>> =EF=BB=BF
>>> I fully understand the requirement for the two-part patch series:
>>> 1. Cleaning up the cancellation logic and comments.
>>> 2. Introducing the serialization lock for TSYNC.
>>> =EF=BB=BF
>>> I will take some time to draft and test this patch series properly.=20
>>> I also plan to discuss this with my kernel colleagues here at=20
>>> UnionTech to see if they have any additional suggestions on the=20
>>> implementation details before I submit it.
>>> =EF=BB=BF
>>> I will send out the v1 patch series to the list as soon as it is
>>> ready. Thanks again for your guidance and the great discussion!
>>=20
>> Thank you, Ding, this is much appreciated!
>>=20
>> I agree, the `exec_update_lock` might be the better solution;
>> I also need to familiarize myself more with it to double-check.
>>=20
>> =E2=80=94G=C3=BCnther
>>=20
>
