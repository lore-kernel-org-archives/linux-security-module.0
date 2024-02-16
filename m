Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070E6646
	for <linux-security-module@vger.kernel.org>; Fri, 16 Feb 2024 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708054393; cv=none; b=p7EpUXIymaWse1ZfMq6VqGtgz+f9Mu2JWvOPY1sIM9Upn8EK7Yl3ykUNzlmFLKJg3tc4t40665z2hh4Db0Dgtrx1dMvnZakrEx9cxnnxaYRYU1zLC7iIVVJyKAJkBwRUMa+myHAsrKfiXxQLU95S1v1Zxpvch66HpvamhyLcLl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708054393; c=relaxed/simple;
	bh=3t546fEgz91vAvQkx/7zlRudegOnhfYWFDVQoa1pGtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RP7AHMK5lVCcWfRZk2t103QkKZy21+GIwzFaW3sYHiMHUlapIRAyy/tVDtBwnwdgs71QR11js2iewl9WM1YJX1gyhDJF0wRzEk/qhmZQT25TBs1Ns/BHjdqtYvP79UMuexZlPl4xrnMmI+3xCtvJRpjBJcyXVn9StPwFSPHMVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NyI8rIk+; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NyI8rIk+"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso1540409276.1
        for <linux-security-module@vger.kernel.org>; Thu, 15 Feb 2024 19:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708054391; x=1708659191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rJ1SQR31QFWXS+4mlImwqEULbuDFVCkilDRUDHOOhA=;
        b=NyI8rIk+gebt7HVU4uwbKc+1Iwf5YOoS4eVyIcpNencC7GpK5S40fYTYfb3rEt3Pef
         4csRxZL0JG+vSFfKHBUe5osTVDSCpLT9KPlolMAgJHYL40LGEltpDVCe4Bi6Mx2G9j5a
         YkCE+ncgHIpL4gP3lcxm1s1H6+VGS8uEHMWHAYWs0LPL4/zbLYxpSDHOnvQ54ENFfs2P
         NeBsfyMojMjl96X8wkTCzbBasBt1iNC/3dopOQy/lZoj29LtqpB0OyZE9oL0Uab5Z5rJ
         vhcxLTb+OUXvqCx1IrAb3rVZ1GjOOgwkKEhT1DTFnH2aEGkpC51k6Ms7ERNuDpNDo5OO
         C3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708054391; x=1708659191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rJ1SQR31QFWXS+4mlImwqEULbuDFVCkilDRUDHOOhA=;
        b=FxqetagGZClGSzmWP+ue402JEvbDbs9tJkmTxrQVSAPFV4NXJV89O+VEFsf+4mtcUx
         t5sFtG/z1tPX3T2juFui56WF3qDEOXa1hfDISWqdzpZWgEsyv9+i/zHTJn/okH7Po0bz
         6uPcnL4hXra23FpqX2g5yQ+tAoxet5kGTOsQUN0GikA8bDkJrhMuRPNnu/pZ5jikCsM1
         eKs4gXoSPa4yXJjonyZcA+V0NGV2tpdCdPeJOVs2vViuOgfnzCmikWJGXebjY6ekAyy+
         iiV+hA0pdXQUStRoReObL+ua4nZ/ybxPf9KgfAcwXvXaH61Ve+1OR2ae6VOKuAZqxIi9
         8HsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeuey1Nyqd0+9NqzBFSlDvJKL37B0gKQ58cABVEc0tZMNH2Ogb4oKP64m/H19WDh6ad/BUHLVOjASvHEZ7gHXgbgbH7CxN+2/v8N58X65n9UeFzlo+
X-Gm-Message-State: AOJu0YwtVhB/mkGeY/x84T4izhfbQxHnFN5Fd9ctyw9hzaddJSetKu/J
	7ngATWSzZ9uOIL8h1POmElvcGjZ5ROWmXvkWVd2EEcfjN+uLYDUMTaIeI9zwOvO3iTWJEJ2judg
	PBnmxQxCQjkTdO4HCr+UQojEJ5BaZ5QdRy5wH3AJbnZiGn/A=
