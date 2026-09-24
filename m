Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4B377AB2
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267007; cv=pass; b=IdVnpn7GHZI9RZ7B6jJsu6AscgldZGM0FOE3YbIM5XqWVx3WOsxjnw4LlrxGeQlgzxKuDPHHSUMGZDPUn5BIAvRYVbfE3p52ycN1LpeYAMAAwrGlUj1oO/qMw0gvbZHLFOkdbGh84Y11EnfuYJGJlnT/Fv4BVegU9eLQEZbPUbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267007; c=relaxed/simple;
	bh=6LYnEnDjDCPLg9ek+kfbdZFOATFZrCp/gleIZE32Nis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYuRzNCAY9RaT8q29LhmTrYAImtHpBnEtwpZa+VAXoVhdhuPlAgbk10kLjvnacMz+kpt6+A1zK5ZUHV8JJdDcRsoS08Q6uAdVUtDPKfuFmmOHS9vwu/rBpq4Fd3snR8xg8M01NQ7iFlRj/tEgIBf6wF3Hh8hX/qGz46Lr39r8qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cTz5jQ8i; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cTz5jQ8i"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469f204f6so41514b3a.2
        for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 09:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790267006; cv=none;
        d=google.com; s=arc-20260327;
        b=s1QsKKEAzZYgjb9b/KNd7Xf7XTjOTDfQ00K35fxuXfTv3ZKspLI1rly+54cnkX/oDe
         F0F/WUmFRev/fXQDYVs3oFzPOJ3qQfjtp2eSLaI6sfgis3UgK8Tr7dDDe1WsFNlLIpy7
         aXGhCZWK/xgzypg1ZfpnDgGBPcYlEwSEQqhQrnWplGdx1sShQw7SfFutNj0jVMwK1H4R
         5UiMe82zHCAT4wQ4d5r/2ohkEESuzm1JeJJ5hRfGcMCVlC1vNGofBbFt7b0P1n34cWUR
         vGMvzumDIe3aOTbFECbAIFron9Mgr7bxAzPt1CMdHaaTexEN/9CKmMMvHe3EWKe4TeB7
         P3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PPib6yxoB1FRZrRWxa+lTjPODBOKUXazi7+OtJhcpow=;
        fh=FMvhD4jSE+FoHU1wpFExJalMVvNRgINhaKEOjrDp6tA=;
        b=Sz0rFbr84W1hUOI7veVDQ5/Gx8k7ukZR8HCJOf3eFTECa91QymL0kBV+goeUCgJHF3
         Pzw1REIvPMrpdZLld7cgbSnvUXdtgrGgzAE+bIuHJ3AEyqB67uAwv5scU4+WvhK8yA1Y
         sK+7T6cb/Uf4Iw8I78xWIGEGcIj78NFalV+3V4DsTQFsYMEIso/0wGHoApLf61ue1vjg
         agbeml4Xe4xIVDcXCuQ4ND/s2MUOW0mHOSQzltUEqAUo4ZdIVQzizMWqszHmlViEOLFq
         FBIGYkuHiFv6zRnbszd8elbXZChZdekbvXMY7dkOR0RU8rCe3XJ0M4Mw0WuUUwEq9OWu
         pISw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790267006; x=1790871806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PPib6yxoB1FRZrRWxa+lTjPODBOKUXazi7+OtJhcpow=;
        b=cTz5jQ8iQ8Z9m+yXT+w/DVEkFGVLoFOwj/jk81451eLJn0jC7GwZZbvS5wmuVRufQj
         dHoFR63IaxWdYn5AJ0o5etk08HxBSFwhE1A7n2a/X+bB20HE5ewODe0OVYs0mFIFCllN
         L3D8NFr7b+B2YUUnS7uuMgwQZSpW8VeNdYFUAptQqMlZHDRPp+0RZKANON0ZQnMklqEV
         lkGGopNJFt9uhiNSDahESzw/5u53RzQQg5s+Je6/fRuf92h2aW+WYLLHBq5cb4wAGJV7
         C02xfMr45vFDqWJBAqwEI0GejAxWvAKuWYiRSYPHtv9Lk4TMCuO/sDeAIC/Ii17rS8Er
         tPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267006; x=1790871806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PPib6yxoB1FRZrRWxa+lTjPODBOKUXazi7+OtJhcpow=;
        b=ch5Yg57zXmFK2NC8qc1pKkiL3Mngyz5pOt7H8T23D2P8IXeBecTjTp3slOTs2hnq4H
         u9Av704Eq5WVi26wbfoVJ7c30jOlcJdBv8cHLSCXezMcS6PddqjevGJJ0wAgjr+rjtUW
         dTRA2iD+WDH/Ja7svsu/3rDe45BUwxZoDvmBb/Zj/1vb4JPDmji9qy/mZr6R+YbbXA5r
         88rO3R6N5N1lyNsQ2qm1Bj836Q7BXE/KyibEDSXxfU6Z1FhfpzXhpTgLlmWiUSd7JzZX
         dyCjlMop3eHJ5kC4qsTr0GhwK4vDuPz18OoZopjQhqr79a3+uB5akbHYkCZLhQ59YYWM
         ppaQ==
