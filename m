Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C963DC4DF
	for <linux-security-module@vger.kernel.org>; Thu, 19 Mar 2026 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932053; cv=pass; b=CWpHeunP0YTTwrutzF5ISSpYieqDzOvK0XoL5xzwgF8x1jYrtK0CEyLs/2NKWcUWh1aKxlk0SDD6pftnF2gRLcGNeYoWbQbL8IKyv3vz10U7gO5c2dYoMw9QSAEyEdOGckWFudiSf9JLKTo0Woufj9FU4bDk3RXUibvy7bY4GHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932053; c=relaxed/simple;
	bh=UmN42XIFxWPA+oc5RV+ztiTu/o/KFtkvvg5unw0jZ4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/FCYFgUS824D62nQQFD38bTTguftdLP/Maq5/cwAV5jTAuYyKAjnf16XXlLyw4UKX2hOqu97aJRhR63TZFjXswAvECOYBtP06QWmZVsNll3S2KqmdJDfAgkkC/SjqYJT/Hhm7ETfvpkInwqW1a8R1LiinF6Qa1jXTZFMOKOhvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXdDk7A7; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXdDk7A7"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b982a80317fso30833466b.1
        for <linux-security-module@vger.kernel.org>; Thu, 19 Mar 2026 07:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773932050; cv=none;
        d=google.com; s=arc-20240605;
        b=DritzuFhFzCoBE8Rf+A39MINcu9F1qocxoF8CXL6RiUKaaE0IcIkjRHFNajFLH8mGI
         BCWlia+dIpLg8YFU7thCMtpdc1TowanA0q6qML4wbzsGJpBz+qmSKUNcomrOJKdfxgWb
         9Rs5GTuKoQvB3VgMEyJnAqzftSRtE5lcjWRnzcgGp+wSEqhschuMfPYdS20Pvuj+FyCv
         lLdfX6/eHQtopa99zIDAigu3kP8acQdTFV58uHPes721NazN4lQsUFPY3EhlND+KdAqX
         BFRngxgQVjj0lBAcaWFeAx/atGMlHAZIxtuwAMdLU0sCki7pn6Y5BTXe1b5rPVg23EFs
         LBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jw0GH/4mNtxvnbd70gE+2uTwAn5ypE+g4jyg0EIdEpQ=;
        fh=Xs8P1kQ5PhGnfM6oqspGoq45Stl50N+2Pr5rNowI3gs=;
        b=km3lzWVaTAt+QYL9f/G1yrOtQEaEzzBlZmtEC3lccsAX5x2FSGrE8LlLCqwQiOt8hL
         y+XNQaT6CfAaSyuMsGovErXfz8pPtsvcjRILYJ48Z/9kxyGN7j46b4Rg1Q/HkltwgffG
         hsC0/yZIfQCPF/4eRs0cioFRGHxZ1gLvL/pLH2Lf0JiWwWseZc3Foy7be6aJWtdg9P68
         WDKtiZTuvZ4RSnyybW3vqw1VcwY6JTJdxwtoBr/NsGdyXHjxZM2KED5TlG4R/uRVJ9Qk
         /63p4klo5cOb5AGV2NKqvyLErqm8SCxl5CRNQ8vA33TZTvOfCAvcH0y65wJvQGDIh/4X
         1TaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773932050; x=1774536850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jw0GH/4mNtxvnbd70gE+2uTwAn5ypE+g4jyg0EIdEpQ=;
        b=hXdDk7A7vGYw3Zx6tF71xgZ7WwjEnaSx5y641xv65jo7qeQ8m8GRnNgGYdbd7kyl6R
         jJrYRxgyKtVCKK4gWldoBp3Tvv5JIfA34Qk+AUM+Tc1yNVtKuQOzEjlcqKADPmBmdM8w
         Abw0s9L2n45ICgImp7PJzWtFr3S9gAQrMEjvGWASPn8mFsb6ObKzNoAMwTU0IXbMD2wE
         RqECz/OvszbdyuC1gWzGfiUkUSZgpXR6vJXzxNUgUd6dbCF/7aJ293WWUo3p4R/57EBl
         UZcoxF6Zh44ecjSgAzXPCdgTQ7czPzt94DSczCXot4iFxD9ZleUU1yD7bhYc660LKoOY
         FQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773932050; x=1774536850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jw0GH/4mNtxvnbd70gE+2uTwAn5ypE+g4jyg0EIdEpQ=;
        b=Cfz4lRNVduILlKeeyhHZJlEjqi+SiPWxuEoh7bwYvUkki7R/5VFfDpNhxN0S+y7tvX
         e7+R5fbHnjBEdymki+A0PTaGER5fKIQjrriJYdW+W65mGmcRyc0UuHfj/O4IsHm4CWEP
         6fviYPqksXwv3B69TNMcvs6kkBJyuqJEiZLDixNMYxodiPMnPCrnWmjKSX4f1xn1XqtE
         nbuF84RKOapsuNZseE6E0+828J31T2Yl6C/rhKaoI4/PiFHnP6aUuT5UqJ/MZV7S0ogZ
         CwJxVEQr5oNQj8lEuPIrC+IaGlQAVQTcS65HDal6HWJsANKg6ANDFmrCYnH7I3QbA0ks
         bAFA==
