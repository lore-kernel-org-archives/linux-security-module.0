Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D353F4DE9
	for <linux-security-module@vger.kernel.org>; Wed,  5 Aug 2026 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785970331; cv=pass; b=QRAZw+8EbBsAbcDpG+NXT4NGZOloOI57+CZXpMGio/0D7GFLaMxhQVJqBFnCHfAZAH9e50G6Hbfbm1LmiODJd8Ttho4mAp+fvITG+yIpelVHWbwA/qixPnaMtWdOpBvWX5lLV+cHZ4S7kYgiokUT55cGhmyf8YtqDd252kupKiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785970331; c=relaxed/simple;
	bh=zW3RxM/rNbqJdWn4Mi6JYrmSdA5p5pUuWesdsgwjB4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5tqL0E2bK+k2ujtao4bpEKF7QjOeeMSdZ5UZqjLC4qELFSbURcCyaKRIZkbIcyugyMSFSmHMlt1CT61ImE4fnTUMKmfwGkhNG36Za7ifZEyt7Vh1E/t2/LyRw6cwSoj5KjDlv1KWvwfc8q+KLvL1HhqicguddFujJSk1oBwwrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UCx7JuPr; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UCx7JuPr"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cee9b74ee1so13871755ad.3
        for <linux-security-module@vger.kernel.org>; Wed, 05 Aug 2026 15:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785970329; cv=none;
        d=google.com; s=arc-20260327;
        b=pugnNiYu0VmEDRQ3SrKSLq8zXAgOpw8UC258YTH2ZfVCiWlbjOgR3hK4iI18Xie8Lx
         TTt7/zQvxQXCJgAZddzYhil1uhPhGpp2qmYZnwZPm/Cu1EKyGzaPkfKCejlxKDB1z6QL
         EyeW3UOwqGwXWmffUZK0BnF+uCchKKjjvNnlbXVTTq+sYbFxtehf4EZ5EPGDldqE5NNC
         BW1/vkh73VdnsuPbkA+/SKR/KDamP3BSKpVKyQafeCC+E9W0NSN1YnqQe6bSYbv/37sb
         0baj9bWfLxWzipy/PP/E/33VQt6qB+xg4W2JDsQtbVKnGL6FOeeVVWSL7UNAOQtvEyaw
         7hJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UEUgxUIihU95kBMJ6tsYeTw6BnIB/l3iVQ0BO03aWqw=;
        fh=SfJGis1RbI4YYlJ+pUrc8XM0yEMj8KRFF+j1auPp5pU=;
        b=nL8F6J2iSchI9emvUA49/EfauHzn20jkg5uXYfSY0nuIFS0518aSpjwLSXysm99SLx
         XmDP1fETnpPCCTq5K6kgeCMyu5dSR6X+hGXZuoYNkIr8ZHckk2cxLr2CbB6jOUfEzeFe
         bjHS/gYMJ4x/OrKot0Yh+9WZ4pgoQR7aO1zMnsbvK7Qx/w5HszJGcmM4ABivXUSRRFT+
         cUFU6Tu/f7m8y0r3F7r9QN1J5WrpRMYSW7vGHz3N/aaSzfGsHQSVrr+uhLh+RUkEwuhy
         XbFJnaC62mXqS+OIfFTxtQggSV9Gm+94x2PljG+ygDbR770b1UsYV2rp2jCxAaTJ1DHH
         lQuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785970329; x=1786575129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UEUgxUIihU95kBMJ6tsYeTw6BnIB/l3iVQ0BO03aWqw=;
        b=UCx7JuPrEv0HNJwY+yOsUlz3SZtclI/yOGAryYxTj02QCprTHA75pXff2hHW0SHl//
         cpGQ46LvCwbuCuBm/219MLR/CvMH1/BVJ7NddmWfiyNAuT5ZwaWhD4CORzdxOe/8puzk
         VEOPAk6Bv8IajkFG0hQxTxiVb7VS6yim6cyy4jSZlA3qkZPCLOBMyrm1DxH2+eobp7bd
         JgRPC126xCYYhM8i+UDiIqPcFLBgnOM+lzZI9SAyHBiNmU9B+OtQhsFxtmuSLo4+OTDF
         RyrEkUSr3dnG2iGVXOWyCHpdgQWwhvAwuhq3NIZFcKA3uIWQ34YWLNVhnG0tnbflZNYt
         SeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785970329; x=1786575129;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UEUgxUIihU95kBMJ6tsYeTw6BnIB/l3iVQ0BO03aWqw=;
        b=IXtMSDk063vI5JPjl9x6LU0dsyk+hhH8yIZI+vyl2P4fk5PxLg/Qzrx2tiYRm52XQO
         YyH8gOHVAprIlbhn5LD5XBKxqtB9AfN3D2TaowN8h7ManRM499rGat4CsTWt8TA8buAQ
         p928fjypnjfqUFbMuk2aT5hFCLMy0U5MWRV9A5aP2pr64+feP0Hb/48NsIqu6uptxuzf
         PM/qA78eb1tvZvCYMwtUN4hPnm83L1z9HapglQ2SJibb80sCeY5nobEo8QVPbk639qWL
         0wsdOYfXVgAKd2nLKobuV67SYZI5o0F4Bo/XGs6uAJCez02oYqMhTPZhsWLOAlUfvDyD
         uW0g==
