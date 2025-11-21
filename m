Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FB928FFE7
	for <linux-security-module@vger.kernel.org>; Fri, 21 Nov 2025 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763766438; cv=none; b=F4TZtsn282RJIadrpgTD3lmQ6VRCuh99qdbc9A/yCNbclQq1JJcZSoLFPlwu0SA7+6OzPqqMu+xC3iwsp3aoElAdhtzIhB8l4f7ptLzywOMgH7SawL8XtQL826zsdVciHl9BmLJ9Araoz061vd5DpspP2Iik2jGmZWrR3IoJwSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763766438; c=relaxed/simple;
	bh=VDL6/Wkzo+nHYBUJmIFWZKGy/WAbBJD7BKdCRJT3tcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoTr3vn/nt6pGUuT4UUgJdoKaKsMMaCxAC/mMNszymxjTWtJHWnp6DSnJ29JQ4HYFGoV/GGCPEeTCt1EVizaGjoOwVw71JCi8p76/dgeexUIJHF7HmBwuSrL8uybkojOS4oa5yXLa2JX1Bi0EXxJZ8kCZ1V18E723K+YOwyW8A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=B5S/vbXt; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="B5S/vbXt"
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9C9D13F950
	for <linux-security-module@vger.kernel.org>; Fri, 21 Nov 2025 23:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1763766430;
	bh=mURGdZgdGyl5h9hsbUzCtRvDVWH4yABOB0i1o0xgZtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=B5S/vbXtLJu20ym2qcsqSyWf1AE+c9Sn8f14SkORNVbAld3d+NENV3l5gvxaJ5EeB
	 BnX5XgPTZqoxv+3JVBH2XZ8n8+GnnVSCFKRFGxX+b4/jnlFlgkaLF1ynes606R7HD5
	 630tGb7x5PuEtfTbSxqidGhetRlzfQ4hSwNSkiW3RSKXCaM/DTktFgAKzX3l+4xsuu
	 aTRx2kKq5MDvLn848zM2h2v83K+KVXLlBguV1MufranEcuDbNF0zmwqYFySJKUxCid
	 DQIMNRNU5nURUcfqf0QAsG+Uxtnih0QwgQlqTzN8oFkwQaZWHSwL3uOQMvsJnus6Yr
	 3GWnLgISnEV+xmMmol6kzKpO8QIK1nQKKDP6L4HNgRMAWi1mIvnC+JpbdKFXyysLlS
	 TwP1XyYuScJH1HMvLCX46P1UXBGDLqV/n+SXAVgDdkjilvgfVDv/Dml3npyHPVjn1d
	 PbSfqku52Zf77Xw8gu1/sxJy1djR2QGu7h1OgxKL7OhadA+M5mr7nHxKwX73U5Ldsy
	 FAozW5Kupk4lohlvhq6TWpmQms5s4jYDHlv5JWYuuEyEPl9ymD84YNPizstwq+a0lo
	 GSipoI3A175kQ9lze2RLj8sbFPouAGhSk+fwSaqq1mo41Rc5ScR8L6BPDjahkK6LsZ
	 pQD5N2K6KNwMcliX3v0YQWCc=
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-787f7261b62so52107557b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 21 Nov 2025 15:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763766429; x=1764371229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mURGdZgdGyl5h9hsbUzCtRvDVWH4yABOB0i1o0xgZtw=;
        b=bN4PLkgVXpA34znJRzoNGKwpHwQrG9UtXKNzN+g7ceubzTe2ftPQ1yNdhg6MnkJDpP
         gCnGpfIzvQBI8nKq1ghiSkfE9abm15Zjn+Ir9DhFBQtCrHB+t8lzIpD5z1xKGiTKIpAJ
         +o9jpPpBazLpsgyt6e1zXCaK48bEUeNlsP+ziWukdEfAu7tTHvmlfb/MIKk8OOEyKHYi
         bQ3ImtqLyUFv1ulHg0WLUU1Qnq78PA5y/TiswxAJcpTMbqkT8LkO7f8s19N1OxY2CAT3
         c6lbkYVAoaaaprnHvMW3wMgXWV9iTvv/Y1DATnXFkXWRpnFmoDgNEge+hrP9s3lqtFhB
         nJqg==
