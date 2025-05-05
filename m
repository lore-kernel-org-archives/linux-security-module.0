Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1CE34CF5
	for <linux-security-module@vger.kernel.org>; Mon,  5 May 2025 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746475916; cv=none; b=Mk2DjvDqow9ra8uzXZJD3uZFTMhg0AXWzJp8D3zYfY92CYFFG++N1MPX+/xRzGQQSk9UtiA8tt06as2y2F3T/2j+RGUJz0DnTihuauEPWZdRP6sCbxabnnagTScT5HbTIKZXws5CYUrugJn0TXaUbehdUJgqvaLQ7j41Wa/wJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746475916; c=relaxed/simple;
	bh=eJibAmb7tSGzkvZzMztEjYtTqmIUQ/waK/3Kpn53Vms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwUDMz51kMwQUyK96FVhC5A45SofbgRozqJeMz/vtWE4Burg1tmRMGhDN+zOCVrB+llP8WCK9m4BW1oCK293pvp026nEriuzuqI4x0Xr9Q1mRggyDRjKcYqYMEBOzZC1ytqROpBGniUgl7TLyNI8sMTNFeUS9abVPoP2ZBVGqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bXyL9VRm; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bXyL9VRm"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-707d3c12574so39371197b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 05 May 2025 13:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746475913; x=1747080713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwI5AJY33LLiedS6PgDfr7P97WLOsNbgetoXuoKpLkw=;
        b=bXyL9VRmr0Lm/ykEPPnkrT7YfhC0Jo63pFgDKdxzLt7ZozT+d2CfzG0wzKX19bvMth
         bkyUaI+mkBhEEjoJiPWA49rgLNleKOkzxnrgRWITJShBbbcJoMZN/MNCzDFtMkRtRY9l
         t747ZmfpevHGusHaH0OrTQpXw3TtON2CNAEtNSJ4XyrJazcPEn3JvoJmOzfF+OCSGDtU
         DWX9QWlvxin2dPsEtS1zYiuP6aEmCG1IFEx19ns7vgiULZ9MIDOwcizb6hUCmamwKRON
         Ylxdd1hClbCudjQnIn0lS0/TrkZBbEWqXA0eM1VYNrN3nUSk9dtWT/R3lj3pEUMBASWl
         V/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746475913; x=1747080713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwI5AJY33LLiedS6PgDfr7P97WLOsNbgetoXuoKpLkw=;
        b=CztTx3WIYLutEor2mvNjOGQZ/B21J/NCo9Q9m7C+U8lZK2R8aRqwPkz0cjERwbWs7w
         FnF0WnSbx7kbbsAVw05ExUJVq606Znx/XczEU8hvhAEo8okgcaQRIYOi+Uf8X4T9j/qj
         4/IDE/Db26rJ2vl8FrDHfC53OaSNlljVwNiPlG+NMnCJO+NW/u1/Y+Qa9CNusq59KbIr
         RJuZceSJE+6a/DpRwHTfiMBEEuugGAZzED4zO/zZID2lC4JH8fv6T8dpHovc7YK+T3ZI
         Jhjf3WPEJ8H9vcpCaqInRZs8FehITNMapSB5c/857AQ8MBfsyyP2bIGwqEucyMK4nXze
         a0cg==
X-Gm-Message-State: AOJu0Yx4IsSrh+pH9bEY1jKek2Q6SWp/I9yurSA2n5GA8e9pdP7sYUaY
	ypKOL2gu9cgIQSwnYa5VDxb4Ssai8hl8oEPyyy0sPT5cE03EA8NZeeNX1N5U9McrGf2Qjp4WEIz
	i0fEMsI0k7sLsxBLjGztr9VUYJ5M8q4Sl47sE
X-Gm-Gg: ASbGncvdXxjlUNNMO/vB4dIDZ4n2pFvPU8phYuaLrsqmRBTSXWFjG0PFDcJcSIyoTLl
	ls7rJjzyjTISXkLkO3pkj5dCWb1uWLi5hzRTMeUIL7YqJ9Gvm9gShntcayszh3oCCYZJW5E1MXZ
	VjA9qDe/raNAuKrjtuWAWdjjTOF7uOx73g
X-Google-Smtp-Source: AGHT+IFz7O1UV8aqPPrOHoZe+MTc/e7wHj2oqnvyUWATc2eWD2t32fMKNTBDZDLO4/q63p2cuRGyFbUOPR+nY6tos5I=
X-Received: by 2002:a05:690c:610f:b0:6ea:8901:dad8 with SMTP id
 00721157ae682-70918865c61mr11828167b3.3.1746475912139; Mon, 05 May 2025
 13:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
 <f2b76c86-2b2c-49c1-8294-c75e4c758b27@schaufler-ca.com>
In-Reply-To: <f2b76c86-2b2c-49c1-8294-c75e4c758b27@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 May 2025 16:11:39 -0400
X-Gm-Features: ATxdqUE0st_phM8YuUm96w4YJken3hwnzOyh3ebkMJjCjcrMozRLnPnRMkMKZRQ
Message-ID: <CAHC9VhTO5Sh0BorZqMdx1PCJBKyhE_xOUhT0tWUsT4yUkFPbag@mail.gmail.com>
Subject: Re: [RFC] LSM deprecation / removal policies
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Fan Wu <wufan@linux.microsoft.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>, 
	John Johansen <john.johansen@canonical.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 4:44=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> On 5/2/2025 1:01 PM, Paul Moore wrote:
> > Hello all,
> >
> > We've worked in the past to document some of our policies and
> > guidelines, the result can be seen at the link below (also listed in
> > MAINTAINERS):
> >
> > - https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
> >
> > However, one of the areas that has been missing from this guidance,
> > are policies on deprecating and removing LSM hooks as well as LSMs
> > themselves.  In an effort to fix that, I've drafted two additional
> > sections (below) and I would appreciate feedback from the LSM
> > community as a whole on these sections.  The LSM hook deprecation
> > policy follows the undocumented process we've typically followed, and
> > while we've never deprecated/removed a LSM, I believe the guidance
> > documented here follows existing precedence.
> >
> > ## Removing LSM Hooks
> >
> > If a LSM hook is no longer used by any in-kernel LSMs, there is no ongo=
ing work
> > in progress involving the hook, and no expectation of future work that =
will use
> > the hook, the LSM community may consider removal of the LSM hook.  The =
decision
> > to ultimately remove the LSM hook should balance ongoing maintenance an=
d
> > performance concerns with the social challenges of reintroducing the ho=
ok if
> > it is needed at a later date.
>
> Should there also be a section
>
> ## Changing LSM hook interfaces
>
> The interface for an LSM hook may need to be changed for a number of
> reasons. ...

That's a good point, I'll add that to the TODO.  Much like the LSM
hook removal guidance, it should be fairly brief as I'll simply
document the general practices we've followed thus far.

--=20
paul-moore.com