X-Forwarded-Encrypted: i=1; AHgh+RqGlOAR/Ml2GO5ejKjTFmQ//PEpyFHcz5tT7BE0TH51JeukjOtkf3H7mmawjTEwQ8WAx3bz4ZQIJTeKSfP65n12CMikJPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJTbQUXZGwrMNCfqpjuKiB0sMtds/Dfz3BEcM6VzZlXaYQNam+
	CkrQzA2ac4QLiQjhIDjc7mNDnwDBR8ZzRuaFzOtTIc/yZ8OU1Wd8ZySFdCBRhPWTSz7pg4VqpPB
	4C6b+hNnAYjfhIuiaMoiVZd7HUpQ3CZp1LCw0+KtJ
X-Gm-Gg: AR+sD10ncg2oCIYsMPQi+ALumJTzr4PCt352mMMeLFfPpDk6uSgQdk0320tBMTa/0vW
	rztt518TVfnkg0vwe0rCjO3z7+fpCqTZ8Q/8zfhTJ/bqGsXdmPQcGLmmke2M0DmZ915CiWXrmZr
	6WeRNG65pYvSOAig2W3/xTyrv8sDK1s1/WYt1xUT96MSteniIDGaxGx6HHYwYvNWj668RRFou76
	V21A9rFyff/TmxjHgH9sJ3J9EjJqBZ75cuvvyu3SFdzFTMMEXlxBClS43aZzO22ZzPihaLDHJdZ
	LcH04dJ1Eu3ORv5VgIo6htm7iTAB8/5E/jJp9DbkXIz/
X-Received: by 2002:a17:903:2450:b0:2ca:e19c:986 with SMTP id
 d9443c01a7336-2d0ca70e87bmr103149425ad.1.1785970329277; Wed, 05 Aug 2026
 15:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com> <anOnaGmBTlBW9xwj@zenbox>
In-Reply-To: <anOnaGmBTlBW9xwj@zenbox>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Aug 2026 18:51:56 -0400
X-Gm-Features: AUfX_mzPunhiwVEajozDtlbD27VL1S40fcPizXOWOu5cVq-CtR6P_R27IEYpqmY
Message-ID: <CAHC9VhRBYMaNBPfnV=TK8g-M7H_qsBu=CsVVOwnAzTPAkpAZaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] BPF interface for applying Landlock rulesets
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, mic@digikod.net, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org, gnoack@google.com, jack@suse.cz, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 5:37=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
> On Fri, Jul 31, 2026 at 04:30:39PM -0400, Paul Moore wrote:
> > On Thu, Jul 30, 2026 at 10:21=E2=80=AFPM Justin Suess <utilityemal77@gm=
ail.com> wrote:
> > [...]
> > As you may, or may not have seen, there is currently an ongoing debate
> > regarding the location of LSM kfuncs that will impact this patchset.
> > Sadly, we don't appear to be approaching an agreement on this issue
> > which introduces some additional risk to this patchset.  We'll have to
> > see how that ends up, but I just wanted you to be aware of the
> > situation.
>
> Quick aside question: Would security/bpf/ be a better place for these
> type of kfuncs?
>
> security/bpf/bpf_lsm_kfuncs.c could be for LSM framework kfuncs,
> and each LSM could maintain their own security/bpf/<lsm>_kfuncs.c
> for kfuncs dealing with lsm-specific types.

This gets back to the other issue in the patchset that we've
discussed: general LSM interfaces vs Landlock specific interfaces.
There are plenty of reasons why we don't support the kernel calling
directly into individual LSMs, and from my perspective this is another
instance of that.  Here it just happens to be that the kernel caller
was written in BPF and not C (or Rust for that matter).

--=20
paul-moore.com