X-Forwarded-Encrypted: i=1; AJvYcCWbNrZXD92z6vxczbs5LDsoPDJ64aCbv7Ypo2XrEh3jiExAUidg2UQWWG7DO8o8LCvWcKhJoFnsG7cCP2zSqLic/pNByEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8EV+ZSWpFysGHayxsDaKspDmKiYZqZazTfsatFQgVD0PGiPnK
	nnnJdJdVmE/OyjfsmgBpTqGhWbeickmeTZzp8rnPMgUmaxEyf+laWdQPWzRuf1UMRMqUkYwuR83
	j+aOg0JfWVBmECe2BqTQTxBKwAwcHY2zc1ClupaYhYV1tp66yeobont4A8BWcYzhUb8xP60eIQp
	aO2tK1BYQ0fEeAyeRDmXsAHLyKhQEfC0fEmNRs0o3VWRDN0utCRIuOCrdscpBMVdg4BfJm
X-Gm-Gg: ASbGncu+T1CnBgyDfd12gkubliwdvYq2GF3dY9B3wFaCPYM/vpvsmzqZ6aq1imb9pPB
	1Nc8s3GmUF6tayJYlh52l9b2466HMZ5O5ch+PXBy/3YRoFNnXlNSNebU4rOzHYn1/FBpAlw8B0+
	83eDpkHt0VpFy7PHk2PcC0SzXgWZqmJLAjrZ7/2mYIQaGxGrNDDKMPceHm1elVksUvQA==
X-Received: by 2002:a53:b10a:0:b0:63f:c019:23bc with SMTP id 956f58d0204a3-642f8e30acamr6393271d50.27.1763766428806;
        Fri, 21 Nov 2025 15:07:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNbsczd5MfsDryDTrdB8miQHCP9n6FhmNbRk59/WbSb6lt9I6iTtdnnpp053CuQIcThR+YHVO/xZ+HKm10C6g=
X-Received: by 2002:a53:b10a:0:b0:63f:c019:23bc with SMTP id
 956f58d0204a3-642f8e30acamr6393202d50.27.1763766428362; Fri, 21 Nov 2025
 15:07:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEE807D016A79FE7A2F463E4D6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <87tsyozqdu.fsf@email.froward.int.ebiederm.org> <87wm3ky5n9.fsf@email.froward.int.ebiederm.org>
 <87h5uoxw06.fsf_-_@email.froward.int.ebiederm.org> <87a50gxo0i.fsf@email.froward.int.ebiederm.org>
 <GV2PPF74270EBEEAD4CACA124C05BE1CE45E4D5A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <87o6ovx38h.fsf@email.froward.int.ebiederm.org> <GV2PPF74270EBEEFA106F4EF26B087ED898E4D5A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEED0840E45459881C0EDD4E4D5A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <87ikf3w5us.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87ikf3w5us.fsf@email.froward.int.ebiederm.org>
