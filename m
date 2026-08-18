Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B07C361666
	for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085712; cv=pass; b=u9f4qwCNtUk1g7lQwm0p4P/QnHsouPfEyo+hAaSktw2/rPUC5jgoCjj+mYaXLIRh4ihxWpiCRvEc6nyTONNX7GFWQuC8o/Epk0YqCMi/uapmFsOhpGsdLDMSTQTEsNBGMjPWMm7Lq5AeyLZe2ZHrscvD52KYUt3l/DxD767UpYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085712; c=relaxed/simple;
	bh=oSxvmMJWKPDVnxWkodLeetjh1ap0IaHpc44VwhS767k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EM3FBEAodTlBheJvY4BdIXI9YqzV2UNfnYfpJuyWoc7hQYJX6DIDrXR+1fBj6xfjkV5jDOYlxeIA1sjAetuqzcR4GWfxnmGbvPn7a0B8WPaGQQm6zDNeVqYkcv1xwZQooIJNHkr3fBxipmEfadYBcbFW7M/AMVTTV8f5mTsCmJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pxmz33Ay; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pxmz33Ay"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8efcef23d21so2774866d6.2
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 13:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787085710; cv=none;
        d=google.com; s=arc-20260327;
        b=hxGbucisC2x0KXQZmfDQX4NR6TQZrvLJ9s11OZdbUGDRIBmXJvHIQpzunssSZsH219
         wUFBx0kQPx+mx1o6+qcQdVvLH1iPJJAOHuVPtW+1HEunk3vNp8KmDPJwHWUVC0+wQpJk
         CWfKpB+bS07MF1Y9cNBmoigdQKbKNLHgNNHAatrpMz5dKYe4VhB8Wz32tbP6RT/A1QQH
         OWS0JGzZDiYSLB8jxq06Ad5/iFtWhrhPG+5nykxci3In4URTjVcUl3sat65gYOB9ON54
         bvZyCaygHBouO7H13Du30MOdPO7p0Gw/XozNhILBsZfJ5Pp9oVTSEW4M1N0HZbEuI2cp
         BTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e+jRDvtK8PMuPCS2sGNAScxlW3qwdUi8K3HelhQRKVI=;
        fh=Pjmfwu7I/G6wTZXlgD01V4/RBTrfXB57uTQuTx7ipQ4=;
        b=PlfbaseA0ID6Xk8GNcFjUyz49yqom03z1v5YoH1zpo5cBnBmqy2yO6tPD5km7slNgq
         bka2+xuP/4Tk7yVE5ymgRqD4z0jwFzzelbiB56VD8KtVLapFGy0PPuW4rBcgl5Ip1LYT
         N1Ho6jhN6PC++xyz689cjdlAL8e8y74nBAxJu4vN5YC0kDdoZceoKfK5olOtdesG+L2U
         sjs8BChf8VqYElyEM0vTXvb+Mc9n3s2/uEM17AZ0K/hXuCD25facw/E3PSujODDX3RME
         rJKZGp4SHLmzfLjVdGI98uKi0lSlswWSSoN6g2nzL+1AmRKl/e85sIsPMsH/lJYQKAF6
         7KkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787085710; x=1787690510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e+jRDvtK8PMuPCS2sGNAScxlW3qwdUi8K3HelhQRKVI=;
        b=Pxmz33AyB8CrJNhyeFojiJvOMV2qlCaBwtyZnL1rCAvu+vnpfexaDbGAyHHwxZjLsz
         Dm5oyp71L0jbPAhkoiEZuhtKrx91IXQpW9pQx22ZDeLotfiFC5FlF/lt0KM3BXA8fZe2
         eoD/iGXlptYhCB3uKiSOSDpJNsUSKXxYR85eVeA8JWSckvyuSbRo3wHcPGc4BRJa0thu
         pPx2KYoo7uwC3jWAXZskKcg15Bl/P/k8JghBqiXgZR3JDf3Q9kNPomFJT46Jy9S3e0JX
         VpH1qnfRnVLUUR4cpu1oIQdkAcbsjStqKYnKgFageSmE0v8VVoSSgDmbivWquxwDKa67
         08XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787085710; x=1787690510;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e+jRDvtK8PMuPCS2sGNAScxlW3qwdUi8K3HelhQRKVI=;
        b=TaPQDvSLjXVZVImefpTLgafPJXtHyyyoWGjcn4RPPbXiO9Q3EL8dTVAZ3ovj7YT9XJ
         UtGz4Foi1m3eU60sVtqOOEBgSZBEDUNH15ZgPZhIqYJefZlApWnmpdqbtFK21VvHkb2Y
         5sWQ70K3tYYPqmxp3COnHzE9lxHupj6zDBH/8rSluuEG88ecP9HEcQmbIaBbXuFOIAyz
         YiZZseJZmzj4/7Io69T/3FfPKZJbjBiTr2OGE3YZd7t2fJiQpvF1ZNUBmfJaOE2gZxwa
         AXmD/7QKhZfKeBBHstXCQwJbPrPB7ZMASYY6vFr+LXWLndj/YwJ02swC6VKL8v0ClcJ+
         ZAIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3ocThOv04IoEqLXA3TdaLHzhq1aZwk9YoAyTbPdpYvUAGz5d6OTIcaHNRbjmAPbir7Li2IwjGs1Fx3e6fuyiu+u9M/TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIQMc17KH+k8ZQkOJ+W4lbUWKAx1uUnt6KDVZGsjfxFZTUuME2
	mZNw6uXpAUNCVB2PWiu4zS56pb8CwlqF1w2020XvqOOifEsnbUkVCScGo2wRgplNvAicmX7Opyw
	jH4jy0jkR3AuOws8zn4VPIkYjRmBFfFRU8UA4
