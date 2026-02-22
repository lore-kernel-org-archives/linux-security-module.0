Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE87335BDBC
	for <linux-security-module@vger.kernel.org>; Sun, 22 Feb 2026 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771793081; cv=pass; b=MRG/zpntBfu9Riv+Af4pqY4MeFixI+7pUXTWXwrPyy13AqPX2fYJpvPSlTnIEq9DAbMxF7BGodgbV8Yy26ohHpwEHJRaOqk9jsASnbsy4HLVH9e30HtRUeRwMCDrMn4w9Jx8Tsfscb33wbNyiwaWQNBhjQVPoBzYP2ePZdTulL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771793081; c=relaxed/simple;
	bh=hp7f/xcQLM4YKqC46AX9x0C8T1QSRpBd0PokasCrG+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/+j5G32ehH3/VyQZWzj5cwbYF2SJdUUsCM6f7gmzeMPmo0FiOG/vmtx8pLVfZcVyB0Lu0g3zRBrQ3L6uTG4ph+AeMV11GJsjwAOk3PE54Gs29QFJgWrY5ZCV9iY1rAfGPI3WPksU2bQb3KYl+Xf5WWxEXs5i0L7C1FaGLwWVVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y460imou; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y460imou"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a7a23f5915so21218365ad.2
        for <linux-security-module@vger.kernel.org>; Sun, 22 Feb 2026 12:44:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771793079; cv=none;
        d=google.com; s=arc-20240605;
        b=OP0dvoWiyN54S6uqUQ/QKfAMOZ431NuvKHN0Oi9iULOx8YefvowqQlhmYdTmXy+r0y
         wfIsB1BOECBXa64oS9hNbJU+2ccDzDwswRJUnqj+FWVnW3MNqKSk2GMmnT9MbSTOCfsH
         33h6G+PKuQdOFwUwVzo5RyUSUjWnzCaCIyFCrZeaDNyB8XTRlUR2z1u+mUPJk2zpZy0C
         he73HFYizbvV8oHLvcXpiMqWGjSov6e5qk9R0H5dXZxbfQtnClAM/FnZk/eyhh8FLL4Q
         8n5lXuZhiDOKi3n9mONCjXB0dXALTaL1VcHrqGvheYiiqAggu/+O4tpYgXqJUjnoG6zZ
         1Twg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SZS3ht6qpZxvXlxvBozprXgo1676sf/FcqaXKyi4R0M=;
        fh=fP1QcbNUJzceGScunxrsU57vhCObQC4XcfXvUH3izQU=;
        b=HphT+Hc1uj9GEP2Pjqjs8vD2MiTlZ6dj/Qoll60JgdSOtYtxFQ2MGoK1kqUjmHI/Jr
         dsUzxwcXZk1Wiaj4QTJ+ANstffQ5LkNRYSTbTSPye8ehZ8CZBXBZu49zyi3Zf9+Ok2g5
         P8C0Lftw/cYWU7ZczevRNh/84eluQIJOYAmssT6PJ8//HV+g1wAR81dsspVLGLaVSFIJ
         coPUhwtgBRz6o5KBgc+rAEmWsR7Nh8ma/aEzvCp8ytr3lF4shjoixptHdhUHXmouyGYy
         paT1BPp+0kOCr+2fNN8xhCRRHq/fjuwMJNYIWiU6dmZtnQQBX2M2Nt02TSxCotuVAOqJ
         OJCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771793079; x=1772397879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZS3ht6qpZxvXlxvBozprXgo1676sf/FcqaXKyi4R0M=;
        b=Y460imouQRWnRkg4aeW4mXXIInl8JrXhI2L2st6sInuLFIlBhiFosX1OMGoUAhEkVe
         uVomRuUsqjEgFbzjIxciRZO0hCyQTBGc+DpjtPuEe20QDxm+rbTqp2pa5M52/5aygnQK
         xr6sWLF2oCuXSM65vtMHnNRjRScbIS1WTFTLwSuzSz3BPQTapLczRsotfjmOdttMFWmg
         WTi/U/rMTGHIWfzj1EPlarXetNAyEY58rADg1Xol5uydmjcmeZSlBgs8hZ4Egg+PnTgf
         XyPd/aUstU3bVSXxkCFkc9r1IJdxw5jElEmmXcR/z8uMO5LrgEVtsWL71WeslrJIMrdz
         GjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771793079; x=1772397879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SZS3ht6qpZxvXlxvBozprXgo1676sf/FcqaXKyi4R0M=;
        b=iwI/TAinkjjL4PNtzFij+F7JBfQ3PCmkHgdcmRmGSn4ibHMWMjZ/nczAiuGAMU9ejT
         gllRwOJvjNI+pmmDIEtBgHtYqqxzaq2Tsb3EQbhig/ye869Pn4hu8r6lMjZ2NbRp0lpZ
         myTj1ciZ1hX5IQPK/h9O2dZssF0eThoHG/NVZp30cKrjp4wn9T7EMK18+PDwQuq+KKWG
         9/CC1mhMdqoO0TNVhSDLK1xmr1bzfv4ZN4I/OFpq18vMaFOrK9deejRAaHd85u8y3L3L
         NOLPX9u7UtUZn86tYBgE9/1GPmkBfRz8rbvu7jcostRWirrYfpJT/Zm0/1shf2AsAHuJ
         c9vQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+Wu5LDbXM0errJFIqA5Fy7B37vbRX/1O5gDbOL3A7AIzbWIr+v1WUc3BXLbvjGHCFJ43i91QC9JS4iaaGnaV3FF5/GJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxou4a+LDbVITJgIbNi/fuo7lS3t5EUST2gWhHmGIh74n0T75En
	Kja4r4EF4/IKrkr+CfZa/caZnO1UgbHtNVywYU/cuHaYB1hj5nyr3UAYpAllueqKHd70mDPA/eS
	StQCiea5zA5Y5rhVbjhnQqQjzV6JlR+cXpaXsDHol