From: Ryan Lee <ryan.lee@canonical.com>
Date: Fri, 21 Nov 2025 15:06:57 -0800
X-Gm-Features: AWmQ_bl4fHuqSO33WuXiPW9zqHuMd1nfWUHzCuIgifbxs4kTz1ezfJlXQS9fZjo
Message-ID: <CAKCV-6sH03G2xuZrhqEMExx-AAKPZgQ7Z1BnDgV5HimFVGCWwg@mail.gmail.com>
Subject: Re: [RFC][PATCH] exec: Move cred computation under exec_update_lock
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Bernd Edlinger <bernd.edlinger@hotmail.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, Serge Hallyn <serge@hallyn.com>, 
	James Morris <jamorris@linux.microsoft.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yafang Shao <laoar.shao@gmail.com>, Helge Deller <deller@gmx.de>, 
	Adrian Reber <areber@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>, 
	Alexei Starovoitov <ast@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	tiozhang <tiozhang@didiglobal.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Frederic Weisbecker <frederic@kernel.org>, YueHaibing <yuehaibing@huawei.com>, 
	Paul Moore <paul@paul-moore.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Stefan Roesch <shr@devkernel.io>, Chao Yu <chao@kernel.org>, xu xin <xu.xin16@zte.com.cn>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>, 
	Dave Chinner <dchinner@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Elena Reshetova <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, 
	"Joel Fernandes (Google)" <joel@joelfernandes.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Hans Liljestrand <ishkamiel@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Adrian Ratiu <adrian.ratiu@collabora.com>, 
	Ingo Molnar <mingo@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Cyrill Gorcunov <gorcunov@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	apparmor <apparmor@lists.ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 11:20=E2=80=AFAM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Bernd Edlinger <bernd.edlinger@hotmail.de> writes:
>
> > On 11/21/25 10:35, Bernd Edlinger wrote:
> >> On 11/21/25 08:18, Eric W. Biederman wrote:
> >>> Bernd Edlinger <bernd.edlinger@hotmail.de> writes:
> >>>
> >>>> Hi Eric,
> >>>>
> >>>> thanks for you valuable input on the topic.
> >>>>
> >>>> On 11/21/25 00:50, Eric W. Biederman wrote:
> >>>>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
> >>>>>
> >>>>>> Instead of computing the new cred before we pass the point of no
> >>>>>> return compute the new cred just before we use it.
> >>>>>>
> >>>>>> This allows the removal of fs_struct->in_exec and cred_guard_mutex=
.
> >>>>>>
> >>>>>> I am not certain why we wanted to compute the cred for the new
> >>>>>> executable so early.  Perhaps I missed something but I did not see=
 any
> >>>>>> common errors being signaled.   So I don't think we loose anything=
 by
> >>>>>> computing the new cred later.
> >>>>>
> >>>>> I should add that the permission checks happen in open_exec,
> >>>>> everything that follows credential wise is just about representing =
in
> >>>>> struct cred the credentials the new executable will have.
> >>>>>
> >>>>> So I am really at a loss why we have had this complicated way of
> >>>>> computing of computed the credentials all of these years full of
> >>>>> time of check to time of use problems.
> >>>>>
> >>>>
> >>>> Well, I think I see a problem with your patch:
> >>>>
> >>>> When the security engine gets the LSM_UNSAFE_PTRACE flag, it might
> >>>> e.g. return -EPERM in bprm_creds_for_exec in the apparmor, selinux
> >>>> or the smack security engines at least.  Previously that callback
> >>>> was called before the point of no return, and the return code should
> >>>> be returned as a return code the the caller of execve.  But if we mo=
ve
> >>>> that check after the point of no return, the caller will get killed
> >>>> due to the failed security check.
> >>>>
> >>>> Or did I miss something?
> >>>
> >>> I think we definitely need to document this change in behavior.  I wo=
uld
> >>> call ending the exec with SIGSEGV vs -EPERM a quality of implementati=
on
> >>> issue.  The exec is failing one way or the other so I don't see it as=
 a
> >>> correctness issue.
> >>>
> >>> In the case of ptrace in general I think it is a bug if the mere act =
of
> >>> debugging a program changes it's behavior.  So which buggy behavior
> >>> should we prefer?  SIGSEGV where it is totally clear that the behavio=
r
> >>> has changed or -EPERM and ask the debugged program to handle it.
> >>> I lean towards SIGSEGV because then it is clear the code should not
> >>> handle it.
> >>>
> >>> In the case of LSM_UNSAFE_NO_NEW_PRIVS I believe the preferred way to
> >>> handle unexpected things happening is to terminate the application.
> >>>
> >>> In the case of LSM_UNSAFE_SHARE -EPERM might be better.  I don't know
> >>> of any good uses of any good uses of sys_clone(CLONE_FS ...) outside
> >>> of CLONE_THREAD.
> >>>
> >>>
> >>> Plus all of these things are only considerations if we are exec'ing a
> >>> program that transitions to a different set of credentials.  Somethin=
g
> >>> that happens but is quite rare itself.