X-Forwarded-Encrypted: i=1; AJvYcCUTBhx2IJLLgXkhFmw6iGmojnprjU0fHPPx5Fp4+NPpRRQckpfdOKzKDNfk7iKPauZwERvNRNlETZN/BN3Rrub4gsYANL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhwLdaWQWsbr8nYIZ04VGW+Qo+MNffJ1Y5EGkVXY7zYPPSEp5o
	nEYIxlb/QlThPwtJkKduNAHrz/MpaLP3hogqJEz6ZAE1hul+olzessf1f0tx4wc9FsvF7w4/bLr
	dCFGDSpMYAbngx9PBnpchnhxFwhjjt8c=
X-Gm-Gg: ATEYQzz4YySzaFuiWDVi2/KefhFlPeUABobfn3PNbvTqmW8k2kTNF6lkkPa9vjDV0w7
	KYBF23s4hYu+mhGKPn1spCOxqw7CAYaJyiJnHIczwcHOghXDlS4op0lsEXf9/5DkO/nlIoxjsIW
	LYX3v7SySqXX92wNhzAz8vUj06LnDRW1BwEJdoHilGclZvGns1aXMEgmAI7Z5qb0hlmtwDauf96
	usRJcaaVOUiIv3O+WNKQg+RtY1EJenLHYtHBkh7OfE1aV1ChVThUEpIUjmfXFVj13u2JPPbuA8J
	yDgyu6G7kTVgdAKhwtecK4/z0xXovvjzZ+E8aOLCeAM1frZKccIG
X-Received: by 2002:a17:906:945:b0:b97:d76f:3790 with SMTP id
 a640c23a62f3a-b97f4948e4dmr422735566b.24.1773932049652; Thu, 19 Mar 2026
 07:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318131258.1457101-1-amir73il@gmail.com> <CAHC9VhTKvOzMS2ZyawE=qBN-EpyucfxvwcHZYjXF5zugRhE2rw@mail.gmail.com>
In-Reply-To: <CAHC9VhTKvOzMS2ZyawE=qBN-EpyucfxvwcHZYjXF5zugRhE2rw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Mar 2026 15:53:58 +0100
X-Gm-Features: AaiRm53ob940soSsJtP2tgmiMXVCsKvszmwMYDw08PfOi4CUawSVTSX4zhGKxzI
Message-ID: <CAOQ4uxj8SZqaFbrVifw0uw7skbUvJP1_nLWj4PYCeZuaLy5t_A@mail.gmail.com>
Subject: Re: [PATCH v6] backing_file: store user_path_file
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 12:47=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, Mar 18, 2026 at 9:13=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > Instead of storing the user_path, store an O_PATH file for the
> > user_path with the original user file creds and a security context.
> >
> > The user_path_file is only exported as a const pointer and its refcnt
> > is initialized to FILE_REF_DEAD, because it is not a refcounted object.
> >
> > The file_ref_init() helper was changed to accept the FILE_REF_ constant
> > instead of the fake +1 integer count.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Christian,
> >
> > My v5 patch was sent by Paul along with his LSM/selinux pataches [1].
> > Here are the changes you requested.
> >
> > I removed the ACKs and Tested-by because of the changes.
> >
> > Thanks,
> > Amir.
> >
> > Changes since v5:
> > - Restore file_ref_init() helper without refcnt -1 offset
> > - Future proofing errors from backing_file_open_user_path()
> >
> > [1] https://lore.kernel.org/r/20260316213606.374109-6-paul@paul-moore.c=
om/
> >
> >  fs/backing-file.c            | 26 ++++++++++--------
> >  fs/erofs/ishare.c            | 13 +++++++--
> >  fs/file_table.c              | 53 ++++++++++++++++++++++++++++--------
> >  fs/fuse/passthrough.c        |  3 +-
> >  fs/internal.h                |  5 ++--
> >  fs/overlayfs/dir.c           |  3 +-
> >  fs/overlayfs/file.c          |  1 +
> >  include/linux/backing-file.h | 29 ++++++++++++++++++--
> >  include/linux/file_ref.h     |  4 +--
> >  9 files changed, 103 insertions(+), 34 deletions(-)
>
> Still works for me.  I'm going to update lsm/stable-7.0 with this
> patch so we can get some more linux-next testing.
>
> Tested-by: Paul Moore <paul@paul-moore.com>
>

Paul,

As you saw, syzbot found a nasty bug in this patch and it is too hard
to fix it without introducing more hazards.

Therefore, per Christian's request I am withdrawing this patch.

Please see compile tested alternative solution for selinux without
intrusive vfs change at:
https://github.com/amir73il/linux/commits/user_path_file/

Thanks,
Amir.