X-Gm-Gg: AR+sD13vBO++y4PdVBXrbJQw+R507v7P1htIxjLq6AYLK3ex+IgmL/LR2JvqOrX8cYu
	S+ehJ9lfXyNUPVLsG6OWr9bSUMtymhEAxrJo6ElOHax9YHeRGHYKzFH6zJRXje5bh0rL42JRT0D
	aQPybWRE7axHQwy2osRfVrTOvapiFPQIqfh0utv38boqJy2jGjlRwwpjMVb2yLwlifKJKB0fCzM
	5aqOuPohGIDjybqwLaXSc0PvW4LhtlIohAOPVhXT8r9/pZATTK+52vJkF1z52VbaK1K70sf1zIA
	8HCseR8ozyOhf7Unknc5LO49n89vF/68C4ekYDNFHQGayr05iQp3YRJcAV0RA3sV1vwd/y3s6x0
	=
X-Received: by 2002:a05:6214:458f:b0:90c:5947:7e60 with SMTP id
 6a1803df08f44-90c5c24abbfmr15219616d6.4.1787085710038; Tue, 18 Aug 2026
 13:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
 <DKRYZPV04750.1V3UXL56PKB6@gmail.com> <CAEXv5_gT+xcZauKug-VsmqSBtuMPEPtw7hubxn6-0nv=D9aq5A@mail.gmail.com>
 <CAHC9VhSs5noQexa5c5RiP_DEzUgGaZw1hwsP+T-HWRvvymB+3w@mail.gmail.com>
 <CAEXv5_j0h+qCvj5U_aha_7OUUyuR6FPzufo3zK=Ax67724CPjA@mail.gmail.com> <CAHC9VhRzfOR4-RtPapOC4am8F=sC54VDzr7hAn2UMxNQwp_38A@mail.gmail.com>
In-Reply-To: <CAHC9VhRzfOR4-RtPapOC4am8F=sC54VDzr7hAn2UMxNQwp_38A@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 18 Aug 2026 16:41:38 -0400
X-Gm-Features: AcwNN1VAkYgsCnapUQ6Evh5Gxdzz2qYTdWEeHRtYokO6ZmlzYQiklEHul7sqqh8
Message-ID: <CAEXv5_imtiRdkmGrdmhAk7c7SS65o_Lxse4+=XaTFYar8uvBtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
To: Paul Moore <paul@paul-moore.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Justin Suess <utilityemal77@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 4:33=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Aug 18, 2026 at 4:16=E2=80=AFPM David Windsor <dwindsor@gmail.com=
> wrote:
> > On Tue, Aug 18, 2026 at 3:48=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, Aug 18, 2026 at 1:42=E2=80=AFPM David Windsor <dwindsor@gmail=
.com> wrote:
> > > > On Tue, Aug 18, 2026 at 5:43=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > > >
> > > > >
> > > > > Lastly, given the difficulties we've faced from the LSM maintaine=
rs, I'm not
> > > > > inclined to waste more time in explaining again why this cannot g=
o under
> > > > > security/.
> > > > >
> > > >
> > > > I'm still going to send v7 of bpf_init_inode_xattr series, even tho=
ugh
> > > > it's a stalemate. Haven't yet decided where it'll live in v7, I'm
> > > > inclined to leave it where it was (in fs/) since one side will NAK =
it
> > > > wherever it lives. We can record NAKs and take it from there.
> > >
> > > As a FYI, I'm not going to ACK any of the LSM changes with the kfunc
> > > in security/bpf_lsm_kfuncs.c.
> >
> > Hmm, even if it lands in security/ you'd not ACK it?
>
> Bah, a typo on my part, my apologies!  What I had meant to say was
> that I'm not going to ACK any of the LSM changes with the kfunc *not*
> in security/bpf_lsm_kfuncs.c.  Sorry for the confusion.
>

Makes sense, thanks. I'll send it in the next week most likely.
