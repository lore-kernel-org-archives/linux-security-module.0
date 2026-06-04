Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA1118BC3D
	for <linux-security-module@vger.kernel.org>; Thu,  4 Jun 2026 00:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780533127; cv=none; b=FLy5On5lN3zu2Na9fmjD/i0KgdX/IbOw8RE6wzso1/BAIZuM34Hzul3ZiHmEnSyhRL7dpfC/UxCKzWwdyzdeNx4O9rT0fEy5rxx82f8G2lB53TtI0BrwnTniTttSMnoQ9VuoBojyayQk1rKAozYSBXiyCFB9w0zPkaJlRITHMQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780533127; c=relaxed/simple;
	bh=jZoIBQxjQ7P3tlUSk0EEmDO+cPHIkeVPtdsxpvA+jEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEFAdpcrTs507uVDbqGC40RUwjno1O8v2tOtrsC1DNEKlEW18P97cTfLpMP99nZ+1xPkKRfD+tovSkK4xGO3F9ByEKV4LTQ1FEuFjo+8aJihMTyM8NtbQB/FOBHD5/EkMZCEabrBy71e8LtxabH4UnbbDhcPeEBpa2by1pfSLpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NguiVgiX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NguiVgiX"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf22d29dabso841625ad.2
        for <linux-security-module@vger.kernel.org>; Wed, 03 Jun 2026 17:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780533125; x=1781137925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oKGAYmkPB1Hr3YB+iaIUqqiRIAjAPxQPvI1HFGUlMt0=;
        b=NguiVgiXmRyttKiiYfJ4KugCmIXvrh5mhlV/6TVijBT/B05/KbU2qgpZyClNMGVJFi
         R1zQP7T9O0xuOiGsWsVL3wXs49viFcSNNvLh+ceVngdeW+eEQOLP6s0SMzhb0ezdAx7v
         QXlWkEdVpzyhwQtlqhFhG2+YsXY/DB6IqE0/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780533125; x=1781137925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKGAYmkPB1Hr3YB+iaIUqqiRIAjAPxQPvI1HFGUlMt0=;
        b=GEkDdAGTkNR87+UVtTrxhaJ0bg/AVvbEpcoDdKxlcfqjp8XN5a9o+vpK4C0zO0d0Xo
         +t6Ex357GTO9+KPHm15csYrn1PQbk4K3/vTK9hjdjvIkFKBVgixDB50CBfFW2bFDLhtD
         Qn//bOpI+6YXDLlVMUOE2robXgsJB85EAwukCk2i/m6wrRIvof0NO4zkFIRziKsmFf91
         louNlsIJ5kg90S1yGhWL7ei+Ebo11FidgOx7M8dIt3HaCzg4Va/oMBvqA5hY1By/D7NV
         VlIt1axiHV7VGwPFhkFFJjh45M/4jQLlUKe1cBmzUeiGgonMnlKNCwN6e1LsTlsCWYG3
         5dMg==
X-Gm-Message-State: AOJu0Yx9f1T9o84X95B/ziqfFVA0cRK7nsnEhdzZNkKvieBzpR3AOIsl
	WzZEga2HLmPgVVy7oLYlw1lIliFb0kLYmwOJrkaO03UptwtLA60/sd5Nl7tSw47otwPmqfZ1WTL
	TaQ64+hKJfw==
X-Gm-Gg: Acq92OF2g64+js6hx0CNBP9CoxTTchNURJtScJLGCqg4NSFamslkkmhxAlYO+NzKcmH
	z2Z0/Q2gQLRzl88SRSktDkrCFmj+wMlPaw78g+9P+KdNo2y4LrmcVt7T1nE6VZI+y9es6QoMrLf
	MNHP8nAaXPa9/IDOlCPOt+SHZahJNY7oDXi8DKIO7D8jZf4COm79JtnRg0mWliow1tCgnPISNuE
	BhXmyNHag8tADCMCF5LwMPCuR2Pc9MtclTtvqHGJDrsQMlgMM4adGV84i3K7UAy79mm+YAG160f
	+wmHCLRHjXdp7KXopVldjqSCYPl7XRZMW2w+XA8AwV34Erz0RGV6j4yb0kyy/lsLN7Rcs5YlQmc
	n5h3R487qGwjSkf8IT9BvJ+47aDKpDVlpB/fqn9ctp5NNYwe9RVXFxas8RY7sP81HBvS2MX89NP
	hQIJbHYu6BWUoUG+5MXTHj3mjZ2U8+J4eoh4xmuBvfCSRgC39bo20gCydVc6+nyQ2DL9z7hVOi7
	EwrG+n/UyCw3ZU=