X-Forwarded-Encrypted: i=1; AKwUvByAKpXb6ey90BqVEZ+dBhxvi5X6cnflJYC7bs9woJpDhiC7rKcRdvBz2IeEpwEEWOhPL/5jmmjbl+rMoG+jHZt4nI7UJUQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mHbSfMa+HckfwRIDFCKHFmwQOV/IUAmglNnb3ywp3mgi7IN8Ed
	a5f/ygxXMNxP5dFRrite1MT5NdFJ4O/dYCGTh3P9e//12YI5/l9TkVT3NE2294QV2/VM08QtWSJ
	NBK8QRyz501IrTvlknt095Jfz6rdnlsIRrTazabQz
X-Gm-Gg: AYBFou2ddEwOwuFeealLQjAsWB281RoUgP++K3yOfOqk1BclYC6pKhwzBWsjKth+qhd
	9CRdvJFpIdR35sSE+RNyx8PMK1SppjgjFTVsW1jsDZ5wNd9QJebMS4IfXfYj8DNMiozkz0ncD7a
	P4/7WM8En2hjG9Vjb73TsLb9ldpedZivXlsRrqoCzyTcN/yNZCaCJLWt0aZlT4aISDZhFzuuM3g
	MGc6dP6p+K7Gd0M3JFxyvtojpc3PbWVcJu5VciEuuuOoHTL8i7qE6BDtmLUvuDGrmatCGMylbe+
	ltdfbZflC/yYidW6BovTMimclp7S5SLkiklSzHv2mrz4GAPbPoomwDqC7LtU58VqAYxh9JAuQtS
	5cMYbFpC1YYA5HUsT+bJrgQ==
X-Received: by 2002:a05:6a00:bb91:b0:878:3773:81fb with SMTP id
 d2e1a72fcca58-87e9cd0e721mr2840299b3a.55.1790267005739; Thu, 24 Sep 2026
 09:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150739.284189-1-daniel@iogearbox.net> <20260915150739.284189-5-daniel@iogearbox.net>
 <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com>
 <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com> <arVKSpezisxe3pkr@suesslenovo>
In-Reply-To: <arVKSpezisxe3pkr@suesslenovo>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Sep 2026 12:23:13 -0400
X-Gm-Features: AclHuK_6WIHuuAde2rO_dJRZdDgeEWTftPypXMJBnjHVfzkE8DO4K6tdHmMf_Bs
Message-ID: <CAHC9VhSwbHF8tZkZ00JM40VTBeXVgcVdoBt7NcX0XKaKSARWug@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: Justin Suess <utilityemal77@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	alexei.starovoitov@gmail.com, brauner@kernel.org, john.fastabend@gmail.com, 
	memxor@gmail.com, kpsingh@kernel.org, matt@bobrowski.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 12:15=E2=80=AFPM Justin Suess <utilityemal77@gmail.=
com> wrote:
> On Wed, Sep 23, 2026 at 03:14:28PM -0400, David Windsor wrote:
> > On Wed, Sep 23, 2026 at 12:57=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > @David, simply for my own understanding, did you ask Daniel to do
> > > this, or was Daniel operating on his own with this patchset?
> > >
> >
> > Daniel and I work together and both have things written on top of this
> > kfunc. He reached out to collaborate, I agreed. We're also going to
> > send bpf_set_file_xattr shortly.
> >
> > This implementation was chosen due to its immediate mergeability (it
> > only touches security/bpf), but was actually suggested by Kumar in v1
> > or so of my original series.
> >
> > That said, sorry for any confusion about this appearing as a new
> > series rather than as v7 of my previous one.
>
> Howdy all,
>
> Hope you all are doing well and having a good Thursday.
>
> These patches are excellent and useful, and have been in the pipeline
> for a while.
>
> In the interest of moving forward:
>
> Would you both be able to live with the following: provide a security hoo=
k
> for lsm_get_xattr_slot or another proper interface with the necessary
> abstraction, and keep the kfunc where it is in fs/?

That still doesn't change the fundamentals around the kfunc: it is
really only a valid to call it from within the LSM inode_init_security
callback, it populates a LSM framework managed buffer, and that buffer
is then used to by the LSM framework code in
security_inode_init_security() to do the xattr initialization using
the values from the BPF LSM as well as all of the other configured
LSMs.  It's very hard to see this as anything other than an LSM kfunc.
I worked with David over several revisions of his patchset to review
the code and get it in a good place, I'm supportive of the basic
ideas, but this really needs to be located in
security/bpf_lsm_kfuncs.c as it is an LSM kfunc.  As we've seen there
is precedence for subsystem specific kfuncs located in the associated
subsystem's directory, things should be no different here.

--=20
paul-moore.com
