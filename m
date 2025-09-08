Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52BE47F4A
	for <linux-security-module@vger.kernel.org>; Mon,  8 Sep 2025 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372157; cv=none; b=EZ41nMbWrwNXBJPY8rkgOLw8kL1W02tc6TeEHfYWVnbVCZHlw56rcHNv4YX8h02vX2Wjz8YKgANPVs2XJzIxVGPcxIVVkf+kYYsZXHN1VB5i7nrdpmwR83MLdT6qMZWzp4P0ZTwmCPR8vMr/Ki34DCZFU6RGdn/IhNs8tJIYH2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372157; c=relaxed/simple;
	bh=+XzjpF72oR0BhA1MAgqcvlKvf4PFws6+CaXWpgK8OOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuYpycW12WMBmh+ewGeqNkfuicFiqXRPRUQAbvfOcQbOXbtfoPah71EldNQsaU4tK6pPjWuiqRqTE7ylPTdp7z73P08WBRbc+3W3B2GREejbdFnx7aodilCYxTHn+jiApR8G+SMA5dqQlif7uvG2CjcHYQHy2+2BrVXVaAyrgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F80gxtIN; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F80gxtIN"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-329b76008c6so3994033a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 08 Sep 2025 15:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757372155; x=1757976955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxCFNKv1MEGcR1RbYeBLsxqGeh0St6S3SA4BiIH0bxo=;
        b=F80gxtINfRgRbYmRqg4pxe7y+M1q3769ZLx40/YVHhGFch/S0dIFgKT+e2Cl4LquVS
         IPJrrYub5e/I4JIVdc7fKGCOW0aekAvrJE1g3mX/MOZFL4M3L7uj/KtVXWEYFEU+VG4l
         Td3NM6zxI9xQTT+VB52AX+1wVhYWvErjtDSkHF+wE+xjbW56Dl8M5S6Axk/usmiIsfL7
         Mo425uexO2yvPUyX8OplUpPbtLLkWaQSp5uH6bjP65pWisI9yp5VkqTStYBMmH8NJWqx
         EDSVNaE+wD0GOl+jQ4rKn10sapCinIoKwnvLogxQ3hyCnv27G4jH6N7yQBU/5LzxQJgP
         4SXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757372155; x=1757976955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxCFNKv1MEGcR1RbYeBLsxqGeh0St6S3SA4BiIH0bxo=;
        b=MD4hquPBezBFOCNyZVdRfuLpL8gIBT6s9+kX90oE2gVC9YJU/ziIZ6mQsC5Mgls5dd
         qUkIiR38rSEDDCs5weF8KA9frQPZkETA8wNmgseQ09DwrWLbRiov6GNAfD6GRjhekBgf
         c/NEY8Yq8KzoCZdbXLfde6EKMgYUJ4OyYSyZc2wJSOhjYeg3oz6K3N0KxyeYvQObpjom
         Pl721VHP7wGUujKgb7Q+KsO/oBlPEnxZdqmIbYw+v6pIFPTZ69obNYoA5g0bwUC7iEHc
         Lt5njhfREd7APpqxo+RPFPSk+xSQkOgKfvSSYVO8K2gni1FAJs0opUj57m8InWVbVssD
         55Fw==
X-Gm-Message-State: AOJu0YxXhoaOO/29MVB/TOBCbAkEnTgsc81rN8r1TTIhph/Rq0Sl/jTd
	qS1zu7deMoi4RocF/j2LBshmi4HT0AFIVMLYBPykX34eU/vIor/lX4j9g7YsgnWejE058U86KO6
	7ml3KWsTL9chSjSgs8xrczTz8NXL3+kdt4azRq/X1y7TJ856Tbg4=
X-Gm-Gg: ASbGnctCrT66YPhC8Pqnzzf4QZHWiCIK37ev5pWdHXUcY0HBfc6+8h0gKVi//pUqba9
	YSpnvoUc2JhUW3j8VVPPoiPDFokoy4SVOarhD4HG7akT3HH1MLAvNO2PGYJqnZ7emZJsja0NF/E
	pbJzLYqBrja0YhUkMZ1LEPpSyVivxAi3A28xVyOgyUT6DdjMEBUayRBZGU44Uz9byG9cjQevdl3
	ly9HOk=
X-Google-Smtp-Source: AGHT+IHzHfFNQ1awRJiprxGViPWMQtIhIoGx/V4yE26TmKpuD0txhCvnfm+J7YHYmyyf7f37Z2G7k5Phv7YZK28KfXs=
X-Received: by 2002:a17:90b:4fcb:b0:32b:c9c0:2a0b with SMTP id
 98e67ed59e1d1-32d43f7df7dmr11356235a91.22.1757372154752; Mon, 08 Sep 2025
 15:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-63-paul@paul-moore.com>
 <CAHC9VhSf=zo0BkTc_=Qqq59OMVHsMUs_OqcmSUK501LYpAdMYg@mail.gmail.com>
 <3be8c5b7-a5d1-497d-8fbd-c74c1e22034f@I-love.SAKURA.ne.jp>
 <CAHC9VhTJp91zfyz4C2jU8WFDH50V0mnEVGLcZKGhaVm6XQ_L8Q@mail.gmail.com> <2c42b87b-d22f-4ac7-9c1c-200e1241833c@I-love.SAKURA.ne.jp>
In-Reply-To: <2c42b87b-d22f-4ac7-9c1c-200e1241833c@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Sep 2025 18:55:43 -0400
X-Gm-Features: Ac12FXxrmmSwuG9csBdtgHeuzbO1dj_jejSk0vm0_RGOuzOQHSTbUF_MkWMuURI
Message-ID: <CAHC9VhT=2HYOh+vJrVudDcZ8iZm-tK7jgdfjZftfcaisn72eXw@mail.gmail.com>
Subject: Re: [PATCH v3 27/34] tomoyo: move initcalls to the LSM framework
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 3:39=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2025/09/05 0:02, Paul Moore wrote:
> > On Thu, Sep 4, 2025 at 5:53=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >> On 2025/09/04 5:32, Paul Moore wrote:
> >>> On Thu, Aug 14, 2025 at 6:54=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> >>>>
> >>>> Reviewed-by: Kees Cook <kees@kernel.org>
> >>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>>> ---
> >>>>  security/tomoyo/common.h        | 2 ++
> >>>>  security/tomoyo/securityfs_if.c | 4 +---
> >>>>  security/tomoyo/tomoyo.c        | 1 +
> >>>>  3 files changed, 4 insertions(+), 3 deletions(-)
> >>>
> >>> Tetsuo, does this look okay to you?
> >>>
> >>
> >> Yes.
> >
> > Thanks for reviewing, may I add your ACK?
>
> Yes.

Done.  Thank you.

--=20
paul-moore.com
