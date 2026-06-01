Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930AA17BA6
	for <linux-security-module@vger.kernel.org>; Mon,  1 Jun 2026 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780278173; cv=pass; b=gpcUWi9A7rzN9z5wt8oy6I3ItxefKOW8z4pLEzvN6Xp+Cj5Wup2cF7qkybtLZT2rQFmISbXwE1ZuDuU58iGhnwYMi9QctcGnZzd5oEWZeNEYQtBbkeixKqcfaEkoMzFiT/I1v5yLXUK+Sx11gwFntIrZxLIpQg5juIsXuPNVmcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780278173; c=relaxed/simple;
	bh=1SQw3rHHmwJUM/B/fNJMq+S/nMdmh2BRJEnqOmPw2as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDK5/PtR2mYAUC+ps0XUQpE3YcXFDcxXRiHTnM5RDA9zaUq2JBrN9C2YDm6ZHoSAbAUGiM35OBsmHAQOf/pCfZfXH59YckE7abyAPmwqP0vB2io6k8uh1EdIqV+BsMhQlJp0hLQqj3m1IdV0Iur1nvWJpkWJXzxWrhH2fHwnGBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdXvrHXG; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdXvrHXG"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45efa0326fdso1108985f8f.1
        for <linux-security-module@vger.kernel.org>; Sun, 31 May 2026 18:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780278170; cv=none;
        d=google.com; s=arc-20240605;
        b=kuKmaEQaWOgAnVki+iU36vm/gOSFs8kdRng6v/HBLE/63HAWk9GCZwO4V6RenmcUQH
         ysKxvcPj8vYsaADuWEAf0mTCJuX7O5H+AMb1m0mBG6JYWwgpO/zTc4q9nsR4qZwLc3uf
         ibEy7+I+EaPB7oloPVWrk03sOvRekfCIletoKr3GVzBIznsSmba/qpGz+kQH/c5+bvX9
         qdAoattXCW5zHiGtd8GrVGBuy/Q5ahfIfPHtuMG1sZub9PIFYMLxDLJhGpleNwVhbhQh
         Hz4yHZgOJCB1xR5yJOAtXHWblKVuaHKRujvOg7wcaF5HTLMu0ggPbNoSoFInd3KveuFJ
         KcGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fI9AGBHWrCu/vWdIzq4GOSmcoyxsFLE6j/7qelnpJcI=;
        fh=3rDqkAMtLbHUEoAKwEI9HbJD9yr4uzIigy+xp0dX750=;
        b=b+mahTV5hKWRIekw4dq613e1E6l9QWE8/fbDmL4U4kpq295Q6MOVE++Gw3TS01hJBD
         BWKC0x5Shx42Gf40+kTC1LWXkV/4SGeNmgNAWSalHEQrYD7Z1J+1agQjBpTO3IvI7+cK
         DmSzC0xlL82bhWg/oAdB7Ho9YfqS9W8dZ4xv24NMxoQl0DMM9+PN2avGppVv1mtmap1n
         21Wlh2bKW8c4+LZzHVI5wqwvleeJuj2A+/Kh6UDHT6/CiKxKKeZJDmhsdPBesybLTTAf
         VIwDlHe7ADkjWcn5UJIJTjzMHN7mJvTBxlKdQLE8dfgj6XGue7L1ezG25g9WeAhBKu0c
         IbuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780278170; x=1780882970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fI9AGBHWrCu/vWdIzq4GOSmcoyxsFLE6j/7qelnpJcI=;
        b=cdXvrHXG/GZjnDDOA9uUrJbSiKS/nq6dRpO7y+NnnE+xYbcu+GyoKlvGQp/dcG4VKb
         Zd6QVc9VzkQ3bPQNqh7KQMckS677FGduTHjVsJ4lca12X2Df0qt9NdlZFB+xaDdE8Rrm
         FKzltMp6wF+Yv+sB1Ghs3SwxLla+dDpSt7Ptldg6Y4/ZIC/GmaTMa2SscMrJYnlnDrjr
         zCnIT7Fb+bT39xYS9cPC5vMItjdkkygbg3hZn4zN7NnO45g4p8t/Fd624xpsjbuudxzU
         1ViwBzfPzUqx7U8xdYPouEsKp9IxepTmpDk2uqyaN/iXMbSMDTsyJtA5lsWkK674Fbmk
         kWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780278170; x=1780882970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fI9AGBHWrCu/vWdIzq4GOSmcoyxsFLE6j/7qelnpJcI=;
        b=T9CgVqX7fzc1aKSmwpXXqbwiGzV6yRlIL4iLvQlssY44TYEXH3MocCIGGooyqso+y/
         vkLJv+3Tc7RVBgsKbU8KerO0b8A+kIBODDj1+ck2nBXiArDr5DtqCRUFeZh1Mskj/kcb
         n7ykXVsrCs9j//i7n4UAuNXblps8/z0Q2Egz48woEJ+uXuka31CIzr2PMytWyAacPaCq
         RSjj621RVSA45tP5yc8Cg1r8EhZjc1yvGHkBZ4K93S+B9jtnk9p8EX58m+UKsDUBnpXV
         q/By+PKhT1HmTizPr2Azg2Vo0uhGSNLaAZ78dzm5W1gB42Z8c8c45w+ffr5soiEDMGB1
         7DiA==
