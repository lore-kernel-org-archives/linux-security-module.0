Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6F91AD9C0
	for <linux-security-module@vger.kernel.org>; Wed, 28 Aug 2024 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886542; cv=none; b=WN/awxCVj3DR+8AwdLzizCfP+UMOE4xwe1DkQWGEnaEVFmdEp5Vnmo7Pk4BaMGcVYlKbqxKIFf04WeEG/fhDfXpwsoOVDWSC7zGeH1W99gungB5OWWgwkQj4IWKs3yRUJj0PaslcuXpj0R3MP+RCMLshwPRgfCGXRw9zSsqDPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886542; c=relaxed/simple;
	bh=S6khVv2K3zqenjuZaXHlbsGEquUo21R2DNwX+2TYioE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsKpClNmhWI+XV90rXNYuONJr9OOFoLdTYMQuzrW57Wm683M9hMl5fE38T65QnU1meymE89tXtZQm0CjTIQZJIj99dlXuirllQaOtGPUkJKdJF0e4TocIOM7KM7cKXRkBwhIG9wrYM7MTLQ3d4JoMJba2Em56j/PwyV+Ixu3AgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LnH1ZQv0; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LnH1ZQv0"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e026a2238d8so88794276.0
        for <linux-security-module@vger.kernel.org>; Wed, 28 Aug 2024 16:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724886539; x=1725491339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rnWaW1Wi74NhhYke8yxwRLmARuCVrhloji7XbjFHLI=;
        b=LnH1ZQv0ZHuja0G36rmHXCT8JSxeoSsmb2yhdq7+qHPq55Vlgal5H0kmiSZb5MR3K7
         O/UT9AYDEtST5/OTsxlPml2JBUYsKFA5N6/a3KyDT8qwxUKbfkXzsqZJ0Xg6hRjYC0zI
         4wHAovacb9n0+Ya+QlAgN2/4kb9QyrLukXFpseHy6oEVmdT/s6KWxA7C0dVfcmutSh3t
         6sfZMM4IukDUqy43xog9rqOG5fI3ILOv2tyNHJ6/55HyZP3w08oKtAfG+XiRWt/2YvQ9
         lj6aHf7yBuv1kYYESooMUVZhFsZ2J8RYzW8WZ+NqaLJsSDNZrHEiZVlDnxeQ2h91sPFs
         f3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724886539; x=1725491339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rnWaW1Wi74NhhYke8yxwRLmARuCVrhloji7XbjFHLI=;
        b=uVGlJCqHbugvtEKulPS9dbhNgR2mZJR8lctpsQQ74LGbrLmcIutrNgXwGdxO2bREmy
         dlVWq0r1tDjwsAfHcJpMd6as0u5CcD0xorLHfedkosj/vBnQ898vMtY/71UzQOv2RahZ
         +abtxK9BL7Mn29vQ7HcFBRGJa6u6+teDL2ixTGAoweXV23K9nId0chi9CU1OYI6FKSYw
         kOtCHf1eOZ/4p6rGAN0de7FRfRid+l+rAEesoLkGXDS19jLOF0mQZ8SxRYuFsBOpYGg7
         lNpHiDocHP852DIUEUNc8r+U3pjEPjuNjCy5hBgCEpUPLDZHVnifTZY8WLhTNX+07f4R
         /fzg==
X-Forwarded-Encrypted: i=1; AJvYcCWIqMH7uT81OV6sJpFNyeu4jtoZmsFka0aD7KeK9n4WTBcif565mpQR7NKa36q3Dvjeuhu19Mw084ica7q9Z7aim+I8x6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQBWiH6QykEXNtd+nMyDW12R5DI5bsLQz8wRT3gLnzpq1VMFpO
	jWaof0urQHrM/YpTAho/iP710SC2wl5zu6TZybWrRW+iMj18z1pliCsS0J20pXE2Kc7l3u5BeI1
	B5Ar0QuysxqZ7ny/I82xRGXfJSJEdBb+zIZwJ
X-Google-Smtp-Source: AGHT+IGGXa0V8oGxUH3v22rH7vhuHhw9UfTo9cOdvs7DK/8DvFvDweL505TqKuvwIrMUiZgtV173ulYyn2z+iRorJiU=
X-Received: by 2002:a05:690c:6512:b0:64a:4728:ef8 with SMTP id
 00721157ae682-6d277f51e62mr11216887b3.44.1724886539569; Wed, 28 Aug 2024
 16:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828195129.223395-1-smayhew@redhat.com> <20240828195129.223395-2-smayhew@redhat.com>
 <CAHC9VhTCpm0=QrvBq_rHaRXNqu7iRcW7kqxjL8Jq9g=ZypfzsQ@mail.gmail.com> <70639b16-d48c-4465-80f5-4192c9d86b36@schaufler-ca.com>
In-Reply-To: <70639b16-d48c-4465-80f5-4192c9d86b36@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 28 Aug 2024 19:08:48 -0400
Message-ID: <CAHC9VhRDD76EnuXAbK1wPVCP5X-Fu9AytxC2bD3vvApLjzak6g@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux,smack: don't bypass permissions check in
 inode_setsecctx hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Scott Mayhew <smayhew@redhat.com>, stephen.smalley.work@gmail.com, 
	chuck.lever@oracle.com, marek.gresko@protonmail.com, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 5:29=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 8/28/2024 2:05 PM, Paul Moore wrote:
> > On Wed, Aug 28, 2024 at 3:51=E2=80=AFPM Scott Mayhew <smayhew@redhat.co=
m> wrote:
> >> Marek Gresko reports that the root user on an NFS client is able to
> >> change the security labels on files on an NFS filesystem that is
> >> exported with root squashing enabled.
> >>
> >> The end of the kerneldoc comment for __vfs_setxattr_noperm() states:
> >>
> >>  *  This function requires the caller to lock the inode's i_mutex befo=
re it
> >>  *  is executed. It also assumes that the caller will make the appropr=
iate
> >>  *  permission checks.
> >>
> >> nfsd_setattr() does do permissions checking via fh_verify() and
> >> nfsd_permission(), but those don't do all the same permissions checks
> >> that are done by security_inode_setxattr() and its related LSM hooks d=
o.
> >>
> >> Since nfsd_setattr() is the only consumer of security_inode_setsecctx(=
),
> >> simplest solution appears to be to replace the call to
> >> __vfs_setxattr_noperm() with a call to __vfs_setxattr_locked().  This
> >> fixes the above issue and has the added benefit of causing nfsd to
> >> recall conflicting delegations on a file when a client tries to change
> >> its security label.
> >>
> >> Reported-by: Marek Gresko <marek.gresko@protonmail.com>
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218809
> >> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> >> ---
> >>  security/selinux/hooks.c   | 4 ++--
> >>  security/smack/smack_lsm.c | 4 ++--
> >>  2 files changed, 4 insertions(+), 4 deletions(-)
> > Thanks Scott, this looks good to me, but since it touches Smack too
> > I'd also like to get Casey's ACK on this patch;
>
> Testing labeled NFS has always been a challenge for the somewhat
> limited resources available to the Smack project. I'll Ack the patch,
> but won't claim to have tested it.

Understood, thanks for the quick reply.

--=20
paul-moore.com