X-Gm-Gg: AZuq6aJQmNGVezttQymqSSmPU3vbeH02cDo6JOn6m5Amywe8qzmmlFuk9OOZ3V/SG7i
	w9N0qEaMQsAZnyVDduhZWyWZVNPdhr5dpBdZB5pZ2LpeUs+tK8ul6t/MusnKSUgwW+kzBP6kk6N
	Cf92iscUaYWob5fXahN4d82COTdiiq6ofvnd28wGeJQj36tyB4RSc34KtWAjYjtdsyrYOI39zbz
	k9uvxqcPPzVJ6Sk0MdcsYIa6/Y7HKdbjoe/qOsz1UKDbppqS0d2BiIh6B//zt+PwxRQ3R0hLL/w
	Jyazpfc=
X-Received: by 2002:a17:902:ea0f:b0:298:485d:556e with SMTP id
 d9443c01a7336-2ad74419faemr67616305ad.11.1771793079051; Sun, 22 Feb 2026
 12:44:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122140745.239428-1-omosnace@redhat.com> <CAHC9VhSgbHx4NcMVjMMk0D332b0DTEQi6dD_wO1fvQne-JVisw@mail.gmail.com>
 <aXgZI1td0Hremulj@mail.hallyn.com> <CAFqZXNve_7oKFWydUrskOcvsfbRZVKyWRmLvHKsTzBhG+RmEmQ@mail.gmail.com>
 <CAHC9VhQOW4BQR+UCvrcXa_yiSqADN0HC2Xp0pMKs3FtnjcVaOQ@mail.gmail.com> <20260222115824.37ae0de1eb183997a23669ae@linux-foundation.org>
In-Reply-To: <20260222115824.37ae0de1eb183997a23669ae@linux-foundation.org>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 22 Feb 2026 15:44:27 -0500
X-Gm-Features: AaiRm529BwI7MTcZeMtMwIdjiMFYT8r8qV_tonLYGDsJ05o-JBxp1asG2tQIdao
Message-ID: <CAHC9VhQzjCrLv7c5hsumkEzM5jfDVn93dF4tGkKqGzeJnNuCXw@mail.gmail.com>
Subject: Re: [PATCH] ucount: check for CAP_SYS_RESOURCE using ns_capable_noaudit()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 2:58=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 27 Jan 2026 17:09:40 -0500 Paul Moore <paul@paul-moore.com> wrote=
:
>
> > > > > > Fixes: dbec28460a89 ("userns: Add per user namespace sysctls.")
> > > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > > > ---
> > > > > >  kernel/ucount.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > > >
> > > > Acked-by: Serge Hallyn <serge@hallyn.com>
> > > >
> > > > Looks good to me.  What tree should this go through?  Network?
> > >
> > > Andrew has already applied the two patches I posted into his
> > > mm-nonmm-unstable branch, so I assume they are set to go through his
> > > tree.
> >
> > Andrew, any chance we can get a reply to these threads when you merge
> > a patch into your tree?
>
> I already spray out soooo much email.
>
> A better approach would be for me to become more chatty.  Reply
> "thanks, applied <reasons> <caveats> <etc>".  Shall do this.

Appreciated, thank you.

--=20
paul-moore.com
