Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848B15E5C0
	for <linux-security-module@vger.kernel.org>; Tue,  2 Apr 2024 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093803; cv=none; b=hkH0F4mNONfCV9axIVcQNyLN5daLVSCKd+Jq3XDZW7EaAVLD3hS/YDush7QF1TaVEifHjekbcOQLo7WcUT9zLJ6LfHhxDDD/3fOcv2/bV71pZ4VjkJcywIdTid0Rp7TqvI3OmQRLWzZ85KO76iuvQ0wYxqMxlYLWCm3LTDXTr0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093803; c=relaxed/simple;
	bh=zRrJ7KggAH7cTt1Vhmiuiy2Df28+5h6/wPPYTkWVw04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFBwuOC9a2dudHH3aSmXq7asFy7ivyBh9IUJM1DSLvEBUiRy2ROSzyZs23pxmzSokjS+C9r4pnX3+tFjCXqQnCHUJn9W9xTvegmccABjNjq5sDg/rzG708ZIOYaRDkK8l0zshVK/dzElm1jEeS3ueWZg0cMzLgCsQfG95fFExRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VFs56/kY; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VFs56/kY"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61461580403so39011617b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 02 Apr 2024 14:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712093801; x=1712698601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=timWU9GFd6HZQcBIpJ1fDsofXUJOEA2GJUMxdnQeWyI=;
        b=VFs56/kYlEJ/L6SfqNtsq2LSS+FXJEtIlml70yJZrVYGXT5pKgv9O1EfqVnfef2DHC
         effgJPyzTa7fxIfft8tofMWxtRk6jmHDTs/yrjT89LI5jITiHeDxBltTiHMGm1NgfK0c
         C/IyN5f7hATZMFKF4tDkZVaKw40iTbRHuRL92vkwITMIrS8aH/VZ2+qDNVtlfDd2CWfD
         4JwBLd0t6R2N76LWeJCWujE/6aOaergy+OuNTXokJ3qZixcUjT3l+gdhN9qrThw4qDzV
         aHjcDYvhpXIKiv7j7zkVSqOt6JiBpGFYEfXPT1uYaYV2WBffe/MmP7+wNEp2PnfMMkS0
         L4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712093801; x=1712698601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=timWU9GFd6HZQcBIpJ1fDsofXUJOEA2GJUMxdnQeWyI=;
        b=COLaxFpVUzMAR2OuRUYLA38CEBZ5U5ksxAKG1oW5ubZcKaVzhxACn4daQIS1+SECvh
         OssFKvkukVtPZ9K7xUJpApBFpgD+goy64RC4R7D+JNywCpTXsHmtrQdToS4umBQK8l7X
         dEU6dcHGa7PfZArxwK7xwjyHSHR+mOpT/VcljgiFN7F6vY47qVW22OO4xVVCmV6lX2cz
         ZaVdjynzudiXu9soGjEg0p2PCsN5Q8gccY8qM0t9TILkaSLRm6wHLzCdYIfEmrbgUwfI
         o6XtER1FEk+JZci0gemb4kow44lYpdn8WOF2SwomZobk8OqV6L/QzjftHtNit0gFNcFk
         gpwg==
X-Forwarded-Encrypted: i=1; AJvYcCVAL1kD19yGg75L7rK8ZzYG/LY0ITUKTSiXcSEDLlaSKcXNJ/QswuGlkczXCgRVujdhQou8ZnIK1KVlvvRmfK/LYmzvOLfHZqUBp4iGvsaGy6c02QtP
X-Gm-Message-State: AOJu0YxHPB1fbCEAwjhxzx6TYUzEavgx/GuRzkjNV/VS8W93sqppF5gx
	HT6XcYwBXutUlAdIlCczQkRkmBB+zgpuAsC5FlTpMbknG8xXP1M/yqnI5mhrio/cawZ+SdMFE9I
	0Komj6fPfy+onSkIgLKxjnZGz67wgXjM0bo29
X-Google-Smtp-Source: AGHT+IFJTwImClpiwZnwMaF5ABMRExNpfaFRHdgXao7m2+19hKn+RgyYiVPx95ZPN4eHvFaQwRNeE+0VXYBbG7NAbBQ=
X-Received: by 2002:a81:8544:0:b0:610:e9b2:f84a with SMTP id
 v65-20020a818544000000b00610e9b2f84amr12120598ywf.26.1712093801155; Tue, 02
 Apr 2024 14:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
 <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
 <CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com> <20240402210035.GI538574@ZenIV>
In-Reply-To: <20240402210035.GI538574@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Apr 2024 17:36:30 -0400
Message-ID: <CAHC9VhSWiQQ3shgczkNr+xYX6G5PX+LgeP3bsMepnM_cp4Gd4g@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 5:00=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> On Tue, Apr 02, 2024 at 12:57:28PM -0700, Linus Torvalds wrote:
>
> > So in other cases we do handle the NULL, but it does seem like the
> > other cases actually do validaly want to deal with this (ie the
> > fsnotify case will say "the directory that mknod was done in was
> > changed" even if it doesn't know what the change is.
> >
> > But for the security case, it really doesn't seem to make much sense
> > to check a mknod() that you don't know the result of.
> >
> > I do wonder if that "!inode" test might also be more specific with
> > "d_unhashed(dentry)". But that would only make sense if we moved this
> > test from security_path_post_mknod() into the caller itself, ie we
> > could possibly do something like this instead (or in addition to):
> >
> >   -     if (error)
> >   -             goto out2;
> >   -     security_path_post_mknod(idmap, dentry);
> >   +     if (!error && !d_unhashed(dentry))
> >   +             security_path_post_mknod(idmap, dentry);
> >
> > which might also be sensible.
> >
> > Al? Anybody?
>
> Several things here:
>
>         1) location of that hook is wrong.  It's really "how do we catch
> file creation that does not come through open() - yes, you can use
> mknod(2) for that".  It should've been after the call of vfs_create(),
> not the entire switch.  LSM folks have a disturbing fondness of inserting
> hooks in various places, but IMO this one has no business being where
> they'd placed it.

I know it's everyone's favorite hobby to bash the LSM and LSM devs,
but it's important to note that we don't add hooks without working
with the associated subsystem devs to get approval.  In the cases
where we don't get an explicit ACK, there is an on-list approval, or
several ignored on-list attempts over weeks/months/years.  We want to
be good neighbors.

Roberto's original patch which converted from the IMA/EVM hook to the
LSM hook was ACK'd by the VFS folks.

Regardless, Roberto if it isn't obvious by now, just move the hook
back to where it was prior to v6.9-rc1.

--=20
paul-moore.com