X-Received: by 2002:a17:903:289:b0:2bf:372a:830c with SMTP id d9443c01a7336-2c163a43306mr64393435ad.11.1780533125182;
        Wed, 03 Jun 2026 17:32:05 -0700 (PDT)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com. [209.85.210.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8429fsm45820735ad.18.2026.06.03.17.32.03
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 17:32:04 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-842848fd613so65608b3a.3
        for <linux-security-module@vger.kernel.org>; Wed, 03 Jun 2026 17:32:03 -0700 (PDT)
X-Received: by 2002:a05:6a21:3989:b0:3b4:8ba9:4d8e with SMTP id
 adf61e73a8af0-3b4979a4e44mr6703825637.23.1780533123566; Wed, 03 Jun 2026
 17:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83f77b2b-8c00-424d-b6f9-b044e7ea1ee7@sirena.org.uk>
 <CAHk-=wj6CtZS9hbwFjQcoNkPwQLoyKmk8czaBF6=bBOCYuXEUQ@mail.gmail.com> <CAHC9VhRX1=tx4+arzuH76kirYFFJozexa5L=41Bb2QbgWZXOkQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRX1=tx4+arzuH76kirYFFJozexa5L=41Bb2QbgWZXOkQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 17:31:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_rtiufEEVudMCSbh86HYrnmEa9NhYfKeWHs1SOzJVnA@mail.gmail.com>
X-Gm-Features: AVHnY4LFh1aPXsQ6zdDL4_HlTChSE-hAiyStcDf8UlBB35Dp83kOTZRnA_qQqTs
Message-ID: <CAHk-=wj_rtiufEEVudMCSbh86HYrnmEa9NhYfKeWHs1SOzJVnA@mail.gmail.com>
Subject: Re: -next status as at v7.1-rc6
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, linux-next@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 17:04, Paul Moore <paul@paul-moore.com> wrote:
>
> It's worth mentioning that resolving the merge issue was relatively
> straightforward and we had a tested patch ready in a few hours

This is not the reason I'm not going to pull it - the merge issue was
just the reminder I got about an earlier email that I had dropped on
the floor.

No, the reason I won't pull it is that the main developer I pull bpf
code NAK'ed it.

Now, I will cdertainly sometimes override maintainers, so it's not
like a NAK is always some final thing.

I don't _like_ overriding developers, but I'll do it when I feel it is
necessary to make forward progress.

But I also have to  feel people have been unnecessarily difficult, and
I have been extensively informed about the decision and I feel like I
can make a reasonable judgement on it.

So it happens, but it happens with my explicit understanding.

My tree is *not* some kind of "we are bypassing developers by sending
a pull request directly to Linus" tree.

NEVER is that the way things get done.

[ Yes, that too has happened, and I have done that unwittingly because
I didn't realize what was going on ]

So I will not pull this tree. End of story.

The way to get me to override developers is to make me aware of the
conflict and convince me that yes, something needs overriding - but it
is typically not very easy to do with active developers.

And honestly, I also have two+ decades of history of "LSM people
cannot agree on a single thing".

That is _literally_ why the LSM layer exists in the first place.

So when LSM people then disagree with _other_ developers, quite
frankly my immediate and visceral reaction then is "oh, these people
who have decades of history of not being able to even agree amongst
themselves are now disagreeing with outsiders too".

Put another way: LSM people have a  higher barrier to convince me that
I should take their disagreements seriously.

And no, I'm afraid that may not be entirely fair.  But "history of
being disagreeable" is a thing.

              Linus