AppArmor's exec rules rely heavily on transitioning to different creds
on exec. For example, an AppArmor policy like

profile example_1 /usr/bin/example_1 {
    /usr/bin/example_2 Px -> example_2_profile,
    /usr/bin/example_3 Px,
}

will allow binary example_1 to execute binaries example_2 and
example_3, launching those processes under a different confinement
(example_2_profile and a profile that attaches to /usr/bin/example_3,
respectively). We will need to look into how much this patch (or a
corresponding change in behavior) would affect our use case, but
confinement transitions (where the confinement information is stored
as an LSM blob on the cred struct) are extremely common in a system
that uses AppArmor as an LSM.

> >>>
> >>> In practice I don't expect there is anything that depends on the exac=
t
> >>> behavior of what happens when exec'ing a suid executable to gain
> >>> privileges when ptraced.   The closes I can imagine is upstart and
> >>> I think upstart ran as root when ptracing other programs so there is =
no
> >>> gaining of privilege and thus no reason for a security module to
> >>> complain.
> >>>
> >>> Who knows I could be wrong, and someone could actually care.  Which i=
s
> >>> hy I think we should document it.>>
> >>
> >>
> >> Well, I dont know for sure, but the security engine could deny the exe=
cution
> >> for any reason, not only because of being ptraced.
> >> Maybe there can be a policy which denies user X to execute e.g. any su=
id programs.
> >>
> >>
> >> Bernd.
> >>
> >
> > Hmm, funny..
> >
> > I installed this patch on top of
> >
> > commit fd95357fd8c6778ac7dea6c57a19b8b182b6e91f (HEAD -> master, origin=
/master, origin/HEAD)
> > Merge: c966813ea120 7b6216baae75
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Thu Nov 20 11:04:37 2025 -0800
> >
> > but it does panic when I try to boot:
> >
> > [  0.870539]     TERM=3D1inux
> > [  0.870573] Starting init: /bin/sh exists but couldn't execute it (err=
or -14) 0.8705751 Kernel panic- not syncing: No working init found. Try pas=
sing i mit=3D option to kernel. See Linux Documentation/admin-guide/init.rs=
t for guidance
> > [  0.870577] CPU: UID: 0 PID: 1 Comm: sh Not tainted 6.18.0-rc6+ #1 PRE=
EMPT(voluntary)
> > [  0.870579] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS Vi=
rtualBo x 12/01/2006
> > [  0.870580] Call Trace:
> > [  0.870590]  <TASK>
> > [  0.870592]  vpanic+0x36d/0x380
> > [  0.870607]  ? __pfx_kernel_init+0x10/0x10
> > [  0.870615]  panic+0x5b/0x60
> > [  0.870617]  kernel_init+0x17d/0x1c0
> > [  0.870623]  ret_from_fork+0x124/0x150
> > [  0.870625}  ? __pfx_kernel_init+0x10/0x10
> > [  0.870627]  ret_from_fork_asm+0x1a/0x30
> > [  0.870632]  </TASK>
> > [  0.8706631 Kernel Offset: 0x3a800000 from Oxffffffff81000000 (relocat=
ion ran ge: 0xffffffff80000000-0xffffffffbfffffff)
> > [  0.880034] ---[ end Kernel panic - not syncing: No working init found=
. Try passing init option to kernel. See Linux Documentation/admin-guide/in=
it.rst for guidance. 1---`
> >
> >
> > Is that a known problem?
>
> Nope.  It looks like the code needs a little bit bug fixing testing.
>
> I will take see about taking a look.
>
> Eric
>

I've also CC'ed the AppArmor mailing list on this patch to facilitate
discussion if, upon further investigation, this patch would require
changes or cause other problems on the AppArmor side.
