Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B552A50
	for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387294; cv=none; b=ay/ixRd4E71TBYUyBZ6eh258VIwJEeC0E0SqI8C1SI819agLSQmweXj1TuqgRPFom0omJbY9Tblz9Paz7WzZNUCXUqNaTR5XyxSqiFEBSqyQtry1QpUhKHj+ZWWYJb3gFDevFfMVKceOIynKinK4Vbk9iQWL0egLwnSTNAPq40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387294; c=relaxed/simple;
	bh=viw5DHYPaObU3U7ujOkzz6hhRTbM8dWi+h/TUtfWHlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwgh059pd7pIpcsxPfL07zqrc8N1ArUFqz8ZPWHiD8XXo9pvJGrkJPm2c38e+ZMocz2ybhKAxSlOjFt+kzwGzSk7Yk5BgPdmBWrZFsOaxwki+gzOui8elIV5QQ9STaOqhvf2++4yn+PHr5LCbArmJRDCAmR0TN5AEMB8uIgpMC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YTTx+L+K; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YTTx+L+K"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-609f1b77728so50897797b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2024 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711387291; x=1711992091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwFJJMO8Y9QW/VnLPngFZc/sbeBlDHZAU2bsUzRDf74=;
        b=YTTx+L+KKPuBuhxnpXHeUOcGt8Uppef+zkahssJep2AgGWDOHljab1Iv+i3+xFKuEQ
         AedEqMLV30CVEKseuJCHYMatq/Ao2y29L0rUJ/y7WWgFwHUe9PpUHunZ0iHX7A3pHnVA
         bu+44E6/EZhSswDywqaK86dGhvY9Ne0QGdhC8bSojLoMxA/AJuRS3IISZG8MOubOfM+q
         rdiBpQSaVfzt8dRjM3VzPOaEQYn5HnGWC4oRHoIodImVh35IF/sB0aDxFU8YcIo55Px3
         7iXnPO+oqSCFJb9yS5+/Yewcix0r84Fss4uSeJa9ycsUQo1W/6GTX8cds+XLTV+2DNZS
         y+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387291; x=1711992091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwFJJMO8Y9QW/VnLPngFZc/sbeBlDHZAU2bsUzRDf74=;
        b=RnS15WJiF+qhvWUvNI0zashhODSZCeFAhY9vRW4VwUFIdb+xRm67iTanP7eHJEKfJH
         galAYkMo0NNlwATZpH+eimxNGI0oFNGrPbUzQ1OhMuAKIOdSpCGwgchLWtOPUEQJ7Ks3
         WyfWShahL77VXyJfGhbal+WGbup36iOO5Fed8EnTm5tyZyHKxt+cKsWXCOIbudGZSbyz
         kcdr4RV0J+UXspo0mI00rW4vMSoU4bUeHGgeYjiz099tRb6mUv/Dia80U6DODyN+YYwB
         Jl4f7kMjHNrtAb8ZXp5akMiXmBXPoPWAkgXsQpexdyTFmXCMPG4dnbhnjnFGkf92HZ4R
         UVKg==
X-Forwarded-Encrypted: i=1; AJvYcCXLbDtCWsLeVxcxE15fSKcDO0oNAZUjWPxc6HIPUm2oUsM88k9xTYGDCP0dIyqTWMzImpy1BacpdGw1DTmYYl9dnXTtgyle96CKJPrpvGunlObz58Js
X-Gm-Message-State: AOJu0Yx5r0ykUDKg8KEKI7+okoIzUiQm8lIzMsA6GBunMdPuqveWzV06
	wbdk6ScuT+wyNjbUzxMJCXDlqsLlniw1Nr4PoR2FODwhe7PIy0+7xvEx5WpS+s8hOxO3rjCQV02
	w5GVnr9rIxkkMI+Vcio0F9OCUrUGGBn6PaTY2
X-Google-Smtp-Source: AGHT+IFMwOQ7JYZ7RIBsL/iaaKoCpBdaov3J7tHg8zqWWrlziSCuAkCo3Xzme8ojXw3lDFimOmE9DPWmLf9w8Ru0nlE=
X-Received: by 2002:a81:a10e:0:b0:60f:e8ca:4959 with SMTP id
 y14-20020a81a10e000000b0060fe8ca4959mr6688036ywg.18.1711387291265; Mon, 25
 Mar 2024 10:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV> <3441a4a1140944f5b418b70f557bca72@huawei.com> <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
In-Reply-To: <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 25 Mar 2024 13:21:20 -0400
Message-ID: <CAHC9VhSamu4706AwP1M+3D9vyxrMZgaZmHH8KUmjuG1Jig4aPw@mail.gmail.com>
Subject: Re: kernel crash in mknod
To: Christian Brauner <brauner@kernel.org>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Steve French <smfrench@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Christian Brauner <christian@brauner.io>, 
	Mimi Zohar <zohar@linux.ibm.com>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 12:06=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
> I'm a bit confused now why this is taking a dentry. Nothing in IMA or
> EVM cares about the dentry for these hooks so it really should have take
> an inode in the first place?

I don't want to speak for Roberto or Mimi here, but this LSM hook was
intended to replace the dedicated ima_post_path_mknod() hook as I
wanted to see IMA/EVM integrated as proper LSMs so we could so away
with all of the special IMA/EVM hooks and treat everything as a LSM.
Part of this was creating new LSM hooks where historically we only had
a IMA and/or EVM hook, the security_path_post_mknod() hook is such a
case (e.g. /ima_post_path_mknod/security_path_post_mknod/) and the new
LSM hook kept the same parameters as the old IMA hook.

Yes, you are correct that neither IMA and EVM do anything with the
dentry other than looking at the associated inode.  I'm not the
IMA/EVM expert in this thread, but I suspect this is simply an old
vestige of former code, or perhaps an "optimization" to avoid having
to fetch the inode pointer in cases where IMA/EVM was not enabled
(although it is used in the vfs_create() call directly above, so who
knows ...

> And one minor other question I just realized. Why are some of the new
> hooks called security_path_post_mknod() when they aren't actually taking
> a path in contrast to say
> security_path_{chown,chmod,mknod,chroot,truncate}() that do.

Once again, think of this as a
/ima_post_path_mknod/security_path_post_mknod/ type of replacement and
you have your answer.  That said, I'm not really against bikeshedding
LSM hook names if people want to do that, it's not a stable protected
API so while we try to keep it stable~ish simply for our own sanity,
I'm happy to see it changed if everyone agrees it makes sense.

--=20
paul-moore.com