X-Google-Smtp-Source: AGHT+IH76DVP444gDd+wf6uNfWtITB6UJ/TjyhCFk5nsVL1PvzFP0vw/NLgKzMIEoTrpGNc9CaLKhT/IzS1Qxy3kCY0=
X-Received: by 2002:a05:6902:1b13:b0:dc6:c619:61d8 with SMTP id
 eh19-20020a0569021b1300b00dc6c61961d8mr5175844ybb.35.1708054390849; Thu, 15
 Feb 2024 19:33:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ad9dddfe-0fa1-40f6-9f8c-f2c01c7a0211@I-love.SAKURA.ne.jp>
 <fa719d6f-1960-491e-89c2-ed2c14d184fc@I-love.SAKURA.ne.jp>
 <2fa0a73a-1d03-4937-8599-e4560297af3f@schaufler-ca.com> <f15e4a73-02e1-4758-a8e6-0edd27224c0a@I-love.SAKURA.ne.jp>
 <757dc423-f914-44b7-98bb-fde5cd42d33b@schaufler-ca.com> <b240a8ad-240a-4bc5-9414-62bd417f0b92@schaufler-ca.com>
 <CAHC9VhRdqjWa0Zhw==U=kLNiSeYHDWnQyP8Yb4JNtTA7ki1gqw@mail.gmail.com>
 <8d093ada-995f-4291-9c31-35d9a62525b7@I-love.SAKURA.ne.jp>
 <6e00373a-a028-4575-b2cf-d4da366c2b6f@schaufler-ca.com> <CAHC9VhT730AxsUv=1=dEn22ABeHJPZ1JA-xwZv6DN54+DiiKQg@mail.gmail.com>
 <9a816f3b-452e-4d3a-8c45-da49f5461317@schaufler-ca.com>
In-Reply-To: <9a816f3b-452e-4d3a-8c45-da49f5461317@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Feb 2024 22:32:59 -0500
Message-ID: <CAHC9VhRK3L12zgzm4-9eyxdhb8Zp-OrAg0UQxFdc3Qdm2yoTKw@mail.gmail.com>
Subject: Re: smack: Possible NULL pointer deref in cred_free hook.
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 7:22=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 2/15/2024 3:38 PM, Paul Moore wrote:
> > On Wed, Feb 14, 2024 at 7:13=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> On 2/14/2024 2:15 PM, Tetsuo Handa wrote:
> >>> On 2024/02/15 3:55, Paul Moore wrote:
> >>>>> Ah, but it turns out that the only LSM that can fail in _cred_prepa=
re()
> >>>>> is Smack. Even if smack_cred_prepare() fails it will have called
> >>>>> init_task_smack(), so there isn't *currently* a problem. Should ano=
ther
> >>>>> LSM have the possibility of failing in whatever_cred_prepare() this
> >>>>> could be an issue.
> >>>> Let's make sure we fix this, even if it isn't a problem with the
> >>>> current code, it is very possible it could become a problem at some
> >>>> point in the future and I don't want to see us get surprised by this
> >>>> then.
> >>>>
> >>> Anyone can built-in an out-of-tree LSM where whatever_cred_prepare() =
fails.
> >>> An in-tree code that fails if an out-of-tree code (possibly BPF based=
 LSM)
> >>> is added should be considered as a problem with the current code.
> >> Agreed. By the way, this isn't just a Smack problem.
> > I've tried to make this clear on previous issues, but let me say it
> > again: I don't care what individual LSMs are affected, a bug is a bug
> > and we need to fix it.
>
> Yes, I understand that.
>
> >> You get what looks
> >> like the same failure on an SELinux system if security_prepare_creds()=
 fails
> >> using the suggested "fault injection". It appears that any failure in
> >> security_prepare_creds() has the potential to be fatal.
> > Perhaps I didn't look at the original problem closely enough, but I
> > believe this should only be an issue with LSMs that register a
> > cred_free hook that assumes a valid LSM specific credential
> > initialization.  While SELinux registers a cred_prepare hook, it does
> > not register a cred_free hook.  Or am I missing something?
>
> Yes, you're missing something. If security_prepare_creds() fails prepare_=
creds()
> will fail, and the system will lurch to a halt because it can't create a =
new
> cred. The cred_free hook is a red herring.

Okay, my apologies, I thought the issue was due to one of the LSMs
failing their cred_prepare hook and causing security_cred_free() to be
called for LSMs that hadn't successfully cred_prepare()'d the new
creds.

However, if I'm understanding you correctly, the issue is that a
failed security_prepare_creds() call can cause both prepare_creds()
and prepare_kernel_cred() to fail, yes?  If that is the case, can
someone explain to me why this is a problem?  Both prepare_creds() and
prepare_kernel_cred() can fail in ways unrelated to the LSM and thus
callers must be prepared to handle a failure in both prepare_cred()
functions.

--=20
paul-moore.com
