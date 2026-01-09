Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434BA2C21F0
	for <linux-security-module@vger.kernel.org>; Fri,  9 Jan 2026 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984710; cv=none; b=pEPOiTE2vJZLxpAuxh/woi/QiI4USICzAHQhcCzLDva729OZtSBDL0DHSDAG604O94ID+M/XwoEOgXAsvNA4H4NtlI6xm5E86sOfIxCNyWbrKQP3P0Cu/WVa5qlJ1S+XMZgxqPcu0GMqAseplvFytuGppJzPsYbT1mSoZHtJZ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984710; c=relaxed/simple;
	bh=UE6bar34zNQqNl/HfuRduZRcCQK+W7/HCqX2aYPbXgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ne08AS+Cv9VXCxBH0E+3h+z/SN+jweeLyek7pT6jjTCwuOdxW2dBhOe7jjxMAdlZt+WgBH1vTNjPi4bQyFIAh2UXXUF562NRgnLBBhQr+ujmQ+UNmq7GhZ324Pe3EDqQrizKqTHNv9wz1V0pdd82iUSUKFRKO6Au8w47E3D2X+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AczImOy3; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AczImOy3"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso2950823a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 09 Jan 2026 10:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767984708; x=1768589508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGKgGuQio4TEZZGc1192xgk0DQ2sdbJiRaAHHtf132o=;
        b=AczImOy3ez9mQsCLoOGgXFeSV9TPIitvL8rWgnRSkv46YiEywRRGjFcBSl9s1QcACP
         C0JdkxA+Uho0FzGZA5/8KgE5Ww9JhtsTUg2UHkpBD+5/TMFecM7xGjyNnKXzTbJGQm8b
         V0OLnlvgUbQNCKMvU7aXSzp0bSzoZ3pD5LFhrqfOgX0RfTEUpPOpRXPbXumd2HZOMPM8
         fuW+0TKcpmK3pWY7TpzIb0pwShNi35qtGmGj48UVse+ExNHNL1JrvsAQXFwMmhnF7SVL
         Uv/2JGVPbQjIsx8U36Qd/CEh853R3cTaE3Ew9zCqM+0peJ0EEa4RoJfKb615nr2zOGkd
         Q0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767984708; x=1768589508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BGKgGuQio4TEZZGc1192xgk0DQ2sdbJiRaAHHtf132o=;
        b=GIGlJWWDj+ufyD7ndYUXptKaoe56TaQYkxlhN1NHPXOOOVr/Uq0nTKoQ6aGM+jkEOn
         CfrYP2nwSkqaqu0DnrvelE1jbHMP750MdtQWP4uMQ8x7KDWUEhn5TNaBGo2N2XVOGfiC
         uwR99sYmfKriMongfS2DZuDMZws7bxAwvtghnf4mHjqKLsp6e2zwuYFLTPDVadhkbJwy
         jWdGUTVOdM+Rv9IoKfGtYAWolawgisziMxv0a6RL3ypyf1mR3DoaocDjdYca1rFwmvsO
         zqrqftF3V4yD9gd1nmhwSPkBLqQYBgqzdrQ+yoHT1q4479GWhJnvn3Kd0ESJMQ0EMuAc
         dKlg==
X-Gm-Message-State: AOJu0YyA7LyjTtkNXZ2Je2guUln0biNBYCjVy2xarE+LcVVMlTi+ignc
	MyGayYzz/bwYkL2EyuQBscau92jhKAb2SVRWOrIvafyBteLNRHreQJN6Pdv5JzBuccGACPSb3wQ
	n+Y5Hw66FGTVd13idvfY+rb0/5ukcAphLlQVjsdD+ecWDSojuWOiJCQ==
X-Gm-Gg: AY/fxX5rmCE19N239HKfXXqjR7AY3Hec6Z4CD8Rc3BraMDNrOzYXWniR0n4g47Ostl1
	QiRbvf/EAaufyb2fQ3di8DErylXnt/gA9Qe7JLocP2q2hSiv4RmaW/jKQqfFpLecm4Nv8K0CgCs
	TR0anG09iD/ENeR+TfTpHPOAQ3pOJduPiDhGOsdT/0Me3zl1VY+jv6udOcqiQDpfUv6soYd860g
	q4aZC1dFaW8M6FPeS195CCsYonjQtK7UzgbxpuVvpBc0pvVc/hSOuM4PQjIVFeABTsdCvR/GTi6
	7SYD8g==
X-Google-Smtp-Source: AGHT+IH0SAF0o/CwFTR6m36RR/T6xAmIad21m5cwTqj4mism/UZtBSKEJiQsgX8E2HxsUvfgh71zE5z9cNIwRMN8KmY=
X-Received: by 2002:a17:90b:2c84:b0:32b:65e6:ec48 with SMTP id
 98e67ed59e1d1-34f68c31c72mr10670522a91.8.1767984708459; Fri, 09 Jan 2026
 10:51:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108154604.GA14181@wind.enjellic.com>
In-Reply-To: <20260108154604.GA14181@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 9 Jan 2026 13:51:36 -0500
X-Gm-Features: AQt7F2rvHn8ymHz3HoDP3JOORzS7-85BVllOcoA8GDpaW6_PjIGI2Cv2fHCwFY0
Message-ID: <CAHC9VhTyvEVLGLJkkyQnSZYSj4-YHPz82BnDEUwMjU7hHdbFoA@mail.gmail.com>
Subject: Re: Improved guidance for LSM submissions.
To: "Dr. Greg" <greg@enjellic.com>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 11:08=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote:
>
> What is not clear in these guidelines is how a virgin LSM should be
> structured for initial submission.  Moving forward, we believe the
> community would benefit from having clear guidance on this issue.
>
> It would be helpful if the guidance covers a submission of 10-15 KLOC
> of code and 5-8 compilation units, which seems to cover the average
> range of sizes for LSM's that have significant coverage of the event
> handlers/hooks.

I would suggest looking at the existing Linux kernel documentation on
submitting patches, a link is provided below.  The entire
document/page is worth reading in full, but the "Separate your
changes" section seems to be most relevant to your question above.

https://docs.kernel.org/process/submitting-patches.html

Beyond that general guidance, at this particular moment I do not have
the cycles to draft a LSM specific recommendation beyond what has
already been documented and reviewed.  As usual, the mailing list
archives are also an excellent resource that can be used to
familiarize yourself with community norms and expectations.

--=20
paul-moore.com
