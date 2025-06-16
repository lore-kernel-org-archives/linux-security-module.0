Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC11A8F84
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750114265; cv=none; b=SkF/AbYjyhlPl5lyv+joFDjKG0gkKqjDYD1qCWeh3ePAZ+Sc+8mKq75yM/fsyh3Qm9qGWo/m8hzD6ar7Qv8dpsEmrUSbQsTOmkLMNjtlXG+6r/srFhjagYJ1WaJ6Qysd4ykB9bYABa3eBqOpS9w5FzMJrOtJ7oqMcBMSZ0JNVVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750114265; c=relaxed/simple;
	bh=dgg6yAuDVo3vleEyCChbNqOWuBv+k/MlWJld3pX9/MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DceA7VnXwJwQkRdPJsH6aJ4/55wfcpCsxQzzuoOkjied1pLRWDIXcv54yVOq1ySq962dPaISWOdwUv+uJVrh5kfNMK/wBufyZkqymn9dI6SvDoe6C3RBoaokZf/dRv/MTAHO4m6LIbZp2NdZDyZ1CpCpak2q/khqCNQ3stI/c4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LqWHPyrl; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LqWHPyrl"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-710e344bbf9so45654407b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 15:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750114259; x=1750719059; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eOumrIvQvMcIuJoDiv93cWolbr2s9Amklvv80KdrJs=;
        b=LqWHPyrlt81ELG/NcxQ8Ttddv2W1VF27BB4xDSC4zFdzWcKH81jviNDQv/bs+WNcqi
         lmDMLC903KAolT00l8YM5y23PuEBSzbOwU26vFsL8MmyMsTHGFducrsyKtOetv3cHcBg
         fGajPWKbzdsdQ4xMJfSu2SD4dEDggoHDVqRIr9bLcLCwEmYN3KspE1NxURU9LpDuC+F0
         0NDq3mZxquWwV8H4Y8XcIwZdCNgdCToWb9809x+iZ+vgh93hadry4g7WNQd16pVO8mQo
         b5EQh8dSwIUR+4k1CuAVHhu3f3iWq+Do8tc09bkhLD/RgZA3N7ASOFi4x8AKECbJ1myS
         c/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750114259; x=1750719059;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eOumrIvQvMcIuJoDiv93cWolbr2s9Amklvv80KdrJs=;
        b=JP6hFAjqb8xWxg49xRR8C/+VJ73MeGLi0fhFPqMi06BG3ShV3fcheGLXVwiuG/B6hs
         UUIxAXYrcCG8uYYEvn47UC3KQJlSeao/+b/lG7s9xcWYlduGnk2NpraQrCjwo8Han32u
         i647slKJza7FbCJIyDkbDBxa4fZA56am2YvWe+i9gyUoGwWFXEtmGjeW+ji1da4/bNZM
         lqacQGHK6U8ZD1hdKq6rfxEbFDYejfoKXA5Z7zOzptjZLwXyPkEsRdfEhnUwdkKXaYch
         zxxBoL0RcjoiD9At+046THcGdpHZO2WgnFZ7QpBYgeQwIwT3PbWjkrkxfDPos/Jmt+Rn
         ckWw==
X-Gm-Message-State: AOJu0YzL4lDbplH0RII/DopMwq6BtAJHzFtv/m08CguhPT5toiBb/vI0
	WlYfx3WM3lJ74wwioNrgWpOgc9/bf4Y4/MKgUzib3b7K+ShfgAmoh3IzrQsH8BMzFFf1Oj9tHtY
	ulGZ59JUYa+Ipc+fyImUrD6w0OyePeJiFmEMmlx+NeVv81oU3Vqc8Bg==
X-Gm-Gg: ASbGncuFXWWfYgIol9i6LHwC1Twq15VBzQZO5qBOMfirfZHfSHh/gxS4Hssvl+A2oVi
	ujxjVBI2s2M+kURvR3l7pdscU3L6KkOORygH3a0PM4CJLUzYd1KgUtd4sVtDciOonA1beWrbHgY
	ceVhVbx4jQ16HCIptvHIEIxRo4JW4wg+AMXmpxgsvdTsI=
X-Google-Smtp-Source: AGHT+IH6K7b65SOcZ3UL42VzK0ycq2N+XTmuhVcIgFIlyY+zlqbt+r6MyEzGmQ316e0BK/kO1VFZytwdP/N5HYUDazs=
X-Received: by 2002:a05:690c:7085:b0:711:33d3:92ed with SMTP id
 00721157ae682-7117547e398mr138894287b3.38.1750114259284; Mon, 16 Jun 2025
 15:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhS9P-fgWac_sJ_dq6_AQf76RGiqLAmOFnR_4NZ83KQogw@mail.gmail.com>
 <CAHC9VhSae4Vhypwr+hkAvddQ5_DQ90-jaS+pWPqJwPjk_dzMZg@mail.gmail.com>
In-Reply-To: <CAHC9VhSae4Vhypwr+hkAvddQ5_DQ90-jaS+pWPqJwPjk_dzMZg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Jun 2025 18:50:48 -0400
X-Gm-Features: AX0GCFsxmqLGPd1Dwp438v3XRjCA8HQII6EN0vJI_Uc-Mpd9DAorAZ5Dqh4hgW4
Message-ID: <CAHC9VhQn-HVuqn9UWVnb17VOGrYsNsqjCvqd2OEOi7=YQReCUA@mail.gmail.com>
Subject: Re: ANN: LSM and SELinux trees to rebase to v6.16-rc2 next week
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 12:45=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Wed, Jun 11, 2025 at 12:45=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > Hi all,
> >
> > In order to pickup an xattr fix, link below, in the LSM and SELinux
> > trees, I'll be rebasing the lsm/dev and selinux/dev trees next week
> > once v6.16-rc2 is released.  Currently each tree only has one trivial
> > patch in their respective dev branches so the rebase is expected to be
> > trivial.
>
> ... here is the link I forgot to include:
>
> https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.smalley.wor=
k@gmail.com/

Unfortunately the VFS folks did not send that patch up for v6.16-rc2
as originally planned, but it was sent out and merged into Linus' tree
today.  Considering the importance of the patch for testing/CI, and
the desire to delay a of rebase the LSM and SELinux trees to
v6.16-rc3, I've rebased both trees to commit fe78e02600f8 ("Merge tag
'vfs-6.16-rc3.fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs"), which is two
commits past the v6.16-rc2 tag and contains the xattr patch mentioned
last week.

Unfortunately, this does mean that the lsm/dev and selinux/dev
branches are not based on a v6.16-rcX tag, but with everything
considered, I believe the exception made sense.  If anyone has any
concerns or questions, let me know.

--=20
paul-moore.com