X-Forwarded-Encrypted: i=1; AFNElJ9dnTx4+Vbrw3xLKDQlIWmS+3UjWBYWdIyUV0YDEbVSLRdUOg1JRf/MtG7kTk2ndCTEj/ue+uiH8OaBGkEjCUlThUYQc34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf1fUYy8dc/mWn0Ql43K/in5cnQvBnssSv8C4nQWltVa3xOhNy
	Tq9hlts81dffJQSvfAM0MqHCIDqavNPwmgVNjG2CGSO7TB6qI6ax/J0uQquQvv3pDOXo+zi4Nxj
	DpknnMR+XVDEoGjIdE5D5TLkK4OTeaRM=
X-Gm-Gg: Acq92OF5APBphiTAeZKSmw+QiPDogUKPI+CezH/e+0w3sNR+DfwOEM1HKvMCSv6ALMd
	iWFWRLxySRCwq7YYPzFRHhN6eiTZxaMeuD9L3PXMwFYOjuZJmrzSV2CS2kr6LSXBCX60jN+k/0Y
	K2TxdhA4WTrmVsT1JqpkDis3F8v0sEijOVkcC7tt6j5btr09yBlymAwCBPXFX4bjdUqXEnzFMu1
	oD+luGLFAVGSAtfe623KCGdGhbTqHouJyX/7TdBbfJIWoF5mgBio3JHrU42aXlOSQdwEcWKf7pZ
	W4vh2Zy/E7lKJwAxNEsXSEVD7Uz8vIZDypv97luG6yXzJ0sR2Ll61flIIRLWQ+eEqoadtMEZSuS
	9b4PW
X-Received: by 2002:a05:6000:5c3:b0:45e:fa4c:47c8 with SMTP id
 ffacd0b85a97d-45efa4c4bbbmr13291146f8f.27.1780278169823; Sun, 31 May 2026
 18:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523160025.16363-2-paul@paul-moore.com> <CAHC9VhR6RSq1TUgAyvHmaF01h87Cazy=BNJhk654BP8yfeSwng@mail.gmail.com>
 <CAADnVQ+WTfgO636GqgxzJ6r=jENpG704kmNAsy-X8=WyjMOV+g@mail.gmail.com>
 <19e55c1c1f0.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com> <CAADnVQ+JDtc_GdxCv6tWAT03k85PTc0+zdcpCQ6NU-T8yJcu0A@mail.gmail.com>
In-Reply-To: <CAADnVQ+JDtc_GdxCv6tWAT03k85PTc0+zdcpCQ6NU-T8yJcu0A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 31 May 2026 18:42:38 -0700
X-Gm-Features: AVHnY4KyQFn04X4dWlQGyHLkT-INPicXgTz14ihkeRdjdGaPQttUsvgaZ_6DhR0
Message-ID: <CAADnVQKwxeunxW3iedoaquGAEvO+2jO5fpgbvxMGW_UvWzpdJw@mail.gmail.com>
Subject: Re: [PATCH] lsm,bpf: fix security_bpf_prog_load() error handling
To: Paul Moore <paul@paul-moore.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 10:19=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, May 23, 2026 at 6:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On May 23, 2026 11:25:55 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Sat, May 23, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > >> On Sat, May 23, 2026 at 12:00=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > >>>
> > >>> If security_bpf_prog_load() fails there is no need to call into
> > >>> security_bpf_prog_free() as the LSM will handle the cleanup of any =
partial
> > >>> LSM state before returning to the caller with an error.  Thankfully=
 this
> > >>> isn't an issue with any of the existing code as the LSMs which curr=
ently
> > >>> provide BPF hook callback implementations don't allocate any intern=
al
> > >>> state, but this is something we want to fix for potential future us=
ers.
> > >>>
> > >>> Cc: bpf@vger.kernel.org
> > >>> Cc: linux-security-module@vger.kernel.org
> > >>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >>> ---
> > >>> kernel/bpf/syscall.c | 4 +---
> > >>> 1 file changed, 1 insertion(+), 3 deletions(-)
> > >>
> > >> Alexei, I'm assuming you would prefer to take this via the BPF tree?
> > >
> > > Paul, I see that you're intentionally trying to piss me off.
> > > It's not going to work :)
> >
> > I promise you that is not the case. I was looking at the sashiko result=
s of
> > the latest Hornet patch and it identified this potential issue in the e=
rror
> > handling code that is an issue independent of Hornet. I posted the quic=
k
> > little patch above to fix the issue, and since the diffstat is solely i=
n
> > kernel/bpf/syscall.c I figured you would want to merge it via the BPF t=
ree;
> > if that is not the case let me know.
>
> It's in a queue. You can monitor it here:
> https://patchwork.kernel.org/project/netdevbpf/list/?series=3D&submitter=
=3D&state=3D&q=3D&archive=3D&delegate=3D121173
>
> But please be advised that when submitters ignore issues
> found by bots and maintainers agree with bot findings
> we mark patches as changes requested.

Applied.
